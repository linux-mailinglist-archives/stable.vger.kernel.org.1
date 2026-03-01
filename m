Return-Path: <stable+bounces-222194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPnoG2iio2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:20:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD05E1CD749
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E2CF3475FE2
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86F22FC89C;
	Sun,  1 Mar 2026 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDqv5h99"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11A2FCC0E;
	Sun,  1 Mar 2026 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330131; cv=none; b=DfkmTuIxHDaSu5wTLk1WzR+yi28ngpPdo408C7J4V0E13xvAZ/MEWSngXwDAW7lW2HyvCuiiFuEF+tcleqvZnK9sdlluEbniyKjTPkuxdcBCiA7uBmK3fgawjHrhLW0CMswvmP3FwYmw9wglPSiX3oO423hbsVK2FxfO9k6O+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330131; c=relaxed/simple;
	bh=HeQEw+4cZDGdtUl8Hf0+gc+uk9kxJOZhB/FlPTCdUuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n75IgC5xw31jvCaFyhkoTvQECTsnJsEgakGnBFpb61rooS5exQSqU1fDVtL3XG3FN24HeYev0XJfOuFAB2AW5utmKdkC8yC6SW18sdStpuqYrIg5VQ7wv/nF2yspK9guYXoevlptxdyS0xAz/GahHHtxJBr2NWz0Z7GH/ukBl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDqv5h99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C52DC19421;
	Sun,  1 Mar 2026 01:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330131;
	bh=HeQEw+4cZDGdtUl8Hf0+gc+uk9kxJOZhB/FlPTCdUuo=;
	h=From:To:Cc:Subject:Date:From;
	b=SDqv5h99WLieyWgidpiLdZ5MDaf7c0NokXFVQIwKEkVE6eIpvR9ah4usHX3Cwe7R1
	 cG0idaTLoQTbH4i4T+yeFdp/85jQ13u9SFBPxStEU94UXbT8CVwclgoQ5ONHibm731
	 jPEmpeVc9HZeI7taADxE7rTEy98O7F/T1cXLuywY03SHFFE+MPsQhcroPZGdO5NyHB
	 Hh2DxM52SX5Jrd5keByfICTAPoLy7qKvMWoo1i9k3WrBFq1OLMiTKQbKhtpmLkdu5Y
	 E5EQWeQUN/PmKCl4Rk/nuuGzAZL63hsGPYdKPIQMzT5gHweepT+AAs9H79PfvS0KUf
	 SWflFgVf2tcJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	enelsonmoore@gmail.com
Cc: Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: ethernet: marvell: skge: remove incorrect conflicting PCI ID" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:29 -0500
Message-ID: <20260301015530.1722731-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222194-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: CD05E1CD749
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
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





