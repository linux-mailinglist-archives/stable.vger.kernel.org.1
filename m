Return-Path: <stable+bounces-43531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736998C22B1
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 13:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E196D1F229B0
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B445916D320;
	Fri, 10 May 2024 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gciWar13"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AA82C6C;
	Fri, 10 May 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339095; cv=none; b=ItmQ4mrsEX3CqW+zf4+Lv8S08fmDZYpBVETaEWglZ+EFUkqmuNHIhcxrE+z6F58+QJ3y3YJKT9csZhtRBRT5hYn0yXu37TzjN3BxncWd3B3w1DbUJOoerpIlfbkyKYW5R2iWresaqg8p4d8D3fsF2hqQkBtAt/f1b6QNNDbOY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339095; c=relaxed/simple;
	bh=/AbLtv5qJYURPkAqLByoz8wtqVadIyU5TujTScOCGOs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBYqOBYSKz3x6SvFJ3AgEgGmtv8L5zeQXc9W+Mp+a1ru3AkWGwCjszZtsMEVnI1vRIA7MXxDWo4PqoM81W03MtzpqMWJHreJXaRmT4MOCtnaIrlSLLknE6J16XzsfHnOoOm4ffgR1ngvxo5Eo3k6s96oVUkRYixEuV1NNGPHbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gciWar13; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so21448631fa.3;
        Fri, 10 May 2024 04:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715339092; x=1715943892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4a6MqAXgOYgO/zeSg4OXSoaN8MW/2yPAiLOJV3hKyn4=;
        b=gciWar13fHRV/bWCMi6j6z4fg+JsBPqhmK6ektOQAhVj3kKtaMUY57rYjzQS6H2tin
         aSSPU6djWF6xyhDR7HJ7QHe12djvNMycLPjPDx6Vq6eXlhLvW33dhpIgTrv2lsjiaVrP
         ZPY0mEr+KBMQ0e+Nn9q6fFKTC0g4yObfU7Ub2lH0SjswISrMQk6lW+F5Ltzflt3dp63K
         wmyZVrafJkwFc4scW26IlzHPnWxkT+RZ/0uhUB8dJZ4Iw8ulowumAYi4woKg8Hb/PMUv
         nnezz9Racv5P3/G6JoLsjBHwpLc5PxBY1PR4Nd4YCDAbsF0M+LHAuPOiemBjBULetHyQ
         eMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339092; x=1715943892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a6MqAXgOYgO/zeSg4OXSoaN8MW/2yPAiLOJV3hKyn4=;
        b=i0UraNhl7gny/TN6Xaw+ucI6FekdbvfTQdeqGcOma6dEB6o1uU/KuMArqpHaHs3BJF
         mmiWu99AGyBaC7Un6MRyVV7vLlFYrjG6KYX9sp3kSrSFhwuzQ5AQy5Da/cF6M/1gwA6G
         RPDyLmQWvopLGY3/0NtaYRLxyyEvu6oSR53eB1FjxEAO58qKYjk6pM0k/n8aeXfkLW2o
         xiQs3oXPOah8UcZhCJfy1833Fo1xfEyGo+YlSJmGY0bohW3GlxD1Ggmkp3lUH6wNVfum
         4jliMO4qkuBCNiQQ5w0zDCHhnrmGAQFQ2cY+dNjaygnq6JM2JweNcFjHkGWrqoOTfwbG
         GDrw==
X-Forwarded-Encrypted: i=1; AJvYcCV8OLom6hvY3KSHb3wb+8Q2OpOvsqOYZhR3W8O3oyYQDtPe60Paa+vhNS43jY2R+9363mLReNJlt3VDFfx5oax1hvjgYonCzFS3JavQUbEJEBFemEKd55LolnWyvBd4e7gZo8Vk
X-Gm-Message-State: AOJu0Yyid5nvjgZDvthJ/eUvcqLr24W4t6OPoJNce89g4dAyHtIDsrqM
	0PS1MqFPTjZrrHXqeKGfRtLTsqg1zlfzI3Z7SnRsk3/pyDrXUCR3
X-Google-Smtp-Source: AGHT+IHNdtEdIiwJ0odNu9WSq6dAR5BKpqr2GOix0my+cZM7OnDExinCASQ62/8BSIIHVZjIhdalGw==
X-Received: by 2002:a2e:8449:0:b0:2e0:3132:94d4 with SMTP id 38308e7fff4ca-2e51fe53f21mr14120001fa.16.1715339091512;
        Fri, 10 May 2024 04:04:51 -0700 (PDT)
Received: from pc636 (host-90-235-3-187.mobileonline.telia.com. [90.235.3.187])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ef17absm4761551fa.62.2024.05.10.04.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:04:51 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 10 May 2024 13:04:47 +0200
To: hailong.liu@oppo.com
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, 21cnbao@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, xiang@kernel.org, chao@kernel.org,
	mhocko@suse.com, stable@vger.kernel.org,
	Oven <liyangouwen1@oppo.com>
Subject: Re: [PATCH v2] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <Zj3_T_lFU6WGUXHt@pc636>
References: <20240510100131.1865-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510100131.1865-1-hailong.liu@oppo.com>

On Fri, May 10, 2024 at 06:01:31PM +0800, hailong.liu@oppo.com wrote:
> From: "Hailong.Liu" <hailong.liu@oppo.com>
> 
> commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> includes support for __GFP_NOFAIL, but it presents a conflict with
> commit dd544141b9eb ("vmalloc: back off when the current task is
> OOM-killed"). A possible scenario is as follows:
> 
> process-a
> __vmalloc_node_range(GFP_KERNEL | __GFP_NOFAIL)
>     __vmalloc_area_node()
>         vm_area_alloc_pages()
> 		--> oom-killer send SIGKILL to process-a
>         if (fatal_signal_pending(current)) break;
> --> return NULL;
> 
> To fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> if __GFP_NOFAIL set.
> 
> Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
> Cc: <stable@vger.kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Barry Song <21cnbao@gmail.com>
> Reported-by: Oven <liyangouwen1@oppo.com>
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> ---
>  mm/vmalloc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 125427cbdb87..109272b8ee2e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3492,7 +3492,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  {
>  	unsigned int nr_allocated = 0;
>  	gfp_t alloc_gfp = gfp;
> -	bool nofail = false;
> +	bool nofail = gfp & __GFP_NOFAIL;
>  	struct page *page;
>  	int i;
> 
> @@ -3549,12 +3549,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		 * and compaction etc.
>  		 */
>  		alloc_gfp &= ~__GFP_NOFAIL;
> -		nofail = true;
>  	}
> 
>  	/* High-order pages or fallback path if "bulk" fails. */
>  	while (nr_allocated < nr_pages) {
> -		if (fatal_signal_pending(current))
> +		if (!nofail && fatal_signal_pending(current))
>  			break;
> 
>  		if (nid == NUMA_NO_NODE)
> ---
> Changes since RFC v1 [1]:
> - Remove RFC tag
> - Add fixes, per Michal
> - Use nofail instead of gfp & __GFP_NOFAIL, per Barry & Michal
> - Modify commit log, per Barry
> 
> [1] https://lore.kernel.org/all/20240508125808.28882-1-hailong.liu@oppo.com/
> 
> This issue occurred during OPLUS KASAN TEST. Below is part of the log
> -> oom-killer sends signal to process
> [65731.222840] [ T1308] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/apps/uid_10198,task=gs.intelligence,pid=32454,uid=10198
> 
> [65731.259685] [T32454] Call trace:
> [65731.259698] [T32454]  dump_backtrace+0xf4/0x118
> [65731.259734] [T32454]  show_stack+0x18/0x24
> [65731.259756] [T32454]  dump_stack_lvl+0x60/0x7c
> [65731.259781] [T32454]  dump_stack+0x18/0x38
> [65731.259800] [T32454]  mrdump_common_die+0x250/0x39c [mrdump]
> [65731.259936] [T32454]  ipanic_die+0x20/0x34 [mrdump]
> [65731.260019] [T32454]  atomic_notifier_call_chain+0xb4/0xfc
> [65731.260047] [T32454]  notify_die+0x114/0x198
> [65731.260073] [T32454]  die+0xf4/0x5b4
> [65731.260098] [T32454]  die_kernel_fault+0x80/0x98
> [65731.260124] [T32454]  __do_kernel_fault+0x160/0x2a8
> [65731.260146] [T32454]  do_bad_area+0x68/0x148
> [65731.260174] [T32454]  do_mem_abort+0x151c/0x1b34
> [65731.260204] [T32454]  el1_abort+0x3c/0x5c
> [65731.260227] [T32454]  el1h_64_sync_handler+0x54/0x90
> [65731.260248] [T32454]  el1h_64_sync+0x68/0x6c
> 
> [65731.260269] [T32454]  z_erofs_decompress_queue+0x7f0/0x2258
> --> be->decompressed_pages = kvcalloc(be->nr_pages, sizeof(struct page *), GFP_KERNEL | __GFP_NOFAIL);
> 	kernel panic by NULL pointer dereference.
> 	erofs assume kvmalloc with __GFP_NOFAIL never return NULL.
> [65731.260293] [T32454]  z_erofs_runqueue+0xf30/0x104c
> [65731.260314] [T32454]  z_erofs_readahead+0x4f0/0x968
> [65731.260339] [T32454]  read_pages+0x170/0xadc
> [65731.260364] [T32454]  page_cache_ra_unbounded+0x874/0xf30
> [65731.260388] [T32454]  page_cache_ra_order+0x24c/0x714
> [65731.260411] [T32454]  filemap_fault+0xbf0/0x1a74
> [65731.260437] [T32454]  __do_fault+0xd0/0x33c
> [65731.260462] [T32454]  handle_mm_fault+0xf74/0x3fe0
> [65731.260486] [T32454]  do_mem_abort+0x54c/0x1b34
> [65731.260509] [T32454]  el0_da+0x44/0x94
> [65731.260531] [T32454]  el0t_64_sync_handler+0x98/0xb4
> [65731.260553] [T32454]  el0t_64_sync+0x198/0x19c
> --
> 2.34.1
> 
Makes sense to me:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

