Return-Path: <stable+bounces-98884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23969E6268
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610BE285E21
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3221DFFC;
	Fri,  6 Dec 2024 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jG5Yt3nB"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F21758B
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446089; cv=none; b=BzUW6lxn7ax3OwHsPaT/bY1eMJkIMTtha1yrbLFQj1Zy3sEvv2IHV9y76KFCM5eDj1IynXK9/T6AURAPe5aLiCqvUfjrtBSBapyGWIfWbPmp13U8CcyrhRi7G+I4y65nTt9LiX91Y+vxvMaMlQ5QVaIfdtTJSlDqTKx19O/H1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446089; c=relaxed/simple;
	bh=7o4FkoiZuy7PUjTuzrcAlScaNKtV8bX0eRwU9s63kps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvPscryinG8CSTsgvGOKyamEYgBUCTxBczaJZJMUtLQLG/hKF+HTKVx42H6Wv2vR+eb3523iJw8uZV2JTf6IbvM6wGMwyQjABuWl0jx1mHsOvBnHGDU8DwLwsT6/60HXQ3lFpopJ3j0Bf5kBRDp5JUuxbJkLDp4FsIXzQCF7x+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jG5Yt3nB; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Dec 2024 16:47:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733446085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgZ8nqyj5fuU76zFx2zmKyv8BJLk5V1Xo4T78qfEMZA=;
	b=jG5Yt3nB6u8oxePP2X6ZHalqnQ1vknKrK3SvFUTajcCvl9EBXHyOs+DFXI7diXGcE7JPKJ
	zBAHb5PS/X0sThwZuNFyCQ3/x69MMfRZ7Fx/+DiuJo6Cvnoz11EHs7Tv7K4QfaKZxCCijA
	6AKD4mvNShQMfbaeDXWz37pADu/Pzc4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jing Zhang <jingzhangos@google.com>
Cc: stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH 5.4.y 1/3] KVM: arm64: vgic-its: Add a data length check
 in vgic_its_save_*
Message-ID: <Z1JJvuUjbk009fWV@linux.dev>
References: <20241204202301.2715933-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204202301.2715933-1-jingzhangos@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 04, 2024 at 12:22:59PM -0800, Jing Zhang wrote:
> commit 7fe28d7e68f92cc3d0668b8f2fbdf5c303ac3022 upstream.
> 
> In all the vgic_its_save_*() functinos, they do not check whether
> the data length is 8 bytes before calling vgic_write_guest_lock.
> This patch adds the check. To prevent the kernel from being blown up
> when the fault occurs, KVM_BUG_ON() is used. And the other BUG_ON()s
> are replaced together.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> [Jing: Update with the new entry read/write helpers]
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> Link: https://lore.kernel.org/r/20241107214137.428439-4-jingzhangos@google.com
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

For the series:

Acked-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver

> ---
>  virt/kvm/arm/vgic/vgic-its.c | 20 ++++++++------------
>  virt/kvm/arm/vgic/vgic.h     | 24 ++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index f4ce08c0d0be..f091d4c9120a 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -2134,7 +2134,6 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
>  static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
>  			      struct its_ite *ite, gpa_t gpa, int ite_esz)
>  {
> -	struct kvm *kvm = its->dev->kvm;
>  	u32 next_offset;
>  	u64 val;
>  
> @@ -2143,7 +2142,8 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
>  	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
>  		ite->collection->collection_id;
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
> +
> +	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
>  }
>  
>  /**
> @@ -2279,7 +2279,6 @@ static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
>  static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
>  			     gpa_t ptr, int dte_esz)
>  {
> -	struct kvm *kvm = its->dev->kvm;
>  	u64 val, itt_addr_field;
>  	u32 next_offset;
>  
> @@ -2290,7 +2289,8 @@ static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
>  	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
>  		(dev->num_eventid_bits - 1));
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
> +
> +	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
>  }
>  
>  /**
> @@ -2470,7 +2470,8 @@ static int vgic_its_save_cte(struct vgic_its *its,
>  	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
>  	       collection->collection_id);
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
> +
> +	return vgic_its_write_entry_lock(its, gpa, val, esz);
>  }
>  
>  static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
> @@ -2481,8 +2482,7 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
>  	u64 val;
>  	int ret;
>  
> -	BUG_ON(esz > sizeof(val));
> -	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
> +	ret = vgic_its_read_entry_lock(its, gpa, &val, esz);
>  	if (ret)
>  		return ret;
>  	val = le64_to_cpu(val);
> @@ -2516,7 +2516,6 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
>  	u64 baser = its->baser_coll_table;
>  	gpa_t gpa = GITS_BASER_ADDR_48_to_52(baser);
>  	struct its_collection *collection;
> -	u64 val;
>  	size_t max_size, filled = 0;
>  	int ret, cte_esz = abi->cte_esz;
>  
> @@ -2540,10 +2539,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
>  	 * table is not fully filled, add a last dummy element
>  	 * with valid bit unset
>  	 */
> -	val = 0;
> -	BUG_ON(cte_esz > sizeof(val));
> -	ret = kvm_write_guest_lock(its->dev->kvm, gpa, &val, cte_esz);
> -	return ret;
> +	return vgic_its_write_entry_lock(its, gpa, 0, cte_esz);
>  }
>  
>  /**
> diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
> index 83066a81b16a..ac553f9171a6 100644
> --- a/virt/kvm/arm/vgic/vgic.h
> +++ b/virt/kvm/arm/vgic/vgic.h
> @@ -6,6 +6,7 @@
>  #define __KVM_ARM_VGIC_NEW_H__
>  
>  #include <linux/irqchip/arm-gic-common.h>
> +#include <asm/kvm_mmu.h>
>  
>  #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
>  #define IMPLEMENTER_ARM		0x43b
> @@ -126,6 +127,29 @@ static inline bool vgic_irq_is_multi_sgi(struct vgic_irq *irq)
>  	return vgic_irq_get_lr_count(irq) > 1;
>  }
>  
> +static inline int vgic_its_read_entry_lock(struct vgic_its *its, gpa_t eaddr,
> +					   u64 *eval, unsigned long esize)
> +{
> +	struct kvm *kvm = its->dev->kvm;
> +
> +	if (KVM_BUG_ON(esize != sizeof(*eval), kvm))
> +		return -EINVAL;
> +
> +	return kvm_read_guest_lock(kvm, eaddr, eval, esize);
> +
> +}
> +
> +static inline int vgic_its_write_entry_lock(struct vgic_its *its, gpa_t eaddr,
> +					    u64 eval, unsigned long esize)
> +{
> +	struct kvm *kvm = its->dev->kvm;
> +
> +	if (KVM_BUG_ON(esize != sizeof(eval), kvm))
> +		return -EINVAL;
> +
> +	return kvm_write_guest_lock(kvm, eaddr, &eval, esize);
> +}
> +
>  /*
>   * This struct provides an intermediate representation of the fields contained
>   * in the GICH_VMCR and ICH_VMCR registers, such that code exporting the GIC
> 
> base-commit: cd5b619ac41b6b1a8167380ca6655df7ccf5b5eb
> -- 
> 2.47.0.338.g60cca15819-goog
> 

