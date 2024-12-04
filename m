Return-Path: <stable+bounces-98553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833699E459C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFA7280E0B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BE1F5404;
	Wed,  4 Dec 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yspo1BoC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DECE1C3BF5
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343825; cv=none; b=pO0lq4FB5ZgVW62Y7wtU9ENhZfgJLAoUr7eWXsFpxY3rjUClloBaege6IywSk1XrRok4jBEqvjvO1PjDg0ywI3yMdQ2Qcwn5VZHiCa8PntdpZJw6H46PBwOL3Vma//EFmrDbVitm1xIadVSiQwzCzfjLQPQtAsIb+tDOW/pV/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343825; c=relaxed/simple;
	bh=2OPFV9E9+DWaYgu5pkNg6LPG2HZ0rpdFhC4WCgN/jTw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TAPyRoRDeRWjioRD8aa9Lo/Wq0guGFVDsQ9Z3vDwtmk9cZLM6OHaE/2UhrtMNdb64fjHmAP+un2S8lurvpbv4U5U01gp7pnionWPyIq+l/pTDLf+9ijj0vsCK9bhaRCZB2QwLEBe5u09Sv7iQtHUM/ubcypkQh9ATH8oqRZEdDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yspo1BoC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72501c1609dso246961b3a.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343823; x=1733948623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1kuZo5M2IBXB6EAqLNmqe7NSfRFtVb5M8OewMzGAIR0=;
        b=Yspo1BoCSXJ55iR8gSsbvQsw9UWH6OgndBvKVowWammws11bQeC1MLN8/KH25L6guU
         +Y3LMxq8LCjYs0RXKyqxAu4puPY+V8orm/ZU4cj0qvgCvoPtimRWO1S+d+PzwWE3X89x
         SGooigXr/p76JL0DipgpfQhuLOHmhcNnYUyWa+yvWE7givNJC0PIWsrznopM/0nhuYYD
         FwNyVdFl1vy2HipHgoJvzCtjfp5xjB4cRiBAd3mEz3roMLl33KroYM7kXPIphf3l2J96
         oy0F3he3MQE8kTB5OXVLYzc0inu2h4AYrIO0TyNicdMJtU85ZdVqEfEI1/P31wJHzu/1
         NXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343823; x=1733948623;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kuZo5M2IBXB6EAqLNmqe7NSfRFtVb5M8OewMzGAIR0=;
        b=YAuy3dJHMRh0M8C/9uiDwziecrLy8zd2M4UrzaNJ1u+tS6ND/Y1Yr8x2ff6PS9FpU8
         fpkGiw5UHQEIWx1OesH3nI/RSlhH97yQQ0x7+IVrXrRvIke/lwIsgJIeo2J0xfDEF7tH
         JqvWzHuVBdir0WXRcU5m/BDZoMgCedKNpS4iMzOl7l3XXCvYbKns3aVTEki89u1pU6ws
         wiSmefAIVrP5rBw35z4N5sBRupxiv0xm2cB9ibt/07YAL+D6AK52gx2iMGs1Hr+D9EA2
         TqTk81VisGAu74+bQD5hblSLLO5ZuOqByMB8+/EoPsPwdyPfn460RUtnKUnGN2v0ZbYS
         MqbA==
X-Gm-Message-State: AOJu0YyuU99y2O+iJpcitGanKlFdsZ5AV/QpsubKe0olc9QtGT7iy5KG
	56vcpQhdY7Se1RFtWz6aNbldhzfOSj6tzs4nbopyHE4wzy0sE4jWPiO7BPfV+mh3M+QUCM2R4ZV
	qnle8KnvYtGHYVziMJy88IFsDQ6IVwkOO7J9G4n6w2emduyz8sWDa0zT6BwLq1eDa+tRLEwlwaJ
	iBv7ion71lOsJ8GU0azOtuhkRFdjBjpF4OPJlmJZArXDtW+uv0Dq2GOfPpNec=
X-Google-Smtp-Source: AGHT+IEC4qxe+2fcc7/Igyahjsz5xBzOySUx4aKQ6En2whROnPmXHy5yyGjklCnC3VePxvrE4ugXLUCozmfFTE1BEA==
X-Received: from pfbeg17.prod.google.com ([2002:a05:6a00:8011:b0:725:1e1b:7b2e])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cc4:b0:725:389:3e11 with SMTP id d2e1a72fcca58-7257fcac089mr11976707b3a.20.1733343822927;
 Wed, 04 Dec 2024 12:23:42 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:38 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202340.2717420-1-jingzhangos@google.com>
Subject: [PATCH 5.15.y 1/3] KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
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
 arch/arm64/kvm/vgic/vgic-its.c | 20 ++++++++------------
 arch/arm64/kvm/vgic/vgic.h     | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 02ab6ab6ba91..bff7c49dfda5 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2135,7 +2135,6 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
 static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 			      struct its_ite *ite, gpa_t gpa, int ite_esz)
 {
-	struct kvm *kvm = its->dev->kvm;
 	u32 next_offset;
 	u64 val;
 
@@ -2144,7 +2143,8 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
 		ite->collection->collection_id;
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
+
+	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
 }
 
 /**
@@ -2280,7 +2280,6 @@ static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
 static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
 			     gpa_t ptr, int dte_esz)
 {
-	struct kvm *kvm = its->dev->kvm;
 	u64 val, itt_addr_field;
 	u32 next_offset;
 
@@ -2291,7 +2290,8 @@ static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
 	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
 		(dev->num_eventid_bits - 1));
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
+
+	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
 }
 
 /**
@@ -2471,7 +2471,8 @@ static int vgic_its_save_cte(struct vgic_its *its,
 	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
 	       collection->collection_id);
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
+
+	return vgic_its_write_entry_lock(its, gpa, val, esz);
 }
 
 static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
@@ -2482,8 +2483,7 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
 	u64 val;
 	int ret;
 
-	BUG_ON(esz > sizeof(val));
-	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
+	ret = vgic_its_read_entry_lock(its, gpa, &val, esz);
 	if (ret)
 		return ret;
 	val = le64_to_cpu(val);
@@ -2517,7 +2517,6 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
 	u64 baser = its->baser_coll_table;
 	gpa_t gpa = GITS_BASER_ADDR_48_to_52(baser);
 	struct its_collection *collection;
-	u64 val;
 	size_t max_size, filled = 0;
 	int ret, cte_esz = abi->cte_esz;
 
@@ -2541,10 +2540,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
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
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 2be4b0759f5b..d2fc5ecb223e 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
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

base-commit: 0a51d2d4527b43c5e467ffa6897deefeaf499358
-- 
2.47.0.338.g60cca15819-goog


