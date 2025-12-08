Return-Path: <stable+bounces-200353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2DCAD4BB
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 14:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B79983017F3C
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501F2E9EA1;
	Mon,  8 Dec 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RhsRZPHE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0EHEcbk"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436E2C324E;
	Mon,  8 Dec 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201199; cv=none; b=EVHbW3ZZGNoKTBHcF9eaJsQmFPXdNWfxFJP7vzKTnCgwKlGylkFRPFo6fO+XaojmDRCsu/7pJkqTX5+RfvTuyBP/0ieNdTWXrHOAt/TI7qdtdwp0u9rcIi6vG2cT5ld2ukA/uh2Pbtuh4TsPGlTUS7rMfI8mwrbaW1dEgBidGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201199; c=relaxed/simple;
	bh=eYVXL8DMZB+r5fPjy/NycOp2+iNe5gsZtxUfAuaCUYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sH5wWs1vtTqUd1fonzAxLlnlr8FqcS5GIhWsUPxdKnGfxtuS7Hs04MHSjp4ERKIrlhR4nRouujLZJg9IHYRAclPWTdllTxKDZ9+j1vQ0gCfkpN5sDom9h+TQ7LakFYVY/pbXCwVG7pd6OojFEwfZq+QsbV1/+koZCwgkyIvMYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RhsRZPHE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0EHEcbk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765201195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LPRcMTt1XndV8muqKGUnybX/A1IYES6ugXD4w/hW3RM=;
	b=RhsRZPHEkZxPhZJ71U4XjSDsy4QbloQklyp2q+DXzPF2uPb2SC22ETdtOGyh3yhvpwINxr
	cGDU+e/z9JP1M1T7Zeif2FvI7SdEhEmuVuhhc2r4q94hcl3L1Q2f8S7vuK652KVaxHJcv4
	yO0811NIiONtO3i+W1ydVPp0cgC+EXQONxJokD+OEozW01Wa6xgUQ2sgkcW9LD+pI7t4vN
	qMQcwlTVz7ZWp3YGWpu5UINfoewJSoMfbNbggTVFSDNZIXPqo1D5ujN1kwUnJ1RnXrKbtx
	THhUpCnCqRC1dEPxcC9CwY71tOZDJsN18E7XwCpPkcaOM2KjES/XQn+C09QFKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765201195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LPRcMTt1XndV8muqKGUnybX/A1IYES6ugXD4w/hW3RM=;
	b=i0EHEcbk0YHTVkv1xOu3t+RMxxcaJUOmGv6IYvBZ5L9tzUwH1E78I4AFiuJ+Px5AQgvBye
	bLpo5o91jG95ZbAA==
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	maz@kernel.org,
	gautam@linux.ibm.com,
	Gregory Joyce <gjoyce@ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Nilay Shroff <nilay@inux.ibm.com>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/pseries: Fix MSI-X allocation failure when quota is exceeded
Date: Mon,  8 Dec 2025 14:39:49 +0100
Message-ID: <20251208133949.3651991-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Nilay reported that since commit daaa574aba6f ("powerpc/pseries/msi: Switch
to msi_create_parent_irq_domain()"), the NVMe driver cannot enable MSI-X
when the device's MSI-X table size is larger than the firmware's MSI quota
for the device.

This is because the commit changes how rtas_prepare_msi_irqs() is called:

  - Before, it is called when interrupts are allocated at the global
    interrupt domain with nvec_in being the number of allocated interrupts.
    rtas_prepare_msi_irqs() can return a positive number and the allocation
    will be retried.

  - Now, it is called at the creation of per-device interrupt domain with
    nvec_in being the number of interrupts that the device supports. If
    rtas_prepare_msi_irqs() returns positive, domain creation just fails.

For Nilay's NVMe driver case, rtas_prepare_msi_irqs() returns a positive
number (the quota). This causes per-device interrupt domain creation to
fail and thus the NVMe driver cannot enable MSI-X.

Rework to make this scenario works again:

  - pseries_msi_ops_prepare() only prepares as many interrupts as the quota
    permit.

  - pseries_irq_domain_alloc() fails if the device's quota is exceeded.

Now, if the quota is exceeded, pseries_msi_ops_prepare() will only prepare
as allowed by the quota. If device drivers attempt to allocate more
interrupts than the quota permits, pseries_irq_domain_alloc() will return
an error code and msi_handle_pci_fail() will allow device drivers a retry.

Reported-by: Nilay Shroff <nilay@inux.ibm.com>
Closes: https://lore.kernel.org/linuxppc-dev/6af2c4c2-97f6-4758-be33-256638=
ef39e5@linux.ibm.com/
Fixes: daaa574aba6f ("powerpc/pseries/msi: Switch to msi_create_parent_irq_=
domain()")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Acked-by: Nilay Shroff <nilay@inux.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/platforms/pseries/msi.c | 42 ++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/=
pseries/msi.c
index a82aaa786e9e..8898a968a59b 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -19,6 +19,11 @@
=20
 #include "pseries.h"
=20
+struct pseries_msi_device {
+	unsigned int msi_quota;
+	unsigned int msi_used;
+};
+
 static int query_token, change_token;
=20
 #define RTAS_QUERY_FN		0
@@ -433,8 +438,26 @@ static int pseries_msi_ops_prepare(struct irq_domain *=
domain, struct device *dev
 	struct msi_domain_info *info =3D domain->host_data;
 	struct pci_dev *pdev =3D to_pci_dev(dev);
 	int type =3D (info->flags & MSI_FLAG_PCI_MSIX) ? PCI_CAP_ID_MSIX : PCI_CA=
P_ID_MSI;
+	int ret;
+
+	struct pseries_msi_device *pseries_dev __free(kfree)
+		=3D kmalloc(sizeof(*pseries_dev), GFP_KERNEL);
+	if (!pseries_dev)
+		return -ENOMEM;
+
+	ret =3D rtas_prepare_msi_irqs(pdev, nvec, type, arg);
+	if (ret > 0) {
+		nvec =3D ret;
+		ret =3D rtas_prepare_msi_irqs(pdev, nvec, type, arg);
+	}
+	if (ret < 0)
+		return ret;
=20
-	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
+	pseries_dev->msi_quota =3D nvec;
+	pseries_dev->msi_used =3D 0;
+
+	arg->scratchpad[0].ptr =3D no_free_ptr(pseries_dev);
+	return 0;
 }
=20
 /*
@@ -443,9 +466,13 @@ static int pseries_msi_ops_prepare(struct irq_domain *=
domain, struct device *dev
  */
 static void pseries_msi_ops_teardown(struct irq_domain *domain, msi_alloc_=
info_t *arg)
 {
+	struct pseries_msi_device *pseries_dev =3D arg->scratchpad[0].ptr;
 	struct pci_dev *pdev =3D to_pci_dev(domain->dev);
=20
 	rtas_disable_msi(pdev);
+
+	WARN_ON(pseries_dev->msi_used);
+	kfree(pseries_dev);
 }
=20
 static void pseries_msi_shutdown(struct irq_data *d)
@@ -546,12 +573,18 @@ static int pseries_irq_domain_alloc(struct irq_domain=
 *domain, unsigned int virq
 				    unsigned int nr_irqs, void *arg)
 {
 	struct pci_controller *phb =3D domain->host_data;
+	struct pseries_msi_device *pseries_dev;
 	msi_alloc_info_t *info =3D arg;
 	struct msi_desc *desc =3D info->desc;
 	struct pci_dev *pdev =3D msi_desc_to_pci_dev(desc);
 	int hwirq;
 	int i, ret;
=20
+	pseries_dev =3D info->scratchpad[0].ptr;
+
+	if (pseries_dev->msi_used + nr_irqs > pseries_dev->msi_quota)
+		return -ENOSPC;
+
 	hwirq =3D rtas_query_irq_number(pci_get_pdn(pdev), desc->msi_index);
 	if (hwirq < 0) {
 		dev_err(&pdev->dev, "Failed to query HW IRQ: %d\n", hwirq);
@@ -567,9 +600,10 @@ static int pseries_irq_domain_alloc(struct irq_domain =
*domain, unsigned int virq
 			goto out;
=20
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &pseries_msi_irq_chip, domain->host_data);
+					      &pseries_msi_irq_chip, pseries_dev);
 	}
=20
+	pseries_dev->msi_used++;
 	return 0;
=20
 out:
@@ -582,9 +616,11 @@ static void pseries_irq_domain_free(struct irq_domain =
*domain, unsigned int virq
 				    unsigned int nr_irqs)
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
-	struct pci_controller *phb =3D irq_data_get_irq_chip_data(d);
+	struct pseries_msi_device *pseries_dev =3D irq_data_get_irq_chip_data(d);
+	struct pci_controller *phb =3D domain->host_data;
=20
 	pr_debug("%s bridge %pOF %d #%d\n", __func__, phb->dn, virq, nr_irqs);
+	pseries_dev->msi_used -=3D nr_irqs;
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
=20
--=20
2.47.3


