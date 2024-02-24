Return-Path: <stable+bounces-23573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0707A8625DD
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 16:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837211F218D4
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF446544;
	Sat, 24 Feb 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWG/fSaZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9F1E49D
	for <stable@vger.kernel.org>; Sat, 24 Feb 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708789900; cv=none; b=gieUmwFQfPAuuQXvN36BZ/E8FZ/ZRFYCuS5iW1/2wWG/iCO+3dOw4ej7+blJ+u90itoFZp/pAYy6qBY2Lgx09eK3UwwTN89xw+XNuSTZvhQwTd/Y07YUbeULqLTPuZXz7CJLyuGDbc3DHSrJ//3piVlNyA+bcvAY8JAQz7p1xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708789900; c=relaxed/simple;
	bh=U/wcljAf4AANc6QDw+IQ0KO00PBVdngL7aa7qn719J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THrEp17a2I7hbt09BUQrgAwgcK/RN8p0e6jsx4MXK7lT33SQyre7BCbjOysd8n/Z5/giOfwqLyRfNIVoZzZdX0jm7aGYLHGrPKqGFNNkZ22nvIQrjnMIG/FYH5ikGDH84CpuWNVJryZQ6WJNypQ6eEt8sFmV97CLHdB+MABEsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWG/fSaZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da9c834646so1736466b3a.3
        for <stable@vger.kernel.org>; Sat, 24 Feb 2024 07:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708789898; x=1709394698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbQ4SLsny4bFWDjPuLR76KvUDSBLgo9Lb0WGrwi11bY=;
        b=BWG/fSaZ0HKrKPpvJ6PZFaDlSeqeKCHApj5AKh3bqyvngtYtQa9dEQ0j5s2dm1oFcK
         urcjMuLLkcveEDgs6X+IUYiNeqBgsmbpoDA6LVek6YKUSxKoc0Z3dIoLbg/XzmmevZol
         23LH/4LSSyFDWuWflGVcsA13Cbf9/J2cxBlTOyS3nTgm/QXioIRBVnum6K8AmwTAFDf1
         dGMcGhSaN5RL1fNG5V2x8BgzIMtPIvfmA92XL9w3agYtfFoQSIMnoY8do+dVRXFRu1Mj
         LXK6iqdP63da3tKPSNsd55iJ2qonc7TUwDcj0zSXXWWB+fZViMOqQ7AEEq5kn6xNFH84
         iE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708789898; x=1709394698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbQ4SLsny4bFWDjPuLR76KvUDSBLgo9Lb0WGrwi11bY=;
        b=kFL0PAGDYlLppAQYL3jSZ0vH7ESdM8CEF9/kvONbovfaYbLEN2p263WQbxYWbOWW9V
         lJGLBEW1+2eyNZFfKT3i0f7vZ6PeGifl+Gp4TggwQRQQh5Kgfrx93D3kOTdGyjVTce34
         PfpHR4aJx1djmA+65eskHKJCuK3jM95C5+0bh/KUI4zabfVwbIJUDiqqntKTKbv5BXR8
         2PqBX02Ws1VSx6NBpEpk0Gb3NP5QtEc920GVrhERZLlAZXQwkavs4LyRAQCo3CDkP+57
         9/LsPdmnmBKZ0dK0eLfAXFYkhH7UxzarxSE9htnENZEsqJAXGMSasNC6dMqH2Cv/LknH
         Vgmg==
X-Forwarded-Encrypted: i=1; AJvYcCV9yrsHgtLNLDg3E3BCvzFnNElRiRH+e/KNa8rtlGnwLGs+habhEvQO/d4svZEbi1FjK7DKSHSlukkO/Pd+FTUSVX17WK6B
X-Gm-Message-State: AOJu0YwJWIYeZVUInbJ7IJHUwJxWzipnYvZNqJMPicHvRAVN9BmYqzwT
	elBNO18Xn71AXIGQUEqTtrC+6dqFEgOXS0bREP0hxbnQwfACNBKoo735tXUfPZk=
X-Google-Smtp-Source: AGHT+IFsw0VHBKLsPADE/Zyzt+AJ02imoqLC4ZNIbFns+RhGglF1KoNoiADkNHkc95OUccOxx9K1IA==
X-Received: by 2002:a05:6a00:4403:b0:6e5:265:fd38 with SMTP id br3-20020a056a00440300b006e50265fd38mr1040874pfb.18.1708789897891;
        Sat, 24 Feb 2024 07:51:37 -0800 (PST)
Received: from localhost.localdomain (201-13-160-44.dial-up.telesp.net.br. [201.13.160.44])
        by smtp.gmail.com with ESMTPSA id m20-20020a63f614000000b005b7dd356f75sm1263123pgh.32.2024.02.24.07.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 07:51:37 -0800 (PST)
From: Willian Wang <wilwxk@gmail.com>
X-Google-Original-From: Willian Wang <git@willian.wang>
To: wilwxk+test@gmail.com
Cc: Willian Wang <git@willian.wang>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8
Date: Sat, 24 Feb 2024 12:51:27 -0300
Message-ID: <20240224155127.1142896-1-git@willian.wang>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo Slim/Yoga Pro 9 14IRP8 requires a special fixup because there is
a collision of its PCI SSID (17aa:3802) with Lenovo Yoga DuetITL 2021
codec SSID.

Fixes: 3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555
Link: https://lore.kernel.org/all/d5b42e483566a3815d229270abd668131a0d9f3a.camel@irl.hu
Cc: stable@vger.kernel.org
Signed-off-by: Willian Wang <git@willian.wang>
---
 sound/pci/hda/patch_realtek.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ec1312bffd5..f3b847f38153 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7444,6 +7444,7 @@ enum {
 	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
 	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
 	ALC298_FIXUP_LENOVO_C940_DUET7,
+	ALC287_FIXUP_LENOVO_14IRP8_DUETITL,
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
 	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
@@ -7495,6 +7496,26 @@ static void alc298_fixup_lenovo_c940_duet7(struct hda_codec *codec,
 	__snd_hda_apply_fixup(codec, id, action, 0);
 }
 
+/* A special fixup for Lenovo Slim/Yoga Pro 9 14IRP8 and Yoga DuetITL 2021;
+ * 14IRP8 PCI SSID will mistakenly be matched with the DuetITL codec SSID,
+ * so we need to apply a different fixup in this case. The only DuetITL codec
+ * SSID reported so far is the 17aa:3802 while the 14IRP8 has the 17aa:38be
+ * and 17aa:38bf. If it weren't for the PCI SSID, the 14IRP8 models would
+ * have matched correctly by their codecs.
+ */
+static void alc287_fixup_lenovo_14irp8_duetitl(struct hda_codec *codec,
+					      const struct hda_fixup *fix,
+					      int action)
+{
+	int id;
+
+	if (codec->core.subsystem_id == 0x17aa3802)
+		id = ALC287_FIXUP_YOGA7_14ITL_SPEAKERS; /* DuetITL */
+	else
+		id = ALC287_FIXUP_TAS2781_I2C; /* 14IRP8 */
+	__snd_hda_apply_fixup(codec, id, action, 0);
+}
+
 static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_GPIO2] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9379,6 +9400,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_lenovo_c940_duet7,
 	},
+	[ALC287_FIXUP_LENOVO_14IRP8_DUETITL] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_lenovo_14irp8_duetitl,
+	},
 	[ALC287_FIXUP_13S_GEN2_SPEAKERS] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -10247,7 +10272,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
-	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8 / DuetITL 2021", ALC287_FIXUP_LENOVO_14IRP8_DUETITL),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-- 
2.43.2


