Return-Path: <stable+bounces-221988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCeAHeaqo2nfJQUAu9opvQ
	(envelope-from <stable+bounces-221988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:56:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA11CE135
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 534ED321D2DA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4662F3C02;
	Sun,  1 Mar 2026 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOKHyZwq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED52F25F5;
	Sun,  1 Mar 2026 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329630; cv=none; b=i/C+ArtNVo7WhJNu+kXA16bzhAleBqVhT+Nbzvb8jkoWO7noZ2K12fLnTgDwEDBmFaH6vg39CmnbLms0Kbm19Rins6KnrUjEt8HaTVYUQVf8354pUmGlHiPwoySJwJEikv44pX0cM4fnvCWZV2Jr/3zQSgyeM3swdcM8nCvVrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329630; c=relaxed/simple;
	bh=3SSeFCCfAkqeNnx3CbQeqwJZweZyXC2JCytdjnmDrzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzR5LjZ025llCHtg2S2Dk4KQtK0GfV4mjSjmW8g8DG3FrhNR38w75HmUo1YkZnX1+Up8Mx5+0JXgpEDHDHATyk40OYvY7lcXlARGmVsWLkcw/qBr25HmxhMxs6ZUOjTQdH2yT6oziV/UR1+umrmFO1EE4M5PkEAR510/1u5hA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOKHyZwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26784C19421;
	Sun,  1 Mar 2026 01:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329629;
	bh=3SSeFCCfAkqeNnx3CbQeqwJZweZyXC2JCytdjnmDrzs=;
	h=From:To:Cc:Subject:Date:From;
	b=HOKHyZwqtFKbALDW4K5GqoJ6gPSXhRIOsrWNN2w2MVx+ieLYQU8NxoYrQZiv+7fo8
	 wof/z+Kpc24lGcHoMQA/C51o98H4WbMARoaPG8Nr5Bc2uPEz9bGp6lS7cXalWMOh3c
	 pMuHEqScPOxxdBzF9A9Fecz+e7Sd0PF9QJKfGkDl4b8jFdYrAQrV9OxR/dG2Vek6eh
	 o4nVY3NM8E2DbJJ/THFkl6BGgL3nFdcM7rpyVAyWBl4Azf1kPB/nEbCcxU9bqs4c3+
	 WVfgFkbqdtOJch2tkzxEqH1xAHkzrKqxoC1H8XgfMVskEX6v/a7tgdOY293Sfq19pB
	 gFJnV2d9OXsMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	enelsonmoore@gmail.com
Cc: Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: ethernet: marvell: skge: remove incorrect conflicting PCI ID" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:07 -0500
Message-ID: <20260301014708.1710461-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-221988-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F3AA11CE135
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d01103fdcb871fd83fd06ef5803d576507c6a801 Mon Sep 17 00:00:00 2001
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 5 Feb 2026 23:17:14 -0800
Subject: [PATCH] net: ethernet: marvell: skge: remove incorrect conflicting
 PCI ID

The ID 1186:4302 is matched by both r8169 and skge. The same device ID
should not be in more than one driver, because in that case, which
driver is used is unpredictable. I downloaded the latest drivers for
all hardware revisions of the D-Link DGE-530T from D-Link's website,
and the only drivers which contain this ID are Realtek drivers.
Therefore, remove this device ID from skge.

In the kernel bug report which requested addition of this device ID,
someone created a patch to add the ID to skge. Then, it was pointed
out that this device is an "r8169 in disguise", and a patch was created
to add it to r8169. Somehow, both of these patches got merged. See the
link below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=38862
Fixes: c074304c2bcf ("add pci-id for DGE-530T")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Link: https://patch.msgid.link/20260206071724.15268-1-enelsonmoore@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/marvell/skge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 05349a0b2db1c..cf4e26d337bb5 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -78,7 +78,6 @@ static const struct pci_device_id skge_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x4320) }, /* SK-98xx V2.0 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b01) },	  /* D-Link DGE-530T (rev.B) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4c00) },	  /* D-Link DGE-530T */
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4302) },	  /* D-Link DGE-530T Rev C1 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4320) },	  /* Marvell Yukon 88E8001/8003/8010 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5005) },	  /* Belkin */
 	{ PCI_DEVICE(PCI_VENDOR_ID_CNET, 0x434E) }, 	  /* CNet PowerG-2000 */
-- 
2.51.0





