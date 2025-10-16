Return-Path: <stable+bounces-186093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9328CBE3947
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872DE40448B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CEB33437E;
	Thu, 16 Oct 2025 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nZy0QkkL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0C3375B9
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619592; cv=none; b=mNyh1Wv+DtjecO09OPhH1gayh74c5aKVuDCOi1Hz42LYVqP4PGQDI6sfvuvrQ8ttISsp5bxk1ADLvRZvN67aSatIPi9To6fR+aILEq+GFymrqO3vAdrjsEYyO/COCHjLGiTUfUojMZj/LJJ15ZSwH04yvMkr5Rr7ie8nEE+eRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619592; c=relaxed/simple;
	bh=ZkMT+cPndS5tBIQv1t5yFd2cAiR6f0otERHa800cwFc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h/OjR8ME2yNYUoeqe/dPbr0Kbl2uRS8S5ntHFgd20fJQFLlrcMnKsd+FVR5OwzXtnK6r2twrtEv6x1btyL0Ma+g3Q+OirkHYzh2S+d64TXSfyEeYUr07t72QPKFLJ/WuGwtIVKxOzIWgRhbTWJz78LDHt3fTrrff/GcEv8xfimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nZy0QkkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704EEC4CEF1;
	Thu, 16 Oct 2025 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619590;
	bh=ZkMT+cPndS5tBIQv1t5yFd2cAiR6f0otERHa800cwFc=;
	h=Subject:To:Cc:From:Date:From;
	b=nZy0QkkL7DBxI/tDCDN0CSAdk+zRGrDslA8dzf+aAPM3QyR9CfV2Dee19yZQW/XYn
	 XVrcXLsZL8Nr9pqrKUsv3VV/pCT7N0tcAI041E4yi4kMdPXOjxPAWrgFK4cOIl4IaZ
	 f+X0XWpxuGfv1rvGYOD1FEKcVcZ8fSPziiHCpNxU=
Subject: FAILED: patch "[PATCH] PCI: rcar-host: Drop PMSR spinlock" failed to apply to 5.15-stable tree
To: marek.vasut+renesas@mailbox.org,duy.nguyen.rh@renesas.com,geert+renesas@glider.be,mani@kernel.org,thuan.nguyen-hong@banvien.com.vn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:59:48 +0200
Message-ID: <2025101648-abruptly-poncho-afdd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0a8f173d9dad13930d5888505dc4c4fd6a1d4262
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101648-abruptly-poncho-afdd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a8f173d9dad13930d5888505dc4c4fd6a1d4262 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date: Tue, 9 Sep 2025 18:26:24 +0200
Subject: [PATCH] PCI: rcar-host: Drop PMSR spinlock

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

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 4780e0109e58..625a00f3b223 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -52,20 +52,13 @@ struct rcar_pcie_host {
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
 
@@ -87,8 +80,6 @@ static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
 		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
 	}
 
-unlock_exit:
-	spin_unlock_irqrestore(&pmsr_lock, flags);
 	return ret;
 }
 


