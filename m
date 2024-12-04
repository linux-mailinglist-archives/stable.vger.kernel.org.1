Return-Path: <stable+bounces-98544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B64F9E4588
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9FC16866E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D04C1F5403;
	Wed,  4 Dec 2024 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdzXlyY2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DFF1F03EE
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343654; cv=none; b=k/Nogj28OgcA+I5Xls+74aDESLeZd4MejBpsOQBDiutIW51CbzVOp3milZQbyaF1Nit4jdAiJ5kd5KN4nMLUjtVmRXan8SLXDWDuniq96Iki/0PHXdxurzpPuDee9HD/Z5k2RKcoLMQoZfmAkff+r+rKUhRrf5ArWUjtBhI4hsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343654; c=relaxed/simple;
	bh=xl45x911e1LFBhagQsjaa+eU71uS9V375TNP9tY0rgw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G/8U3b/6fViHHPXTf/Vsh2WQ56gUFCePwwfSdUdmexaFho/rOfgr0fpSwn0jvbGIUscM7fGrJE1J7nIHgW/1hYXNUTTdfd1AqcYvemOPYn6CmMOSXBAfMkxtcJBuArJXEDQdToAsgCaRYL6v5CyySqG9e5mE9dM4L5ZWg8p8u2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdzXlyY2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7259a7fd145so143241b3a.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343651; x=1733948451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9rK98CcgsSX9/z8ZxFOlGRABw60gj8frVJzX8QSET8M=;
        b=NdzXlyY2+xxc73Yt9WgQT60AhTkBXhqVwSs46vhQTJsjscfyIBVJpbuZOOTZVBaAAz
         DOJ5sqbdvZG/NntxgAkOjqDH0Vl1KUH2emOlo9acS2/4INH8o8QHZNIGO3tBMcCoZ1mh
         SFx1cmUyh/V8rporevBfsUXhHipxR/iXmZQNJj5oUJV7oW5qpoYm0DVxP9fi0JKEO5AZ
         KpVufBKZJuLFNY1eybEMq7mr4dW7ljxyNVktQsClzVEtd3xrxdEFNA+3b+Mk9CMGwtQu
         9tzmNVU4RorXzzt630o6mbF6R1hzDNzzdw2FWiwoOcVxN90OMlZoASgDpTZrOMvnziJE
         BYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343651; x=1733948451;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rK98CcgsSX9/z8ZxFOlGRABw60gj8frVJzX8QSET8M=;
        b=GTLpCU1mANgIaU3ytvdYcgv4/Y17Ro5qOx+1Nh5/dv6imsuteaKTHZ3ebGm1eT41Lh
         K96yhyW7EvGBODyR6PMTvf3fH3P2o9lG5MDILewXOSiYJAoSs+RLKRB5D+aX522kTB/i
         H3/SJu4XID8JOhMb7c3rbScSzhYCKT4QJVNga1Cv7meDupWkEa4H58S2TNR6JvAfqcoo
         yGVMP2lXeynODEbQT85XtMZU4BewRFWIcjOfy7fyOeJ60l0QihQ6gJNuMhYFG0M+lRTd
         eNkPfkC3QEJOWzj03H50pSbC8WNySKTbaLOZnzarvqIYlO6mw3jRiDH05QY+ehG5jerk
         GomA==
X-Gm-Message-State: AOJu0YyYW14GgIAhDAAzJ8bozIYBElBmJsliRtEOZpSFAi7ekVzsHT6e
	7giYg8EBDj2ZuGilsVh7yA9zJ1YB6xDb+T5n7bM79Qa1+USC8MqOdnDUArhBdeLJJ64jdhhN4bR
	IUYAIzBQL+bPeTAoMTfKJEfLwywgdRNJSJHMlQmWDyy/kHVPR5AQqG7gV3lQaYUGKRXyakcloF6
	3E/u418306UwOkp1JmbhzeD9B+j5QjjTQYxaDkNJ3j3M/0mtoHHrzjPaXI3ks=
X-Google-Smtp-Source: AGHT+IHBCBSKpBd/ded+WgzupwoG9GSRCsSWKAhw7bvZVAXmQba+AeYF8yEL1VbmwBpvdki5FZxFgCPBeUJrMiETpg==
X-Received: from pfbay30.prod.google.com ([2002:a05:6a00:301e:b0:724:e029:ed22])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1790:b0:725:3305:1a80 with SMTP id d2e1a72fcca58-7257fa4b354mr10905615b3a.4.1733343651530;
 Wed, 04 Dec 2024 12:20:51 -0800 (PST)
Date: Wed,  4 Dec 2024 12:20:36 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202038.2714140-1-jingzhangos@google.com>
Subject: [PATCH 4.19.y 1/3] KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
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
index 2fb26bd3106e..7fcf903fa5b0 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1949,7 +1949,6 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
 static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 			      struct its_ite *ite, gpa_t gpa, int ite_esz)
 {
-	struct kvm *kvm = its->dev->kvm;
 	u32 next_offset;
 	u64 val;
 
@@ -1958,7 +1957,8 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
 		ite->collection->collection_id;
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
+
+	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
 }
 
 /**
@@ -2094,7 +2094,6 @@ static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
 static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
 			     gpa_t ptr, int dte_esz)
 {
-	struct kvm *kvm = its->dev->kvm;
 	u64 val, itt_addr_field;
 	u32 next_offset;
 
@@ -2105,7 +2104,8 @@ static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
 	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
 		(dev->num_eventid_bits - 1));
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
+
+	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
 }
 
 /**
@@ -2285,7 +2285,8 @@ static int vgic_its_save_cte(struct vgic_its *its,
 	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
 	       collection->collection_id);
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
+
+	return vgic_its_write_entry_lock(its, gpa, val, esz);
 }
 
 static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
@@ -2296,8 +2297,7 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
 	u64 val;
 	int ret;
 
-	BUG_ON(esz > sizeof(val));
-	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
+	ret = vgic_its_read_entry_lock(its, gpa, &val, esz);
 	if (ret)
 		return ret;
 	val = le64_to_cpu(val);
@@ -2331,7 +2331,6 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
 	u64 baser = its->baser_coll_table;
 	gpa_t gpa = BASER_ADDRESS(baser);
 	struct its_collection *collection;
-	u64 val;
 	size_t max_size, filled = 0;
 	int ret, cte_esz = abi->cte_esz;
 
@@ -2355,10 +2354,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
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
index d5e454279925..e5a307dab61e 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -17,6 +17,7 @@
 #define __KVM_ARM_VGIC_NEW_H__
 
 #include <linux/irqchip/arm-gic-common.h>
+#include <asm/kvm_mmu.h>
 
 #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
 #define IMPLEMENTER_ARM		0x43b
@@ -137,6 +138,29 @@ static inline bool vgic_irq_is_multi_sgi(struct vgic_irq *irq)
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

base-commit: 708f578f2a8f702d2f2a0ef5e6eac28e08206e03
-- 
2.47.0.338.g60cca15819-goog


