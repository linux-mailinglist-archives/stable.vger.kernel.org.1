Return-Path: <stable+bounces-98883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602289E6267
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E857B1882AD4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112661DFFC;
	Fri,  6 Dec 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VL1BnAQE"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7661EEF9
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446057; cv=none; b=nNK3SfWxPEkHCtpddAwPsMNWM80TkrvaaaBmfmZEVN6uFfAncudaRtD5sAIvhADjQTvV26WwneYRIG3+ig1INFzasUyh8NYlUAnw+5RIBqCd1E8II1v1R2otpqSFQIwrObFIEnYx8eKTnaQCiwBPM7de49+OTBaL3rskqaq1A3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446057; c=relaxed/simple;
	bh=/8CnTaAHdSDRvvTzV00/IZWsFsusaNcgYkScChET5ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kodzjyXbFLqZsW99N8sWIRhFC+wiYU00jy8SwQ1e7icbq4iPN+FOtQbLdkGixdAa637esXfvTJ4qCnROa+uDOwuMKn+T6++NJ8Jsfvzoevf/FRrsbv6dEQK7MYxQ2uN5R7PzKjiRavYSC2rjqW4XdHwSTq+SOfLPj/DUHucqwDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VL1BnAQE; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Dec 2024 16:47:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733446053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IEZDZOSzmcJ+X6LjLDvz0dxZX+PQ0TzSko0YGz3Br3M=;
	b=VL1BnAQEyR7xp+47uGuPyJE0VDDTkceVeHPAmeMOgrrXNji+xXty5O+yL5rDNLJ1PbxzDO
	DzJTr6M71OXFMvKL3iXHM+WYFYZHLjwox1MjFvju6WaqBD1QD9wymGpT1Re0uRkhsSf3rX
	/kyx3sI0axms5dvtWALUNEeCrkoQVeg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jing Zhang <jingzhangos@google.com>
Cc: stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH 4.19.y 1/3] KVM: arm64: vgic-its: Add a data length check
 in vgic_its_save_*
Message-ID: <Z1JJn7PgcdvQs4kC@linux.dev>
References: <20241204202038.2714140-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204202038.2714140-1-jingzhangos@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 04, 2024 at 12:20:36PM -0800, Jing Zhang wrote:
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
> index 2fb26bd3106e..7fcf903fa5b0 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -1949,7 +1949,6 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
>  static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
>  			      struct its_ite *ite, gpa_t gpa, int ite_esz)
>  {
> -	struct kvm *kvm = its->dev->kvm;
>  	u32 next_offset;
>  	u64 val;
>  
> @@ -1958,7 +1957,8 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
>  	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
>  		ite->collection->collection_id;
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
> +
> +	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
>  }
>  
>  /**
> @@ -2094,7 +2094,6 @@ static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
>  static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
>  			     gpa_t ptr, int dte_esz)
>  {
> -	struct kvm *kvm = its->dev->kvm;
>  	u64 val, itt_addr_field;
>  	u32 next_offset;
>  
> @@ -2105,7 +2104,8 @@ static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
>  	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
>  		(dev->num_eventid_bits - 1));
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
> +
> +	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
>  }
>  
>  /**
> @@ -2285,7 +2285,8 @@ static int vgic_its_save_cte(struct vgic_its *its,
>  	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
>  	       collection->collection_id);
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
> +
> +	return vgic_its_write_entry_lock(its, gpa, val, esz);
>  }
>  
>  static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
> @@ -2296,8 +2297,7 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
>  	u64 val;
>  	int ret;
>  
> -	BUG_ON(esz > sizeof(val));
> -	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
> +	ret = vgic_its_read_entry_lock(its, gpa, &val, esz);
>  	if (ret)
>  		return ret;
>  	val = le64_to_cpu(val);
> @@ -2331,7 +2331,6 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
>  	u64 baser = its->baser_coll_table;
>  	gpa_t gpa = BASER_ADDRESS(baser);
>  	struct its_collection *collection;
> -	u64 val;
>  	size_t max_size, filled = 0;
>  	int ret, cte_esz = abi->cte_esz;
>  
> @@ -2355,10 +2354,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
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
> index d5e454279925..e5a307dab61e 100644
> --- a/virt/kvm/arm/vgic/vgic.h
> +++ b/virt/kvm/arm/vgic/vgic.h
> @@ -17,6 +17,7 @@
>  #define __KVM_ARM_VGIC_NEW_H__
>  
>  #include <linux/irqchip/arm-gic-common.h>
> +#include <asm/kvm_mmu.h>
>  
>  #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
>  #define IMPLEMENTER_ARM		0x43b
> @@ -137,6 +138,29 @@ static inline bool vgic_irq_is_multi_sgi(struct vgic_irq *irq)
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
> base-commit: 708f578f2a8f702d2f2a0ef5e6eac28e08206e03
> -- 
> 2.47.0.338.g60cca15819-goog
> 

