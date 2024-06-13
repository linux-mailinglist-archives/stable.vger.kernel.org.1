Return-Path: <stable+bounces-52082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5859079EE
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E48E282B0B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487D149C5B;
	Thu, 13 Jun 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExoxHtN2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086911304BF;
	Thu, 13 Jun 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300003; cv=none; b=SliDk9MVs0nA4WJ9IRIV5j0YxmC+hwu1Js+i2OH4VIufbCrDWMJ+Cqpv55U/nu8H7HeM1XJefdxS0urF6H659H92Mt//UZtA3TeCQggfLAtM/RfYy0WLBNfCInWsqyGWDT5bU4YuG8fPX5pyPF63Kx1G8efIP7aY0yg6NHf/wkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300003; c=relaxed/simple;
	bh=BziG7gMJekaLwRZVsyqiqvarqPrzKqRYoZRH1Y+5/GA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPslDxK5HM6AzeKO/a21l9CCOxGvdENgDQtnnYhVYUcL5c2wwWB9ZbhvpiJkCz7kt9YQ8ZMeId9cCJ72wMUTeRJ4dV532xXa6lFQCktUXqB9gwN7NZUU1JnPCe93+CCDqfoNO79CoZuhUgm3twaWBjSJr5bwYRW3PN9AhiNwsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExoxHtN2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5295eb47b48so1645630e87.1;
        Thu, 13 Jun 2024 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718300000; x=1718904800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ii4ZY+8PBn+yY1/1MCO+EH7pdZ1b188VW9sApqkczU=;
        b=ExoxHtN2Obb5yKlf+Kfp4ahQl7Neql2+l9R5RpIokZ+6lGa3K+lhqMpNPyrA/6I1ex
         Xi/lSDZ+LPZCZqkVT9XMKEVDPVVX3mCJyXkrfiUsVT/JndxkCP6AVKfD2J+Hyx668CPA
         jlQ+8xLTXd6/5b1K7Pskg80CM6FRJ/i440uReoGPf8mTtXZTOoGZkY6qKBgdO7z2DwFJ
         NKu1aSxKiP0O+m6ey0ap6U3Yc2z5fLdZ9UWwvrsaITsstmth4UsfXQ1+shIbbS4xkZ61
         +QVnB2my65EkYYU5Vj29JfB++OdbsC8xynXLlMJkJXsuXLTM1qcznScPza9N9+360Npn
         T+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718300000; x=1718904800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ii4ZY+8PBn+yY1/1MCO+EH7pdZ1b188VW9sApqkczU=;
        b=TNCNYm6qL69CE3HXeJ171dTkVoMkoVep/Yz9endiI5xbEo3JsDZwV+r/OlbH8hnkPT
         cN+L5YJFlAIx7ZgJzz+SlxJkdDcdXQA7GgQ0Lu5qxh25VR0EyWM1ZLfhoT6PdrNRQwQX
         dSfLsV3rq9wrDMWInBUd5sPlH8Jhaayo7Vh2DVjM2G4gTdy1yo4LDT5kOxGuaUzgA10m
         hn2kxGULXjRDtCGhddv1H45b1wWahnnwbmK8duYoGf0LL1Ih3bCRrj1Iv41dwwP69xt5
         Bf78MSwK27kUyUtBVdADzti9YfmiUg7pvtgT/nr8Tn5AZf9+JVvhtYS6yeujrq1iC5a5
         J42A==
X-Forwarded-Encrypted: i=1; AJvYcCWFxjWvB/szeWC2zHDv/9G+86yNcALbyvGjtZgAMG02BhAhkhz0kzFgb3oFaxhJVj39KGKRTckc/5MlDALnMmop0epSAMQzIiNqAY1y+iKe62BF6F8igzLSwmtBKh9q//TKuDT9
X-Gm-Message-State: AOJu0YzXI6131QB1Xebw7bTu6QtfyoBGKrVXhG4lCqdAn4aVRqyyoyT7
	rnaxCsBjTtkjqfp/oW9mDYw7ix/TA077lTFsL4+9y/uYZAzdah1k
X-Google-Smtp-Source: AGHT+IG98HI4qEE4jMbTN26+L2Wk9PobS+fctcwhqnSg84S8A8OKwKrR6phVc+FCr6Vkbe1dO/5Oyg==
X-Received: by 2002:a05:6512:208d:b0:52b:c296:902a with SMTP id 2adb3069b0e04-52ca6e56364mr265661e87.5.1718299999626;
        Thu, 13 Jun 2024 10:33:19 -0700 (PDT)
Received: from pc636 (host-90-233-218-141.mobileonline.telia.com. [90.233.218.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287231csm298652e87.162.2024.06.13.10.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:33:19 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 13 Jun 2024 19:33:16 +0200
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZmstXFYq6iSHYdtR@pc636>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>

On Fri, Jun 07, 2024 at 10:31:16AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> vmalloc area runs out in our ARM64 system during an erofs test as
> vm_map_ram failed[1]. By following the debug log, we find that
> vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> when vbq->free->next points to vbq->free. That is to say, 65536 times
> of page fault after the list's broken will run out of the whole
> vmalloc area. This should be introduced by one vbq->free->next point to
> vbq->free which makes list_for_each_entry_rcu can not iterate the list
> and find the BUG.
> 
> [1]
> PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
>  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
>  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
>  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
>  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
>  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
>  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
>  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
>  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
>  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
>  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> 
> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
> 
> For detailed reason of broken list, please refer to below URL
> https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/
> 
> Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: introduce cpu in vmap_block to record the right CPU number
> v3: use get_cpu/put_cpu to prevent schedule between core
> v4: replace get_cpu/put_cpu by another API to avoid disabling preemption
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
Yes there is a mess with holding wrong vbq->lock and vmap_blocks xarray.

The patch looks good to me. One small nit from my side is a commit
message. To me it is vague and it should be improved.

Could you please use Hailong.Liu <hailong.liu@oppo.com> explanation
of the issue and resend the patch?

See it here: https://lkml.org/lkml/2024/6/2/2

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

