Return-Path: <stable+bounces-67405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3094FA51
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 01:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7241C222C6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE6170A22;
	Mon, 12 Aug 2024 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3iz2srk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F17E0E8
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505665; cv=none; b=OJQm9q4YuSeWRtvELyLnuU3RXWceoKq/CyzU5LioPBDhCe4L/QHt21fi1HmyjUzAjKPDJOkYU9PIEDi++pdR7+95p1ol8Z5cDqV6D8PAK3OPoUSobpV/kVYY/MVLQ3BXJznE6QTiYlrnqYDqwFYikenaRB0PY+2PXF22Cg6Iyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505665; c=relaxed/simple;
	bh=jvTBjRpRoW78XsIotGEOmlF/dnPKtDcAOdq6tU7Lnuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQFCHpv6+EoUgSlg5mHJgcUBEWKcr+RLg+pkNjLlZAlLtMqvHN8CwrRzzOF95eYTtWPwzc+ehD0SwmD8K5L6rnz6LfOXC50Iul43issA3GqnGaE/MB1srQf61Q1XTmuYNDIS9rUuRPD2joEFb5xnH7OTN1C0YO75yDz/VQUyDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3iz2srk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723505661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xKDbGaTX8EZpcenHgPa8veNn1wKEPpwdIKATGSiYtC4=;
	b=V3iz2srkHdsuFli8Aeu2AVWmttkvtREhNJogzDYmqStuU3Bx56kFvSY8Ah2Ot4JpfqkAH8
	IZwWBXx0AO+7YK4Xka0tFbna04Ea1tch7f44XjMxUCsIHCUDak1sE/Q3/mQMN/PsgwqTz5
	3VhnIijfcHhaZaPFyviF3fW/v9Gu0Q4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-9hhukabLNNaaRmDZhHsE1w-1; Mon,
 12 Aug 2024 19:34:18 -0400
X-MC-Unique: 9hhukabLNNaaRmDZhHsE1w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E4DC1955F45;
	Mon, 12 Aug 2024 23:34:16 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B6CB30001A1;
	Mon, 12 Aug 2024 23:34:14 +0000 (UTC)
Date: Tue, 13 Aug 2024 07:34:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	"Hailong . Liu" <hailong.liu@oppo.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: Ensure vmap_block is initialised before
 adding to queue
Message-ID: <Zrqb8n3DikE+K+Xm@MiWiFi-R3L-srv>
References: <20240812171606.17486-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812171606.17486-1-will@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/12/24 at 06:16pm, Will Deacon wrote:
> Commit 8c61291fd850 ("mm: fix incorrect vbq reference in
> purge_fragmented_block") extended the 'vmap_block' structure to contain
> a 'cpu' field which is set at allocation time to the id of the
> initialising CPU.
> 
> When a new 'vmap_block' is being instantiated by new_vmap_block(), the
> partially initialised structure is added to the local 'vmap_block_queue'
> xarray before the 'cpu' field has been initialised. If another CPU is
> concurrently walking the xarray (e.g. via vm_unmap_aliases()), then it
> may perform an out-of-bounds access to the remote queue thanks to an
> uninitialised index.
> 
> This has been observed as UBSAN errors in Android:
> 
>  | Internal error: UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
>  |
>  | Call trace:
>  |  purge_fragmented_block+0x204/0x21c
>  |  _vm_unmap_aliases+0x170/0x378
>  |  vm_unmap_aliases+0x1c/0x28
>  |  change_memory_common+0x1dc/0x26c
>  |  set_memory_ro+0x18/0x24
>  |  module_enable_ro+0x98/0x238
>  |  do_init_module+0x1b0/0x310
> 
> Move the initialisation of 'vb->cpu' in new_vmap_block() ahead of the
> addition to the xarray.
> 
> Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> Cc: Hailong.Liu <hailong.liu@oppo.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 8c61291fd850 ("mm: fix incorrect vbq reference in purge_fragmented_block")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---

Good catch, this truly could happen and collapse system.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> I _think_ the insertion into the free list is ok, as the vb shouldn't be
> considered for purging if it's clean. It would be great if somebody more
> familiar with this code could confirm either way, however.

It's OK, please see below comment.

static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
{
......
        vaddr = vmap_block_vaddr(va->va_start, 0);
        spin_lock_init(&vb->lock);
        vb->va = va;
        /* At least something should be left free */
        BUG_ON(VMAP_BBMAP_BITS <= (1UL << order));
        bitmap_zero(vb->used_map, VMAP_BBMAP_BITS);
        vb->free = VMAP_BBMAP_BITS - (1UL << order);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         Here we have cut away one piece according to vb_alloc() and set vb->free.
        vb->dirty = 0;
        vb->dirty_min = VMAP_BBMAP_BITS;
        vb->dirty_max = 0;
        bitmap_set(vb->used_map, 0, (1UL << order));
        INIT_LIST_HEAD(&vb->free_list);
...
}

static bool purge_fragmented_block(struct vmap_block *vb,
                struct list_head *purge_list, bool force_purge)
{
        struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, vb->cpu);

        if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ The above setting
                of vb->free and vb->dirty will fail conditional check here.
                So it won't be purged. 
            vb->dirty == VMAP_BBMAP_BITS)
                return false;
 
        /* Don't overeagerly purge usable blocks unless requested */
        if (!(force_purge || vb->free < VMAP_PURGE_THRESHOLD))
                return false;
...
}
> 
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6b783baf12a1..64c0a2c8a73c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2626,6 +2626,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	vb->dirty_max = 0;
>  	bitmap_set(vb->used_map, 0, (1UL << order));
>  	INIT_LIST_HEAD(&vb->free_list);
> +	vb->cpu = raw_smp_processor_id();
>  
>  	xa = addr_to_vb_xa(va->va_start);
>  	vb_idx = addr_to_vb_idx(va->va_start);
> @@ -2642,7 +2643,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	 * integrity together with list_for_each_rcu from read
>  	 * side.
>  	 */
> -	vb->cpu = raw_smp_processor_id();
>  	vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
>  	spin_lock(&vbq->lock);
>  	list_add_tail_rcu(&vb->free_list, &vbq->free);
> -- 
> 2.46.0.76.ge559c4bf1a-goog
> 


