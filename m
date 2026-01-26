Return-Path: <stable+bounces-211529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEPjKtcnd2kUcwEAu9opvQ
	(envelope-from <stable+bounces-211529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:37:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6058588B
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C951B3006B09
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104E2AF1D;
	Mon, 26 Jan 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nOtrzNVo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5HuaIWBT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WaKuCiJh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ALuzgEkT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54271DF254
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416653; cv=none; b=rBLNOt5uruf16nifxe6Ed3Lzy4JYAlkkcrIzcP7nHqxH9l0WfgfMv68zH8TH7tDcl/W5jxCr60gmOk+RdwV1IWm8nNlHe0U9m0o0ciNQI/R8jbzwcAyRvYWYwRKKZtuwdg4LnaIl4psWLZEmBsZQ5shJ5LGGJn5Di3JUhfg5rPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416653; c=relaxed/simple;
	bh=uiPZ3Fyln4O6TvOvNqyOg0PsGKLU1SW9h0osg0PaE7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQyiqTOWKSGt4IA/XEYda7j1167jsxUmYnpT70pt0NTTH5Yf2GcUlagN/b2dSjpQlKJjtR0WMObxfkrIqD4KH8XSGPq84Qb0aseCSMNORC57KnRbDFemKN9fgukQml1LpJSlehSCD/jB+TPBWItTDvWg1w/flyBzzmkXWiPXxsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nOtrzNVo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5HuaIWBT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WaKuCiJh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ALuzgEkT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBE01336B9;
	Mon, 26 Jan 2026 08:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769416650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ItVJe7EX5a0KaCp3PFewhzHNmoMV6IH1mvEqTdGuR2U=;
	b=nOtrzNVobZK+SmtfDIVfqP4FAtD5jH15w7xyDXOFUXOPwKHLAkL3nPyJF1lV7a2kRpfC02
	9VgCfDl0xi01UmUyMtS7Zk/crXtXFt9CQHtqhRVY+WNpmBtFJZgLOlz5+x7YG+1SlObpcI
	7EUHdTQcV6BMhpTqEpG7v08KYJM6WDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769416650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ItVJe7EX5a0KaCp3PFewhzHNmoMV6IH1mvEqTdGuR2U=;
	b=5HuaIWBT4KU85Ffu6GJp2V4mZtgm1hHGgGxaSxBIvlHI4jyIQGGu/rw2Lf9TsZ+Cak10q0
	mLc4oCna6zy+sIAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769416649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ItVJe7EX5a0KaCp3PFewhzHNmoMV6IH1mvEqTdGuR2U=;
	b=WaKuCiJh4yqZaIGkrbgJFPBU3aWVrWGUdejtXJ1CqJO1CGoOomyo/cN2K+1pf+fqqsWrX/
	FF9MHrJl0p2hbq2VJ2XHLsHJ+dW79wCFqhHgVRHHP1QU4AvxnhWVPOnxKJVLmZYrN5B+OV
	7UODzNNZaV/wVDKebqeGV+rwk/2Krec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769416649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ItVJe7EX5a0KaCp3PFewhzHNmoMV6IH1mvEqTdGuR2U=;
	b=ALuzgEkTkHJBPgrue4sgK/GLUhPIxnEz5rui0w0fuYcbzYLq7g+8rWjNCSHt94T7Kiu6wq
	I2sGHLZGuIKFJ7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE620139F0;
	Mon, 26 Jan 2026 08:37:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G8kKMsknd2lbJQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Jan 2026 08:37:29 +0000
Message-ID: <55ab1a9b-1d7a-4e7e-b6bc-ee327197dc4b@suse.cz>
Date: Mon, 26 Jan 2026 09:37:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: avoid allocating slabobj_ext array from its own
 slab
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cl@gentwo.org,
 rientjes@google.com, surenb@google.com, hao.li@linux.dev,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
References: <20260124104614.9739-1-harry.yoo@oracle.com>
 <2b116198-b27a-4b20-90b2-951343f9fff1@suse.cz> <aXcmGMlH3sWO03rv@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aXcmGMlH3sWO03rv@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-211529-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D6058588B
X-Rspamd-Action: no action

On 1/26/26 09:30, Harry Yoo wrote:
> On Mon, Jan 26, 2026 at 08:36:16AM +0100, Vlastimil Babka wrote:
> /*
>  * Calculate the allocation size for slabobj_ext array.
>  *
>  * When memory allocation profiling is enabled, the obj_exts array
>  * could be allocated from the same slab it's being allocated for.
>  * This would prevent the slab from ever being freed because it would
>  * always contain at least one allocated object (its own obj_exts array).
>  *
>  * To avoid this, increase the allocation size when we detect the array
>  * would come from the same cache, forcing it to use a different cache.
>  */
> static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
>                                          struct slab *slab, gfp_t gfp)
> {
>         size_t sz = sizeof(struct slabobj_ext) * slab->objects;
>         struct kmem_cache *obj_exts_cache;
> 
>         /*
>          * slabobj_ext array for KMALLOC_CGROUP allocations
>          * are served from KMALLOC_NORMAL caches.
>          */
>         if (!mem_alloc_profiling_enabled())
>                 return sz;
> 
>         if (sz > KMALLOC_MAX_CACHE_SIZE)
>                 return sz;
> 
>         if (!is_kmalloc_normal(s))
>                 return sz;
> 
>         obj_exts_cache = kmalloc_slab(sz, NULL, gfp, 0);
>         /*
>          * Random kmalloc caches have multiple caches per size, and the cache

Maybe start with something like "We can't simply compare s with
obj_exts_cache, because..."

>          * is selected by the caller address. Since caller address may differ
>          * between kmalloc_slab() and actual allocation, bump size when both
>          * are normal kmalloc caches of same size.

As we don't test the other for normal kmalloc(), anymore this now reads as
if we forgot to.

>          */
>         if (s->size == obj_exts_cache->size)
>                 return s->object_size + 1;

Why switch to size from object_size for the checks? I'd be worried that due
to debugging etc this can yield wrong results?

> 
>         return sz;
> }
> 


