Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8071F713D03
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjE1TU6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjE1TU5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C10AA6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8235361AFD
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DDBC433D2;
        Sun, 28 May 2023 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301655;
        bh=lPeDyhKyzVkZ6FXjdNik2KX1gAFLDpr7/++kndnOgqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItJITd0CLVy2bQbJ7Afc4jLVhLr+kkK3ihHghigrQ/d5r92QQrzylv9I/ffV1DJC3
         YkF/r9XoRB2uk2wBK/DBlaU1mrG3m+yPWtyzK9LJiqKi0bL6B+JQcMSqYT/5GL+dPW
         wv2nMiUDDXkTwHl24QeiSd8vMVliz7yiRJGkJkKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/132] ALSA: hda/realtek - More constifications
Date:   Sun, 28 May 2023 20:10:26 +0100
Message-Id: <20230528190836.227748190@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 6b0f95c49d890440c01a759c767dfe40e2acdbf2 ]

Apply const prefix to each coef table array.

Just for minor optimization and no functional changes.

Link: https://lore.kernel.org/r/20200105144823.29547-4-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 90670ef774a8 ("ALSA: hda/realtek: Add a quirk for HP EliteDesk 805")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 118 +++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 98b6e93084e5e..3916f2eb5384a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -956,7 +956,7 @@ struct alc_codec_rename_pci_table {
 	const char *name;
 };
 
-static struct alc_codec_rename_table rename_tbl[] = {
+static const struct alc_codec_rename_table rename_tbl[] = {
 	{ 0x10ec0221, 0xf00f, 0x1003, "ALC231" },
 	{ 0x10ec0269, 0xfff0, 0x3010, "ALC277" },
 	{ 0x10ec0269, 0xf0f0, 0x2010, "ALC259" },
@@ -977,7 +977,7 @@ static struct alc_codec_rename_table rename_tbl[] = {
 	{ } /* terminator */
 };
 
-static struct alc_codec_rename_pci_table rename_pci_tbl[] = {
+static const struct alc_codec_rename_pci_table rename_pci_tbl[] = {
 	{ 0x10ec0280, 0x1028, 0, "ALC3220" },
 	{ 0x10ec0282, 0x1028, 0, "ALC3221" },
 	{ 0x10ec0283, 0x1028, 0, "ALC3223" },
@@ -3116,7 +3116,7 @@ static void alc269_shutup(struct hda_codec *codec)
 	alc_shutup_pins(codec);
 }
 
-static struct coef_fw alc282_coefs[] = {
+static const struct coef_fw alc282_coefs[] = {
 	WRITE_COEF(0x03, 0x0002), /* Power Down Control */
 	UPDATE_COEF(0x05, 0xff3f, 0x0700), /* FIFO and filter clock */
 	WRITE_COEF(0x07, 0x0200), /* DMIC control */
@@ -3228,7 +3228,7 @@ static void alc282_shutup(struct hda_codec *codec)
 	alc_write_coef_idx(codec, 0x78, coef78);
 }
 
-static struct coef_fw alc283_coefs[] = {
+static const struct coef_fw alc283_coefs[] = {
 	WRITE_COEF(0x03, 0x0002), /* Power Down Control */
 	UPDATE_COEF(0x05, 0xff3f, 0x0700), /* FIFO and filter clock */
 	WRITE_COEF(0x07, 0x0200), /* DMIC control */
@@ -4235,7 +4235,7 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 	}
 }
 
-static struct coef_fw alc225_pre_hsmode[] = {
+static const struct coef_fw alc225_pre_hsmode[] = {
 	UPDATE_COEF(0x4a, 1<<8, 0),
 	UPDATE_COEFEX(0x57, 0x05, 1<<14, 0),
 	UPDATE_COEF(0x63, 3<<14, 3<<14),
@@ -4248,7 +4248,7 @@ static struct coef_fw alc225_pre_hsmode[] = {
 
 static void alc_headset_mode_unplugged(struct hda_codec *codec)
 {
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x1b, 0x0c0b), /* LDO and MISC control */
 		WRITE_COEF(0x45, 0xd089), /* UAJ function set to menual mode */
 		UPDATE_COEFEX(0x57, 0x05, 1<<14, 0), /* Direct Drive HP Amp control(Set to verb control)*/
@@ -4256,7 +4256,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		WRITE_COEFEX(0x57, 0x03, 0x8aa6), /* Direct Drive HP Amp control */
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		WRITE_COEF(0x1b, 0x0c4b), /* LDO and MISC control */
 		WRITE_COEF(0x45, 0xd089), /* UAJ function set to menual mode */
 		WRITE_COEF(0x06, 0x6104), /* Set MIC2 Vref gate with HP */
@@ -4264,7 +4264,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		UPDATE_COEFEX(0x57, 0x05, 1<<14, 0), /* Direct Drive HP Amp control(Set to verb control)*/
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		WRITE_COEF(0x1b, 0x0c0b),
 		WRITE_COEF(0x45, 0xc429),
 		UPDATE_COEF(0x35, 0x4000, 0),
@@ -4274,7 +4274,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		WRITE_COEF(0x32, 0x42a3),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x4f, 0xfcc0, 0xc400),
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
@@ -4282,18 +4282,18 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		UPDATE_COEF(0x67, 0x2000, 0),
 		{}
 	};
-	static struct coef_fw coef0298[] = {
+	static const struct coef_fw coef0298[] = {
 		UPDATE_COEF(0x19, 0x1300, 0x0300),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x76, 0x000e),
 		WRITE_COEF(0x6c, 0x2400),
 		WRITE_COEF(0x18, 0x7308),
 		WRITE_COEF(0x6b, 0xc429),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		UPDATE_COEF(0x10, 7<<8, 6<<8), /* SET Line1 JD to 0 */
 		UPDATE_COEFEX(0x57, 0x05, 1<<15|1<<13, 0x0), /* SET charge pump by verb */
 		UPDATE_COEFEX(0x57, 0x03, 1<<10, 1<<10), /* SET EN_OSW to 1 */
@@ -4302,16 +4302,16 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		UPDATE_COEF(0x4a, 0x000f, 0x000e), /* Combo Jack auto detect */
 		{}
 	};
-	static struct coef_fw coef0668[] = {
+	static const struct coef_fw coef0668[] = {
 		WRITE_COEF(0x15, 0x0d40),
 		WRITE_COEF(0xb7, 0x802b),
 		{}
 	};
-	static struct coef_fw coef0225[] = {
+	static const struct coef_fw coef0225[] = {
 		UPDATE_COEF(0x63, 3<<14, 0),
 		{}
 	};
-	static struct coef_fw coef0274[] = {
+	static const struct coef_fw coef0274[] = {
 		UPDATE_COEF(0x4a, 0x0100, 0),
 		UPDATE_COEFEX(0x57, 0x05, 0x4000, 0),
 		UPDATE_COEF(0x6b, 0xf000, 0x5000),
@@ -4376,25 +4376,25 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
 				    hda_nid_t mic_pin)
 {
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEFEX(0x57, 0x03, 0x8aa6),
 		WRITE_COEF(0x06, 0x6100), /* Set MIC2 Vref gate to normal */
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		UPDATE_COEFEX(0x57, 0x05, 1<<14, 1<<14), /* Direct Drive HP Amp control(Set to verb control)*/
 		WRITE_COEFEX(0x57, 0x03, 0x09a3),
 		WRITE_COEF(0x06, 0x6100), /* Set MIC2 Vref gate to normal */
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		UPDATE_COEF(0x35, 0, 1<<14),
 		WRITE_COEF(0x06, 0x2100),
 		WRITE_COEF(0x1a, 0x0021),
 		WRITE_COEF(0x26, 0x008c),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x4f, 0x00c0, 0),
 		UPDATE_COEF(0x50, 0x2000, 0),
 		UPDATE_COEF(0x56, 0x0006, 0),
@@ -4403,30 +4403,30 @@ static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
 		UPDATE_COEF(0x67, 0x2000, 0x2000),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x19, 0xa208),
 		WRITE_COEF(0x2e, 0xacf0),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		UPDATE_COEFEX(0x57, 0x05, 0, 1<<15|1<<13), /* SET charge pump by verb */
 		UPDATE_COEFEX(0x57, 0x03, 1<<10, 0), /* SET EN_OSW to 0 */
 		UPDATE_COEF(0x1a, 1<<3, 0), /* Combo JD gating without LINE1-VREFO */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0xb7, 0x802b),
 		WRITE_COEF(0xb5, 0x1040),
 		UPDATE_COEF(0xc3, 0, 1<<12),
 		{}
 	};
-	static struct coef_fw coef0225[] = {
+	static const struct coef_fw coef0225[] = {
 		UPDATE_COEFEX(0x57, 0x05, 1<<14, 1<<14),
 		UPDATE_COEF(0x4a, 3<<4, 2<<4),
 		UPDATE_COEF(0x63, 3<<14, 0),
 		{}
 	};
-	static struct coef_fw coef0274[] = {
+	static const struct coef_fw coef0274[] = {
 		UPDATE_COEFEX(0x57, 0x05, 0x4000, 0x4000),
 		UPDATE_COEF(0x4a, 0x0010, 0),
 		UPDATE_COEF(0x6b, 0xf000, 0),
@@ -4512,7 +4512,7 @@ static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
 
 static void alc_headset_mode_default(struct hda_codec *codec)
 {
-	static struct coef_fw coef0225[] = {
+	static const struct coef_fw coef0225[] = {
 		UPDATE_COEF(0x45, 0x3f<<10, 0x30<<10),
 		UPDATE_COEF(0x45, 0x3f<<10, 0x31<<10),
 		UPDATE_COEF(0x49, 3<<8, 0<<8),
@@ -4521,14 +4521,14 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		UPDATE_COEF(0x67, 0xf000, 0x3000),
 		{}
 	};
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x45, 0xc089),
 		WRITE_COEF(0x45, 0xc489),
 		WRITE_COEFEX(0x57, 0x03, 0x8ea6),
 		WRITE_COEF(0x49, 0x0049),
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		WRITE_COEF(0x45, 0xc489),
 		WRITE_COEFEX(0x57, 0x03, 0x0da3),
 		WRITE_COEF(0x49, 0x0049),
@@ -4536,12 +4536,12 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		WRITE_COEF(0x06, 0x6100),
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		WRITE_COEF(0x06, 0x2100),
 		WRITE_COEF(0x32, 0x4ea3),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x4f, 0xfcc0, 0xc400), /* Set to TRS type */
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
@@ -4549,26 +4549,26 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		UPDATE_COEF(0x67, 0x2000, 0),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x76, 0x000e),
 		WRITE_COEF(0x6c, 0x2400),
 		WRITE_COEF(0x6b, 0xc429),
 		WRITE_COEF(0x18, 0x7308),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		UPDATE_COEF(0x4a, 0x000f, 0x000e), /* Combo Jack auto detect */
 		WRITE_COEF(0x45, 0xC429), /* Set to TRS type */
 		UPDATE_COEF(0x1a, 1<<3, 0), /* Combo JD gating without LINE1-VREFO */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0x11, 0x0041),
 		WRITE_COEF(0x15, 0x0d40),
 		WRITE_COEF(0xb7, 0x802b),
 		{}
 	};
-	static struct coef_fw coef0274[] = {
+	static const struct coef_fw coef0274[] = {
 		WRITE_COEF(0x45, 0x4289),
 		UPDATE_COEF(0x4a, 0x0010, 0x0010),
 		UPDATE_COEF(0x6b, 0x0f00, 0),
@@ -4631,53 +4631,53 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 {
 	int val;
 
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x45, 0xd489), /* Set to CTIA type */
 		WRITE_COEF(0x1b, 0x0c2b),
 		WRITE_COEFEX(0x57, 0x03, 0x8ea6),
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		WRITE_COEF(0x45, 0xd489), /* Set to CTIA type */
 		WRITE_COEF(0x1b, 0x0e6b),
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		WRITE_COEF(0x45, 0xd429),
 		WRITE_COEF(0x1b, 0x0c2b),
 		WRITE_COEF(0x32, 0x4ea3),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
 		UPDATE_COEF(0x66, 0x0008, 0),
 		UPDATE_COEF(0x67, 0x2000, 0),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x6b, 0xd429),
 		WRITE_COEF(0x76, 0x0008),
 		WRITE_COEF(0x18, 0x7388),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		WRITE_COEF(0x45, 0xd429), /* Set to ctia type */
 		UPDATE_COEF(0x10, 7<<8, 7<<8), /* SET Line1 JD to 1 */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0x11, 0x0001),
 		WRITE_COEF(0x15, 0x0d60),
 		WRITE_COEF(0xc3, 0x0000),
 		{}
 	};
-	static struct coef_fw coef0225_1[] = {
+	static const struct coef_fw coef0225_1[] = {
 		UPDATE_COEF(0x45, 0x3f<<10, 0x35<<10),
 		UPDATE_COEF(0x63, 3<<14, 2<<14),
 		{}
 	};
-	static struct coef_fw coef0225_2[] = {
+	static const struct coef_fw coef0225_2[] = {
 		UPDATE_COEF(0x45, 0x3f<<10, 0x35<<10),
 		UPDATE_COEF(0x63, 3<<14, 1<<14),
 		{}
@@ -4749,48 +4749,48 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 /* Nokia type */
 static void alc_headset_mode_omtp(struct hda_codec *codec)
 {
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x45, 0xe489), /* Set to OMTP Type */
 		WRITE_COEF(0x1b, 0x0c2b),
 		WRITE_COEFEX(0x57, 0x03, 0x8ea6),
 		{}
 	};
-	static struct coef_fw coef0256[] = {
+	static const struct coef_fw coef0256[] = {
 		WRITE_COEF(0x45, 0xe489), /* Set to OMTP Type */
 		WRITE_COEF(0x1b, 0x0e6b),
 		{}
 	};
-	static struct coef_fw coef0233[] = {
+	static const struct coef_fw coef0233[] = {
 		WRITE_COEF(0x45, 0xe429),
 		WRITE_COEF(0x1b, 0x0c2b),
 		WRITE_COEF(0x32, 0x4ea3),
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
 		UPDATE_COEF(0x66, 0x0008, 0),
 		UPDATE_COEF(0x67, 0x2000, 0),
 		{}
 	};
-	static struct coef_fw coef0292[] = {
+	static const struct coef_fw coef0292[] = {
 		WRITE_COEF(0x6b, 0xe429),
 		WRITE_COEF(0x76, 0x0008),
 		WRITE_COEF(0x18, 0x7388),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		WRITE_COEF(0x45, 0xe429), /* Set to omtp type */
 		UPDATE_COEF(0x10, 7<<8, 7<<8), /* SET Line1 JD to 1 */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0x11, 0x0001),
 		WRITE_COEF(0x15, 0x0d50),
 		WRITE_COEF(0xc3, 0x0000),
 		{}
 	};
-	static struct coef_fw coef0225[] = {
+	static const struct coef_fw coef0225[] = {
 		UPDATE_COEF(0x45, 0x3f<<10, 0x39<<10),
 		UPDATE_COEF(0x63, 3<<14, 2<<14),
 		{}
@@ -4850,17 +4850,17 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 	int val;
 	bool is_ctia = false;
 	struct alc_spec *spec = codec->spec;
-	static struct coef_fw coef0255[] = {
+	static const struct coef_fw coef0255[] = {
 		WRITE_COEF(0x45, 0xd089), /* combo jack auto switch control(Check type)*/
 		WRITE_COEF(0x49, 0x0149), /* combo jack auto switch control(Vref
  conteol) */
 		{}
 	};
-	static struct coef_fw coef0288[] = {
+	static const struct coef_fw coef0288[] = {
 		UPDATE_COEF(0x4f, 0xfcc0, 0xd400), /* Check Type */
 		{}
 	};
-	static struct coef_fw coef0298[] = {
+	static const struct coef_fw coef0298[] = {
 		UPDATE_COEF(0x50, 0x2000, 0x2000),
 		UPDATE_COEF(0x56, 0x0006, 0x0006),
 		UPDATE_COEF(0x66, 0x0008, 0),
@@ -4868,19 +4868,19 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 		UPDATE_COEF(0x19, 0x1300, 0x1300),
 		{}
 	};
-	static struct coef_fw coef0293[] = {
+	static const struct coef_fw coef0293[] = {
 		UPDATE_COEF(0x4a, 0x000f, 0x0008), /* Combo Jack auto detect */
 		WRITE_COEF(0x45, 0xD429), /* Set to ctia type */
 		{}
 	};
-	static struct coef_fw coef0688[] = {
+	static const struct coef_fw coef0688[] = {
 		WRITE_COEF(0x11, 0x0001),
 		WRITE_COEF(0xb7, 0x802b),
 		WRITE_COEF(0x15, 0x0d60),
 		WRITE_COEF(0xc3, 0x0c00),
 		{}
 	};
-	static struct coef_fw coef0274[] = {
+	static const struct coef_fw coef0274[] = {
 		UPDATE_COEF(0x4a, 0x0010, 0),
 		UPDATE_COEF(0x4a, 0x8000, 0),
 		WRITE_COEF(0x45, 0xd289),
@@ -5165,7 +5165,7 @@ static void alc_fixup_headset_mode_no_hp_mic(struct hda_codec *codec,
 static void alc255_set_default_jack_type(struct hda_codec *codec)
 {
 	/* Set to iphone type */
-	static struct coef_fw alc255fw[] = {
+	static const struct coef_fw alc255fw[] = {
 		WRITE_COEF(0x1b, 0x880b),
 		WRITE_COEF(0x45, 0xd089),
 		WRITE_COEF(0x1b, 0x080b),
@@ -5173,7 +5173,7 @@ static void alc255_set_default_jack_type(struct hda_codec *codec)
 		WRITE_COEF(0x1b, 0x0c0b),
 		{}
 	};
-	static struct coef_fw alc256fw[] = {
+	static const struct coef_fw alc256fw[] = {
 		WRITE_COEF(0x1b, 0x884b),
 		WRITE_COEF(0x45, 0xd089),
 		WRITE_COEF(0x1b, 0x084b),
@@ -8550,7 +8550,7 @@ static void alc662_fixup_aspire_ethos_hp(struct hda_codec *codec,
 	}
 }
 
-static struct coef_fw alc668_coefs[] = {
+static const struct coef_fw alc668_coefs[] = {
 	WRITE_COEF(0x01, 0xbebe), WRITE_COEF(0x02, 0xaaaa), WRITE_COEF(0x03,    0x0),
 	WRITE_COEF(0x04, 0x0180), WRITE_COEF(0x06,    0x0), WRITE_COEF(0x07, 0x0f80),
 	WRITE_COEF(0x08, 0x0031), WRITE_COEF(0x0a, 0x0060), WRITE_COEF(0x0b,    0x0),
-- 
2.39.2



