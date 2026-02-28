Return-Path: <stable+bounces-220323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJdOMHs1o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:35:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF591C6031
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087613014BEB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAF5394E25;
	Sat, 28 Feb 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERDrbgHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9D394E1D;
	Sat, 28 Feb 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300224; cv=none; b=b9ST9RWxWpvmu33XPYOcc6mCF4sZgv5BFN2121+9vFnl+9+EMA2IpasiUYOhMzY5NZFrflrSimwG9wMlBwyqTTqjbCEQYb8hIVZ4zxxqvQoiD5+uFCiiQvACGW2ltShh7M/weQoyUvqv3nJW0iw2rL34cv1zM8EM8IM9ohhhRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300224; c=relaxed/simple;
	bh=gxPyM4X4JordGtusy2n/qrvh83bBiJbA4cMFLCusdHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJhUjHrLtrYyKR0LUVGDwZrTgz1DEN8adVvgNbOgIGIzV1IFPtrlVMWBdCMph1tZTR1EXDex82kDQhZFk1AYT1NRkbQvcUWryYqsEMXY1aqJIiFis9DG2v3neKD0V299aBsh8CfanFyRoUugtnbAARE5I605dzyXQYiLcjE5Yxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERDrbgHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9987C19425;
	Sat, 28 Feb 2026 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300224;
	bh=gxPyM4X4JordGtusy2n/qrvh83bBiJbA4cMFLCusdHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERDrbgHjpfGVMdIGXPWPk1By2GkBMKDuGKVYFz7iKRw5MMT5WKtFvswfPPRBH7Lw7
	 3PWQqpmYJxx+IckeVN2l+6oN67DUtvsPxUa5VAXL+ALmM55lIEc8D41UBX4Miz6kg1
	 X23i6KY69A5IbBL5FducQjbIfuyfWJHAWNUVsrMVxTK5VB9AitoGCLxMzcQwuNXM5R
	 senEFRh6ao5l7iQvxO1cic6V6aKfZG56adK59D1pLAKzTyQnJH3Fepku+LCiaMR4sd
	 bF/nF9cpRU55UFFl6NufvVwULUTV5/K0lA2UZcIkrKIpEc7kWs8qzvB5Erpm18zqzl
	 s0tBLKj+cbkNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harin Lee <me@harin.net>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 245/844] ALSA: ctxfi: Add quirk for SE-300PCIE variant (160b:0102)
Date: Sat, 28 Feb 2026 12:22:38 -0500
Message-ID: <20260228173244.1509663-246-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220323-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0EF591C6031
X-Rspamd-Action: no action

From: Harin Lee <me@harin.net>

[ Upstream commit 3a92733e052753d87fdd56bd6f621f969be28447 ]

Add quirk for the Onkyo SE-300PCIE variant with PCI subsystem ID
(160b:0102). This variant (OK0011) was found in the official Windows
driver packages.

Also, reorder entries and fix the indentation to maintain
consistency.

Signed-off-by: Harin Lee <me@harin.net>
Link: https://patch.msgid.link/20260208133001.680550-1-me@harin.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/ctxfi/ctatc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index 227d8c8490e1f..a25a599fc5bec 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -52,18 +52,19 @@ static const struct snd_pci_quirk subsys_20k1_list[] = {
 static const struct snd_pci_quirk subsys_20k2_list[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, PCI_SUBDEVICE_ID_CREATIVE_SB0760,
 		      "SB0760", CTSB0760),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, PCI_SUBDEVICE_ID_CREATIVE_SB1270,
-		      "SB1270", CTSB1270),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, PCI_SUBDEVICE_ID_CREATIVE_SB08801,
 		      "SB0880", CTSB0880),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, PCI_SUBDEVICE_ID_CREATIVE_SB08802,
 		      "SB0880", CTSB0880),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, PCI_SUBDEVICE_ID_CREATIVE_SB08803,
 		      "SB0880", CTSB0880),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, PCI_SUBDEVICE_ID_CREATIVE_SB1270,
+		      "SB1270", CTSB1270),
+	SND_PCI_QUIRK(0x160b, 0x0101, "OK0010", CTOK0010),
+	SND_PCI_QUIRK(0x160b, 0x0102, "OK0010", CTOK0010),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_CREATIVE, 0xf000,
 			   PCI_SUBDEVICE_ID_CREATIVE_HENDRIX, "HENDRIX",
 			   CTHENDRIX),
-	SND_PCI_QUIRK(0x160b, 0x0101, "OK0010", CTOK0010),
 	{ } /* terminator */
 };
 
@@ -78,8 +79,8 @@ static const char *ct_subsys_name[NUM_CTCARDS] = {
 	[CTSB0760]	= "SB076x",
 	[CTHENDRIX]	= "Hendrix",
 	[CTSB0880]	= "SB0880",
-	[CTSB1270]      = "SB1270",
-	[CTOK0010]    = "OK0010",
+	[CTSB1270]	= "SB1270",
+	[CTOK0010]	= "OK0010",
 	[CT20K2_UNKNOWN] = "Unknown",
 };
 
-- 
2.51.0


