Return-Path: <stable+bounces-222027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MLHEDeco2l2IQUAu9opvQ
	(envelope-from <stable+bounces-222027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:53:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEFF1CC2E5
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F69B3072C1D
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7553033D1;
	Sun,  1 Mar 2026 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY2iZvZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727692820A9;
	Sun,  1 Mar 2026 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329724; cv=none; b=BhazDAHEL+oRO5PM22FFT+Wz3/s4NVoA8do8iKWYuxNwGET/4CEf5ZBwxIkOJCUYsi4PYwn+n0nC7ewiCyKvXbDqCBvhPpa/NUAV1cjnN5D6NjBdoJcHA3439pHAPzLU5ih2pZcScDG7p1E6TtY8o1kjf4zeh6Xm68TswHXVeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329724; c=relaxed/simple;
	bh=AUACrQx+xtM3CGFAvFDvwz2ovMdSALIYkLvLDcKUqig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+8TwSzu9miifvABr2gF7Tm5HDIBbPdbjFUEilMrOkfX9FAAe7vST7tnL+L3RbV/D77mlxXZu9VU8i5HGUeI5VNPJfDyK5GsWgZkaT6hTY5rjkK2d1EY8piMHOz0ZPhigiK0PXhfuOVdK6RUq/wIRHoRaxdoxBA1znAd2LOR6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY2iZvZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D79C19421;
	Sun,  1 Mar 2026 01:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329724;
	bh=AUACrQx+xtM3CGFAvFDvwz2ovMdSALIYkLvLDcKUqig=;
	h=From:To:Cc:Subject:Date:From;
	b=WY2iZvZfijMEuf+dtgKjSzEdsxtdXIKgaly3nQmarG35Da5f6FirPA1qz/qJ+VDZo
	 0u34UZxSSGFjA4QsmgotViHH4GlxzO+I0ommoOPIS4Qd2FBU4oB0ulmUC58++QFSAh
	 +k4vYOYDVyd+zKcrgu00mzBVsS6in2K0UeZl79IowH07pMy/VLE9n9aKRcGZC9ZlsD
	 uWDkpMudc0j5jZvsTHw334bbdEM60sBp/6GLElDQGVXfoiJHsUQXxtU4/HJvyLz4YL
	 EwFhR0br75BXYqdpyV/mds23d34OGJiN/vhzE/hoPROGtRt7ayGFxPTclYWPQtccQo
	 Um1JptDbyumpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cassel@kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: FAILED: Patch "Revert "PCI: dw-rockchip: Don't wait for link since we can detect Link Up"" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:48:41 -0500
Message-ID: <20260301014842.1712951-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222027-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 2BEFF1CC2E5
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fc6298086bfacaa7003b0bd1da4e4f42b29f7d77 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Mon, 22 Dec 2025 07:42:08 +0100
Subject: [PATCH] Revert "PCI: dw-rockchip: Don't wait for link since we can
 detect Link Up"

This reverts commit ec9fd499b9c60a187ac8d6414c3c343c77d32e42.

While this fake hotplugging was a nice idea, it has shown that this feature
does not handle PCIe switches correctly:
pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46

During the initial scan, PCI core doesn't see the switch and since the Root
Port is not hot plug capable, the secondary bus number gets assigned as the
subordinate bus number. This means, the PCI core assumes that only one bus
will appear behind the Root Port since the Root Port is not hot plug
capable.

This works perfectly fine for PCIe endpoints connected to the Root Port,
since they don't extend the bus. However, if a PCIe switch is connected,
then there is a problem when the downstream busses starts showing up and
the PCI core doesn't extend the subordinate bus number and bridge resources
after initial scan during boot.

The long term plan is to migrate this driver to the upcoming pwrctrl APIs
that are supposed to handle this problem elegantly.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251222064207.3246632-9-cassel@kernel.org
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 8c1c922088023..ca808d8f79753 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -601,7 +601,6 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
-	pp->use_linkup_irq = true;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-- 
2.51.0





