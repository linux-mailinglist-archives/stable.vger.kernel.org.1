Return-Path: <stable+bounces-221585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI6LM1KZo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:41:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE761CB5D9
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2112831BFFDD
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929842773CC;
	Sun,  1 Mar 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4DMm8Zf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552F813B58A;
	Sun,  1 Mar 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328642; cv=none; b=K+XqV5KV6ya1PKDZWbgm4L2WRNBg6OE3wvQv6dUZjhGPPrGb2Bv9aWkg0JIkwbHgroKfB9W85PetZl0bmXYbCabVfNYZ43Ul3zdHMXzvl2yYKsOXvxXCHpYU1NFQda/ofUpBdKf4pG6h+t3u/zQwRivyOJfMV5Lta2tbueMlNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328642; c=relaxed/simple;
	bh=OiYdBn+YM100iH2TtITrKoBIb5SGtjy9JgEFFQJwjok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFB6EM8wD2oi2iPLR8VWSyaC2jI5GHPHS17W3QxxknsBSGvft5WIT8W/Lw1IERpu+1Dswv6kViOcKXBaYzF6SB/lTAz3dyWhBV305rSfZxU4d6zayD8AY47AeOWzJJAvIFTlGDjJF6k7EjV/uVQuNoJA6cx0oqI5soWfdkukuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4DMm8Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4870C19421;
	Sun,  1 Mar 2026 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328642;
	bh=OiYdBn+YM100iH2TtITrKoBIb5SGtjy9JgEFFQJwjok=;
	h=From:To:Cc:Subject:Date:From;
	b=s4DMm8Zf5KKfd1PdAyWIHL0BTu9e/SbdnoMXyL687NsjDWl/ewpmVJ6Yjt2SBFxDw
	 +4Rm7491jczjxh0lH1N+o0CfxbJMogM3bYxe5MP6St7HVnGPmVh9TbzbpkyXwIV/CR
	 sbB0aRv3045gVS34GK+TT1sCYyhN0+Fcs+NtvkZREN0nVrsy/yXi4aXoYwPJSKhvlz
	 VEJg3QeWePdnSFAXtkJCllpDsf+J8Adsnw/HwUSvpKFD0WvXaqdDn4eZ33x2dKlb7a
	 bPpyhJ6G2dYiWO78hm/Iyz/llIKzWsJwdlwH2JOHzOb27i6gZm3cx3LUJaaLcrATAB
	 5mRcdncAtktCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cassel@kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "Revert "PCI: dwc: Don't wait for link up if driver can detect Link Up event"" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:30:40 -0500
Message-ID: <20260301013040.1688904-1-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221585-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EE761CB5D9
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 142d5869f6eec3110adda0ad2d931f5b3c22371d Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Mon, 22 Dec 2025 07:42:13 +0100
Subject: [PATCH] Revert "PCI: dwc: Don't wait for link up if driver can detect
 Link Up event"

This reverts commit 8d3bf19f1b585a3cc0027f508b64c33484db8d0d.

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

So revert the change that skipped dw_pcie_wait_for_link() if the Link up
IRQ was used by a vendor glue driver.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251222064207.3246632-14-cassel@kernel.org
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++--------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 8c41b90a1db1e..06c02fcc76c89 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -665,14 +665,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_remove_edma;
 	}
 
-	/*
-	 * Note: Skip the link up delay only when a Link Up IRQ is present.
-	 * If there is no Link Up IRQ, we should not bypass the delay
-	 * because that would require users to manually rescan for devices.
-	 */
-	if (!pp->use_linkup_irq)
-		/* Ignore errors, the link may come up later */
-		dw_pcie_wait_for_link(pci);
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(pci);
 
 	ret = pci_host_probe(bridge);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index fc9cf8ce86290..a3a3f6e89a812 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -438,7 +438,6 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
-	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
-- 
2.51.0





