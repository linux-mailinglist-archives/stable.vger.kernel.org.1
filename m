Return-Path: <stable+bounces-43809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609908C4FB9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E67283510
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D263C12F398;
	Tue, 14 May 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zM8Fb0/P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D555C0A;
	Tue, 14 May 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682392; cv=none; b=soAdEa9sR0YYo25OP6i7WZW8rlXU524rBjfPAHflJU23JUom4IAdtUdx/yV1uwFk0cKJKbpvNC7rdd5/isT66SwxNA2Ym1y4a/kxvK7DiJQPbxfWPxEOkzf/y+dXbwD9ZBQvvrmxRoot1lUo1F8+P7fXAyKaFXSsvxJwVeKRVOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682392; c=relaxed/simple;
	bh=hfoUo0obQFgrDrQmPugbOqG0s3lMysdYyhOvIkXEGOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS2F4aM/43HpcHIxDCI6+7lIPUpy+POsyeUvKRBiinlgFSVfptn2V7vw317YHi2wDyVtOiZGfvqx+H1vsc5WiCLL9W95pbHfbBW3AezsYOi6ANWLHbQRASGOeZABSdUzklXOPvfnUvXVjUHD84f9gxuo01iunaee5C9JnGzNFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zM8Fb0/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A5BC2BD10;
	Tue, 14 May 2024 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682392;
	bh=hfoUo0obQFgrDrQmPugbOqG0s3lMysdYyhOvIkXEGOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zM8Fb0/PJ/VPrX8TYsgsvQcct75YcidvTQvHwyqvK1+9lxaJ7JYlr65iQEFfnN8pT
	 V8KgUSuKuhEyGXW66PKiuAsTpDLaLor5045QzaVj50VlK7hvjbrSmpS2iOlXUobBf9
	 6FUZgVJzufi0dHOIaueg1mcmyK7kXca4evdxhbNY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 054/336] ALSA: emu10k1: factor out snd_emu1010_load_dock_firmware()
Date: Tue, 14 May 2024 12:14:18 +0200
Message-ID: <20240514101040.645666876@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Stable-dep-of: f848337cd801 ("ALSA: emu10k1: move the whole GPIO event handling to the workqueue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/emu10k1/emu10k1_main.c | 66 +++++++++++++++++---------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 85f70368a27db..6265fc9ae2606 100644
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
 	} else if (!(reg & EMU_HANA_OPTION_DOCK_ONLINE)) {
@@ -892,7 +898,7 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
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




