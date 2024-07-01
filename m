Return-Path: <stable+bounces-56149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9073C91D4EB
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DAA1C20B54
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182128FF;
	Mon,  1 Jul 2024 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLMg3nhr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69B17BDA;
	Mon,  1 Jul 2024 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792747; cv=none; b=loDfexV2cvS748BYAe1+McxpXanINPLhZ73rAdYgVYe+qKPhDsrpEDWeKOQ4b2Zxqw7TNQD4/+PHoBYxLzg/tpvqscoyP6vYGE5O8/RbAdnG7d6X4XgcqrxKEdraaAfbTI6q36uRhrGUqPyeSFhycCjrmGHbfYI1PLS8uJUbcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792747; c=relaxed/simple;
	bh=9ppsar3U9X6rd7sZwhOQ3vNvYo9VYpJ15BUhiX1oO9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIy3yfobXwVhw1LLHOL6cWfbTc+JI90l1mii8UR6PTo1tBJnRNs1+mQqgyImEtPeVxcKNMPW+eQaEjJRRTKngCYsZt82qsGa1TfXBgZy7sBCF2CjeDx4U8tR5YjTnQ8m5hp2tgfKrfSyQhgmyEM2SePj7BfrKcwJwXOnr3Dhr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLMg3nhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F03C4AF0B;
	Mon,  1 Jul 2024 00:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792746;
	bh=9ppsar3U9X6rd7sZwhOQ3vNvYo9VYpJ15BUhiX1oO9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLMg3nhrC5rJkv1L1KM0POEWSDAet37W3r+9wEvISGtRTVRqnsgKEeIUaGPkYFj8X
	 KKzORS2Z7Ddv6Fn4HGbFBqA7KRu1AWdaQVCJSUPSJo7H/eZ5TtyNfw63Tfi1aQwVvr
	 9jf+K0GFp2upmOxIXuBq8Nx10k/De+OzI0BaOac9DJ/4K3nqo5R8JuYsMQ3d1X9jAp
	 NsdAPRF7V+5vrIHY0ewUJBVww/VlduOjRExnpzg5U9CBRM2p/jm11aIGmCZNpSD6nE
	 35kSGLioYtMWM6zclKhxAwXTHKL9jwX/l+f5TA6EPrEq5FlYFl/xevaLehzYTPyoGQ
	 bqmbVtK5Jf+ug==
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
Subject: [PATCH AUTOSEL 6.9 06/20] ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 4
Date: Sun, 30 Jun 2024 20:11:11 -0400
Message-ID: <20240701001209.2920293-6-sashal@kernel.org>
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

[ Upstream commit 4ecb16d9250e6fcf8818572bf317b6adae16515b ]

Add support for this laptop, which uses CS35L41 HDA amps.
The laptop does not contain valid _DSD for these amps, so requires
entries into the CS35L41 configuration table to function correctly.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20240606130351.333495-5-sbinding@opensource.cirrus.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 237fb86f2004a..c3412dbdc775d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10521,6 +10521,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38bf, "Yoga S980-14.5 proX LX Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38c3, "Y980 DUAL", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38c7, "Thinkbook 13x Gen 4", ALC287_FIXUP_CS35L41_I2C_4),
+	SND_PCI_QUIRK(0x17aa, 0x38c8, "Thinkbook 13x Gen 4", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x17aa, 0x38cb, "Y790 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38d2, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
-- 
2.43.0


