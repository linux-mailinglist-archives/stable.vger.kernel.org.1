Return-Path: <stable+bounces-220410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD1ZMWU0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF271C5E44
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 808AC30FFFA4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971A3AF3BA;
	Sat, 28 Feb 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW9WPEVK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9343AF3B0;
	Sat, 28 Feb 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300301; cv=none; b=kMAsZnsF+QE0KrQl4l0r8WLAAk6DKhsOq7OYRWAlrawa1eV9XBpC7Ps6otXD7qGPv30rKiqvxQgQ+aD4hKqO4Wfat/bFz/2TXYVdZMr4fGRSeedvqy5QDnZb143M9eT7c40gVGa3F3g10SLUj+KALxiGzAHGLZ++a8cjBwLfPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300301; c=relaxed/simple;
	bh=/OMTTSzkMuyg7MouPley8iAmlYs+K6zFTS1Ol+cCZYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9zGrJiADaJrt5GmNtbONbY6hWd3Dekkep697XWQBm4NVZQxCSUwPY/135s5BmOqU+zO5dkN2gcR5EEF4LXcECRddr0iI5rAVXGamn/JTNibx0aVCmjQvNuVn3znv+tRc1gUaQ+3ZgrGRvP2FI/rSqK8eLvBUq9lctNUjStVjy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW9WPEVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4316C19424;
	Sat, 28 Feb 2026 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300301;
	bh=/OMTTSzkMuyg7MouPley8iAmlYs+K6zFTS1Ol+cCZYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OW9WPEVKr6M0AVfmYKGZko06nFeSAVFqDPVzboukrLmUnbK420XyDClDJYAkdwMi5
	 AU5gsC43wQQYPR/sLx+YbDCCScxacH5utyUP1ETIWrU29aR0zX7lC2g+MU2EcCNAu7
	 xwrY+Z4F8eeFxjgOVPh+qY1BoHUwVyxKbycngooVj+OgkjaNWIpqtJniqvaMJa2aKo
	 wLwNuSW624tlnDLeqN4dMhcQLzGla2qalZ2oVjp8xiWWohqmt0nB7V5nWRT5AHQGPc
	 U0qtsPpquagdqfhaxjROV+2z6Z2/Pu4dytw1tixctEniynJXzagG5EtStm6poTW2Hh
	 uUFxgHlv5G2vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Patrick Bianchi <patrick.w.bianchi@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 331/844] PCI: Mark ASM1164 SATA controller to avoid bus reset
Date: Sat, 28 Feb 2026 12:24:04 -0500
Message-ID: <20260228173244.1509663-332-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220410-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,google.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6BF271C5E44
X-Rspamd-Action: no action

From: Alex Williamson <alex.williamson@nvidia.com>

[ Upstream commit beb2f81792a8a619e5122b6b24a374861309c54b ]

User forums report issues when assigning ASM1164 SATA controllers to VMs,
especially in configurations with multiple controllers.  Logs show the
device fails to retrain after bus reset.  Reports suggest this is an issue
across multiple platforms.  The device indicates support for PM reset,
therefore the device still has a viable function level reset mechanism.
The reporting user confirms the device is well behaved in this use case
with bus reset disabled.

Reported-by: Patrick Bianchi <patrick.w.bianchi@gmail.com>
Link: https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-two-identical-devices.149003/
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260109000211.398300-1-alex.williamson@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6df78efd7f6dc..538ad85cf7c30 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3791,6 +3791,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
 
+/*
+ * Reports from users making use of PCI device assignment with ASM1164
+ * controllers indicate an issue with bus reset where the device fails to
+ * retrain.  The issue appears more common in configurations with multiple
+ * controllers.  The device does indicate PM reset support (NoSoftRst-),
+ * therefore this still leaves a viable reset method.
+ * https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-two-identical-devices.149003/
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
-- 
2.51.0


