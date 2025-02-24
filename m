Return-Path: <stable+bounces-119245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2FAA42522
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4C019C54F6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5724886B;
	Mon, 24 Feb 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DzuPyQ90"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D06727701;
	Mon, 24 Feb 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408812; cv=none; b=BwmgNiB36UeLakEdz0IvWzSHUGlCPpzXOxjukdwtyhBpr0RAWFPnLQEAoGQaJZWwMGXe5c2vvnWMqE+wn7JvJ8D3XUGYSSTsjjgAwvjpa6A+ziH/MnyMSToKC3LrFMum0tukJ/8vR2i1bax47+HaAC90+6R6sTJyczfj3NqDu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408812; c=relaxed/simple;
	bh=ieU+3LaXmpPZ/7Jd6swhmtCyLI6YI6zdeGVF4kwHB/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTSqauRrPo8E4xnfMcPIunFMEDGtAYF/ZpuO525Jo6k7Usa5a2gGo4MvTTk6dPbk02SkECvug72I4ZTUXNTH/L/GfPDrjJEFeoFRR4mzL9X4wsokz6Gm6Q7B6VvSSWP97RumTxGufvzi0oByg/KmMKOtiIg6djx2lAqVH+dlRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DzuPyQ90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AA9C4CED6;
	Mon, 24 Feb 2025 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408811;
	bh=ieU+3LaXmpPZ/7Jd6swhmtCyLI6YI6zdeGVF4kwHB/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzuPyQ90Twj/n+ciI9EFpFVqxKjDab22eufAKa2EWel36hhil2UiLjIvDs/j3+ny9
	 3Uceu+/iq5vuOPyErYBHvz/KWCfid7k7Yd+OqVD3tznvHLGk0C5cP1CAWCymtaUBI0
	 xZZS20jsdHc4d+kUsg/NqFlGHMa5rUvCr8YFQy3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Stanner <pstanner@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 013/138] PCI: Remove devres from pci_intx()
Date: Mon, 24 Feb 2025 15:34:03 +0100
Message-ID: <20250224142604.983233014@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit dfa2f4d5f9e5d757700cefa8ee480099889f1c69 ]

pci_intx() is a hybrid function which can sometimes be managed through
devres. This hybrid nature is undesirable.

Since all users of pci_intx() have by now been ported either to
always-managed pcim_intx() or never-managed pci_intx_unmanaged(), the
devres functionality can be removed from pci_intx().

Consequently, pci_intx_unmanaged() is now redundant, because pci_intx()
itself is now unmanaged.

Remove the devres functionality from pci_intx(). Have all users of
pci_intx_unmanaged() call pci_intx(). Remove pci_intx_unmanaged().

Link: https://lore.kernel.org/r/20241209130632.132074-13-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: d555ed45a5a1 ("PCI: Restore original INTX_DISABLE bit by pcim_intx()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/devres.c |  4 ++--
 drivers/pci/pci.c    | 43 ++-----------------------------------------
 include/linux/pci.h  |  1 -
 3 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3594eea379931..cc31951347210 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -416,7 +416,7 @@ static void pcim_intx_restore(struct device *dev, void *data)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcim_intx_devres *res = data;
 
-	pci_intx_unmanaged(pdev, res->orig_intx);
+	pci_intx(pdev, res->orig_intx);
 }
 
 static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
@@ -453,7 +453,7 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 		return -ENOMEM;
 
 	res->orig_intx = !enable;
-	pci_intx_unmanaged(pdev, enable);
+	pci_intx(pdev, enable);
 
 	return 0;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d3c3425f7bc57..b0ae4bc1a1bee 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4483,17 +4483,13 @@ void pci_disable_parity(struct pci_dev *dev)
 }
 
 /**
- * pci_intx_unmanaged - enables/disables PCI INTx for device dev,
- * unmanaged version
+ * pci_intx - enables/disables PCI INTx for device dev
  * @pdev: the PCI device to operate on
  * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device @pdev
- *
- * This function behavios identically to pci_intx(), but is never managed with
- * devres.
  */
-void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
+void pci_intx(struct pci_dev *pdev, int enable)
 {
 	u16 pci_command, new;
 
@@ -4509,41 +4505,6 @@ void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
 
 	pci_write_config_word(pdev, PCI_COMMAND, new);
 }
-EXPORT_SYMBOL_GPL(pci_intx_unmanaged);
-
-/**
- * pci_intx - enables/disables PCI INTx for device dev
- * @pdev: the PCI device to operate on
- * @enable: boolean: whether to enable or disable PCI INTx
- *
- * Enables/disables PCI INTx for device @pdev
- *
- * NOTE:
- * This is a "hybrid" function: It's normally unmanaged, but becomes managed
- * when pcim_enable_device() has been called in advance. This hybrid feature is
- * DEPRECATED! If you want managed cleanup, use pcim_intx() instead.
- */
-void pci_intx(struct pci_dev *pdev, int enable)
-{
-	u16 pci_command, new;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-
-	if (enable)
-		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
-	else
-		new = pci_command | PCI_COMMAND_INTX_DISABLE;
-
-	if (new != pci_command) {
-		/* Preserve the "hybrid" behavior for backwards compatibility */
-		if (pci_is_managed(pdev)) {
-			WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
-			return;
-		}
-
-		pci_write_config_word(pdev, PCI_COMMAND, new);
-	}
-}
 EXPORT_SYMBOL_GPL(pci_intx);
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b5eb8bda655dc..f05903dd7695e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1350,7 +1350,6 @@ int __must_check pcim_set_mwi(struct pci_dev *dev);
 int pci_try_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 void pci_disable_parity(struct pci_dev *dev);
-void pci_intx_unmanaged(struct pci_dev *pdev, int enable);
 void pci_intx(struct pci_dev *dev, int enable);
 bool pci_check_and_mask_intx(struct pci_dev *dev);
 bool pci_check_and_unmask_intx(struct pci_dev *dev);
-- 
2.39.5




