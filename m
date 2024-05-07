Return-Path: <stable+bounces-43351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6448BF1FA
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD101C235A9
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678D14B951;
	Tue,  7 May 2024 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQnOdft7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7214B946;
	Tue,  7 May 2024 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123470; cv=none; b=IRjtqzPdgqPxcseEdyLFZmpEqBu8yFMNFmoxrnZ45GeN+BmlEQtbJrdCK7+AP/9jVSfOY4gM1t/i/I6zdOtuSpSAWhyq6j+zaopev8x8/4OtfYvtVP1BtEBrq//nOUcEgppWqi7PNjPP0tZflZRWBm8MluDu1T+pZdDzgPKc7vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123470; c=relaxed/simple;
	bh=Hh/1C4AKF94JLe48CVZQ/4GOW6QNUCJrBJ9s/sd1IQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldO1tG3zp6qUPM9xtUrcLi9LlDpqvgLXZT04uiU9OnBbReb6+MnXIc+F+Df1J736a0U3sKDYjXTJVs4UKXc2zYUiJrNX1vXK8/p0cjqoA3NveZ/IB8sfgqAnrIW4/bgnGSGwFF+3c8TNS06nb33fkbeHK7TrdkoQMjAyBAQxVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQnOdft7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5A9C2BBFC;
	Tue,  7 May 2024 23:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123470;
	bh=Hh/1C4AKF94JLe48CVZQ/4GOW6QNUCJrBJ9s/sd1IQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQnOdft7vqg6gY+xGXTmNSSeMx5Bxok9ctpBQuA1GFqZcpCXe5WWVmbti0M6ahMCL
	 UQOsQbJe5flB0imLhufjiHMtlsiyWq19s7s8MtB19VE1l4iGBn/1IWbS7yKyAmqvk+
	 QLA9sPC02AWPNOPnKe6nuF7Qntoo1wTCuFN770ZqV/c0XoSIcsKtx76SnlNUvA2xtX
	 W+nu0TxlUiUtWH3UM7iNKwqNED3DaAFZUmZX4X4T24My3yCcaC7Fmx7kcHe6+jKWj3
	 9Jf7neATvOpNHlWqurKcX1H9NQXpwBh+2TxRv9WhX5SPPsRv5IlatTsRJo7d1jsGMo
	 jS3x98jpU918g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/43] ALSA: emu10k1: factor out snd_emu1010_load_dock_firmware()
Date: Tue,  7 May 2024 19:09:40 -0400
Message-ID: <20240507231033.393285-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

[ Upstream commit 28deafd0fbdc45cc9c63bd7dd4efc35137958862 ]

Pulled out of the next patch to improve its legibility.

As the function is now available, call it directly from
snd_emu10k1_emu1010_init(), thus making the MicroDock firmware loading
synchronous - there isn't really a reason not to. Note that this does
not affect the AudioDocks of rev1 cards, as these have no independent
power supplies, and thus come up only a while after the main card is
initialized.

As a drive-by, adjust the priorities of two messages to better reflect
their impact.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <20240428093716.3198666-3-oswald.buddenhagen@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/emu10k1/emu10k1_main.c | 66 +++++++++++++++++---------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index de5c41e578e1f..a6b91597ea544 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -732,11 +732,43 @@ static int snd_emu1010_load_firmware(struct snd_emu10k1 *emu, int dock,
 	return snd_emu1010_load_firmware_entry(emu, *fw);
 }
 
+static void snd_emu1010_load_dock_firmware(struct snd_emu10k1 *emu)
+{
+	u32 tmp, tmp2;
+	int err;
+
+	dev_info(emu->card->dev, "emu1010: Loading Audio Dock Firmware\n");
+	/* Return to Audio Dock programming mode */
+	snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG,
+			       EMU_HANA_FPGA_CONFIG_AUDIODOCK);
+	err = snd_emu1010_load_firmware(emu, 1, &emu->dock_fw);
+	if (err < 0)
+		return;
+	snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0);
+
+	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &tmp);
+	dev_dbg(emu->card->dev, "emu1010: EMU_HANA+DOCK_ID = 0x%x\n", tmp);
+	if ((tmp & 0x1f) != 0x15) {
+		/* FPGA failed to be programmed */
+		dev_err(emu->card->dev,
+			"emu1010: Loading Audio Dock Firmware failed, reg = 0x%x\n",
+			tmp);
+		return;
+	}
+	dev_info(emu->card->dev, "emu1010: Audio Dock Firmware loaded\n");
+
+	snd_emu1010_fpga_read(emu, EMU_DOCK_MAJOR_REV, &tmp);
+	snd_emu1010_fpga_read(emu, EMU_DOCK_MINOR_REV, &tmp2);
+	dev_info(emu->card->dev, "Audio Dock ver: %u.%u\n", tmp, tmp2);
+
+	/* Allow DLL to settle, to sync clocking between 1010 and Dock */
+	msleep(10);
+}
+
 static void emu1010_firmware_work(struct work_struct *work)
 {
 	struct snd_emu10k1 *emu;
-	u32 tmp, tmp2, reg;
-	int err;
+	u32 reg;
 
 	emu = container_of(work, struct snd_emu10k1,
 			   emu1010.firmware_work);
@@ -749,33 +781,7 @@ static void emu1010_firmware_work(struct work_struct *work)
 	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* OPTIONS: Which cards are attached to the EMU */
 	if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {
 		/* Audio Dock attached */
-		/* Return to Audio Dock programming mode */
-		dev_info(emu->card->dev,
-			 "emu1010: Loading Audio Dock Firmware\n");
-		snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG,
-				       EMU_HANA_FPGA_CONFIG_AUDIODOCK);
-		err = snd_emu1010_load_firmware(emu, 1, &emu->dock_fw);
-		if (err < 0)
-			return;
-		snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0);
-		snd_emu1010_fpga_read(emu, EMU_HANA_ID, &tmp);
-		dev_info(emu->card->dev,
-			 "emu1010: EMU_HANA+DOCK_ID = 0x%x\n", tmp);
-		if ((tmp & 0x1f) != 0x15) {
-			/* FPGA failed to be programmed */
-			dev_info(emu->card->dev,
-				 "emu1010: Loading Audio Dock Firmware file failed, reg = 0x%x\n",
-				 tmp);
-			return;
-		}
-		dev_info(emu->card->dev,
-			 "emu1010: Audio Dock Firmware loaded\n");
-		snd_emu1010_fpga_read(emu, EMU_DOCK_MAJOR_REV, &tmp);
-		snd_emu1010_fpga_read(emu, EMU_DOCK_MINOR_REV, &tmp2);
-		dev_info(emu->card->dev, "Audio Dock ver: %u.%u\n", tmp, tmp2);
-		/* Sync clocking between 1010 and Dock */
-		/* Allow DLL to settle */
-		msleep(10);
+		snd_emu1010_load_dock_firmware(emu);
 		/* Unmute all. Default is muted after a firmware load */
 		snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
 	}
@@ -889,7 +895,7 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
 	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
 	dev_info(emu->card->dev, "emu1010: Card options = 0x%x\n", reg);
 	if (reg & EMU_HANA_OPTION_DOCK_OFFLINE)
-		schedule_work(&emu->emu1010.firmware_work);
+		snd_emu1010_load_dock_firmware(emu);
 	if (emu->card_capabilities->no_adat) {
 		emu->emu1010.optical_in = 0; /* IN_SPDIF */
 		emu->emu1010.optical_out = 0; /* OUT_SPDIF */
-- 
2.43.0


