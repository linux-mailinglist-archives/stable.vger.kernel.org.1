Return-Path: <stable+bounces-210274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB7D3A0DB
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A895E3008EB7
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BB2339861;
	Mon, 19 Jan 2026 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AvcfNyGP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1E339719
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809607; cv=none; b=Fc8RsynJ2efoAZzODCN1Gci7nsD/Vc7EX3FLYokXkbsjSjCJq6Jq8rT8Wm1aTaTZMbegxZIZToVNPJYPQaCc15rLkuzf5zZee072foSUOJ4GPL8jBurRInWVM8SCZdaduUvFoZbkZhqnVp1eVgvg7uNNe4sOzciuIeN8Ca2PuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809607; c=relaxed/simple;
	bh=ahB5PXkdKz+OudhXzR5+oJxcANGL1gzgulL++hExJ1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1YXpBAjc1ha9kgx0yFiCniF2VrE029u44hV7O0mP/f9T+dAnY8fC6JOs4BD/ob26tInHEnb3ByXjShJ4z3UI39YAwyhsw6mAvpZP83PbOLL51oe/SKW66mwnRiYJAkiMHZSOqMk+3UErOQCfiWAGJkGEaEQZPzNo5WIzQxG8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AvcfNyGP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so22157935e9.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 00:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768809604; x=1769414404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jye8WAd/vE4qqlECAOAdbFTMAIss/HS1MRQD2Sijk8A=;
        b=AvcfNyGPm4IhUqxYjIaKPc/mq/v54+N76WpR82ftvLOzy0sbvHhoB1C0enIBEsLYvG
         wNySXbHwoqQAF+y5upOCbzI0WUUcGGN7iC301Oc4slHPgW3/hobI8FPrxoqHbgwjobLS
         hTVeqZ0hYhgJ5F3G91ZIX+xAbSuJNGTzjFLLnVP/NB04MYo72JqWYV6Osxb882CSeFu5
         B4qsrvQ3o9ZiSTKX7Kj+9nxld0oqk+UNegHbV70uFYHHC+tLV0s+zysHhhkV+9bvRHyi
         3csfVIWb5m++E5qjINFxDpM8ajjsdSKx8faxJaKIRDsqGrwP9BAK4mkzxmUJ08Xr2umQ
         A2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768809604; x=1769414404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jye8WAd/vE4qqlECAOAdbFTMAIss/HS1MRQD2Sijk8A=;
        b=OfyvhbMoTRBXcZh3Z5xUcL4PIFaMfBZKOyLE3zJj1Oor+Z3b34bAvP1g6mhXxkP8wx
         Ko7SMLb4afd8MQrNE5WUF3FPw1ldZhP+0P+k/4kOWVjQLD1uVYXzPmJ1nmlBJrb75ZRc
         0VRijqumkeZelCmtYW6lw6T65BCq0Nm/AV0qsqv1sAZgrcBUS6wvJUvf2p+PP5s2vJ0n
         Q4LrasQh6v8mCwKEr/RYgeHyBusFKPB/gTz4A2kwGk4cnsVbpabwOOc+vzP1oh0Dr4UP
         DWBnR+E2NQm0JdHpwOFH6C6QQC9gwH0M8Ei2ul/JfZLguP8aCpW7ZkquEEUlggfVRWBP
         Zgjg==
X-Forwarded-Encrypted: i=1; AJvYcCXUoF1PNSpzAukI91O3hRdmyvekRwlQOYW1Yxubz79Gb+KwCjyp4Yb9+fcqat1rcxe8fiVrBPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXjvzndmLn3nimvP4VPFMGUxutYfqd506ejBha+3nRUZs+17h
	OOH4IrCn4H6aRkMGBZ6HQ0R+X0qMGq4Hi5vN/4ne7Aa9VNdnRnoT/bkYH1HzBgfQYes=
X-Gm-Gg: AY/fxX6gkeS7pnOhJcC6QE42HsISzO+FYgik+/eX4lYSNEdq9S+uStGKueWvxeCJDq1
	PZ2WM4z3d4YqD55iwan7MFl4RzqFC6+omPoXNXtRcGKAr98VSclpwrDPfJU7jahgIbyd0nbAYWT
	ui+JobQ4JCzoHiz/0AIfERYpX1m6C9yZ9HjefdS0AT7APBOvc+JtfwIMiT/KGXDeccO1VOrZZ0/
	GvUdM5ioRQlYeGtkv9jqQH28bMAEfV/Zznb1akzuVFF8pvn9WpWR1f6l6LMsWKgc5ECX5EmQpty
	4dSzMW6S6xvwy8PlRNQKzvjvA97Yv5ZjhJ+nRfpihN1mqOKI/fLqwjwKu0Jl7K/eEAaDODmu0Wu
	GzudF5i38q7+o9kpP2kSLvCdF+qvaWLk6q5WETfC+F9eDQNpU6tlWEu+W56XilK/PfCxETXadTT
	kiDm+VJJ70VMWHOiZoVv8ul2Z0
X-Received: by 2002:a05:600c:3b90:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-4801e33a93amr121328725e9.18.1768809604358;
        Mon, 19 Jan 2026 00:00:04 -0800 (PST)
Received: from localhost (109-81-91-169.rct.o2.cz. [109.81.91.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb2asm21670271f8f.37.2026.01.19.00.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 00:00:03 -0800 (PST)
Date: Mon, 19 Jan 2026 09:00:02 +0100
From: Michal Hocko <mhocko@suse.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Restore per-memcg proactive reclaim with !CONFIG_NUMA
Message-ID: <aW3kgrVhWQEyGM-G@tiehlicka>
References: <20260116205247.928004-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116205247.928004-1-yosry.ahmed@linux.dev>

On Fri 16-01-26 20:52:47, Yosry Ahmed wrote:
> Commit 2b7226af730c ("mm/memcg: make memory.reclaim interface generic")
> moved proactive reclaim logic from memory.reclaim handler to a generic
> user_proactive_reclaim() helper to be used for per-node proactive
> reclaim.
> 
> However, user_proactive_reclaim() was only defined under CONFIG_NUMA,
> with a stub always returning 0 otherwise. This broke memory.reclaim on
> !CONFIG_NUMA configs, causing it to report success without actually
> attempting reclaim.
> 
> Move the definition of user_proactive_reclaim() outside CONFIG_NUMA, and
> instead define a stub for __node_reclaim() in the !CONFIG_NUMA case.
> __node_reclaim() is only called from user_proactive_reclaim() when a
> write is made to sys/devices/system/node/nodeX/reclaim, which is only
> defined with CONFIG_NUMA.
> 
> Fixes: 2b7226af730c ("mm/memcg: make memory.reclaim interface generic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Ouch.
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks for catching that up.

> ---
>  mm/internal.h |  8 --------
>  mm/vmscan.c   | 13 +++++++++++--
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 33eb0224f461..9508dbaf47cd 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -615,16 +615,8 @@ extern unsigned long highest_memmap_pfn;
>  bool folio_isolate_lru(struct folio *folio);
>  void folio_putback_lru(struct folio *folio);
>  extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
> -#ifdef CONFIG_NUMA
>  int user_proactive_reclaim(char *buf,
>  			   struct mem_cgroup *memcg, pg_data_t *pgdat);
> -#else
> -static inline int user_proactive_reclaim(char *buf,
> -			   struct mem_cgroup *memcg, pg_data_t *pgdat)
> -{
> -	return 0;
> -}
> -#endif
>  
>  /*
>   * in mm/rmap.c:
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7b28018ac995..d9918f24dea0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7849,6 +7849,17 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>  	return ret;
>  }
>  
> +#else
> +
> +static unsigned long __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask,
> +				    unsigned long nr_pages,
> +				    struct scan_control *sc)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>  enum {
>  	MEMORY_RECLAIM_SWAPPINESS = 0,
>  	MEMORY_RECLAIM_SWAPPINESS_MAX,
> @@ -7956,8 +7967,6 @@ int user_proactive_reclaim(char *buf,
>  	return 0;
>  }
>  
> -#endif
> -
>  /**
>   * check_move_unevictable_folios - Move evictable folios to appropriate zone
>   * lru list
> -- 
> 2.52.0.457.g6b5491de43-goog

-- 
Michal Hocko
SUSE Labs

