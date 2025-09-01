Return-Path: <stable+bounces-176791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918DB3DB81
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFD518957BE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171DB2EE274;
	Mon,  1 Sep 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uME8i/Vq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DA2EDD60
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713035; cv=none; b=qHVa40LZ/wDl5GjqMWpfFEMALFa9VVrZHT8buOrqpt+R9XND40blnZL9p7/wv+qFT3yKKFmkY92mutxNTWvfXNGNHYJTAVqQVYSvxmZvQOkAvxy6IgUOixvGMBh8GGnJWPz689ovdPLW9B4qDXcbKwk+yZZcaKz1WiP+220hNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713035; c=relaxed/simple;
	bh=GCYHl0IzJ/AoEA1OjQZxe5WGrSnqEi8TLuJFcy7EEeQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VQj3LOIRu3YKzXmi+IOjrBS0AKMogIng4/rOaLXIYwbwA4yeaVUJ/6Dl2YOC/X9W2/UaMyWWQZwUEcCMlAfW9xUyBmWCISkPuYCFY9lf8LSB2LwHCKrqLMPOSuqOGKELYd3BoGOHorLiGgC3VMMeFTaGQ9+eE3kNv1nq7B2Gsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uME8i/Vq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24ab15b6f09so117265ad.0
        for <stable@vger.kernel.org>; Mon, 01 Sep 2025 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756713033; x=1757317833; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkNip8h6TggKbPC4j1tIEtRIjWnEKoxCcwgwzmMlJgs=;
        b=uME8i/Vq+bfOKqj7mQYv6Z+nhA3lmu9Ya8paVKhEcIIhedqSNv4W0Q/DMtisEM9A40
         vdUCzjKcpLRtVMHc/ffb0sNyA2LUjjQ3LYl1+z2XSquigHjJcLeMgfOS2j29EEHPJlEI
         YhH48/kkmLxxpyR/jelzIuCwp+RrWwG/b7x2s4FOLd2qgf5DGqI0nU3NlrxG6iJ+A7P0
         qWkMqvAimvdEY6RkZTfXbDgZOymkwc5CqYdEa6VxgyPdRMGDXr9Xbk3UlDW7m5CzWE0N
         Sy6G+FGqc2427y76pWN4a2JNHWD1Qx4bXi+9G+dKxwkX4GqUdWbBJY1sTO2FWf0SEOGd
         pfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713033; x=1757317833;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkNip8h6TggKbPC4j1tIEtRIjWnEKoxCcwgwzmMlJgs=;
        b=D5fYXlE1XZkisZmlg5zQ1C/5zTHhUM5MipERTHPhu7X/A8dOWu6aGG4RKljkQp4k24
         gVlHrjqKbQo4b4ySChcpxT0+2jochIxglpcCMzvm8RX4kbcoUZyaSXoIb0qeRxrREAeI
         kKJXhynU3PHXG0pVGAJITK4tRdCUrQQHqiRRyIoi/RSMS7FDuhcXxS8IIid9X4rTCqXy
         efF/Nc4GIggpHFaCapFOXjju57t//X/b52FzJ5XzCFG+M3W0MGACO/xiTmGHT56WLMeC
         2WtRNZbbDTIYeIGuFM8Gf8u+kxM4MiH7ZQZux1Q3luvXDcL4UXm/bRoWwJM1c+hkOdu7
         njnA==
X-Forwarded-Encrypted: i=1; AJvYcCWBMNpn6WVdYably23yBLRIdhyNilOZ/pCyYsHHxd5ksXB6PNHUhrSzPIwHDxcTBu8sIQ3IZAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VxKBEgemheztLK1iPYyEguj/adFzqTz7OToXjCtbau3PTFlG
	GADhZ3zJXTTDoNT1Sss01iabOn+bTYb2uMSl4OecYcMLYLnHq+6ULK+iaHbcVlO51Q==
X-Gm-Gg: ASbGncu3QtnXOjoI3KFrtdWEr7ldWT1zgOPk+8IEn0ZtFa36pR4arHymVFflsaVjTj7
	K3yDnP3re+N1VE2zd7E4UZQcBmEYn2BYeGnT3cgDkva5lG4R/RtcqUt3eHhMuJIrpLFwNbPpmpV
	41pRr5bpZ1Kd7F9VdKEjNQIKMZmShxhuAQ6cx+QO4+9BuwqQGBhuEGQyu1TMhxBAuQE8YI4APWD
	Dg98A1LqUSvF7zG4BEuwdBP+KsPQ1GItR3OuU1B8MQwMGuDFiOW/ChvmeyTBZ4coDLpiRZVTJm8
	gWqsZz0mqUJRwP6/qDQCcPXVq/lKm9h0a4v5PMFkFHTC57WCl2hvi7C1SNmpRj+DCmcvIg+Q4E9
	8KE+izOhEOF//aqrDZ1W556YhRGGLTiF/4W7Avzxvswig8pXp85DgwwsymoeJb/HyEfLNoM6I8f
	cuu18uKRsaC09FYPGZXdkXuOd3LDNcYxNYaQ/flDOpGDQlHjE7efvd
X-Google-Smtp-Source: AGHT+IGn9QHXHHFTCaWm9H+w1dJZ0iGEeksBYBpp44VGJjpcufhxypiFwN2ftuqbOtcBBJEaj/QBwg==
X-Received: by 2002:a17:902:ce84:b0:248:f76d:2c67 with SMTP id d9443c01a7336-2493e7b9d86mr4983845ad.4.1756713032826;
        Mon, 01 Sep 2025 00:50:32 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:cfcf:e85f:553:d0bf] ([2a00:79e0:2eb0:8:cfcf:e85f:553:d0bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf0567sm15934209a91.27.2025.09.01.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:50:31 -0700 (PDT)
Date: Mon, 1 Sep 2025 00:50:29 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: yangshiguang1011@163.com
cc: harry.yoo@oracle.com, vbabka@suse.cz, akpm@linux-foundation.org, 
    cl@gentwo.org, roman.gushchin@linux.dev, glittao@gmail.com, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    yangshiguang <yangshiguang@xiaomi.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4] mm: slub: avoid wake up kswapd in set_track_prepare
In-Reply-To: <20250830020946.1767573-1-yangshiguang1011@163.com>
Message-ID: <c8f6933e-f733-4f86-c09d-8028ad862f33@google.com>
References: <20250830020946.1767573-1-yangshiguang1011@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 30 Aug 2025, yangshiguang1011@163.com wrote:

> From: yangshiguang <yangshiguang@xiaomi.com>
> 
> From: yangshiguang <yangshiguang@xiaomi.com>
> 

Duplicate lines.

> set_track_prepare() can incur lock recursion.
> The issue is that it is called from hrtimer_start_range_ns
> holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
> CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
> and try to hold the per_cpu(hrtimer_bases)[n].lock.
> 
> Avoid deadlock caused by implicitly waking up kswapd by
> passing in allocation flags. And the slab caller context has
> preemption disabled, so __GFP_KSWAPD_RECLAIM must not appear in gfp_flags.
> 

This mentions __GFP_KSWAPD_RECLAIM, but the patch actually masks off 
__GFP_DIRECT_RECLAIM which would be a heavierweight operation.  Disabling 
direct reclaim does not necessarily imply that kswapd will be disabled as 
well.

Are you meaning to clear __GFP_RECLAIM in set_track_prepare()?

> The oops looks something like:
> 
> BUG: spinlock recursion on CPU#3, swapper/3/0
>  lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
> Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
> Call trace:
> spin_bug+0x0
> _raw_spin_lock_irqsave+0x80
> hrtimer_try_to_cancel+0x94
> task_contending+0x10c
> enqueue_dl_entity+0x2a4
> dl_server_start+0x74
> enqueue_task_fair+0x568
> enqueue_task+0xac
> do_activate_task+0x14c
> ttwu_do_activate+0xcc
> try_to_wake_up+0x6c8
> default_wake_function+0x20
> autoremove_wake_function+0x1c
> __wake_up+0xac
> wakeup_kswapd+0x19c
> wake_all_kswapds+0x78
> __alloc_pages_slowpath+0x1ac
> __alloc_pages_noprof+0x298
> stack_depot_save_flags+0x6b0
> stack_depot_save+0x14
> set_track_prepare+0x5c
> ___slab_alloc+0xccc
> __kmalloc_cache_noprof+0x470
> __set_page_owner+0x2bc
> post_alloc_hook[jt]+0x1b8
> prep_new_page+0x28
> get_page_from_freelist+0x1edc
> __alloc_pages_noprof+0x13c
> alloc_slab_page+0x244
> allocate_slab+0x7c
> ___slab_alloc+0x8e8
> kmem_cache_alloc_noprof+0x450
> debug_objects_fill_pool+0x22c
> debug_object_activate+0x40
> enqueue_hrtimer[jt]+0xdc
> hrtimer_start_range_ns+0x5f8
> ...
> 
> Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
> Fixes: 5cf909c553e9 ("mm/slub: use stackdepot to save stack trace in objects")
> Cc: stable@vger.kernel.org
> ---
> 
> v1 -> v2:
>     propagate gfp flags to set_track_prepare()
> v2 -> v3:
>     Remove the gfp restriction in set_track_prepare()
> v3 -> v4:
>     Re-describe the comments in set_track_prepare.
> 
> [1]https://lore.kernel.org/all/20250801065121.876793-1-yangshiguang1011@163.com/
> [2]https://lore.kernel.org/all/20250814111641.380629-2-yangshiguang1011@163.com/
> [3]https://lore.kernel.org/all/20250825121737.2535732-1-yangshiguang1011@163.com/
> ---
>  mm/slub.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 30003763d224..b0af51a5321b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -962,19 +962,25 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>  }
>  
>  #ifdef CONFIG_STACKDEPOT
> -static noinline depot_stack_handle_t set_track_prepare(void)
> +static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
>  {
>  	depot_stack_handle_t handle;
>  	unsigned long entries[TRACK_ADDRS_COUNT];
>  	unsigned int nr_entries;
> +	/*
> +	 * Preemption is disabled in ___slab_alloc() so we need to disallow
> +	 * blocking. The flags are further adjusted by gfp_nested_mask() in
> +	 * stack_depot itself.
> +	 */
> +	gfp_flags &= ~(__GFP_DIRECT_RECLAIM);
>  
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> -	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +	handle = stack_depot_save(entries, nr_entries, gfp_flags);
>  
>  	return handle;
>  }
>  #else
> -static inline depot_stack_handle_t set_track_prepare(void)
> +static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
>  {
>  	return 0;
>  }
> @@ -996,9 +1002,9 @@ static void set_track_update(struct kmem_cache *s, void *object,
>  }
>  
>  static __always_inline void set_track(struct kmem_cache *s, void *object,
> -				      enum track_item alloc, unsigned long addr)
> +				      enum track_item alloc, unsigned long addr, gfp_t gfp_flags)
>  {
> -	depot_stack_handle_t handle = set_track_prepare();
> +	depot_stack_handle_t handle = set_track_prepare(gfp_flags);
>  
>  	set_track_update(s, object, alloc, addr, handle);
>  }
> @@ -1921,9 +1927,9 @@ static inline bool free_debug_processing(struct kmem_cache *s,
>  static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
>  static inline int check_object(struct kmem_cache *s, struct slab *slab,
>  			void *object, u8 val) { return 1; }
> -static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
> +static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags) { return 0; }
>  static inline void set_track(struct kmem_cache *s, void *object,
> -			     enum track_item alloc, unsigned long addr) {}
> +			     enum track_item alloc, unsigned long addr, gfp_t gfp_flags) {}
>  static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
>  					struct slab *slab) {}
>  static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
> @@ -3878,7 +3884,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  			 * tracking info and return the object.
>  			 */
>  			if (s->flags & SLAB_STORE_USER)
> -				set_track(s, freelist, TRACK_ALLOC, addr);
> +				set_track(s, freelist, TRACK_ALLOC, addr, gfpflags);
>  
>  			return freelist;
>  		}
> @@ -3910,7 +3916,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  			goto new_objects;
>  
>  		if (s->flags & SLAB_STORE_USER)
> -			set_track(s, freelist, TRACK_ALLOC, addr);
> +			set_track(s, freelist, TRACK_ALLOC, addr, gfpflags);
>  
>  		return freelist;
>  	}
> @@ -4422,7 +4428,7 @@ static noinline void free_to_partial_list(
>  	depot_stack_handle_t handle = 0;
>  
>  	if (s->flags & SLAB_STORE_USER)
> -		handle = set_track_prepare();
> +		handle = set_track_prepare(__GFP_NOWARN);
>  
>  	spin_lock_irqsave(&n->list_lock, flags);
>  
> -- 
> 2.43.0
> 
> 

