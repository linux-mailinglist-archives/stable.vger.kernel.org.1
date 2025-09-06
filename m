Return-Path: <stable+bounces-178004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A08B4772B
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 22:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985C17A29DA
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B21C860C;
	Sat,  6 Sep 2025 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoZEv1FK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E7315D45
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757191709; cv=none; b=BVKjvsV8jtaVBf1a2qkbJUHaRs1N9E5Z/oey1cI07wGKNozS/3vUkcr9+zc82J7qB6K4XrU3koeC/rm1gUTQR0RZBMw2WVyz0HWxcGfpvr6qqLU2azZvdUMb714cEYhg/S4U3AvsmS5CbqIrZambx+JZSdFg2FNWXqDlH5Og8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757191709; c=relaxed/simple;
	bh=m/Kr6UFeaFWjGi4YnpwtrrzZ5wXDjB8jXsBf/7v7Yu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gsxjj4awvpLbOmvD/MI02jZsillZJ0yIIq/gQjO4mUGBChQ56jDav5BjAyp1NnIfYUJZjMnZV9DVSy3xv2iO4YcY9XyRGoaIVNlY/4ISoeKfAI4NO75QJlNOcU3woArZdzQHGRIixva/quumv4r4KdsA+/88iSY3dhfX6ExFwoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoZEv1FK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E59EC4CEE7;
	Sat,  6 Sep 2025 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757191709;
	bh=m/Kr6UFeaFWjGi4YnpwtrrzZ5wXDjB8jXsBf/7v7Yu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZoZEv1FKHysbnlwJAihlnApDPtQv5v+UI2mGiUHkDf6jCWViMMpKV9fhFOj81WjT0
	 CPXo39UNIYF77gmYQWsnxImrTR5Pzky4LIGaOcw1W5ysw0s8+o5lhOdoXyuXq0hrpI
	 xSlmS/i2MvWG6dPL97RAKQP2zEooT1NsgcwrMOl45ilPu9leeIcUxzxGu345GWzvID
	 +9CqRwrLfUUVdCll3VUUSE48dD72P55iwblV4hZrO5X8ZMvyIiOsr4IaHh3RK8gmdL
	 /tBx2oT0yw22/U7H7MUNmJnj6XGqQRUe6ZAW6qPy30JT1pGNDpmKDwKLiEi9rWH9CU
	 vO1rtAHtSiDfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Currier <dullfire@yahoo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] PCI/MSI: Add an option to write MSIX ENTRY_DATA before any reads
Date: Sat,  6 Sep 2025 16:48:26 -0400
Message-ID: <20250906204826.282978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025042120-skimming-facing-a7af@gregkh>
References: <2025042120-skimming-facing-a7af@gregkh>
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
[ Applied workaround to msix_setup_msi_descs() instead of msix_prepare_msi_desc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/msi/msi.c | 3 +++
 include/linux/pci.h   | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index c5cc3e453fd0c..7110aed956c75 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -534,6 +534,9 @@ static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
 
 		if (desc.pci.msi_attrib.can_mask) {
 			addr = pci_msix_desc_addr(&desc);
+			/* Workaround for SUN NIU insanity, which requires write before read */
+			if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
+				writel(0, addr + PCI_MSIX_ENTRY_DATA);
 			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index df36df4695ed5..59dfa59d6d597 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -244,6 +244,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
+	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.51.0


