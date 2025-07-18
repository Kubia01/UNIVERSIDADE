import { createClient } from '@supabase/supabase-js'


const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://syhslssfqzbthppprkau.supabase.co'
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN5aHNsc3NmcXpidGhwcHBya2F1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE2NTQ1MzYsImV4cCI6MjA2NzIzMDUzNn0.KDoKpFB4dbJnD47NR_HF_aftqPdvaf5VwLJztu9DurM'

// Debug: log das variáveis (apenas em desenvolvimento)
if (process.env.NODE_ENV === 'development') {
  console.log('Supabase URL:', supabaseUrl)
  console.log('Supabase Key:', supabaseAnonKey ? 'Configurada' : 'Não configurada')
}

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Variáveis de ambiente do Supabase não configuradas')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true
  }
})

export type Database = {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          email: string
          full_name: string | null
          avatar_url: string | null
          role: 'admin' | 'user'
          department: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          email: string
          full_name?: string | null
          avatar_url?: string | null
          role?: 'admin' | 'user'
          department?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          email?: string
          full_name?: string | null
          avatar_url?: string | null
          role?: 'admin' | 'user'
          department?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      courses: {
        Row: {
          id: string
          title: string
          description: string | null
          thumbnail_url: string | null
          category: string | null
          duration: number | null
          level: 'beginner' | 'intermediate' | 'advanced'
          is_published: boolean
          created_by: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          title: string
          description?: string | null
          thumbnail_url?: string | null
          category?: string | null
          duration?: number | null
          level?: 'beginner' | 'intermediate' | 'advanced'
          is_published?: boolean
          created_by: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          title?: string
          description?: string | null
          thumbnail_url?: string | null
          category?: string | null
          duration?: number | null
          level?: 'beginner' | 'intermediate' | 'advanced'
          is_published?: boolean
          created_by?: string
          created_at?: string
          updated_at?: string
        }
      }
      videos: {
        Row: {
          id: string
          course_id: string
          title: string
          description: string | null
          video_url: string
          duration: number | null
          order_index: number
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          course_id: string
          title: string
          description?: string | null
          video_url: string
          duration?: number | null
          order_index: number
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          course_id?: string
          title?: string
          description?: string | null
          video_url?: string
          duration?: number | null
          order_index?: number
          created_at?: string
          updated_at?: string
        }
      }
      user_progress: {
        Row: {
          id: string
          user_id: string
          course_id: string
          video_id: string | null
          completed: boolean
          progress_percentage: number
          last_watched_at: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          course_id: string
          video_id?: string | null
          completed?: boolean
          progress_percentage?: number
          last_watched_at?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          course_id?: string
          video_id?: string | null
          completed?: boolean
          progress_percentage?: number
          last_watched_at?: string | null
          created_at?: string
          updated_at?: string
        }
      }
    }
  }
}
