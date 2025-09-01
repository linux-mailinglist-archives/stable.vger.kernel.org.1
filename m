Return-Path: <stable+bounces-176804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDBBB3DCE3
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5537ADB8A
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A8F2FE592;
	Mon,  1 Sep 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D2kygCGl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wd192ord";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D2kygCGl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wd192ord"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766292FE068;
	Mon,  1 Sep 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716378; cv=none; b=MFjsvdnYOflIegmBUUMOX80Qz8NpyhfXwkNY+E4U6f124JfbLLb7Kf8/n/klXATMPGDxBj9pijdvTLXB2hZbwgH7r5Y4a/SPHPO6fbTDFFAIO7oYbm1HE1Pb92cUe36D2o8BxS8sM9hUlN9dFVKPf7Hmephal5kdKQ+yAzMcLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716378; c=relaxed/simple;
	bh=C5w4bDLt6cXypSVDcIbljs9SBt/bo/XDsluQD8ZIOJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAXXq9f+5wuD2sGns+17EkovogkbX6Tjn2jOJeNcPW4aCT9rGNdapcEwcXhwxPyfVSvkDQWqdhzYrA2boDjSDkQHBnXwNj+MzDTOQiYulpRM7AtNKVfNKTLrVNWOJyQhO2pp970DyFpXln0jmPqLEAPMjzTGXYB7TSyEq41kIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D2kygCGl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wd192ord; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D2kygCGl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wd192ord; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 699C8211CC;
	Mon,  1 Sep 2025 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756716374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Q86hpfGSgj8G2VobCdpf5XaVDOntwogaH4eosMO5QM=;
	b=D2kygCGlMOBUyc4KGcqkNdFxDuICVU4luwj+dCGmzIwQGSDapoWvPmDKcAP7EwrB32Dpi+
	YyIaO97+tBdJiAK5pMLtxnS4RfOkhcJFvIoJN4m/bAzvgKAvtNd+XbgAf//TKYwEXUy8kf
	IunEGyLyaL3e4liMixwoQ2XSr4gTtLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756716374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Q86hpfGSgj8G2VobCdpf5XaVDOntwogaH4eosMO5QM=;
	b=wd192ordSKJwEnTfQGm6oLt/dtVj0CzpofkMehpeKk8K89wtasgVHiR0/s9lV9AlDC3y9X
	baqf6ueZTa1ZFBCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D2kygCGl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wd192ord
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756716374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Q86hpfGSgj8G2VobCdpf5XaVDOntwogaH4eosMO5QM=;
	b=D2kygCGlMOBUyc4KGcqkNdFxDuICVU4luwj+dCGmzIwQGSDapoWvPmDKcAP7EwrB32Dpi+
	YyIaO97+tBdJiAK5pMLtxnS4RfOkhcJFvIoJN4m/bAzvgKAvtNd+XbgAf//TKYwEXUy8kf
	IunEGyLyaL3e4liMixwoQ2XSr4gTtLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756716374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Q86hpfGSgj8G2VobCdpf5XaVDOntwogaH4eosMO5QM=;
	b=wd192ordSKJwEnTfQGm6oLt/dtVj0CzpofkMehpeKk8K89wtasgVHiR0/s9lV9AlDC3y9X
	baqf6ueZTa1ZFBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23F89136ED;
	Mon,  1 Sep 2025 08:46:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PWRbCFZdtWg5YQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 08:46:14 +0000
Message-ID: <c85034fe-d48e-4433-8c65-52bfb1d5d69b@suse.cz>
Date: Mon, 1 Sep 2025 10:46:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: slub: avoid wake up kswapd in set_track_prepare
Content-Language: en-US
To: yangshiguang <yangshiguang1011@163.com>
Cc: David Rientjes <rientjes@google.com>, harry.yoo@oracle.com,
 akpm@linux-foundation.org, cl@gentwo.org, roman.gushchin@linux.dev,
 glittao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 yangshiguang <yangshiguang@xiaomi.com>, stable@vger.kernel.org
References: <20250830020946.1767573-1-yangshiguang1011@163.com>
 <c8f6933e-f733-4f86-c09d-8028ad862f33@google.com>
 <7f30ddd1-c6f7-4b2b-a2b9-875844092e28@suse.cz>
 <11922bd5.7fae.1990464d9c8.Coremail.yangshiguang1011@163.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <11922bd5.7fae.1990464d9c8.Coremail.yangshiguang1011@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux-foundation.org,gentwo.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,xiaomi.com];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 699C8211CC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 9/1/25 10:29, yangshiguang wrote:
> 
> 
> At 2025-09-01 16:15:04, "Vlastimil Babka" <vbabka@suse.cz> wrote:
>>On 9/1/25 09:50, David Rientjes wrote:
>>> On Sat, 30 Aug 2025, yangshiguang1011@163.com wrote:
>>> 
>>>> From: yangshiguang <yangshiguang@xiaomi.com>
>>>> 
>>>> From: yangshiguang <yangshiguang@xiaomi.com>
>>>> 
>>> 
>>> Duplicate lines.
>>> 
>>>> set_track_prepare() can incur lock recursion.
>>>> The issue is that it is called from hrtimer_start_range_ns
>>>> holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
>>>> CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
>>>> and try to hold the per_cpu(hrtimer_bases)[n].lock.
>>>> 
>>>> Avoid deadlock caused by implicitly waking up kswapd by
>>>> passing in allocation flags. And the slab caller context has
>>>> preemption disabled, so __GFP_KSWAPD_RECLAIM must not appear in gfp_flags.
>>>> 
>>> 
>>> This mentions __GFP_KSWAPD_RECLAIM, but the patch actually masks off 
>>> __GFP_DIRECT_RECLAIM which would be a heavierweight operation.  Disabling 
>>> direct reclaim does not necessarily imply that kswapd will be disabled as 
>>> well.
>>
>>Yeah I think the changelog should say __GFP_DIRECT_RECLAIM.
>>
>>> Are you meaning to clear __GFP_RECLAIM in set_track_prepare()?
>>
>>No because if the context context (e.g. the hrtimers) can't support
>>__GFP_KSWAPD_RECLAIM it won't have it in gfp_flags and we now pass them to
> 
>>set_track_prepare() so it already won't be there.
> 
> 
> Sry. Should be __GFP_DIRECT_RECLAIM. I will resend the patch.

I have adjusted it locally already. Also moved the masking of
__GFP_DIRECT_RECLAIM to ___slab_alloc itself as that's where
the preemption is disabled so it's more obvious.

Does the result look good to you?

commit 1b7052bc536650f8ca29b4f6f8682dc9f5692d16
Author: yangshiguang <yangshiguang@xiaomi.com>
Date:   Sat Aug 30 10:09:46 2025 +0800

    mm: slub: avoid wake up kswapd in set_track_prepare
    
    set_track_prepare() can incur lock recursion.
    The issue is that it is called from hrtimer_start_range_ns
    holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
    CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
    and try to hold the per_cpu(hrtimer_bases)[n].lock.
    
    Avoid deadlock caused by implicitly waking up kswapd by passing in
    allocation flags, which do not contain __GFP_KSWAPD_RECLAIM in the
    debug_objects_fill_pool() case.
    Since ___slab_alloc() has preemption disabled and thus was using
    GFP_NOWAIT, we instead mask out __GFP_DIRECT_RECLAIM from the flags.
    
    The oops looks something like:
    
    BUG: spinlock recursion on CPU#3, swapper/3/0
     lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
    Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
    Call trace:
    spin_bug+0x0
    _raw_spin_lock_irqsave+0x80
    hrtimer_try_to_cancel+0x94
    task_contending+0x10c
    enqueue_dl_entity+0x2a4
    dl_server_start+0x74
    enqueue_task_fair+0x568
    enqueue_task+0xac
    do_activate_task+0x14c
    ttwu_do_activate+0xcc
    try_to_wake_up+0x6c8
    default_wake_function+0x20
    autoremove_wake_function+0x1c
    __wake_up+0xac
    wakeup_kswapd+0x19c
    wake_all_kswapds+0x78
    __alloc_pages_slowpath+0x1ac
    __alloc_pages_noprof+0x298
    stack_depot_save_flags+0x6b0
    stack_depot_save+0x14
    set_track_prepare+0x5c
    ___slab_alloc+0xccc
    __kmalloc_cache_noprof+0x470
    __set_page_owner+0x2bc
    post_alloc_hook[jt]+0x1b8
    prep_new_page+0x28
    get_page_from_freelist+0x1edc
    __alloc_pages_noprof+0x13c
    alloc_slab_page+0x244
    allocate_slab+0x7c
    ___slab_alloc+0x8e8
    kmem_cache_alloc_noprof+0x450
    debug_objects_fill_pool+0x22c
    debug_object_activate+0x40
    enqueue_hrtimer[jt]+0xdc
    hrtimer_start_range_ns+0x5f8
    ...
    
    Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
    Fixes: 5cf909c553e9 ("mm/slub: use stackdepot to save stack trace in objects")
    Cc: stable@vger.kernel.org
    Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

diff --git a/mm/slub.c b/mm/slub.c
index 1787e4d51e48..d257141896c9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -962,19 +962,19 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 }
 
 #ifdef CONFIG_STACKDEPOT
-static noinline depot_stack_handle_t set_track_prepare(void)
+static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	depot_stack_handle_t handle;
 	unsigned long entries[TRACK_ADDRS_COUNT];
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
-	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+	handle = stack_depot_save(entries, nr_entries, gfp_flags);
 
 	return handle;
 }
 #else
-static inline depot_stack_handle_t set_track_prepare(void)
+static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	return 0;
 }
@@ -996,9 +996,9 @@ static void set_track_update(struct kmem_cache *s, void *object,
 }
 
 static __always_inline void set_track(struct kmem_cache *s, void *object,
-				      enum track_item alloc, unsigned long addr)
+				      enum track_item alloc, unsigned long addr, gfp_t gfp_flags)
 {
-	depot_stack_handle_t handle = set_track_prepare();
+	depot_stack_handle_t handle = set_track_prepare(gfp_flags);
 
 	set_track_update(s, object, alloc, addr, handle);
 }
@@ -1926,9 +1926,9 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
 static inline int check_object(struct kmem_cache *s, struct slab *slab,
 			void *object, u8 val) { return 1; }
-static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
+static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags) { return 0; }
 static inline void set_track(struct kmem_cache *s, void *object,
-			     enum track_item alloc, unsigned long addr) {}
+			     enum track_item alloc, unsigned long addr, gfp_t gfp_flags) {}
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
 					struct slab *slab) {}
 static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
@@ -3881,9 +3881,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			 * For debug caches here we had to go through
 			 * alloc_single_from_partial() so just store the
 			 * tracking info and return the object.
+			 *
+			 * Due to disabled preemption we need to disallow
+			 * blocking. The flags are further adjusted by
+			 * gfp_nested_mask() in stack_depot itself.
 			 */
 			if (s->flags & SLAB_STORE_USER)
-				set_track(s, freelist, TRACK_ALLOC, addr);
+				set_track(s, freelist, TRACK_ALLOC, addr,
+					  gfpflags & ~(__GFP_DIRECT_RECLAIM));
 
 			return freelist;
 		}
@@ -3915,7 +3920,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto new_objects;
 
 		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
+			set_track(s, freelist, TRACK_ALLOC, addr,
+				  gfpflags & ~(__GFP_DIRECT_RECLAIM));
 
 		return freelist;
 	}
@@ -4426,8 +4432,12 @@ static noinline void free_to_partial_list(
 	unsigned long flags;
 	depot_stack_handle_t handle = 0;
 
+	/*
+	 * We cannot use GFP_NOWAIT as there are callsites where waking up
+	 * kswapd could deadlock
+	 */
 	if (s->flags & SLAB_STORE_USER)
-		handle = set_track_prepare();
+		handle = set_track_prepare(__GFP_NOWARN);
 
 	spin_lock_irqsave(&n->list_lock, flags);
 


