Return-Path: <stable+bounces-88666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A729B26F6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E729B212CC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E84818E37F;
	Mon, 28 Oct 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UZgBZ639"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75D18E03A;
	Mon, 28 Oct 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097849; cv=none; b=Ar8tKicMWmo0ts5QGFFEIUQCf1ptztmjuak0EGwgebj54jPHx9ode1qI92CKyKAuHHVV0tbGL2afcMps1Iggt9bvnrfimv6GL/59QyqryRKYl11VGBYpAlB+njlK695ryMmuy7xJkFtAmugfz99MqjadH0AspG4NQAhN9FxYoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097849; c=relaxed/simple;
	bh=wMcGiDpdvW8j/JpiHCkoes7GAGNtF9q3O1eHvWlEijY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUuuGR9zvc3TyaH7hcktG8nsEiB8wvLOZsm7ldRvs6MMAHiKA1dum+NHXEtm/BXWTdeb7jggG+QZ/WU5XWcel0wxxavbmnt0HCzSVr0Gk4GtUeqUyqRYWtp3bjB05crWsWc0x/idsw15c8Lf9vjQwEUSTQ8x62nMlK3aED7Jm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UZgBZ639; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3A3C4CEC3;
	Mon, 28 Oct 2024 06:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097848;
	bh=wMcGiDpdvW8j/JpiHCkoes7GAGNtF9q3O1eHvWlEijY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZgBZ639HnSnElDW674yOQ9PQ0zhl1qXJb/T1+aww+oeDn766GRQsm5TNuyKZfGeb
	 MXCJJbATE8Q4ehDV6xL0mmaOMZtbe6+X2eoq6+c2mS7RQLJNNUXecBzdzb+aOoiCYs
	 WHb7Uh4Db0AuhQIz8atNd6bL+UDMgBXP7Ib2zKLs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 173/208] ALSA: hda/realtek: Update default depop procedure
Date: Mon, 28 Oct 2024 07:25:53 +0100
Message-ID: <20241028062310.893164637@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit e3ea2757c312e51bbf62ebc434a6f7df1e3a201f ]

Old procedure has a chance to meet Headphone no output.

Fixes: c2d6af53a43f ("ALSA: hda/realtek - Add default procedure for suspend and resume state")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/17b717a0a0b04a77aea4a8ec820cba13@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 38 ++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 07e1547fff2e5..4dc5c7a18d6e7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3857,20 +3857,18 @@ static void alc_default_init(struct hda_codec *codec)
 
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
-	if (hp_pin_sense)
+	if (hp_pin_sense) {
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-
-	if (hp_pin_sense)
-		msleep(85);
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		msleep(75);
 
-	if (hp_pin_sense)
-		msleep(100);
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		msleep(75);
+	}
 }
 
 static void alc_default_shutup(struct hda_codec *codec)
@@ -3886,22 +3884,20 @@ static void alc_default_shutup(struct hda_codec *codec)
 
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
-	if (hp_pin_sense)
+	if (hp_pin_sense) {
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-
-	if (hp_pin_sense)
-		msleep(85);
-
-	if (!spec->no_shutup_pins)
 		snd_hda_codec_write(codec, hp_pin, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
-	if (hp_pin_sense)
-		msleep(100);
+		msleep(75);
 
+		if (!spec->no_shutup_pins)
+			snd_hda_codec_write(codec, hp_pin, 0,
+					    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+		msleep(75);
+	}
 	alc_auto_setup_eapd(codec, false);
 	alc_shutup_pins(codec);
 }
-- 
2.43.0




