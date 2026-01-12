Return-Path: <stable+bounces-208099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD2D11FB1
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 337CB3003538
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFAE329E67;
	Mon, 12 Jan 2026 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fih+5JKb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014026056E
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214667; cv=none; b=cPSdcEhJFwZ6MfxSUVoo/nCpbGeedCO8Wjw7QwpJJr52+uICnPtpq4+JvXSmNpGjFAv46rDZxJTmbOWx4oEa0ujQ7mAXpR6rjH6OalQ3zbgHnYSwM1XMXagvpK0MynKrTYUsBHqivkEAiBJ0D8MHTEQ0O6I0gFl8nW8Ifd2do14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214667; c=relaxed/simple;
	bh=bkR33Pbb5Gnz4EpcJPHb774HObJdw00jVIjVsXVJHfo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fGXSCt9yqu7DwekxL0lzclOjVss+oPDLOLX+tSDJ2zemdDQ2xnoR3J1m1HMIoMImPjIKd3wEdB47qrVyz/SpI1e/DX8Qzp0v4gE5LiXIk0B8mw8i1vedI7KO9DebGI6wjwExf1SNR0KSuVJjYMfJy2g44vtQS9pvZYvT8p+BG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fih+5JKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2F5C19424;
	Mon, 12 Jan 2026 10:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214666;
	bh=bkR33Pbb5Gnz4EpcJPHb774HObJdw00jVIjVsXVJHfo=;
	h=Subject:To:Cc:From:Date:From;
	b=Fih+5JKbmaa99AwRMn+4Nx58ypT2bGx4cFndbuztPwnZuWraa2EI+ecCstaiRencV
	 2jdqBnwJfyyQx4X+7/g7r6Z3TSw8CIgDVUc/KEXcL4yVzdJWoyLHpsLG3rIlo/snR/
	 FZlXR/jjtG9YQWcpTzO0pNjJ1aUmQB53F3Af8kkQ=
Subject: FAILED: patch "[PATCH] PCI: meson: Report that link is up while in ASPM L0s and L1" failed to apply to 6.1-stable tree
To: bhelgaas@google.com,linnaea-von-lavia@live.com,martin.blumenstingl@googlemail.com,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:44:22 +0100
Message-ID: <2026011222-viability-foe-9ac3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x df27c03b9e3ef2baa9e9c9f56a771d463a84489d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011222-viability-foe-9ac3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


