Return-Path: <stable+bounces-220857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJYyMv5Eo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:41:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433B1C7434
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27ED37C58B2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F42041C0D2;
	Sat, 28 Feb 2026 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGS12iWP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4041C0C7;
	Sat, 28 Feb 2026 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300743; cv=none; b=K7OgI4P+g9BejradEObPsfF1gkEFN2Lv0JQ43QKPFHeaSKcnclbLdj1WpEFN5qQB9d+3ZWZoF8LANOFARia8heJ+OZz1YtkyYOWxNAumuxRvDnzrBt5YhTgA6dEc9BoPX81lRHDzOU8oIn84ZdM6eBzmMEOoh+RqBXwShKf4HPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300743; c=relaxed/simple;
	bh=n11fJxM1zdO1l3kKSRQWSOUtzlFHtSJ7rvoF1B0cTWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvXRzNEOcRGM8ppEvGntqHfCOa/mccXwBy9mf/5rwMmwQeJJxXRS5zMoOdXQEFo6gqzF6YStZDnfcOgvcxTUDo7GYOQhpNoZLD1woI2U08b8G4IoVsI5m+vQH59m4Dwx12IMCPl/KK8+hEJ0SX2Fvy6WHIj+zrAXnG2R7Zga+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGS12iWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44436C19425;
	Sat, 28 Feb 2026 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300742;
	bh=n11fJxM1zdO1l3kKSRQWSOUtzlFHtSJ7rvoF1B0cTWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGS12iWPZBDodMMzxUB+8NvbgQ6tndvghG//NAMI9OgPffyF0v6utyNThqscPwA5h
	 zJL2s2XzYo7gdTb95miBNQ8K4KyTHOa/PPnKbF3wAgcipQaaniN3fU5hdUflvHsneU
	 qRXlrVKfbtaNQhTWVW4AOvehYxO8HSKaY7cIZvsdotvqDQbzkp30EYCiVHi0xE5YvM
	 sh+ixkkB+1l1/2wkOe5gQKnU3mOkCYVEUyuqmQARGPifl0g2zN5I5CDKWIb1ukd0H+
	 koEP0Wqzc2LBoPnmZVNdBH7g39l7t88zmnMCS0BQ6cRVe+T0BXlWVfSVKTHfoUG8Pc
	 ezyNiOpgM3WTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 778/844] net: ethernet: marvell: skge: remove incorrect conflicting PCI ID
Date: Sat, 28 Feb 2026 12:31:31 -0500
Message-ID: <20260228173244.1509663-779-sashal@kernel.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220857-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3433B1C7434
X-Rspamd-Action: no action

From: Ethan Nelson-Moore <enelsonmoore@gmail.com>

[ Upstream commit d01103fdcb871fd83fd06ef5803d576507c6a801 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


