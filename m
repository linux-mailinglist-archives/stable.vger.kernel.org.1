Return-Path: <stable+bounces-58831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708F392C084
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245701F220F6
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB51CF3FD;
	Tue,  9 Jul 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQIpwOXr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666071CF3F4;
	Tue,  9 Jul 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542209; cv=none; b=q6LBDreLTSMUW7DzzmunkZES+oI7KfDmwIp/z/A6Wy3ZP0tgTRctdiDF/Pc/xxeA/z2tm296pFNijP41iIxuL5i4J7Qk9JrnkvkrzuvDlI5VeLrHNi8fFdXF+PT9vj2A+5Vj8IGbTDF8rTvZJU9wp2BklvDhI1JX3KnuaQ+ef30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542209; c=relaxed/simple;
	bh=BZrw/hwd0bMBFWcXEOZS+wLhJna+wTE8HSYcOFMjG7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=at4h8A0MpR3xtsELx8oPsaZueKqydsbiHEhH0p8jkQA/oSKbVVdxV9ds1KyBTBPhP0ejU6fF8ZIXiX/r3Kmb8TGuMlC4Tm9o8f0Om3mPNCB2k/vdZ7OGJ7r26ZUNN5q3XUkcKz4STArfv3hnP36hpxOvhDqipi3teD7Z++mrIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQIpwOXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF91FC32782;
	Tue,  9 Jul 2024 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542209;
	bh=BZrw/hwd0bMBFWcXEOZS+wLhJna+wTE8HSYcOFMjG7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQIpwOXrPajoPDDskJDGylqNxZprS78nc+l1uY8O9SZAM2qPkqjx16Jhp96Jcp3nD
	 Mf5WP+f1HDT1gCdxe3lHXVG53A/pZf5CPzzMRRA+wjzS3aQhmo7Bj1bKotOYvgOcIg
	 +gWYIzG0kdxvn+XqbRUN1zPszc24XbAT2yBG0EW2Yj5lB5AK6uiTw1TFRzVYTzXnZm
	 eseqY+2ZQB1y923j69N/rJ9MxV7GMQstztdvvAeOQdGt+0m3l4+NpA7qwRDbLnMyNZ
	 YkjPGIRX54XkL7pq1uRIWdQloHFhXjuTidwH7iMutYIMgTMqoR2PzOMBwI/Z3Dj45l
	 LUeP6gfDltzgg==
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
Subject: [PATCH AUTOSEL 6.6 29/33] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15-gw0xxx
Date: Tue,  9 Jul 2024 12:21:55 -0400
Message-ID: <20240709162224.31148-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
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
index af70e764ea4bc..404c6080a6538 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9852,6 +9852,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f1, "HP ProBook 630 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.43.0


