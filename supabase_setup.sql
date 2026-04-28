-- Supabase Setup for RICE Market Prioritizer

-- 1. Create the `hypotheses` table
CREATE TABLE public.hypotheses (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name text NOT NULL,
    filter_ai boolean DEFAULT false,
    filter_horizontal boolean DEFAULT false,
    filter_b2b boolean DEFAULT false,
    reach numeric DEFAULT 5,
    impact numeric DEFAULT 5,
    confidence numeric DEFAULT 5,
    effort numeric DEFAULT 5,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE public.hypotheses ENABLE ROW LEVEL SECURITY;

-- 3. Create policies (Allow all access for anonymous users, since there's no auth in the app yet)
CREATE POLICY "Enable read access for all users" ON public.hypotheses FOR SELECT USING (true);
CREATE POLICY "Enable insert access for all users" ON public.hypotheses FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update access for all users" ON public.hypotheses FOR UPDATE USING (true);
CREATE POLICY "Enable delete access for all users" ON public.hypotheses FOR DELETE USING (true);

-- 4. Enable Realtime
-- In the Supabase dashboard, go to Database -> Publications
-- and make sure the `hypotheses` table is enabled for `supabase_realtime` publication.
-- Or run this command:
BEGIN;
  DROP PUBLICATION IF EXISTS supabase_realtime;
  CREATE PUBLICATION supabase_realtime FOR ALL TABLES;
COMMIT;
