Return-Path: <stable+bounces-98547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0AE9E4596
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CC32811B0
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A21F5404;
	Wed,  4 Dec 2024 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stb9MdFU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB831C3BF5
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343787; cv=none; b=Dq3LKw4zQGi8svtQF2n/8si8ju+I760o5rv7NI9jre4PwBPfF5olJ/J7bODvnFTBcJPidNs8lk1bEQu/o6mT4BR/pL0a+LYUlNq3hUboIhX5MtrOEjG535Q5xT5bqSxC2Q8/O2XHd3cyvny7re0ATYHrrhs2jlFJRf2bDrop++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343787; c=relaxed/simple;
	bh=NOWkyF/nJ0P7B9mKIcvIdVqqxIxP+GNPmbdCvxb9Oyg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HVxv5CxWTk9/2yPM57J1wmzBVV/e5q4rJVkMBDSpHmCDFqZHexw/UNBauOCIckam4aVbKHgE5dbm+QPojle8WStQCm+7KaTqZh2/PmH+SMXWbLe6IMS2xdIzZxZZdEJnYlU7CenUT5ky/cz2fZX+dhaWl3SVskdMQR0lnGrBqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stb9MdFU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7259ad34b4aso203258b3a.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343784; x=1733948584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FbtYgJtxun3o9HI8ptNTzwTCzDuvOZoeOluj0UfxORY=;
        b=stb9MdFUZdz2tGAqdRnsIKaCIbnmSJBG9UEXErxBXxbVLL+c3IuqY4nbP0p6kEPrIh
         gqCN35C0kQpymb0w+HYqLptY1TM1mEUW9/DdoSFVpMf/upsBiI03AQLE4RGvXgOp/EtU
         TZY+fJ/9IJI5sWaLbAeBltpQmBrrsqVaEEs6uSSC1m6XqYYy5XyoRVawXVwlW90oiCkM
         l2o8jzGzmMugvh9dlqmHdPzEW5hLM8rnjwy54SjbcIl+i+jjJDFPctlB/tkMLVq4aeYB
         ir7E3EjOGTYstL4RyOAotxP2PI+FGUYKH1BgI5MsW8yoF8dGJkTTXb1WJhfr5zI3TUDC
         73Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343784; x=1733948584;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbtYgJtxun3o9HI8ptNTzwTCzDuvOZoeOluj0UfxORY=;
        b=IPMHI9kELCdHU8ieurru2TyI8Orj5vExMx3rSxSGM6bmFo5TyagAHZISsD5cVIn6oR
         bbDt2Q0e4oR6GhH+KwmYaZOXmJqCb1uS2jJkn7DUhG7Ni5CGLq3mA8Iqz94Td9al105Q
         o1044xzGPfv3ZdLVYWJKCphgZUMfvj89g/KKqvB6ay6xmkBLzG3r7qwl/UO3hb8kueFK
         W1lVibgtD6oRIbt54pMn6ZIKq18CFlm+7v6icn+juUnwMzmA5lqSVUEcEzfKvxf6+00w
         2pX3ip+zUHlCMUQg/gafM5RSZjoux3cllaiEM5p6Fm8HHKGN0iQvq6h1TdA+ayLHw86Q
         eRjQ==
X-Gm-Message-State: AOJu0YztjaRzEls/E1y0jhvu8Tdqv4sF7CWxUb2AQ/7tAPKQ77yF15Rq
	JmP9YLkvfC415FpQtEaR96hCqIcNzbqqa9dxFHOgqlx8Ior1YSy7ro7Ry4IAxmCf+kE+swVY14N
	xtoN0utQGc6qIpZwWF7Xo70IkofxJb3iCfP/bDbITZr2eBvXnp/aWAwMMi6a8AGZkHjDOEwnFdc
	mMsudEYwn/Ol8epI/NXYKY292bxnpWlXsnbt6aG3dyw7PY31GLbJe2Doq2tqo=
X-Google-Smtp-Source: AGHT+IGLm1phkkfd2BxJ2tmqN0MIPACsCTwJ/Ft44ZxW+cD58oxJprZ05Nn/BZOD/RbMzdOZwuKEAR9FP3xSQEs3Uw==
X-Received: from pfba4.prod.google.com ([2002:a05:6a00:ac04:b0:725:3321:1f0c])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cd5:b0:725:9ec3:7ed9 with SMTP id d2e1a72fcca58-7259ec3812bmr98296b3a.21.1733343784465;
 Wed, 04 Dec 2024 12:23:04 -0800 (PST)
Date: Wed,  4 Dec 2024 12:22:59 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202301.2715933-1-jingzhangos@google.com>
Subject: [PATCH 5.4.y 1/3] KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
From: Jing Zhang <jingzhangos@google.com>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Kunkun Jiang <jiangkunkun@huawei.com>, Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

commit 7fe28d7e68f92cc3d0668b8f2fbdf5c303ac3022 upstream.

In all the vgic_its_save_*() functinos, they do not check whether
the data length is 8 bytes before calling vgic_write_guest_lock.
This patch adds the check. To prevent the kernel from being blown up
when the fault occurs, KVM_BUG_ON() is used. And the other BUG_ON()s
are replaced together.

Cc: stable@vger.kernel.org
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
[Jing: Update with the new entry read/write helpers]
Signed-off-by: Jing Zhang <jingzhangos@google.com>
Link: https://lore.kernel.org/r/20241107214137.428439-4-jingzhangos@google.com
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 virt/kvm/arm/vgic/vgic-its.c | 20 ++++++++------------
 virt/kvm/arm/vgic/vgic.h     | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index f4ce08c0d0be..f091d4c9120a 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -2134,7 +2134,6 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
 static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 			      struct its_ite *ite, gpa_t gpa, int ite_esz)
 {
-	struct kvm *kvm = its->dev->kvm;
 	u32 next_offset;
 	u64 val;
 
@@ -2143,7 +2142,8 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
 		ite->collection->collection_id;
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
+
+	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
 }
 
 /**
@@ -2279,7 +2279,6 @@ static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
 static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
 			     gpa_t ptr, int dte_esz)
 {
-	struct kvm *kvm = its->dev->kvm;
 	u64 val, itt_addr_field;
 	u32 next_offset;
 
@@ -2290,7 +2289,8 @@ static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
 	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
 		(dev->num_eventid_bits - 1));
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
+
+	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
 }
 
 /**
@@ -2470,7 +2470,8 @@ static int vgic_its_save_cte(struct vgic_its *its,
 	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
 	       collection->collection_id);
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
+
+	return vgic_its_write_entry_lock(its, gpa, val, esz);
 }
 
 static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
@@ -2481,8 +2482,7 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
 	u64 val;
 	int ret;
 
-	BUG_ON(esz > sizeof(val));
-	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
+	ret = vgic_its_read_entry_lock(its, gpa, &val, esz);
 	if (ret)
 		return ret;
 	val = le64_to_cpu(val);
@@ -2516,7 +2516,6 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
 	u64 baser = its->baser_coll_table;
 	gpa_t gpa = GITS_BASER_ADDR_48_to_52(baser);
 	struct its_collection *collection;
-	u64 val;
 	size_t max_size, filled = 0;
 	int ret, cte_esz = abi->cte_esz;
 
@@ -2540,10 +2539,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
 	 * table is not fully filled, add a last dummy element
 	 * with valid bit unset
 	 */
-	val = 0;
-	BUG_ON(cte_esz > sizeof(val));
-	ret = kvm_write_guest_lock(its->dev->kvm, gpa, &val, cte_esz);
-	return ret;
+	return vgic_its_write_entry_lock(its, gpa, 0, cte_esz);
 }
 
 /**
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index 83066a81b16a..ac553f9171a6 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -6,6 +6,7 @@
 #define __KVM_ARM_VGIC_NEW_H__
 
 #include <linux/irqchip/arm-gic-common.h>
+#include <asm/kvm_mmu.h>
 
 #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
 #define IMPLEMENTER_ARM		0x43b
@@ -126,6 +127,29 @@ static inline bool vgic_irq_is_multi_sgi(struct vgic_irq *irq)
 	return vgic_irq_get_lr_count(irq) > 1;
 }
 
+static inline int vgic_its_read_entry_lock(struct vgic_its *its, gpa_t eaddr,
+					   u64 *eval, unsigned long esize)
+{
+	struct kvm *kvm = its->dev->kvm;
+
+	if (KVM_BUG_ON(esize != sizeof(*eval), kvm))
+		return -EINVAL;
+
+	return kvm_read_guest_lock(kvm, eaddr, eval, esize);
+
+}
+
+static inline int vgic_its_write_entry_lock(struct vgic_its *its, gpa_t eaddr,
+					    u64 eval, unsigned long esize)
+{
+	struct kvm *kvm = its->dev->kvm;
+
+	if (KVM_BUG_ON(esize != sizeof(eval), kvm))
+		return -EINVAL;
+
+	return kvm_write_guest_lock(kvm, eaddr, &eval, esize);
+}
+
 /*
  * This struct provides an intermediate representation of the fields contained
  * in the GICH_VMCR and ICH_VMCR registers, such that code exporting the GIC

base-commit: cd5b619ac41b6b1a8167380ca6655df7ccf5b5eb
-- 
2.47.0.338.g60cca15819-goog


