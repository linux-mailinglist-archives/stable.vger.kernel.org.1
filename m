Return-Path: <stable+bounces-89667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF079BB257
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9821F220F0
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053A01E4930;
	Mon,  4 Nov 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUye1hxt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AF1C2DC8;
	Mon,  4 Nov 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717682; cv=none; b=oUpT8Mh8IphOfFDUbRTrRSv4ZrDBD/wsucK1qLkdcByvLmBE2S3RO3QoKVcRmMEsjoLiem3XPoBD/q4fJnedu6WP10mrKOwFXXH3qh57V67v0YQiCxqYHDOMwb2gvRw5LEPA4D4vFEZo/Euo3mM8/bbumI5HpRQ8kvIlBmfcTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717682; c=relaxed/simple;
	bh=2TJRVGNde2MF2WYVyI89EU1iNu8ZQSt9KmM/nE+yVBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9r3UY6X0tclyt3gvQvWH+FNj3Yicdh5o2JHzIH0GL1SB7qJwb1sPsaEu62YCiWuL/pPAwHQXWrXEilYX2R+DIGPe1cEvI6xM1ynFs8BVfNpOVIIWJev3sdsCv2PEDqFH4Hiq5lyxYUu6s3YJoDBKc1Q0SEFTlK2SOcwWDs9ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUye1hxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A93C4CECE;
	Mon,  4 Nov 2024 10:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717682;
	bh=2TJRVGNde2MF2WYVyI89EU1iNu8ZQSt9KmM/nE+yVBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUye1hxtE4UGU25+1tyzUzwDXon9+1XbrE9exsUXXdF4wszxamkfab209n0ya4etv
	 0pyQlsnBM3b6xqg7sTmIWz0eryDEukobsqkIaHzktzERYJkW9wDVXwSQa2SWm3oqp2
	 KnNUlOfLVlD7lWmeH3U3WEK6kUlADcdJ7Mi63k5EntW0DonZ44WZccfkkNjprN8pFC
	 lyw/LbtncypHGhPzFV37M6QGsnjDMVyNMWvOfxypTkVd0BYQJ4BoBMfkrN6AmS1s7B
	 dI9FK8qU5lPMH5nFU4m8r3R8j4WVEBYzx6IHBL0BztIqahBlqMrB/9ZA3WYxZV/Pdn
	 zZ/NNXv9Gqo2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/10] ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13
Date: Mon,  4 Nov 2024 05:53:57 -0500
Message-ID: <20241104105414.97666-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105414.97666-1-sashal@kernel.org>
References: <20241104105414.97666-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.170
Content-Transfer-Encoding: 8bit

From: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>

[ Upstream commit ef5fbdf732a158ec27eeba69d8be851351f29f73 ]

Infinix ZERO BOOK 13 has a 2+2 speaker system which isn't probed correctly.
This patch adds a quirk with the proper pin connections.
Also The mic in this laptop suffers too high gain resulting in mostly
fan noise being recorded,
This patch Also limit mic boost.

HW Probe for device; https://linux-hardware.org/?probe=a2e892c47b

Test: All 4 speaker works, Mic has low noise.

Signed-off-by: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>
Link: https://patch.msgid.link/20241028155516.15552-1-piyuschouhan1598@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6b0d9e006f2a3..637180c774d7d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6935,6 +6935,7 @@ enum {
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
+	ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13,
 	ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO,
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
@@ -7237,6 +7238,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
 	},
+	[ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90170151 }, /* use as internal speaker (LFE) */
+			{ 0x1b, 0x90170152 }, /* use as internal speaker (back) */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
+	},
 	[ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9533,6 +9544,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
-- 
2.43.0


