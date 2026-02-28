Return-Path: <stable+bounces-220416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAK3MA42o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40D1C60BD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE9D93194950
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2B8480DCC;
	Sat, 28 Feb 2026 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxD8rfh6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF43B0978;
	Sat, 28 Feb 2026 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300307; cv=none; b=RlRCEgZLkWPGpEAS48+o01A2V/vZspBKvtH0y7dt5OImCDltNeFI8UJa2zCBetfCAe8FOJjP4mAdT/0RAEaLJk1KoSVeKjk7j0v2rizj1yNzgtFWdUxs1q6zBGTgw8d9mRr18OLxUe/zVHSgRmCEn/whyN1XDx2VUraXWkBPiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300307; c=relaxed/simple;
	bh=qD7fVtheLLhwrPCrINYiMipFKUTRbQYSCMDZcsg+NHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK4Xkb3CaZ4BQNIftatlb+kRiR2DZsO8w5ugc2Xsf6Bim5CSnlxmOjHEO8/sXYK8Sbx7xhLDxdfM6EmBDceh4EVTtAdCs62ZSEb/9b5WvQ20THjCJ9znS+jyAjo6c4Vjk+3ALR40ZG7DQAYgaaR14DdYCOrdXmoqLCH6Ng5rT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxD8rfh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DC0C116D0;
	Sat, 28 Feb 2026 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300307;
	bh=qD7fVtheLLhwrPCrINYiMipFKUTRbQYSCMDZcsg+NHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxD8rfh6+PZov1ATwLBlYjdETWl2a9dQCaKtHZ6rX/1wFwIWw1Eim9RTJIUuGqgFF
	 idI9ThhiXIkWI0kws5kLKYaBDk/M/1CdC9Y+F/mnI9qQdSKpJWWuOoV3rrsRzx55hm
	 fmr37Bkc769Uzzoy/TE6PLDc5/nj1LCQ5SCwO6MsMfTKYaCVp8vJrIApuoXLUBYkdM
	 cz3w2eI93H7BaDzmSvPuX53OULbuV8VH6nAjjGsd80Rjt/Z22vlTok2K9SjqlmEdKX
	 jk0oGhOEcyulaPG+LfmRnCxrQR51lwmyEXAgjrukwFNye+fk3fGcj9p1lU7x4gjUoC
	 7Qc2OAGLu1/9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Adam Stylinski <kungfujesus06@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 337/844] PCI/bwctrl: Disable BW controller on Intel P45 using a quirk
Date: Sat, 28 Feb 2026 12:24:10 -0500
Message-ID: <20260228173244.1509663-338-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220416-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmail.com,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 4B40D1C60BD
X-Rspamd-Action: no action

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 46a9f70e93ef73860d1dbbec75ef840031f8f30a ]

The commit 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as
PCIe BW controller") was found to lead to a boot hang on a Intel P45
system. Testing without setting Link Bandwidth Management Interrupt Enable
(LBMIE) and Link Autonomous Bandwidth Interrupt Enable (LABIE) (PCIe r7.0,
sec 7.5.3.7) in bwctrl allowed system to come up.

P45 is a very old chipset and supports only up to gen2 PCIe, so not having
bwctrl does not seem a huge deficiency.

Add no_bw_notif in struct pci_dev and quirk Intel P45 Root Port with it.

Reported-by: Adam Stylinski <kungfujesus06@gmail.com>
Link: https://lore.kernel.org/linux-pci/aUCt1tHhm_-XIVvi@eggsbenedict/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Adam Stylinski <kungfujesus06@gmail.com>
Link: https://patch.msgid.link/20260116131513.2359-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/bwctrl.c |  3 +++
 drivers/pci/quirks.c      | 10 ++++++++++
 include/linux/pci.h       |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34e..4ae92c9f912a8 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -250,6 +250,9 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	struct pci_dev *port = srv->port;
 	int ret;
 
+	if (port->no_bw_notif)
+		return -ENODEV;
+
 	/* Can happen if we run out of bus numbers during enumeration. */
 	if (!port->subordinate)
 		return -ENODEV;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 90676cb2fd10b..fd86f72f54aef 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1359,6 +1359,16 @@ static void quirk_transparent_bridge(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge);
 
+/*
+ * Enabling Link Bandwidth Management Interrupts (BW notifications) can cause
+ * boot hangs on P45.
+ */
+static void quirk_p45_bw_notifications(struct pci_dev *dev)
+{
+	dev->no_bw_notif = 1;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e21, quirk_p45_bw_notifications);
+
 /*
  * Common misconfiguration of the MediaGX/Geode PCI master that will reduce
  * PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1 datasheets
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b5cc0c2b99065..e958ff7443356 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -406,6 +406,7 @@ struct pci_dev {
 						      user sysfs */
 	unsigned int	clear_retrain_link:1;	/* Need to clear Retrain Link
 						   bit manually */
+	unsigned int	no_bw_notif:1;	/* BW notifications may cause issues */
 	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
-- 
2.51.0


