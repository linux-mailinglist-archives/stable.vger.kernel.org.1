Return-Path: <stable+bounces-208102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C63D11FCC
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1212A305FFC0
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5D320A04;
	Mon, 12 Jan 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yDpmvSIJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549030F815
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214675; cv=none; b=L+HsHG0ORvgyIKYXFdaIyObRkvPiu8aU89mDAQ4VyUoZ8cnrTXE7TlnFCSVE9TTErWCoU+ac0HqU4tS7edlSr17L37F9RW0FVDrc9/p4viezWvN1ipAnSMInYRUxIV2B/OXqQpoAOw5vKRQNBamxzgvXL9gH3yTR3zu6UmTk9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214675; c=relaxed/simple;
	bh=Rh4ANghNwfqfshe4yetXE8GtcoYNsT5nX6L3YvGZJ3c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K3TT7/t+wk9hzTz//VdI5F1XXnbrBQkfJ3xhfTt8hRnDkDvyodoPqBu1v4BKhEeVIKdq0K4M3eNytlpt2yRZprxt083pz2fvJciD8DPxpWT4xZb7c7A2sgVvg5ZVJlwfcuck/cJUIy2YVFZgSxoRipyaCfTCrbuUUMBa3fAWdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yDpmvSIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F33C16AAE;
	Mon, 12 Jan 2026 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214675;
	bh=Rh4ANghNwfqfshe4yetXE8GtcoYNsT5nX6L3YvGZJ3c=;
	h=Subject:To:Cc:From:Date:From;
	b=yDpmvSIJz2eRcsNaHbT6jAFSzoI3Lhz5k7c2pU0kUgC+lLIiJA1qxGR6dE1ssl38y
	 ojJEJNe5jUUFY8aEgYdDuLVogc7yhtD1KDaWT0hakDdS+eozBcN+2raXw6yQwduKPS
	 XvemBo8zLDv/mZ6hmJSEREFqjDkKVVScEBr/IqE0=
Subject: FAILED: patch "[PATCH] PCI: meson: Report that link is up while in ASPM L0s and L1" failed to apply to 5.10-stable tree
To: bhelgaas@google.com,linnaea-von-lavia@live.com,martin.blumenstingl@googlemail.com,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:44:24 +0100
Message-ID: <2026011224-stopper-facing-f62e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x df27c03b9e3ef2baa9e9c9f56a771d463a84489d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011224-stopper-facing-f62e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df27c03b9e3ef2baa9e9c9f56a771d463a84489d Mon Sep 17 00:00:00 2001
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 3 Nov 2025 16:19:26 -0600
Subject: [PATCH] PCI: meson: Report that link is up while in ASPM L0s and L1
 states

Previously meson_pcie_link_up() only returned true if the link was in the
L0 state.  This was incorrect because hardware autonomously manages
transitions between L0, L0s, and L1 while both components on the link stay
in D0.  Those states should all be treated as "link is active".

Returning false when the device was in L0s or L1 broke config accesses
because dw_pcie_other_conf_map_bus() fails if the link is down, which
caused errors like this:

  meson-pcie fc000000.pcie: error: wait linkup timeout
  pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)

Remove the LTSSM state check, timeout, speed check, and error message from
meson_pcie_link_up(), the dw_pcie_ops.link_up() method, so it is a simple
boolean check of whether the link is active.  Timeouts and error messages
are handled at a higher level, e.g., dw_pcie_wait_for_link().

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
Reported-by: Linnaea Lavia <linnaea-von-lavia@live.com>
Closes: https://lore.kernel.org/r/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com
[bhelgaas: squash removal of unused WAIT_LINKUP_TIMEOUT by
Martin Blumenstingl <martin.blumenstingl@googlemail.com>:
https://patch.msgid.link/20260105125625.239497-1-martin.blumenstingl@googlemail.com]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Linnaea Lavia <linnaea-von-lavia@live.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on BananaPi M2S
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251103221930.1831376-1-helgaas@kernel.org
Link: https://patch.msgid.link/20260105125625.239497-1-martin.blumenstingl@googlemail.com

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 54b6a4196f17..0694084f612b 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -37,7 +37,6 @@
 #define PCIE_CFG_STATUS17		0x44
 #define PM_CURRENT_STATE(x)		(((x) >> 7) & 0x1)
 
-#define WAIT_LINKUP_TIMEOUT		4000
 #define PORT_CLK_RATE			100000000UL
 #define MAX_PAYLOAD_SIZE		256
 #define MAX_READ_REQ_SIZE		256
@@ -350,40 +349,10 @@ static struct pci_ops meson_pci_ops = {
 static bool meson_pcie_link_up(struct dw_pcie *pci)
 {
 	struct meson_pcie *mp = to_meson_pcie(pci);
-	struct device *dev = pci->dev;
-	u32 speed_okay = 0;
-	u32 cnt = 0;
-	u32 state12, state17, smlh_up, ltssm_up, rdlh_up;
+	u32 state12;
 
-	do {
-		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
-		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
-		smlh_up = IS_SMLH_LINK_UP(state12);
-		rdlh_up = IS_RDLH_LINK_UP(state12);
-		ltssm_up = IS_LTSSM_UP(state12);
-
-		if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
-			speed_okay = 1;
-
-		if (smlh_up)
-			dev_dbg(dev, "smlh_link_up is on\n");
-		if (rdlh_up)
-			dev_dbg(dev, "rdlh_link_up is on\n");
-		if (ltssm_up)
-			dev_dbg(dev, "ltssm_up is on\n");
-		if (speed_okay)
-			dev_dbg(dev, "speed_okay\n");
-
-		if (smlh_up && rdlh_up && ltssm_up && speed_okay)
-			return true;
-
-		cnt++;
-
-		udelay(10);
-	} while (cnt < WAIT_LINKUP_TIMEOUT);
-
-	dev_err(dev, "error: wait linkup timeout\n");
-	return false;
+	state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
+	return IS_SMLH_LINK_UP(state12) && IS_RDLH_LINK_UP(state12);
 }
 
 static int meson_pcie_host_init(struct dw_pcie_rp *pp)


