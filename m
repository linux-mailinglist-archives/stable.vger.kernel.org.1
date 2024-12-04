Return-Path: <stable+bounces-98550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CCC9E4599
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCF3280E3A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654F1F5403;
	Wed,  4 Dec 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="woJ2+bHL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66601F03C8
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343807; cv=none; b=cjKOaNGpDrfQu0wBR+xZjxR2HOdB+ZQPaotPOzaWrXWqGhiOc8/DVEVM+54QMWEg9FGQ2sDxy3OOp6GkjGhz+Rn3yr1oErwD22yEAUZy6YVCMlMU9OzKS7Zrm/hZpn9fpeU3dnrVfkrxHb2giLspPVIs4HbmZJ2pmnPiAmoJ++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343807; c=relaxed/simple;
	bh=/rt5DjlA7EYa/TJMp127fZTiF/O/u0lYY/c72B20vnk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JAomlW3PSJuzvSk0XE4wEbgrUg8OTHPnwqZT4JR9ghk1x0eh4gjAAu0CFnzbwxELdXjoza6pQCSvg9DSKwvwmNVX+IyUcp6aa3W2dvMYRVTjbApEAzSoH2KBW7tmAvZmkYujryRNQYaIebUwJ57QnfCsZXTS92/zSpAohqlUYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=woJ2+bHL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee31227b58so171662a91.3
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343805; x=1733948605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mx5sg+NDnEMEVsBHmo4z1ZqCK55Eia08bWmY/EI65Zs=;
        b=woJ2+bHLX6OBEwYf6ZKG+jVUPJ6dlzam/zSuX69gXKroWDxc8Fy+i03TOX1t5BMXPo
         DsWypA0Ck31z9lM9Manm1d5TMwvYyn4G1ifQ9syjkJL4OdAZ1WUPb3JAHL8BGrL9vZ5n
         FYqYgDIQ39/xv93BphRKo6NqBZzu3Q21yHAvB9dFypoIq1iO6aBV6dt+jWko04vZQ1Tb
         QPDdOf64VAn/tw6Z2EvnuRww57k0A33g8wSoCsZWhgXe/urdWOlklMAvZSACE5/gbS0Z
         VkM1bF1qaIlHgw3lbLWG/mhq4r62SLYdeh9ToPnvFEjpcB9FS2GNyWh2hASLgcoOkB/H
         FFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343805; x=1733948605;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mx5sg+NDnEMEVsBHmo4z1ZqCK55Eia08bWmY/EI65Zs=;
        b=cbxrHzb7dJljX0DT5P/FuuyBraFxm4hKiLnpPx8oI4cV304pNkdgqtmZFwPRwc08M2
         l82PNj1a737EbYi97va4KdaDF/X3hdhlfrx7zHPvVqP5FLv1QxOWJnt+RXei9AO3pn9q
         jddH9nS9YAtJ5on6dmTgWQw9gQEsVhHiN65BtHijN8GDkDDNZnlmJQcwD/eNfRre60Gu
         Hq+4vJfnSz1Cf7EiPNGe+beF2N1++SVpmhYuElVsJWNs35Hn9c2+PludWOKooWmDPIGq
         6cvl1sTxWmV6mQmdsW4Uzoj3A272s9hpW7net0YOp9BL4cUd8Ig3NARwdCVarAyjkbj3
         b2EA==
X-Gm-Message-State: AOJu0YyLqYYnj3YXshte3x/wolKxzqge3sRDxzPXmMNr/wtTeg5lsvYz
	Kmlcjs1TO9x4LbwOCM7UGynfzLGUAvec4/UBHZxmGSNWpcdDxo211J5Z8oDPY0RH5nQXIKsm1SZ
	psgBxBgEkq+gxYFRklP605JfhHpqkyfzsdV96hawNZUXEw7H7siAMBAW+HFDmdHNEuBsY/uhfBf
	c+TR4EuyMND/KaDQ6j6oChKyzsmnI1TNU6jiMh1md0wCC1d87W6nbBDMq6oj4=
X-Google-Smtp-Source: AGHT+IH5xQjeHQX9tq+43SarBCSvCk1dThgEt62DFKaEU9+m22jhhN89M9ejirkV4cCpLdUoAlpS/L3BigwN3re5gQ==
X-Received: from pfbbr10.prod.google.com ([2002:a05:6a00:440a:b0:725:936f:c305])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b92:b0:2ee:df8b:684 with SMTP id 98e67ed59e1d1-2ef00f19e69mr11607679a91.0.1733343804804;
 Wed, 04 Dec 2024 12:23:24 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:16 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202318.2716633-1-jingzhangos@google.com>
Subject: [PATCH 5.10.y 1/3] KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*
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
index 93c0365cdd7b..d3ea81d947b7 100644
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
index 3d7fa7ef353e..db99a1b167d8 100644
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

base-commit: 711d99f845cdb587b7d7cf5e56c289c3d96d27c5
-- 
2.47.0.338.g60cca15819-goog


