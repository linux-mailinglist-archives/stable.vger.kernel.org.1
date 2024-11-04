Return-Path: <stable+bounces-89645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC149BB204
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FB3B237C2
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA451D31A0;
	Mon,  4 Nov 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWAvrpE3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD661D2F46;
	Mon,  4 Nov 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717581; cv=none; b=FaLTskCdgQ6amg9kp/hlICb2SPqaELM+CO5GbjoU2mLGIoBnWL54Ehrlu13Gks/BWs2w0nZTPYogZ/RQISHrI4UIqVqfQNwsGqbwH9+KqZjshdq8sGy3J4cwZoRHK+LXSABufLERzcE6DDE1oUhqh5XeVrG0r7EWN0UvALpGLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717581; c=relaxed/simple;
	bh=dlIgtHsSJIpiQAd85jQfmAMXLCYDsUZXYwS+9YlXkxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3GU7dVTVKnx3HX5FTtn1BM53h/VcEy57eN32NTSLRrk+bf71m1FQJfAS6rL5YRAncxZFmfKYxExXdYzDPWZktAQM3QUyHtuEjm1RfBaJgc+siFy/dxsruJ/C7iAH85l5Z27Q7e1KpYxrZD1nQ2+PwqxH8FZ9UxpX1TekLVQSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWAvrpE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC38BC4CED2;
	Mon,  4 Nov 2024 10:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717581;
	bh=dlIgtHsSJIpiQAd85jQfmAMXLCYDsUZXYwS+9YlXkxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWAvrpE3A2FRh+wjXJfwILG8J4dLZFIo16NRumUPZUn+v9+Vc6DWCBFFovYovL8es
	 wEqEt0h2jvEfRqJDidZEVV281m/1qCU0p7E0SiqrzhlBZK+qb8cntg2bBo+5x4Wox2
	 vaspoD8HmBaHTzbbnfMSA55WOJrMQqLYqZPtEaNgPDDDhkbh8roKfGPpek3mv2SMcj
	 FrMB+O20AykEyrO4zjWM7BMpe4lmXk4YctpJn2RWowRuNmW6BADe15zpn/Ab7OKO1z
	 iudfVZS//01YekJGMpFghJ1m6Aigq1ePcrY7blswnhTvwVcnLPj/sWC60yyebNGYCX
	 xWJ9P/gucDjVg==
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
Subject: [PATCH AUTOSEL 6.6 11/14] ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13
Date: Mon,  4 Nov 2024 05:52:03 -0500
Message-ID: <20241104105228.97053-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
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
index 9be5a5c509f09..ec68893f79dcd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7264,6 +7264,7 @@ enum {
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
+	ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13,
 	ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO,
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
@@ -7642,6 +7643,16 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -10395,6 +10406,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
-- 
2.43.0


