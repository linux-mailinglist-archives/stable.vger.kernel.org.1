Return-Path: <stable+bounces-98885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20A9E626A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2F518838D3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0D1E51D;
	Fri,  6 Dec 2024 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jLEX8gfP"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952C1758B
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446107; cv=none; b=BMaE+zQdsJTyecXs6Yrz1WnP3WgFfRWKGl1ep6yxSvbhfKw/fBje2rhaJ4Sh50AhBxmEBHpOhStAitSjkOXcl3amq+J4Qj2++pIt/FikfyPuZx5+yfMuT0ZwACh2ysQhv/8Mxy15URy1DrcFhh25hGnN4WH+58cdVNIjN1XOHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446107; c=relaxed/simple;
	bh=XY7+H+HZ/4CqTmZS/R7+qj437WRnLqkbBRlxzBlwUO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifgzuKZJi/13ASBZfRWzz1FEcjoufjZoJjpCu4j/cuoES/kWtbvQB/vohJ3IdvVESPGsjtZkwxlXjrd8nh94gUWNDjfZWmNzpaWDaPCmpWsvuNDko9mGr3avXPo9fKCRoA6Zu2fgk0xvmqEXTf97CU71ZxamlpFL1Myrqb6bhrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jLEX8gfP; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Dec 2024 16:48:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733446102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BANolBkvPo0NYoQbJaKZma0IsqEIcHlSsmOgEjMElTg=;
	b=jLEX8gfPqE4M9XGbKRWIqrvpxLrfqGgVGH7O4nps60kWrGUjp7rt2byFWYZX73Gh3JBrjA
	e19jwyau7a9QV8cBm/8ZLmb5OYS0+Zl2F/hxHdUjQ726oFnhKc2yIfpR+qWuSTlf0Un9/e
	XdAECIUNJG/sVNh4W2gopcFHJWSf1Cc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jing Zhang <jingzhangos@google.com>
Cc: stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH 5.10.y 1/3] KVM: arm64: vgic-its: Add a data length check
 in vgic_its_save_*
Message-ID: <Z1JJ0ZQD6z7K7N-o@linux.dev>
References: <20241204202318.2716633-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204202318.2716633-1-jingzhangos@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 04, 2024 at 12:23:16PM -0800, Jing Zhang wrote:
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
> index 93c0365cdd7b..d3ea81d947b7 100644
> --- a/arch/arm64/kvm/vgic/vgic-its.c
> +++ b/arch/arm64/kvm/vgic/vgic-its.c
> @@ -2135,7 +2135,6 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
>  static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
>  			      struct its_ite *ite, gpa_t gpa, int ite_esz)
>  {
> -	struct kvm *kvm = its->dev->kvm;
>  	u32 next_offset;
>  	u64 val;
>  
> @@ -2144,7 +2143,8 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
>  	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
>  		ite->collection->collection_id;
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
> +
> +	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
>  }
>  
>  /**
> @@ -2280,7 +2280,6 @@ static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
>  static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
>  			     gpa_t ptr, int dte_esz)
>  {
> -	struct kvm *kvm = its->dev->kvm;
>  	u64 val, itt_addr_field;
>  	u32 next_offset;
>  
> @@ -2291,7 +2290,8 @@ static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
>  	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
>  		(dev->num_eventid_bits - 1));
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
> +
> +	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
>  }
>  
>  /**
> @@ -2471,7 +2471,8 @@ static int vgic_its_save_cte(struct vgic_its *its,
>  	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
>  	       collection->collection_id);
>  	val = cpu_to_le64(val);
> -	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
> +
> +	return vgic_its_write_entry_lock(its, gpa, val, esz);
>  }
>  
>  static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
> @@ -2482,8 +2483,7 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
>  	u64 val;
>  	int ret;
>  
> -	BUG_ON(esz > sizeof(val));
> -	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
> +	ret = vgic_its_read_entry_lock(its, gpa, &val, esz);
>  	if (ret)
>  		return ret;
>  	val = le64_to_cpu(val);
> @@ -2517,7 +2517,6 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
>  	u64 baser = its->baser_coll_table;
>  	gpa_t gpa = GITS_BASER_ADDR_48_to_52(baser);
>  	struct its_collection *collection;
> -	u64 val;
>  	size_t max_size, filled = 0;
>  	int ret, cte_esz = abi->cte_esz;
>  
> @@ -2541,10 +2540,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
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
> index 3d7fa7ef353e..db99a1b167d8 100644
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
> base-commit: 711d99f845cdb587b7d7cf5e56c289c3d96d27c5
> -- 
> 2.47.0.338.g60cca15819-goog
> 

