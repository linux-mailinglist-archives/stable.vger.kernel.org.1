Return-Path: <stable+bounces-98556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF99E459F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B60280E01
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC161F5403;
	Wed,  4 Dec 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUbnbXIo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7431F03C8
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343842; cv=none; b=T57E0UPAH+90HzaX6lIgYCv33fugUvJZ5mc0OKvvl5dp4gRhMA/x7qgXSaogVSRLT9BQYBjicC2h+s2eSNXSYbMV4M3G8YeCU1ydYOqPSPYyImiExzbnTOZikB1+tS5C422lgYMpYy+iV9Bso9kVGWTIJ/4JzzUbtVKR6vfMCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343842; c=relaxed/simple;
	bh=PMDWxeTP8tqTWAXUCdpWVGiQJcWoXL6vTZn5iGlVH5Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fvThMBkCL85QmuS5uS5BWpwMA4djGgnEQMPfIZTrICV5cRGnXUbm3LelAzxy4jj7KiGTrVpLhHJ0eZqjwYYjpZyVIRQffBW2ykrXxN7ve9KyUYrNIYR7GneCj7sZerhTkjkHY8qZrKjjwm6gWi/Br6QW1b6f5bt71NQc28KHfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUbnbXIo; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724f1b16bf8so227118b3a.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343840; x=1733948640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Usrb440mDTvLP1CA8ZnfgKBICZhH9QbNFYeGun2mrkA=;
        b=DUbnbXIoMcWEKF4sp2bLRhsWCffzqsOLILeoeMR97Dhqdmwffaqm2M/kun/ANE1c3m
         3WzSQ2OeqyPPb15V8J9U2+Hdjwe730l66hSsAVj2FMMe2k04TWKmuUY9QkTAn3YQFjX4
         C1HzmOej1Iwm8G54uBNJm8cCSrwJ7F652Dq9MIQTj/Irt/IDsJlnTLZBwmQJ/0K7x0YL
         GQa2DnyQoD8IDHskjZRmyxCEFD/AI2g1qlUhjMcc2nogLKXwUn/EsBOQIeapXe5ZC3fP
         VwnTTiSF4LH9/LLwqlOLxMarNdydgus6g/aGEki1PtGB/Jzqup3bhNkC9RZwNRW7ERGd
         ydCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343840; x=1733948640;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Usrb440mDTvLP1CA8ZnfgKBICZhH9QbNFYeGun2mrkA=;
        b=Nw/XnpHcVLbSZvD54dRqd96qXnN50Su/OyYenMbFMy4z6NrpyfRva4nMMOKOjSx1G0
         ifBRn8elKvhzCDSw6sa9F05YSFd9VAj0CjnAgO23PI9wBevXEYU8caI/Mb6yC/AGA+YN
         rBxVpvnW6lSGJ7cAvjscZjv9cVB6WS6p2sv03OVdPemIXMlMnEfmG53Iq9X7qa5vZobK
         4DdBHro1SFWjm1fV98IXU6qR+7Bsb3y+nNkP2RlbgM/zFxj5K1Pe0lrH7J5mUL2cOpQR
         4/8cNopd3fu4C2Wu3gl+TfOLSqOl/xcuCn4kjUbpplF9SCSAG/s5t9t1zqUmuTOju0lW
         7HBQ==
X-Gm-Message-State: AOJu0Yzr5ve5NpskjrC2kFpmw6rBPd5Cw1SXEbr+xIhaC4PaOM4oS+Nw
	0tejKxhGExAHxQnHn+BbpfNETAKCtlshLURQsDgX8xi9kSfiuqDXcxJAAwCV72d5lojhxNvtPRy
	MFQZFoCpw3wv1y6rAftB4h0t6ZKds9984R7dzcvs27W12kgV6owqbrKdFlNuifLO28fGwZqdhNJ
	ekeclKLxOvpaVjSANd3AMKx+6ktatv9Of3SrCw6NET+yo/pFjQVNCh5lu1ynA=
X-Google-Smtp-Source: AGHT+IFHdVdaBYnx1qUE+liqZ0te7EzuDipnJL+BzUoQc3uTVfGdyYiqcXog7FWZp3uR02xL81cWWmcbAhcPbaJE6g==
X-Received: from pfbbv3.prod.google.com ([2002:a05:6a00:4143:b0:725:34dd:498f])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b4a:b0:725:9dec:89e7 with SMTP id d2e1a72fcca58-7259dec8bcemr547557b3a.19.1733343840249;
 Wed, 04 Dec 2024 12:24:00 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:55 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202357.2718096-1-jingzhangos@google.com>
Subject: [PATCH 6.1.y 1/3] KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
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
index 092327665a6e..84499545bd8d 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2207,7 +2207,6 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
 static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 			      struct its_ite *ite, gpa_t gpa, int ite_esz)
 {
-	struct kvm *kvm = its->dev->kvm;
 	u32 next_offset;
 	u64 val;
 
@@ -2216,7 +2215,8 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
 		ite->collection->collection_id;
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(kvm, gpa, &val, ite_esz);
+
+	return vgic_its_write_entry_lock(its, gpa, val, ite_esz);
 }
 
 /**
@@ -2357,7 +2357,6 @@ static int vgic_its_restore_itt(struct vgic_its *its, struct its_device *dev)
 static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
 			     gpa_t ptr, int dte_esz)
 {
-	struct kvm *kvm = its->dev->kvm;
 	u64 val, itt_addr_field;
 	u32 next_offset;
 
@@ -2368,7 +2367,8 @@ static int vgic_its_save_dte(struct vgic_its *its, struct its_device *dev,
 	       (itt_addr_field << KVM_ITS_DTE_ITTADDR_SHIFT) |
 		(dev->num_eventid_bits - 1));
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(kvm, ptr, &val, dte_esz);
+
+	return vgic_its_write_entry_lock(its, ptr, val, dte_esz);
 }
 
 /**
@@ -2555,7 +2555,8 @@ static int vgic_its_save_cte(struct vgic_its *its,
 	       ((u64)collection->target_addr << KVM_ITS_CTE_RDBASE_SHIFT) |
 	       collection->collection_id);
 	val = cpu_to_le64(val);
-	return kvm_write_guest_lock(its->dev->kvm, gpa, &val, esz);
+
+	return vgic_its_write_entry_lock(its, gpa, val, esz);
 }
 
 /*
@@ -2571,8 +2572,7 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
 	u64 val;
 	int ret;
 
-	BUG_ON(esz > sizeof(val));
-	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
+	ret = vgic_its_read_entry_lock(its, gpa, &val, esz);
 	if (ret)
 		return ret;
 	val = le64_to_cpu(val);
@@ -2610,7 +2610,6 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
 	u64 baser = its->baser_coll_table;
 	gpa_t gpa = GITS_BASER_ADDR_48_to_52(baser);
 	struct its_collection *collection;
-	u64 val;
 	size_t max_size, filled = 0;
 	int ret, cte_esz = abi->cte_esz;
 
@@ -2634,10 +2633,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
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
index bc898229167b..056fcee46165 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -6,6 +6,7 @@
 #define __KVM_ARM_VGIC_NEW_H__
 
 #include <linux/irqchip/arm-gic-common.h>
+#include <asm/kvm_mmu.h>
 
 #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
 #define IMPLEMENTER_ARM		0x43b
@@ -131,6 +132,29 @@ static inline bool vgic_irq_is_multi_sgi(struct vgic_irq *irq)
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

base-commit: e4d90d63d385228b1e0bcf31cc15539bbbc28f7f
-- 
2.47.0.338.g60cca15819-goog


