Return-Path: <stable+bounces-98568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E69E48A3
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10D0162D65
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312EC1AFB36;
	Wed,  4 Dec 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsF3RZFo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E619DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354566; cv=none; b=pM/2Qz6LMPhuM9LEfzwgCzZsYmSQjBZhRJIR+6gtqfe0PLzqANxIGXd8W2iIXpbIeUz3mi1gKVJ3j0vktymc8jDhZFh1fSaRdtdfzwagWB4lm0PLeJ30CGMPWAdSFpTVJCTptvnbALQ+aue3AzoYVrcfqsheVT0AEEO2srLg2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354566; c=relaxed/simple;
	bh=ctuPYFg+5CU7e+3BaXX5lZ5LyBwd8fibPtWBPW3Sbp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MscWh8ZVNeHnZv0nsA6BrHjJZSqXEZcH48cptAPvq1QrRUEOEo4rvTuVxU7yoH2A3Aa3zASvgb0V29K+VLdt9OBdV7fIBqaL6au/daAEcMX/E+hsigMBkKy651IiL1+dJrE7e1EgLvhoC8nRsFJ96y41ztbXlCmaig/ppsI0wjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsF3RZFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BCDC4CECD;
	Wed,  4 Dec 2024 23:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354565;
	bh=ctuPYFg+5CU7e+3BaXX5lZ5LyBwd8fibPtWBPW3Sbp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsF3RZFo3kms5mPF4P2VYay81tvxbQfCdCyka9ii6L0xPgtAsr8L6fyo9K5PLxvLQ
	 XzzjpwVtnvNQtpqmC5KWZnfazPFugqyrSb4MdJuQwp7L2GHWYhfAnVX40Ayjf3Gr9z
	 TIvDQetlZKSOx9eHP+UvCXW/lzoVarFZ9gelyr1UPm0k7JjiRXGG2Z5Frq+vU0D5PR
	 L7egHdGjcTX1miFmxPFEs8F5Zk6m2V8IabzjPovl0FdVQeF7Rno1+KD9Glql66InMJ
	 GTYOtqQYJ4gvbnyW1Y+w2Ld7j998O8gU3KLk9JMkiz+0lmQ7vqk+GXmli9Wi5k1Etp
	 7mkbq2/bbD4IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 1/3] KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
Date: Wed,  4 Dec 2024 17:11:25 -0500
Message-ID: <20241204164829-1e97d3fe8d38fa3f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202301.2715933-1-jingzhangos@google.com>
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
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7fe28d7e68f92 ! 1:  4a8a62679975d KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
    @@ Metadata
      ## Commit message ##
         KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
     
    +    commit 7fe28d7e68f92cc3d0668b8f2fbdf5c303ac3022 upstream.
    +
         In all the vgic_its_save_*() functinos, they do not check whether
         the data length is 8 bytes before calling vgic_write_guest_lock.
         This patch adds the check. To prevent the kernel from being blown up
    @@ Commit message
         Link: https://lore.kernel.org/r/20241107214137.428439-4-jingzhangos@google.com
         Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
     
    - ## arch/arm64/kvm/vgic/vgic-its.c ##
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
    + ## virt/kvm/arm/vgic/vgic-its.c ##
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
      static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
      			      struct its_ite *ite, gpa_t gpa, int ite_esz)
      {
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int scan_its_table(struct vgic_its *its,
      	u32 next_offset;
      	u64 val;
      
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
      	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
      		ite->collection->collection_id;
      	val = cpu_to_le64(val);
    --	return vgic_write_guest_lock(kvm, gpa, &val, ite_esz);
    +-	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
     +
     +	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
      }
      
      /**
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
      static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
      			     gpa_t ptr, int dte_esz)
      {
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_restore_itt(struct vgic_its
      	u64 val, itt_addr_field;
      	u32 next_offset;
      
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
      	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
      		(dev->num_eventid_bits - 1));
      	val = cpu_to_le64(val);
    --	return vgic_write_guest_lock(kvm, ptr, &val, dte_esz);
    +-	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
     +
     +	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
      }
      
      /**
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_cte(struct vgic_its *its,
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_save_cte(struct vgic_its *its,
      	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
      	       collection->collection_id);
      	val = cpu_to_le64(val);
    --	return vgic_write_guest_lock(its->dev->kvm, gpa, &val, esz);
    +-	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
     +
     +	return vgic_its_write_entry_lock(its, gpa, val, esz);
      }
      
    - /*
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
    + static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
      	u64 val;
      	int ret;
      
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_restore_cte(struct vgic_its
      	if (ret)
      		return ret;
      	val = le64_to_cpu(val);
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_collection_table(struct vgic_its *its)
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_save_collection_table(struct vgic_its *its)
      	u64 baser = its->baser_coll_table;
      	gpa_t gpa = GITS_BASER_ADDR_48_to_52(baser);
      	struct its_collection *collection;
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_collection_table(struct
      	size_t max_size, filled = 0;
      	int ret, cte_esz = abi->cte_esz;
      
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_save_collection_table(struct vgic_its *its)
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_save_collection_table(struct vgic_its *its)
      	 * table is not fully filled, add a last dummy element
      	 * with valid bit unset
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
     
    - ## arch/arm64/kvm/vgic/vgic.h ##
    -@@ arch/arm64/kvm/vgic/vgic.h: static inline int vgic_write_guest_lock(struct kvm *kvm, gpa_t gpa,
    - 	return ret;
    + ## virt/kvm/arm/vgic/vgic.h ##
    +@@
    + #define __KVM_ARM_VGIC_NEW_H__
    + 
    + #include <linux/irqchip/arm-gic-common.h>
    ++#include <asm/kvm_mmu.h>
    + 
    + #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
    + #define IMPLEMENTER_ARM		0x43b
    +@@ virt/kvm/arm/vgic/vgic.h: static inline bool vgic_irq_is_multi_sgi(struct vgic_irq *irq)
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
| stable/linux-5.4.y        |  Success    |  Success   |

