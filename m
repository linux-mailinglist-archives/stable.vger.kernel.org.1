Return-Path: <stable+bounces-56148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1295D91D4E5
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E46F1C20446
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CFF17FD;
	Mon,  1 Jul 2024 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0sLtC36"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12E10FF;
	Mon,  1 Jul 2024 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792743; cv=none; b=GukoHTTjnFSdSrTXnoNK3iOtXMewgA0E+iV0Gv9Yn5DRegRLUc0Gj8bjrisgqVAqC1YxwiKvBccwpkRKBKDgriW1jmT7Kuhl6eRZ16ORSAXXi6gOf+dPbNa1RPaeds1YvYD1bAR+GDh6pxypE2Jvun8wLCthSI/dGgbWoyXQMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792743; c=relaxed/simple;
	bh=B34yppkMKjh+kd6SZwzmgQcfoz2fNzKG8aCLbhUWKM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCa/ZuF9uCpaUQC6Y8Q2RLmSuI0KdmZmIw+2VRZFbJnrUBFs2TjdbJ6hl1CnEsPBXc7Xv/x/r8OVCf7OsiOcR3An/TZhn8z5iBaj7HXVoDTD/67hpAf9RH46gOF7mt9nXjHEbVgEffHEiKo4DYNAer+/Jen8QcIDPQeBuy3c1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0sLtC36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D94C4AF0D;
	Mon,  1 Jul 2024 00:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792742;
	bh=B34yppkMKjh+kd6SZwzmgQcfoz2fNzKG8aCLbhUWKM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0sLtC36DK8dspDinOBqGVwhgkEWzVVb6Bzz2CsNknGmFj89JneXhCR8/bWSYI0a2
	 /nkwTAihNRTYESRtutTDtQ7kDL0PY4WhfJwNhKukQn3+GVhj6bsGdfQEZ5ltF5PXba
	 vOvq7zX1K42qTdj3RhrPdcHs8a84Z1dIXrgxkP985e00ivDPVVspieB4f5v/8qWpfy
	 YQtdNLRJtDvOWPZbLWc0+gbTlvgq30JkqF545U+C6kOVgmqby8ov7OgAyUobYoETHJ
	 1pcEn2dQVbqtcSZqrGRpu8N2oWFN2IDNOVgVe9uAVdt+Hxn975EWGFwQVcKTDHrPxs
	 21heu87MTLBJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 05/20] ALSA: hda/realtek: Support Lenovo Thinkbook 16P Gen 5
Date: Sun, 30 Jun 2024 20:11:10 -0400
Message-ID: <20240701001209.2920293-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 75f2ea939b5c694b36aad8ef823a2f9bcf7b3d7d ]

Add support for this laptop, which uses CS35L41 HDA amps.
The laptop does not contain valid _DSD for these amps, so requires
entries into the CS35L41 configuration table to function correctly.

[ fixed to lower hex numbers in quirk entries -- tiwai ]

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20240606130351.333495-4-sbinding@opensource.cirrus.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1a1ca7caaff07..237fb86f2004a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10525,6 +10525,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38d2, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38d7, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x38f9, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38fa, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
-- 
2.43.0


