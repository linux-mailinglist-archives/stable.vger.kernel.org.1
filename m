Return-Path: <stable+bounces-52132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B58B6908269
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 05:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391BF1F2222E
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 03:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF207E76D;
	Fri, 14 Jun 2024 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHHs6md5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997E5CB8
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718335105; cv=none; b=H8/ZZejnWlpvfEHNX16G4k0i0MdqMw/e5DJEsyogixCeRZl6G+yrUZ252fPK2HqAr/nQUKHCwml2JKqUahsjGLT6RlWlMwBZkfWJSE3MUxEQ7ZzaDAS/lydznJjixE2wxTokhUvvU3wXlT+Xab7p/jdWuNZdxNbGIWC8Jt04OPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718335105; c=relaxed/simple;
	bh=Eeo2kChNmJ3YVxA6IUniCUai1uvoIiWG53/gPfW0F6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNAeXxBYrp9Z35evWE0Z2af9PxSr2oJdlO4Ip+gA0oHxgA7hqVQd4vD/74g89S3dYaVednK5W83d+pJ8ju1tzGQUM4gEMmCFROz6nGvg+Y7qCACWMDrMjadbxg4Df3/cvVHvbIidEZcn8banpC6mEbT6zlgbTnF+R2KkKL2XcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHHs6md5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718335102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zID3RBBtLNCqI825Aa6VeGA/djgVKIddglnLoE0RH84=;
	b=cHHs6md5MLnSDoTE0cxXeOtNMzzcf26G0YFboQ9O33bhMlIJfMFPnwdO9j3991lonuYhKj
	K5QpAb5l4ry9A/WKnIz8DOLSXskEyeztp7327G1OSS3fQy437sD5PVSlBRE0WFACYBzzPA
	MjfKu/hBtztB3kYUkD+GTCyh6GYk2kU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-b1U1-brmOTeIaZtQF2mftg-1; Thu,
 13 Jun 2024 23:18:18 -0400
X-MC-Unique: b1U1-brmOTeIaZtQF2mftg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71D6419560A0;
	Fri, 14 Jun 2024 03:18:16 +0000 (UTC)
Received: from localhost (unknown [10.72.112.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 470863000219;
	Fri, 14 Jun 2024 03:18:13 +0000 (UTC)
Date: Fri, 14 Jun 2024 11:18:08 +0800
From: Baoquan He <bhe@redhat.com>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com,
	stable@vger.kernel.org
Subject: Re: [PATCHv5 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <Zmu2cEqJJ6F7gMx1@MiWiFi-R3L-srv>
References: <20240614010557.1821327-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614010557.1821327-1-zhaoyang.huang@unisoc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/14/24 at 09:05am, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> The function xa_for_each() in _vm_unmap_aliases() loops through all
> vbs. However, since commit 062eacf57ad9 ("mm: vmalloc: remove a global
> vmap_blocks xarray") the vb from xarray may not be on the corresponding
> CPU vmap_block_queue. Consequently, purge_fragmented_block() might
> use the wrong vbq->lock to protect the free list, leading to vbq->free
> breakage.
> 
> Incorrect lock protection can exhaust all vmalloc space as follows:
> CPU0                                            CPU1
> +--------------------------------------------+
> |    +--------------------+     +-----+      |
> +--> |                    |---->|     |------+
>      | CPU1:vbq free_list |     | vb1 |
> +--- |                    |<----|     |<-----+
> |    +--------------------+     +-----+      |
> +--------------------------------------------+
> 
> _vm_unmap_aliases()                             vb_alloc()
>                                                 new_vmap_block()
> xa_for_each(&vbq->vmap_blocks, idx, vb)
> --> vb in CPU1:vbq->freelist
> 
> purge_fragmented_block(vb)
> spin_lock(&vbq->lock)                           spin_lock(&vbq->lock)
> --> use CPU0:vbq->lock                          --> use CPU1:vbq->lock
> 
> list_del_rcu(&vb->free_list)                    list_add_tail_rcu(&vb->free_list, &vbq->free)
>     __list_del(vb->prev, vb->next)
>         next->prev = prev
>     +--------------------+
>     |                    |
>     | CPU1:vbq free_list |
> +---|                    |<--+
> |   +--------------------+   |
> +----------------------------+
>                                                 __list_add(new, head->prev, head)
> +--------------------------------------------+
> |    +--------------------+     +-----+      |
> +--> |                    |---->|     |------+
>      | CPU1:vbq free_list |     | vb2 |
> +--- |                    |<----|     |<-----+
> |    +--------------------+     +-----+      |
> +--------------------------------------------+
> 
>         prev->next = next
> +--------------------------------------------+
> |----------------------------+               |
> |    +--------------------+  |  +-----+      |
> +--> |                    |--+  |     |------+
>      | CPU1:vbq free_list |     | vb2 |
> +--- |                    |<----|     |<-----+
> |    +--------------------+     +-----+      |
> +--------------------------------------------+
> Here’s a list breakdown. All vbs, which were to be added to
> ‘prev’, cannot be used by list_for_each_entry_rcu(vb, &vbq->free,
> free_list) in vb_alloc(). Thus, vmalloc space is exhausted.
> 
> This issue affects both erofs and f2fs, the stacktrace is as follows:
> erofs:
> [<ffffffd4ffb93ad4>] __switch_to+0x174
> [<ffffffd4ffb942f0>] __schedule+0x624
> [<ffffffd4ffb946f4>] schedule+0x7c
> [<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
> [<ffffffd4ffb962ec>] __mutex_lock+0x374
> [<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
> [<ffffffd4ffb95954>] mutex_lock+0x24
> [<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
> [<ffffffd4fef25908>] alloc_vmap_area+0x2e0
> [<ffffffd4fef24ea0>] vm_map_ram+0x1b0
> [<ffffffd4ff1b46f4>] z_erofs_lz4_decompress+0x278
> [<ffffffd4ff1b8ac4>] z_erofs_decompress_queue+0x650
> [<ffffffd4ff1b8328>] z_erofs_runqueue+0x7f4
> [<ffffffd4ff1b66a8>] z_erofs_read_folio+0x104
> [<ffffffd4feeb6fec>] filemap_read_folio+0x6c
> [<ffffffd4feeb68c4>] filemap_fault+0x300
> [<ffffffd4fef0ecac>] __do_fault+0xc8
> [<ffffffd4fef0c908>] handle_mm_fault+0xb38
> [<ffffffd4ffb9f008>] do_page_fault+0x288
> [<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
> [<ffffffd4fec39c78>] do_mem_abort+0x58
> [<ffffffd4ffb8c3e4>] el0_ia+0x70
> [<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
> [<ffffffd4fec11588>] ret_to_user[jt]+0x0
> 
> f2fs:
> [<ffffffd4ffb93ad4>] __switch_to+0x174
> [<ffffffd4ffb942f0>] __schedule+0x624
> [<ffffffd4ffb946f4>] schedule+0x7c
> [<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
> [<ffffffd4ffb962ec>] __mutex_lock+0x374
> [<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
> [<ffffffd4ffb95954>] mutex_lock+0x24
> [<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
> [<ffffffd4fef25908>] alloc_vmap_area+0x2e0
> [<ffffffd4fef24ea0>] vm_map_ram+0x1b0
> [<ffffffd4ff1a3b60>] f2fs_prepare_decomp_mem+0x144
> [<ffffffd4ff1a6c24>] f2fs_alloc_dic+0x264
> [<ffffffd4ff175468>] f2fs_read_multi_pages+0x428
> [<ffffffd4ff17b46c>] f2fs_mpage_readpages+0x314
> [<ffffffd4ff1785c4>] f2fs_readahead+0x50
> [<ffffffd4feec3384>] read_pages+0x80
> [<ffffffd4feec32c0>] page_cache_ra_unbounded+0x1a0
> [<ffffffd4feec39e8>] page_cache_ra_order+0x274
> [<ffffffd4feeb6cec>] do_sync_mmap_readahead+0x11c
> [<ffffffd4feeb6764>] filemap_fault+0x1a0
> [<ffffffd4ff1423bc>] f2fs_filemap_fault+0x28
> [<ffffffd4fef0ecac>] __do_fault+0xc8
> [<ffffffd4fef0c908>] handle_mm_fault+0xb38
> [<ffffffd4ffb9f008>] do_page_fault+0x288
> [<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
> [<ffffffd4fec39c78>] do_mem_abort+0x58
> [<ffffffd4ffb8c3e4>] el0_ia+0x70
> [<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
> [<ffffffd4fec11588>] ret_to_user[jt]+0x0
> 
> To fix this, replace xa_for_each() with list_for_each_entry_rcu()
> which reverts commit fc1e0d980037 ("mm/vmalloc: prevent stale TLBs
> in fully utilized blocks")
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This paragraph need be updated?

> 
> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: introduce cpu in vmap_block to record the right CPU number
> v3: use get_cpu/put_cpu to prevent schedule between core
> v4: replace get_cpu/put_cpu by another API to avoid disabling preemption
> v5: update the commit message by Hailong.Liu
> ---
> ---
>  mm/vmalloc.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..89eb034f4ac6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2458,6 +2458,7 @@ struct vmap_block {
>  	struct list_head free_list;
>  	struct rcu_head rcu_head;
>  	struct list_head purge;
> +	unsigned int cpu;
>  };
>  
>  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> @@ -2585,8 +2586,15 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  		free_vmap_area(va);
>  		return ERR_PTR(err);
>  	}
> -
> -	vbq = raw_cpu_ptr(&vmap_block_queue);
> +	/*
> +	 * list_add_tail_rcu could happened in another core
> +	 * rather than vb->cpu due to task migration, which
> +	 * is safe as list_add_tail_rcu will ensure the list's
> +	 * integrity together with list_for_each_rcu from read
> +	 * side.
> +	 */

Do we still need above code comment? No lock gurantees vb->cpu is from
the cpu where vb_alloc() is called, it could be from the cpu where
migration moved to. We don't care about it as long as the vbq->lock
correctly protect the vb on its vbq->free?

> +	vb->cpu = raw_smp_processor_id();
> +	vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
>  	spin_lock(&vbq->lock);
>  	list_add_tail_rcu(&vb->free_list, &vbq->free);
>  	spin_unlock(&vbq->lock);
> @@ -2614,9 +2622,10 @@ static void free_vmap_block(struct vmap_block *vb)
>  }
>  
>  static bool purge_fragmented_block(struct vmap_block *vb,
> -		struct vmap_block_queue *vbq, struct list_head *purge_list,
> -		bool force_purge)
> +		struct list_head *purge_list, bool force_purge)
>  {
> +	struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, vb->cpu);
> +
>  	if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
>  	    vb->dirty == VMAP_BBMAP_BITS)
>  		return false;
> @@ -2664,7 +2673,7 @@ static void purge_fragmented_blocks(int cpu)
>  			continue;
>  
>  		spin_lock(&vb->lock);
> -		purge_fragmented_block(vb, vbq, &purge, true);
> +		purge_fragmented_block(vb, &purge, true);
>  		spin_unlock(&vb->lock);
>  	}
>  	rcu_read_unlock();
> @@ -2801,7 +2810,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
>  			 * not purgeable, check whether there is dirty
>  			 * space to be flushed.
>  			 */
> -			if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
> +			if (!purge_fragmented_block(vb, &purge_list, false) &&
>  			    vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
>  				unsigned long va_start = vb->va->va_start;
>  				unsigned long s, e;
> -- 
> 2.25.1
> 
> 


