Return-Path: <stable+bounces-188411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA95BF823A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B24E4F19BF
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A723A34A3C3;
	Tue, 21 Oct 2025 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWDr2T8Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EF34D905
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072394; cv=none; b=AKhgKJRccOoFwwoHNxuQGAN7b7wpHhLs8CNmvGpIn7qRj7CIHP/i0HgUEN+rGPfQKE9dlWMLUr4KM4ql8StA680U8VhYCdgNHxdQTUN1YpfXNcUot1hxcUyn4gwTF8bG5YLBmwZHeULhXrP9p1ML7wsjhyyYJSzSgJZDWmHZIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072394; c=relaxed/simple;
	bh=YSjKEEMOmU97/d3S4DRPQLbqZGPIJJhrWzLAYF9emyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1ddAENY56Vw1XFRuvAGXs+zoGGWq+sVSesu6fPxWNNw7MjuBjajkf79UHuXAma89Lu12JTd4OIo6PAqcbfslVuxtViKMdM+OMooT9b9Ht8n5LCmiuNz6sPCwMCYdThBqRmi9pPAepROkn3Gwpt85O21k5aUjUX/6zJ5y+wt5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWDr2T8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1372CC4CEF5;
	Tue, 21 Oct 2025 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072392;
	bh=YSjKEEMOmU97/d3S4DRPQLbqZGPIJJhrWzLAYF9emyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWDr2T8ZRbaDFVxwfzqHzQ5a3uGKVw6vNb33fuzforuD8NbKqXOk2dwDCzWtUYykG
	 FT4GnzDKo0596ar5QnnTw5uNzLl6wIzWcH6wvaQMfzRkCk2BxZ+hn47Cb7fumyfrgg
	 sCXOCzHMPoGhannC13rfxUDCSARs5wD7KFuAYegeC1m5QYP4yxJ/1WnSk3pAM+DC1b
	 ImjMHuYOcvRmA97yyBDD2aPRwKHHRiUjmQI21b4XmcK5ny7cJA/3s2u6MBOUYOoc45
	 Y43CztLw+jDLvDkbpkTvnqsUqjqxRqe329zM5/da9hyELEL4QRdJW+4oUvVzvsx5qo
	 jrxehCo0H8Yhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] PCI: rcar-host: Drop PMSR spinlock
Date: Tue, 21 Oct 2025 14:46:28 -0400
Message-ID: <20251021184628.2530506-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021184628.2530506-1-sashal@kernel.org>
References: <2025101648-abruptly-poncho-afdd@gregkh>
 <20251021184628.2530506-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit 0a8f173d9dad13930d5888505dc4c4fd6a1d4262 ]

The pmsr_lock spinlock used to be necessary to synchronize access to the
PMSR register, because that access could have been triggered from either
config space access in rcar_pcie_config_access() or an exception handler
rcar_pcie_aarch32_abort_handler().

The rcar_pcie_aarch32_abort_handler() case is no longer applicable since
commit 6e36203bc14c ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
which triggered an exception"), which performs more accurate, controlled
invocation of the exception, and a fixup.

This leaves rcar_pcie_config_access() as the only call site from which
rcar_pcie_wakeup() is called. The rcar_pcie_config_access() can only be
called from the controller struct pci_ops .read and .write callbacks,
and those are serialized in drivers/pci/access.c using raw spinlock
'pci_lock' . It should be noted that CONFIG_PCI_LOCKLESS_CONFIG is never
set on this platform.

Since the 'pci_lock' is a raw spinlock , and the 'pmsr_lock' is not a
raw spinlock, this constellation triggers 'BUG: Invalid wait context'
with CONFIG_PROVE_RAW_LOCK_NESTING=y .

Remove the pmsr_lock to fix the locking.

Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250909162707.13927-1-marek.vasut+renesas@mailbox.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rcar-host.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index afcfc4218a52c..a25e76ef7213b 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -67,20 +67,13 @@ struct rcar_pcie_host {
 	int			(*phy_init_fn)(struct rcar_pcie_host *host);
 };
 
-static DEFINE_SPINLOCK(pmsr_lock);
-
 static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
 {
-	unsigned long flags;
 	u32 pmsr, val;
 	int ret = 0;
 
-	spin_lock_irqsave(&pmsr_lock, flags);
-
-	if (!pcie_base || pm_runtime_suspended(pcie_dev)) {
-		ret = -EINVAL;
-		goto unlock_exit;
-	}
+	if (!pcie_base || pm_runtime_suspended(pcie_dev))
+		return -EINVAL;
 
 	pmsr = readl(pcie_base + PMSR);
 
@@ -98,8 +91,6 @@ static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
 		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
 	}
 
-unlock_exit:
-	spin_unlock_irqrestore(&pmsr_lock, flags);
 	return ret;
 }
 
-- 
2.51.0


