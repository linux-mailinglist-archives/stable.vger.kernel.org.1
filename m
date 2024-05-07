Return-Path: <stable+bounces-43303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B898BF18B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C231C210D6
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B6513E417;
	Tue,  7 May 2024 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi3gBeVY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7113E405;
	Tue,  7 May 2024 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123326; cv=none; b=t2i0loLZ2fwb3EwXrsNPp4GR9QPOFEI269hkdD+6QbZpr1USlyWiwgUfbUPDN3RB/sQtilwv7xYqpz6VIQe62yAexAcWdJkY0h7enPme3hIFt8DNVqn3jTNEJ5uyzD3z/ZvImf9nkZtPcwECndrm8ej6YshWgk35kDvyU0X3qsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123326; c=relaxed/simple;
	bh=Hh/1C4AKF94JLe48CVZQ/4GOW6QNUCJrBJ9s/sd1IQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUo2D5e4jfL5h6d1YhmWYlf6J8Ly6UJno95rH3jsk2Kjd3XFIRUuy3HD7P5lb8wRqtdeZWgpjezpYZSgb45jKnPQIX66xj47obZ8Y5wuhTt6Mp+qrSgEW1vqnVwu67e9bz6yeghXJWF6ciG/wTOlu3hxchTdfVQAPiUAIVntEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi3gBeVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B388DC3277B;
	Tue,  7 May 2024 23:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123326;
	bh=Hh/1C4AKF94JLe48CVZQ/4GOW6QNUCJrBJ9s/sd1IQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qi3gBeVYup+jpBmaHNqPRY3PnA90y2cC2SoQTtmFpcclnzZEsR2BVCemKp65gijAP
	 RHXeykmLJ+NDocOnY30tNpMklGXiFTUFDlefFGP5ZEG+srTWUvXEPAYnM28VEZoZT9
	 Nk7fNURdFBgoweaP6pSUnaP8P9j1WoUWstLZO9JPTZkxYaAJiAaAN6TwH1olip3bih
	 lMIbu6rdrlEL2UsRUuK+3awDeSDixsTiTmHkGTPw3E62fw9mcCgrSc2ek4od50/vy0
	 hEM3apdPSubMeVU5Oo7DYGMflRksJvHhG7cIYcR3LsduBlgmUfgglfFoM87j5UlA0S
	 FA/jOai33fbZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 24/52] ALSA: emu10k1: factor out snd_emu1010_load_dock_firmware()
Date: Tue,  7 May 2024 19:06:50 -0400
Message-ID: <20240507230800.392128-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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


