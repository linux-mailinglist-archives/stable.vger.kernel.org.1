Return-Path: <stable+bounces-132285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40E9A8632E
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA2B3B67C2
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6421B91F;
	Fri, 11 Apr 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gefXXaXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vLdLttkG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gefXXaXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vLdLttkG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8663020FA8B
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388827; cv=none; b=X3lNztDUeBhAuIMo3SRjvHLIaXdXI5+AFVKnDF1amjXQ2p3tk5baPziB1oTev1d0b75FMqID2Lt4X8dfUrY1RQqGMis1FHQvE9tmJQJDgPWFFf1geOnMS3/1wTI9SDZcN449NLD4nZ3dDddppEisgc2fKpq+DLn90r9tw+VjHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388827; c=relaxed/simple;
	bh=qN+fveIB7Z/uxWyU4hV35lEUrbKyoG6kZOE6JvM5BEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LV8xFS/LY7yIjQOh3ginSv0XfnfgkRAalmRO4ASgdU2u5STdAVC0szuSd6aSdVEnIBk2wbf9MfFSAXHg3fdD59yJqFO+CFiUoCv03eGTC1UYdmDVoegus5IzDAjLk3jM0/g+wW4NPJj3P6wFVD3r+6osXuWKisVR0r3hOLmfMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gefXXaXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vLdLttkG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gefXXaXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vLdLttkG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1725121197;
	Fri, 11 Apr 2025 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744388823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=236nQ8T7pqzlQq9bwZKJotq/CNMIrrJmnALSAeK5HJ8=;
	b=gefXXaXXMXhnoCT7Ah6ijWqatyPfpdMiLrQaAnWfi1hVKWyqD4KKClHwy/PNHQxCRR+3s8
	dXCHMWLB5jkioX3YvU3sQes1t95NSGG+CGYeEM2SdxG+XmUHjCaCpCq8AEnQmyz5wHneLQ
	Z29eHTg4oUjxTiMDt5w36LhI6XCX4gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744388823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=236nQ8T7pqzlQq9bwZKJotq/CNMIrrJmnALSAeK5HJ8=;
	b=vLdLttkGuf99qsUTibZx1xOu6OJdg+dZAMCI8QO1YmyWhqlhcIq0QCSAS7WLN/Ty34qvyN
	0VjmLcrnQ1RKiyAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gefXXaXX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vLdLttkG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744388823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=236nQ8T7pqzlQq9bwZKJotq/CNMIrrJmnALSAeK5HJ8=;
	b=gefXXaXXMXhnoCT7Ah6ijWqatyPfpdMiLrQaAnWfi1hVKWyqD4KKClHwy/PNHQxCRR+3s8
	dXCHMWLB5jkioX3YvU3sQes1t95NSGG+CGYeEM2SdxG+XmUHjCaCpCq8AEnQmyz5wHneLQ
	Z29eHTg4oUjxTiMDt5w36LhI6XCX4gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744388823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=236nQ8T7pqzlQq9bwZKJotq/CNMIrrJmnALSAeK5HJ8=;
	b=vLdLttkGuf99qsUTibZx1xOu6OJdg+dZAMCI8QO1YmyWhqlhcIq0QCSAS7WLN/Ty34qvyN
	0VjmLcrnQ1RKiyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC3E9136A4;
	Fri, 11 Apr 2025 16:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IvswOdZC+WfDLwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Apr 2025 16:27:02 +0000
Message-ID: <c88ec69c-87ee-4865-8b2a-87f32f46b0bc@suse.cz>
Date: Fri, 11 Apr 2025 18:26:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] slab: ensure slab->obj_exts is clear in a newly
 allocated slab page
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, roman.gushchin@linux.dev, cl@linux.com,
 rientjes@google.com, harry.yoo@oracle.com, souravpanda@google.com,
 pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250411155737.1360746-1-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250411155737.1360746-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1725121197
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/11/25 17:57, Suren Baghdasaryan wrote:
> ktest recently reported crashes while running several buffered io tests
> with __alloc_tagging_slab_alloc_hook() at the top of the crash call stack.
> The signature indicates an invalid address dereference with low bits of
> slab->obj_exts being set. The bits were outside of the range used by
> page_memcg_data_flags and objext_flags and hence were not masked out
> by slab_obj_exts() when obtaining the pointer stored in slab->obj_exts.
> The typical crash log looks like this:
> 
> 00510 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> 00510 Mem abort info:
> 00510   ESR = 0x0000000096000045
> 00510   EC = 0x25: DABT (current EL), IL = 32 bits
> 00510   SET = 0, FnV = 0
> 00510   EA = 0, S1PTW = 0
> 00510   FSC = 0x05: level 1 translation fault
> 00510 Data abort info:
> 00510   ISV = 0, ISS = 0x00000045, ISS2 = 0x00000000
> 00510   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> 00510   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> 00510 user pgtable: 4k pages, 39-bit VAs, pgdp=0000000104175000
> 00510 [0000000000000010] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> 00510 Internal error: Oops: 0000000096000045 [#1]  SMP
> 00510 Modules linked in:
> 00510 CPU: 10 UID: 0 PID: 7692 Comm: cat Not tainted 6.15.0-rc1-ktest-g189e17946605 #19327 NONE
> 00510 Hardware name: linux,dummy-virt (DT)
> 00510 pstate: 20001005 (nzCv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> 00510 pc : __alloc_tagging_slab_alloc_hook+0xe0/0x190
> 00510 lr : __kmalloc_noprof+0x150/0x310
> 00510 sp : ffffff80c87df6c0
> 00510 x29: ffffff80c87df6c0 x28: 000000000013d1ff x27: 000000000013d200
> 00510 x26: ffffff80c87df9e0 x25: 0000000000000000 x24: 0000000000000001
> 00510 x23: ffffffc08041953c x22: 000000000000004c x21: ffffff80c0002180
> 00510 x20: fffffffec3120840 x19: ffffff80c4821000 x18: 0000000000000000
> 00510 x17: fffffffec3d02f00 x16: fffffffec3d02e00 x15: fffffffec3d00700
> 00510 x14: fffffffec3d00600 x13: 0000000000000200 x12: 0000000000000006
> 00510 x11: ffffffc080bb86c0 x10: 0000000000000000 x9 : ffffffc080201e58
> 00510 x8 : ffffff80c4821060 x7 : 0000000000000000 x6 : 0000000055555556
> 00510 x5 : 0000000000000001 x4 : 0000000000000010 x3 : 0000000000000060
> 00510 x2 : 0000000000000000 x1 : ffffffc080f50cf8 x0 : ffffff80d801d000
> 00510 Call trace:
> 00510  __alloc_tagging_slab_alloc_hook+0xe0/0x190 (P)
> 00510  __kmalloc_noprof+0x150/0x310
> 00510  __bch2_folio_create+0x5c/0xf8
> 00510  bch2_folio_create+0x2c/0x40
> 00510  bch2_readahead+0xc0/0x460
> 00510  read_pages+0x7c/0x230
> 00510  page_cache_ra_order+0x244/0x3a8
> 00510  page_cache_async_ra+0x124/0x170
> 00510  filemap_readahead.isra.0+0x58/0xa0
> 00510  filemap_get_pages+0x454/0x7b0
> 00510  filemap_read+0xdc/0x418
> 00510  bch2_read_iter+0x100/0x1b0
> 00510  vfs_read+0x214/0x300
> 00510  ksys_read+0x6c/0x108
> 00510  __arm64_sys_read+0x20/0x30
> 00510  invoke_syscall.constprop.0+0x54/0xe8
> 00510  do_el0_svc+0x44/0xc8
> 00510  el0_svc+0x18/0x58
> 00510  el0t_64_sync_handler+0x104/0x130
> 00510  el0t_64_sync+0x154/0x158
> 00510 Code: d5384100 f9401c01 b9401aa3 b40002e1 (f8227881)
> 00510 ---[ end trace 0000000000000000 ]---
> 00510 Kernel panic - not syncing: Oops: Fatal exception
> 00510 SMP: stopping secondary CPUs
> 00510 Kernel Offset: disabled
> 00510 CPU features: 0x0000,000000e0,00000410,8240500b
> 00510 Memory Limit: none
> 
> Investigation indicates that these bits are already set when we allocate
> slab page and are not zeroed out after allocation. We are not yet sure
> why these crashes start happening only recently but regardless of the
> reason, not initializing a field that gets used later is wrong. Fix it
> by initializing slab->obj_exts during slab page allocation.

slab->obj_exts overlays page->memcg_data and the checks on page alloc and
page free should catch any non-zero values, i.e. page_expected_state()
page_bad_reason() so if anyone is e.g. UAF-writing there or leaving garbage
there while freeing the page it's a bug.

Perhaps CONFIG_MEMCG is disabled in the ktests and thus the checks are not
happening? We could extend them for CONFIG_SLAB_OBJ_EXT checking
_unused_slab_obj_exts perhaps. But it would be a short lived change, see below.

> Fixes: 21c690a349ba ("mm: introduce slabobj_ext to support slab object extensions")
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> Tested-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <stable@vger.kernel.org>

We'll need this anyway for the not so far future when struct slab is
separated from struct page so it's fine but it would still be great to find
the underlying buggy code which this is going to hide.

> ---
>  mm/slub.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b46f87662e71..dc9e729e1d26 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1973,6 +1973,11 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>  #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
>  				__GFP_ACCOUNT | __GFP_NOFAIL)
>  
> +static inline void init_slab_obj_exts(struct slab *slab)
> +{
> +	slab->obj_exts = 0;
> +}
> +
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		        gfp_t gfp, bool new_slab)
>  {
> @@ -2058,6 +2063,10 @@ static inline bool need_slab_obj_ext(void)
>  
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
> +static inline void init_slab_obj_exts(struct slab *slab)
> +{
> +}
> +
>  static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  			       gfp_t gfp, bool new_slab)
>  {
> @@ -2637,6 +2646,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  	slab->objects = oo_objects(oo);
>  	slab->inuse = 0;
>  	slab->frozen = 0;
> +	init_slab_obj_exts(slab);
>  
>  	account_slab(slab, oo_order(oo), s, flags);
>  
> 
> base-commit: c496b37f9061db039b413c03ccd33506175fe6ec


