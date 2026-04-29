Return-Path: <stable+bounces-241892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH3yD7YG8mkimwEAu9opvQ
	(envelope-from <stable+bounces-241892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:25:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E9494C00
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81255309B6DB
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1673FCB13;
	Wed, 29 Apr 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqijdlY4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326BD3FCB18
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468820; cv=none; b=itoNXb30Nd0Wz/VP72VzehxQmVC0rWOB1Gg2uaRUdAnLkJrudo5zeS8TObwpZKKUMpMtMFX4AH2/Pr3IvtaXmOxw2o1i3X3P8oIPYok4kpNjznTk3M3HcUoQAAMPwr5ROj3MOa+vBdSTj0q1/AjHrYEn+kyjaimtewrZDIQUbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468820; c=relaxed/simple;
	bh=qY6eB96FgX4rdA5fSKY5R/IfRUGHMZl8tl+qMd0TShc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJKdNOFvLdLJfEB9X6XKnbwkTmtRNrNXTirmnq2ZcMDJROwzCP3fhvGgxFKr4jQcvIjE1tEfZiViD5Fl3J9dIPPCECZ8skooHlJo51wRYdG940nOQbhA0vHILLLKF7+2T/7EHXBZvq8gp7NLHLH0lTA1UY7zouwfTBeCd9oyFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqijdlY4; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso4683373c88.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468818; x=1778073618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UR0FCOG1yA7m2DxeXQAQxx+l2dMQw9njJ++QgkzdIdw=;
        b=CqijdlY45PbkwkTiQ0qg8vOWJv22ZUPqXa/jzs3SicOn4Iz3NzAYGD0AA5YAY5Pg7n
         53GCIltbWdbPF/h4Y8Ypx9Ywv/2gRmdVSOMbXO0krHUOUL573O8XG+qwRGGMRRG+sHf9
         MwLYdsdXFBV9AdEsf0I9xAm8ZTLzkD77RVswROuMEORJkgprys/I5HpFbTsasOhwMCaz
         qL9/XY4ti28Radv2891fGSlkmOVlc9z6qGHk8jhUdnqRc+oaLZ+NDuWGe/XqIL7665NS
         mblpKfoAI0Kx8gYX+CHusBoIgVZj9WyZH50rmWXZBExg10r/dvAMt9AgUife7/thYMER
         MyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468818; x=1778073618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UR0FCOG1yA7m2DxeXQAQxx+l2dMQw9njJ++QgkzdIdw=;
        b=ncwdNWz5THkDTEMGZLZ+zsjmZE4wUl/06RzWxRqoI/6QgyzgdU68n0Yus3dwrY4RwN
         GoFrc8actP8tZxc23JzC3oEz1AlSvmbY7dSAxOLdrS+irYvHGMVEXgTkmFxXAQrJ3Ocv
         DX0gqrSx6u/dcqHVVLwb6AtLYUObxC7da7oG6BuC0OVudC79nEF64Yftm+Uh3gNHYq+N
         WpDXeD+NmUmYQBIyhc/Xiq+8U9ouxeVzHRVubVSdHAIZVtg5sVH6YZuK1sxRHuPJmry3
         wQQDR70FBvDAPWXKeZd+DJqN4m7u1uHViaffAMA4MTzAOihMwGluJ0gxu3FR6vP17+dF
         4h/A==
X-Forwarded-Encrypted: i=1; AFNElJ/fFMQxaV5TaJkX5kQpEGJS7DHObXpEkTEFxtP5h+nevIJeINERPMX+2efxzMENSQFP1AkPwFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANglMmKQISA0C5+5iEVCUil7RVWQ2QEsyGOTXkB6i1sP2Kou3
	YTF6wvMMfX1b88H6Vbsj6pAuZS6ZQFstd1UiGw2xWlz4r2C6Hevvr/o9
X-Gm-Gg: AeBDieuJX7Je1xWz4bnfiKZmnlSHnZg1VFS8bk1VnY+xsX4R2d7bLPXMn1JmfJ9nU6m
	kXNzS1WTX7VizbsKGYoyJvUGQfaOJhnQvJ6fV7rSlh7yNJQ0HUI5jh2w1EL6jQBhNI2qKVJUsUR
	T3UDKIjzfP4y3ohDrDR0q0n/kW7iBPhbQ60MCFoMkw/dmmn9SVday7KlmWteDT3xB5k7CVJmRbn
	MCZ3ibr8kWBUJO5SjKXh70Ot6u3gEsMovcr0Akd4+19lLGDGJMN0CxoC6keYZxgv3yzRtFgTS+4
	AQbiknoIRS7HsYlyL98GUu3c527zjRhhE0X+QRABpgSdDtmnOlsieZn89iAP3m4IXh9Zfl3fO6Y
	bgL4ErUcnFvamAg3inDl8SjdEEcnkmz+XKpDFLwtMDSXhZwnalavD9dkxpfQDVCYhEtSoG0kb4q
	LzERPKyc71OeSXD+Vr4jnlAGVhS9uQQ7SE2RxKZuENYCaApaHgFD8TVUCxinByCgI0lxxbcH1sT
	qopYt8HX7hm
X-Received: by 2002:a05:7023:b05:b0:12d:de3f:d848 with SMTP id a92af1059eb24-12de2a76b36mr1531162c88.43.1777468818213;
        Wed, 29 Apr 2026 06:20:18 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de321df36sm3336852c88.7.2026.04.29.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:20:17 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 29 Apr 2026 10:20:01 -0300
Subject: [PATCH 1/2] ALSA: usb-audio: Roll back quirk control caches on
 write errors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-alsa-usb-quirks-cache-rollback-v1-1-01b35c688b80@gmail.com>
References: <20260429-alsa-usb-quirks-cache-rollback-v1-0-01b35c688b80@gmail.com>
In-Reply-To: <20260429-alsa-usb-quirks-cache-rollback-v1-0-01b35c688b80@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Thomas Ebeling <penguins@bollie.de>, 
 Ian Douglas Scott <ian@iandouglasscott.com>, 
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5747;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=qY6eB96FgX4rdA5fSKY5R/IfRUGHMZl8tl+qMd0TShc=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmfWLt+Jr3vZcthXVazcHpSSTDLtdcBaeI1nexvtsgF6
 lZPe9HXUcrCIMbFICumyLI6aZHlnq4HV+vjVnjAzGFlAhnCwMUpABNZ8IPhN8t5me7S2RcuRL24
 qiuV4zzJeukc5qOdV7d79d5SWe85az4jw0rG19pptwOzd1+eK1+674HDb10br9ZzpbLHN/+cMCt
 9MiMA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: B34E9494C00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[bollie.de,iandouglasscott.com,perex.cz,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241892-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]

Several mixer quirk callbacks cache the requested
control value in kcontrol->private_value before
issuing a single vendor or class write.

Their paired get and resume paths consume that cache
directly, so a failed write currently leaves software
state changed even though the update did not succeed.
That can make later reads report a value the device
never accepted and can replay the stale cache on resume.

Restore the previous cached value on failure in
the Audigy2NX LED, Emu0204 channel switch,
Xonar U1 output switch, Native Instruments controls,
FTU effect program switch, and Sound Blaster E1 input source switch.

Fixes: 9cf3689bfe07 ("ALSA: usb-audio: Add audigy2nx resume support")
Fixes: 5f503ee9e270 ("ALSA: usb-audio: Add Emu0204 channel switch resume support")
Fixes: 2bfb14c3b8fb ("ALSA: usb-audio: Add Xonar U1 resume support")
Fixes: da6d276957ea ("ALSA: usb-audio: Add resume support for Native Instruments controls")
Fixes: 0b4e9cfcef05 ("ALSA: usb-audio: Add resume support for FTU controls")
Fixes: 388fdb8f882a ("ALSA: usb-audio: Support changing input on Sound Blaster E1")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/mixer_quirks.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1bdaa46d4fe1..229be55e9158 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -333,6 +333,7 @@ static int snd_audigy2nx_led_put(struct snd_kcontrol *kcontrol,
 	int index = kcontrol->private_value & 0xff;
 	unsigned int value = ucontrol->value.integer.value[0];
 	int old_value = kcontrol->private_value >> 8;
+	unsigned long old_pval = kcontrol->private_value;
 	int err;
 
 	if (value > 1)
@@ -341,7 +342,11 @@ static int snd_audigy2nx_led_put(struct snd_kcontrol *kcontrol,
 		return 0;
 	kcontrol->private_value = (value << 8) | index;
 	err = snd_audigy2nx_led_update(mixer, value, index);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_audigy2nx_led_resume(struct usb_mixer_elem_list *list)
@@ -487,6 +492,7 @@ static int snd_emu0204_ch_switch_put(struct snd_kcontrol *kcontrol,
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	struct usb_mixer_interface *mixer = list->mixer;
 	unsigned int value = ucontrol->value.enumerated.item[0];
+	unsigned long old_pval = kcontrol->private_value;
 	int err;
 
 	if (value > 1)
@@ -497,7 +503,11 @@ static int snd_emu0204_ch_switch_put(struct snd_kcontrol *kcontrol,
 
 	kcontrol->private_value = value;
 	err = snd_emu0204_ch_switch_update(mixer, value);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_emu0204_ch_switch_resume(struct usb_mixer_elem_list *list)
@@ -821,7 +831,11 @@ static int snd_xonar_u1_switch_put(struct snd_kcontrol *kcontrol,
 
 	kcontrol->private_value = new_status;
 	err = snd_xonar_u1_switch_update(list->mixer, new_status);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_status;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_xonar_u1_switch_resume(struct usb_mixer_elem_list *list)
@@ -1159,7 +1173,8 @@ static int snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
 					     struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
-	u8 oldval = (kcontrol->private_value >> 24) & 0xff;
+	unsigned long old_pval = kcontrol->private_value;
+	u8 oldval = (old_pval >> 24) & 0xff;
 	u8 newval = ucontrol->value.integer.value[0];
 	int err;
 
@@ -1169,7 +1184,11 @@ static int snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
 	kcontrol->private_value &= ~(0xff << 24);
 	kcontrol->private_value |= (unsigned int)newval << 24;
 	err = snd_ni_update_cur_val(list);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static const struct snd_kcontrol_new snd_nativeinstruments_ta6_mixers[] = {
@@ -1324,7 +1343,8 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kctl);
-	unsigned int pval = list->kctl->private_value;
+	unsigned long old_pval = list->kctl->private_value;
+	unsigned int pval = old_pval;
 	int cur_val, err, new_val;
 
 	cur_val = pval >> 24;
@@ -1335,7 +1355,11 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 	kctl->private_value &= ~(0xff << 24);
 	kctl->private_value |= new_val << 24;
 	err = snd_ftu_eff_switch_update(list);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kctl->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer,
@@ -2114,13 +2138,18 @@ static int snd_soundblaster_e1_switch_put(struct snd_kcontrol *kcontrol,
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	unsigned char value = !!ucontrol->value.integer.value[0];
+	unsigned long old_pval = kcontrol->private_value;
 	int err;
 
 	if (kcontrol->private_value == value)
 		return 0;
 	kcontrol->private_value = value;
 	err = snd_soundblaster_e1_switch_update(list->mixer, value);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_soundblaster_e1_switch_resume(struct usb_mixer_elem_list *list)

-- 
2.54.0


