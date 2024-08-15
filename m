Return-Path: <stable+bounces-68743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C266B9533C2
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BCA1F26B30
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601BF19FA7E;
	Thu, 15 Aug 2024 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oeZNoo/s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E819FA99;
	Thu, 15 Aug 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731524; cv=none; b=N0DxD7km6rBs/h3Ub15KZu7ASgkFaC8sFH4YxYG0qzMXNwcdIoDgjmp10dxYND+jSduSdI7jcp7UrsKOPdP21pgHIZQBSvvUZ4blTQq8opXtFuIsEQcWNdBK5MdgoCg5HgP6tN8nP3V4mAwAhXQfADmiTQosJmHUIRR0bLGv00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731524; c=relaxed/simple;
	bh=mcv/3Oxo5VtpslgiriHXlZqgt2w6I4ANWF9lpf/5SkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8khQUxYuL+G1Uz3uUdV1wweDaZPGsXzxrjOtkzjshPuPd/XKxzjuRGZqo9n7n6TzTixVoqoNhyw+WYZt26ZrJhpiB/UytXUllx8LwcthsHNpO8T8QqdPTi85bCwlFqdCh59T77jPhayao2zRsOD3aK5tjNb4Gu6vAmlnNRnGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oeZNoo/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353A1C4AF0A;
	Thu, 15 Aug 2024 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731523;
	bh=mcv/3Oxo5VtpslgiriHXlZqgt2w6I4ANWF9lpf/5SkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeZNoo/sjBotzoYV6xdRr+mBDbMr4jZu5u33xV6zkxzhnln49xEYlon0g/3QfytK1
	 +r5jPrp1xQ/PiL+591p3J/DCPBdl3uzWAmRsfTyKr0sUvt7wYRb9tQiOREvUkJ7+fx
	 CCs61ykD9ZdEzVdL28QuYrT28mdsSIH5XFnPJVYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 156/259] s390/pci: Allow allocation of more than 1 MSI interrupt
Date: Thu, 15 Aug 2024 15:24:49 +0200
Message-ID: <20240815131908.809930401@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerd Bayer <gbayer@linux.ibm.com>

[ Upstream commit ab42fcb511fd9d241bbab7cc3ca04e34e9fc0666 ]

On a PCI adapter that provides up to 8 MSI interrupt sources the s390
implementation of PCI interrupts rejected to accommodate them, although
the underlying hardware is able to support that.

For MSI-X it is sufficient to allocate a single irq_desc per msi_desc,
but for MSI multiple irq descriptors are attached to and controlled by
a single msi descriptor. Add the appropriate loops to maintain multiple
irq descriptors and tie/untie them to/from the appropriate AIBV bit, if
a device driver allocates more than 1 MSI interrupt.

Common PCI code passes on requests to allocate a number of interrupt
vectors based on the device drivers' demand and the PCI functions'
capabilities. However, the root-complex of s390 systems support just a
limited number of interrupt vectors per PCI function.
Produce a kernel log message to inform about any architecture-specific
capping that might be done.

With this change, we had a PCI adapter successfully raising
interrupts to its device driver via all 8 sources.

Fixes: a384c8924a8b ("s390/PCI: Fix single MSI only check")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/pci/pci_irq.c | 62 ++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index b36f5ef34a6c1..690f6999287bc 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -262,8 +262,8 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
 
 int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
+	unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
 	struct zpci_dev *zdev = to_zpci(pdev);
-	unsigned int hwirq, msi_vecs, cpu;
 	struct msi_desc *msi;
 	struct msi_msg msg;
 	unsigned long bit;
@@ -273,30 +273,46 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	zdev->aisb = -1UL;
 	zdev->msi_first_bit = -1U;
 
-	if (type == PCI_CAP_ID_MSI && nvec > 1)
-		return 1;
 	msi_vecs = min_t(unsigned int, nvec, zdev->max_msi);
+	if (msi_vecs < nvec) {
+		pr_info("%s requested %d irqs, allocate system limit of %d",
+			pci_name(pdev), nvec, zdev->max_msi);
+	}
 
 	rc = __alloc_airq(zdev, msi_vecs, &bit);
 	if (rc < 0)
 		return rc;
 
-	/* Request MSI interrupts */
+	/*
+	 * Request MSI interrupts:
+	 * When using MSI, nvec_used interrupt sources and their irq
+	 * descriptors are controlled through one msi descriptor.
+	 * Thus the outer loop over msi descriptors shall run only once,
+	 * while two inner loops iterate over the interrupt vectors.
+	 * When using MSI-X, each interrupt vector/irq descriptor
+	 * is bound to exactly one msi descriptor (nvec_used is one).
+	 * So the inner loops are executed once, while the outer iterates
+	 * over the MSI-X descriptors.
+	 */
 	hwirq = bit;
 	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
-		rc = -EIO;
 		if (hwirq - bit >= msi_vecs)
 			break;
-		irq = __irq_alloc_descs(-1, 0, 1, 0, THIS_MODULE,
-				(irq_delivery == DIRECTED) ?
-				msi->affinity : NULL);
+		irqs_per_msi = min_t(unsigned int, msi_vecs, msi->nvec_used);
+		irq = __irq_alloc_descs(-1, 0, irqs_per_msi, 0, THIS_MODULE,
+					(irq_delivery == DIRECTED) ?
+					msi->affinity : NULL);
 		if (irq < 0)
 			return -ENOMEM;
-		rc = irq_set_msi_desc(irq, msi);
-		if (rc)
-			return rc;
-		irq_set_chip_and_handler(irq, &zpci_irq_chip,
-					 handle_percpu_irq);
+
+		for (i = 0; i < irqs_per_msi; i++) {
+			rc = irq_set_msi_desc_off(irq, i, msi);
+			if (rc)
+				return rc;
+			irq_set_chip_and_handler(irq + i, &zpci_irq_chip,
+						 handle_percpu_irq);
+		}
+
 		msg.data = hwirq - bit;
 		if (irq_delivery == DIRECTED) {
 			if (msi->affinity)
@@ -309,19 +325,22 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			msg.address_lo |= (cpu_addr << 8);
 
 			for_each_possible_cpu(cpu) {
-				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
+				for (i = 0; i < irqs_per_msi; i++)
+					airq_iv_set_data(zpci_ibv[cpu],
+							 hwirq + i, irq + i);
 			}
 		} else {
 			msg.address_lo = zdev->msi_addr & 0xffffffff;
-			airq_iv_set_data(zdev->aibv, hwirq, irq);
+			for (i = 0; i < irqs_per_msi; i++)
+				airq_iv_set_data(zdev->aibv, hwirq + i, irq + i);
 		}
 		msg.address_hi = zdev->msi_addr >> 32;
 		pci_write_msi_msg(irq, &msg);
-		hwirq++;
+		hwirq += irqs_per_msi;
 	}
 
 	zdev->msi_first_bit = bit;
-	zdev->msi_nr_irqs = msi_vecs;
+	zdev->msi_nr_irqs = hwirq - bit;
 
 	if (irq_delivery == DIRECTED)
 		rc = zpci_set_directed_irq(zdev);
@@ -330,13 +349,14 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	if (rc)
 		return rc;
 
-	return (msi_vecs == nvec) ? 0 : msi_vecs;
+	return (zdev->msi_nr_irqs == nvec) ? 0 : zdev->msi_nr_irqs;
 }
 
 void arch_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 	struct msi_desc *msi;
+	unsigned int i;
 	int rc;
 
 	/* Disable interrupts */
@@ -349,8 +369,10 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 
 	/* Release MSI interrupts */
 	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
-		irq_set_msi_desc(msi->irq, NULL);
-		irq_free_desc(msi->irq);
+		for (i = 0; i < msi->nvec_used; i++) {
+			irq_set_msi_desc(msi->irq + i, NULL);
+			irq_free_desc(msi->irq + i);
+		}
 		msi->msg.address_lo = 0;
 		msi->msg.address_hi = 0;
 		msi->msg.data = 0;
-- 
2.43.0




