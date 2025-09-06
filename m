Return-Path: <stable+bounces-177998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD4B476ED
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855673AE433
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4437E28851C;
	Sat,  6 Sep 2025 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8wZj5te"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039751E7C2D
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757188217; cv=none; b=ue4Z2Ew1PSzt5SL+lAXAI7RZRLPGOfiA7FKR4QBMqhda2Wj3ug+nSpKwwr7uEhNN1zXG60zSbjyCqFULaEjPDP1WeY5sohoBtG55W+5IHW4udgvf/85k+pkdhl2CuS/LSlrcEtZVYd+Ep3SkSkReiIk6PCg3E4pWHXlTZlKJ5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757188217; c=relaxed/simple;
	bh=OPNY0YWtIbCSHJY1cLKue6r0QurU2sizUExyyYeKVRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1RTCxT9Ti2GvWBecUHKuYna9v59Q9ok1cHnvLY6TYmTGmEht1pkSpxAEgs9N63ca0wbzlhqZRTu/OGujr0DrjG7zxtEkRLbeTxiG6yN9UvYTJKqFlsFX1/EJeyr4aXZidQYMHjtfVYLeopUQWmxpZoyhIGcq/v2Vy59U8BalBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8wZj5te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B4DC4CEE7;
	Sat,  6 Sep 2025 19:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757188216;
	bh=OPNY0YWtIbCSHJY1cLKue6r0QurU2sizUExyyYeKVRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h8wZj5teRv0kzYxxYd7baugvD8DcAgcPSuQAlfh04TKJGTT0oORS+XcswiIteDODn
	 8j3xI2gZosRaLy/8uLGSG9lCZFAjx3Qfq48OesIq7k2meILBL8D6A2fBAet6xlNwKi
	 FzIu6S9aZqWICbzdQj5JliiomnXbZSJiyrX7nGrIKlMaPQgWThNKRyHOYi+wlX67nE
	 V5HLKSSjRXyp1ooRb7cqN96LSalUwQMTbAGNPo1rf26HZqWx/0vqL2hf7Q3OApF8Ap
	 ixCGrnTiGnpA9iIvRIv8Vzkw/ZRuqg3fuX3/w0bQSR4Vajle4LsYVqrUp1+QW98rbt
	 jsFqSbcLGVqOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Currier <dullfire@yahoo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI/MSI: Add an option to write MSIX ENTRY_DATA before any reads
Date: Sat,  6 Sep 2025 15:50:14 -0400
Message-ID: <20250906195014.209521-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025042119-impaired-pretty-e98a@gregkh>
References: <2025042119-impaired-pretty-e98a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Currier <dullfire@yahoo.com>

[ Upstream commit cf761e3dacc6ad5f65a4886d00da1f9681e6805a ]

Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries") introduced a
readl() from ENTRY_VECTOR_CTRL before the writel() to ENTRY_DATA.

This is correct, however some hardware, like the Sun Neptune chips, the NIU
module, will cause an error and/or fatal trap if any MSIX table entry is
read before the corresponding ENTRY_DATA field is written to.

Add an optional early writel() in msix_prepare_msi_desc().

Fixes: 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241117234843.19236-2-dullfire@yahoo.com
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/msi/msi.c | 3 +++
 include/linux/pci.h   | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 053bb9fac6e3e..b638731aa5ff2 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -610,6 +610,9 @@ void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 	if (desc->pci.msi_attrib.can_mask) {
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
+		/* Workaround for SUN NIU insanity, which requires write before read */
+		if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
+			writel(0, addr + PCI_MSIX_ENTRY_DATA);
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ac5bd1718af24..0511f6f9a4e6a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
+	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.51.0


