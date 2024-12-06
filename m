Return-Path: <stable+bounces-98887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3109E6276
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5447E285E67
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67938F9C;
	Fri,  6 Dec 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xv+yB2ip"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808633997
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446151; cv=none; b=Umzqg3xgFVQ28tuwibrzRlam542OkLSWkCtv6M6EAgfQWLT3znBPKdIAYr+oaG2KIx3/hQlghKWmEpNckVe+UQpaMi/iURk8q8RKXHQZvSxFrCxdkg2u+XNBFdYlAwQas7v1B39QmA04AtgondhFNmsqYC2s5HcfNBGHrhcRG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446151; c=relaxed/simple;
	bh=sSWc4lOfgrXequLezIW3Wed07Ny8XSYOHRslBzxfY+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iImVEvxDtKLOW8ud3tRmyWiwUDLkygdc+BarMBY/8cTjoljALc6maGD5F1Qn/PHsgkiYPRywGThYWFHLTOPbVFS5quuXzZ08fEJGe1NldK5p83c36yBrqm5gCyaCCKwEvYoQ1whmYhsIFkE8w3vt89P9bNXj2l/WwIiBGUbQaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xv+yB2ip; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Dec 2024 16:49:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733446147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOFJfHmp55sF9Komhb9x4dt+fkGanoK5wXCLqTHTjBg=;
	b=xv+yB2ipsuGjyhM9kSSGvgqAJdC+le8807La3XqTpKy1d8eoYppSBuEjZtOEk939RmgF6x
	3lerNcS4cTikhMPVeO1s7fAXvPWSeVsQRLb7/jJRx4F3fo4U/XTnf79Nwa+j9603SvJZhN
	5i1IKm49iK1Ss3wi+1/xvVcTfabfoxE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jing Zhang <jingzhangos@google.com>
Cc: stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH 6.1.y 1/3] KVM: arm64: vgic-its: Add a data length check
 in vgic_its_save_*
Message-ID: <Z1JJ_2dN4ysvdmRI@linux.dev>
References: <20241204202357.2718096-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204202357.2718096-1-jingzhangos@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 04, 2024 at 12:23:55PM -0800, Jing Zhang wrote:
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
>  arch/arm64/kvm/vgic/vgic-its.c | 20 ++++++++------------
>  arch/arm64/kvm/vgic/vgic.h     | 24 ++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
> index 092327665a6e..84499545bd8d 100644
> --- a/arch/arm64/kvm/vgic/vgic-its.c
> +++ b/arch/arm64/kvm/vgic/vgic-its.c
> @@ -2207,7 +2207,6 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
>  static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
>  			      struct its_ite *ite, gpa_t gpa, int ite_esz)
>  {
> -	struct kvm *kvm = its->dev->kvm;
>  	u32 next_offset;
>  	u64 val;
>  
> @@ -2216,7 +2215,8 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
>  	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
>  		ite->collection->collection_id;
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
> +
> +	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
>  }
>  
>  /**
> @@ -2357,7 +2357,6 @@ static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
>  static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
>  			     gpa_t ptr, int dte_esz)
>  {
> -	struct kvm *kvm = its->dev->kvm;
>  	u64 val, itt_addr_field;
>  	u32 next_offset;
>  
> @@ -2368,7 +2367,8 @@ static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
>  	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
>  		(dev->num_eventid_bits - 1));
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
> +
> +	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
>  }
>  
>  /**
> @@ -2555,7 +2555,8 @@ static int vgic_its_save_cte(struct vgic_its *its,
>  	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
>  	       collection->collection_id);
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
> +
> +	return vgic_its_write_entry_lock(its, gpa, val, esz);
>  }
>  
>  /*
> @@ -2571,8 +2572,7 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
>  	u64 val;
>  	int ret;
>  
> -	BUG_ON(esz > sizeof(val));
> -	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
> +	ret = vgic_its_read_entry_lock(its, gpa, &val, esz);
>  	if (ret)
>  		return ret;
>  	val = le64_to_cpu(val);
> @@ -2610,7 +2610,6 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
>  	u64 baser = its->baser_coll_table;
>  	gpa_t gpa = GITS_BASER_ADDR_48_to_52(baser);
>  	struct its_collection *collection;
> -	u64 val;
>  	size_t max_size, filled = 0;
>  	int ret, cte_esz = abi->cte_esz;
>  
> @@ -2634,10 +2633,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
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
> diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
> index bc898229167b..056fcee46165 100644
> --- a/arch/arm64/kvm/vgic/vgic.h
> +++ b/arch/arm64/kvm/vgic/vgic.h
> @@ -6,6 +6,7 @@
>  #define __KVM_ARM_VGIC_NEW_H__
>  
>  #include <linux/irqchip/arm-gic-common.h>
> +#include <asm/kvm_mmu.h>
>  
>  #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
>  #define IMPLEMENTER_ARM		0x43b
> @@ -131,6 +132,29 @@ static inline bool vgic_irq_is_multi_sgi(struct vgic_irq *irq)
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
> base-commit: e4d90d63d385228b1e0bcf31cc15539bbbc28f7f
> -- 
> 2.47.0.338.g60cca15819-goog
> 

