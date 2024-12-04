Return-Path: <stable+bounces-98586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4479E48B6
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3957F1880641
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D05A202C5D;
	Wed,  4 Dec 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzFpNdCo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9CC202C58
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354601; cv=none; b=NwZg04N8FIg3Qs84AySNu58EIGwU+j7ryONSU5huk5Q58XFX26T+6fS3IfGqAxayxazbdS5n68PKcT4hzq2SnKd0rpEgqgT83FGsfPcA4FaKsAH1IjC7NJvrP7D7wL9JKDiXX70bRUsd/G8wNRTyW75MOVb7SqluAfYGB8+wQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354601; c=relaxed/simple;
	bh=wOy+7Fwl1Ynk1p3udgvoJWDZH+tly4oQVcyDtKH1vTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaV/GEuUt+bJj2kCFLSADmGYPbzNRwR1IVc1PFR5+2O5yuHjQUBbQMXCXSMtc33Tv9k/I9dQJzeLkbO1Lzaw3GcKvyXYr5s8WFQxrdHPRB+uIS0QKByj5fbGGDoAqzpcBhF/gln9YmSgxHYfcky5EjrbA/PchxL+3tKozmBgErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzFpNdCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A803FC4CECD;
	Wed,  4 Dec 2024 23:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354601;
	bh=wOy+7Fwl1Ynk1p3udgvoJWDZH+tly4oQVcyDtKH1vTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzFpNdCo7YBLKiDhy0a5PzuOIQfJ/c1jDZH9T6B3DcgSJ9ifbz1LZRo5G05ZK7CrD
	 xRJPJVFwU3wAtC+Pi/IOakomrRhGZBzuRDIJlY8rQHW7QrdjzbPjlAer3hXI2BNB4I
	 cLlnlAiuQg2gliFbTOM0QGegqkxsL8ojzS7KrJN62yZnSdPmNrcMKvIUWVSWjGRAEl
	 LcNdo8DkA+QG2lqlUvEimEgR+lsgxPGTwtp38Drpi6zqDnQl07Pq6gP+6NVGiMTdfJ
	 y2ysxcX623mn58gDoCpyJGz49rEUXrBOlrJzrk2jD/NcoenIk4LL94tQOw6Y2K3F0X
	 eIYqvqAIPjvZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/3] KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
Date: Wed,  4 Dec 2024 17:12:01 -0500
Message-ID: <20241204162659-0bcfabea852bef0e@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202340.2717420-1-jingzhangos@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 7fe28d7e68f92cc3d0668b8f2fbdf5c303ac3022


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7fe28d7e68f92 ! 1:  e7bc6980df78e KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
    @@ Metadata
      ## Commit message ##
         KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
     
    +    commit 7fe28d7e68f92cc3d0668b8f2fbdf5c303ac3022 upstream.
    +
         In all the vgic_its_save_*() functinos, they do not check whether
         the data length is 8 bytes before calling vgic_write_guest_lock.
         This patch adds the check. To prevent the kernel from being blown up
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_ite(struct vgic_its *it
      	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
      		ite->collection->collection_id;
      	val = cpu_to_le64(val);
    --	return vgic_write_guest_lock(kvm, gpa, &val, ite_esz);
    +-	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
     +
     +	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
      }
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_dte(struct vgic_its *it
      	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
      		(dev->num_eventid_bits - 1));
      	val = cpu_to_le64(val);
    --	return vgic_write_guest_lock(kvm, ptr, &val, dte_esz);
    +-	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
     +
     +	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
      }
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_cte(struct vgic_its *it
      	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
      	       collection->collection_id);
      	val = cpu_to_le64(val);
    --	return vgic_write_guest_lock(its->dev->kvm, gpa, &val, esz);
    +-	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
     +
     +	return vgic_its_write_entry_lock(its, gpa, val, esz);
      }
      
    - /*
    + static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
     @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
      	u64 val;
      	int ret;
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_collection_table(struct
      	 */
     -	val = 0;
     -	BUG_ON(cte_esz > sizeof(val));
    --	ret = vgic_write_guest_lock(its->dev->kvm, gpa, &val, cte_esz);
    +-	ret = kvm_write_guest_lock(its->dev->kvm, gpa, &val, cte_esz);
     -	return ret;
     +	return vgic_its_write_entry_lock(its, gpa, 0, cte_esz);
      }
      
    - /*
    + /**
     
      ## arch/arm64/kvm/vgic/vgic.h ##
    -@@ arch/arm64/kvm/vgic/vgic.h: static inline int vgic_write_guest_lock(struct kvm *kvm, gpa_t gpa,
    - 	return ret;
    +@@
    + #define __KVM_ARM_VGIC_NEW_H__
    + 
    + #include <linux/irqchip/arm-gic-common.h>
    ++#include <asm/kvm_mmu.h>
    + 
    + #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
    + #define IMPLEMENTER_ARM		0x43b
    +@@ arch/arm64/kvm/vgic/vgic.h: static inline bool vgic_irq_is_multi_sgi(struct vgic_irq *irq)
    + 	return vgic_irq_get_lr_count(irq) > 1;
      }
      
     +static inline int vgic_its_read_entry_lock(struct vgic_its *its, gpa_t eaddr,
    @@ arch/arm64/kvm/vgic/vgic.h: static inline int vgic_write_guest_lock(struct kvm *
     +	if (KVM_BUG_ON(esize != sizeof(eval), kvm))
     +		return -EINVAL;
     +
    -+	return vgic_write_guest_lock(kvm, eaddr, &eval, esize);
    ++	return kvm_write_guest_lock(kvm, eaddr, &eval, esize);
     +}
     +
      /*
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

