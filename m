Return-Path: <stable+bounces-56166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3E691D522
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850512813DD
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048D7210FF;
	Mon,  1 Jul 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scqAGaJ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51EE8563E;
	Mon,  1 Jul 2024 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792831; cv=none; b=Zvh/XXI+tnAtId6HRjwa64cTMPm4qZ2V78dVUg7D1YtMe0yk8BDrhMQOOQhAg38kLlTdhrCqgfQ854H7KR/RFpR+iKZDiSvTzRW/feBD7aLss3Qs3MqfuQGta2dwOTNqAEug4nnbuQ8EhBPsfquBqYrt8/qPp5bzmfEj6rXqp8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792831; c=relaxed/simple;
	bh=0phwtexZn7K+I0jfK7aHVvCIBOymBWPjsWy8kiKGL64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sumkDjmeBYHsPgY6rN0UkjRB5oVI1MFdEMwKxP626/KHNt5Of9Epa7BfQl0zMqYIXuHMLBoQsjsY2TV9cjp+Idf54eFyT+url+1YKw8PI5F2WUaZd9sri5H9pTTvzSzPAiCjBdxNsxrIi9K0W7cHGO/sDhzS6WehkvxGd/caJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scqAGaJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0136BC2BD10;
	Mon,  1 Jul 2024 00:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792831;
	bh=0phwtexZn7K+I0jfK7aHVvCIBOymBWPjsWy8kiKGL64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scqAGaJ4DB5gfTvXZ1eYYzWMivtsFrkzsBrQk/6KhfTsizWdIjQoVedf938aYDlRx
	 hzh04Na9I7TLNw+8YEAlPr5rHZY49+OdS5EzEaY42YT2IhrOFJs/42manDbwrLARSP
	 sMT+2Wlx2OkHLo3fRmUe7swbNX3sd9VrjTGN2L5WDQhTBIn7UWDvttIz5ZuH73zXDc
	 7fP1+zCr2GYO6LTHouwnHiAulI9j8yfelvJLZOk4LK2xzYKD6dySN67Qo45FIQiT68
	 g9Iiv841v7FLWlvrjt26iCx11F3KVrqOVBCTprrgMQayqiHOEai0++PO4c+l9Xw+aA
	 oo0RhEWXU68SA==
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
Subject: [PATCH AUTOSEL 6.6 03/12] ALSA: hda/realtek: Support Lenovo Thinkbook 16P Gen 5
Date: Sun, 30 Jun 2024 20:13:22 -0400
Message-ID: <20240701001342.2920907-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001342.2920907-1-sashal@kernel.org>
References: <20240701001342.2920907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
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
index 2151fb1bd0de7..97df0b01b211c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10275,6 +10275,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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


