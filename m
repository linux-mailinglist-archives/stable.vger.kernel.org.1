Return-Path: <stable+bounces-58797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D792C018
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631501C2414A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB91B3F2D;
	Tue,  9 Jul 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiPgJtRO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779119E83F;
	Tue,  9 Jul 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542086; cv=none; b=C7c9nB2nrtmtUefj1ZqSfSx95cTYtGAFyxIg4MUjkEGvvJPln9ijl7q9RLgVm1l6DyxMuC9wX6ztazHPUy8Hyl1SzyLaJldBKpDdheLPBqJ5Bt44NCAwwv0hCGfFCu0As68F2o8ICDsKtwzEy4qrkaOlporiMd9hNpxzwPTXO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542086; c=relaxed/simple;
	bh=ZQ3mW/hz5kEj1kor8ua3/U+m44zUFmHQrpL5E/rhRrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXm2HwZsfy8/xlgieXxSQ0cMgvfJTbOtpzytOwZxhhpLoVpLIZcfKPc6dDhy8gxdTykeseOR4xftsB/KvfA6P9ceGwOKnBJfLgVeKZ9YgfuEuwwdL3S1pRXGyqCMTFD2zE9w4NTj78MM3sVwr8Pj8k2KJEzOD/2MXa+rtxDb/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiPgJtRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08EDC32782;
	Tue,  9 Jul 2024 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542086;
	bh=ZQ3mW/hz5kEj1kor8ua3/U+m44zUFmHQrpL5E/rhRrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiPgJtROoHgJv1BI9L26ndOmnJxHx6ea/UATAh2kAZn8wrFxM7tu+JVcft2LAusXV
	 HXIlbB5tZtlGTeOIeR9a5CvnmaNOtfi2O1hhsbFnSomArTDRXz1i/JIdbnfafvEa2k
	 kqXzK7JMQYUY3L5d1S6vzUTKd5y6K/sQoK4Lh0x+RgapMSI6cC3Y1GB+5Usohn1rjZ
	 AJ2mrh30lJ8fn80W+ox6Ms/HbZ9snElD6BNI2ZGBF/mtckB8+iZyWXdFTxv4XEN4qb
	 bK6VSLG0QVIjPaNxZViCRlsTKXsS5j/12a2MKH0iDdc9xAVTw9/UEQ4l/CyX97u3JY
	 OmL87xKcjw7xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aivaz Latypov <reichaivaz@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 35/40] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15-gw0xxx
Date: Tue,  9 Jul 2024 12:19:15 -0400
Message-ID: <20240709162007.30160-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Aivaz Latypov <reichaivaz@gmail.com>

[ Upstream commit 1d091a98c399c17d0571fa1d91a7123a698446e4 ]

This HP Laptop uses ALC236 codec with COEF 0x07 controlling
the mute LED. Enable existing quirk for this device.

Signed-off-by: Aivaz Latypov <reichaivaz@gmail.com>
Link: https://patch.msgid.link/20240625081217.1049-1-reichaivaz@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3e6de1d86022f..b3f429990e554 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10034,6 +10034,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f1, "HP ProBook 630 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.43.0


