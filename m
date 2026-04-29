Return-Path: <stable+bounces-241893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHc2B+EG8mkimwEAu9opvQ
	(envelope-from <stable+bounces-241893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:25:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B9494C35
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 757F93014F6B
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8D3FBEDF;
	Wed, 29 Apr 2026 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2gXbMUj"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5833FCB1C
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468824; cv=none; b=Vr+mdiZedCiFEeNMYGmQkkIGUIdplA+0EU16U1NIB/BljXkek8GBMovQqFurVlfS+352oeY77+CSapbnPVC4O38Q6pAaUZAyKEn5XD4qW48P1wTD4HdjrjagNZiMwH6xvq7WmaMBLWhlU79sB80l6bswYv0kmcxmgQAQL2xtCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468824; c=relaxed/simple;
	bh=feuCS+Wde8W7EpfVCWxGj5z6QZqJHZ4hcRmQpIJg2Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOuzER8X/7v+3UIRKnD3/U8wSoW0JANjWZdNMj/6EFGA0dCIdy7WmCEUHLBooIpfMyRIIXeNkXLI2rUiS+upE9mRkkjlbaa0Qa5axL19n7EjrsP5WvU5rA/k6+zK3T/5UbnpNd66vUomdFNGFYheIFPmf9dln2+mKzMrvA/w3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2gXbMUj; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b4520f6b32so18217282eec.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468823; x=1778073623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syI6vCyidI7u0qaJd4ZC0RGGlbIolm5pPKH0di9GsB0=;
        b=k2gXbMUjAHIP9ks38qtvQQyWs2hSgZTiskIWCXpVnMz3H1jJiOJQo8xQRRu1mjeANA
         GoiytNp6pASpSH50tNwIOpS8nBto25mpeTgIOhL+gu8Z+9m8GO2kixc3ojTBvuEEIa89
         U5iVAK+2/FTHI3t+TVMlbF+7NlCHm4eGu455n0fe5j0Q9g6VWiKoCyXYK/tVaktWaTdf
         9JJbQSOT5vNsz5YWedSDrBev2J34aItEUL7bVrR9lLScHLUR6QIE1bUcGwR7jwG0OLhN
         5CutsLThTzdwQVRa4VGE2NYB8mkWwna4BmdPiWRhsc5nisc7tvbZ8EUj+Hth3ew9Dd98
         Or9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468823; x=1778073623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=syI6vCyidI7u0qaJd4ZC0RGGlbIolm5pPKH0di9GsB0=;
        b=rZUPUdhgc3dmEB4SLrVOF9dI8DvAfKz0mxHFRBc7Qxg+36OiXLy7V7v2BUGoTIIeB3
         hzy9gMsPE0wjO8gdaw2JPgcjnpwFpmF2ONFA5BBi5TcXARb0YSbLRnzALOEydkMy4aXn
         N9rliuG00SoFbOLH7KZbUik9naDK6qsHB3rwGVt3scQgsH6G8/umIqU5/F5yS9bv+9SW
         e8q7YBJ2VfJyNfamiyIWUReBHRyU8Hy7yE1XU49BUCt05o0rh3zuTYdoRvBwiV8LKXVC
         OiXmKxbsgOUqZCzw8p8Y1mILownDuj3QRhDSYbMhu3wJtqDRb8HLsk5nCbgJHbH/Eua6
         go2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+F8SfZRwKB1BF8uMBSAd0XhosoNUii9x14VImScwH/JsFYjJLHat0sogKgL/KKwT+SbJsPVig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvGAFD8KTvZGlNS7KfGrjsJG59seFml3L4WG7ZY5InQlDzb3H
	i6C0ikGytAoo1SLm1M5JG2rJbubRSPxe/f8WkGCiwVq2r2J53zanx38E
X-Gm-Gg: AeBDieuLLHGaAaJHbi95HMBd7Xz9cnNidhdfpQdQ2UmTwyp4pYyTQl6JXi32ucSxKN9
	9zVPSgV9u6OdHXWtQAZcKqw+3H8jU9D5R/JQSTDzVnlV9h4DpypY5PzJ3SJble1M1egqW8wtz0h
	Z4tCtmoNaVOn9hFoK6j/nGdw8Ic6tXCPeFWuLE8FLgazD5wTe8ib7Hu7mdDpTKJX+4/HgXi9ue5
	P7q2luF8B7fUeH2GXq574SIeCQQHbD/ojc4+n72wQROoJD32mTaaKyA8bpICVXKt66l/Xyluf1G
	d6+JAZ/0CReWLRH1L9gOTsk3IbQoYRYEqCzLGTGb6hV5lVL4WSyBb00iqlYvu46NuX6BWhi2Aqi
	etPcAgSvtqVbSWY/mOJNlZTnk99Xj17I+Xhns+G7BEM/PQzLzABhxJw4PKtB00yKIX3uLkCUqOt
	KIRSJBSxctE9s+fl/QlJMyxhO22zh8CZQlFSn8rV1mYhzl2mEC6XeJtWnpJ/3ibIjv/X+8wx7za
	dmzzu8FZo5n
X-Received: by 2002:a05:7022:e98d:b0:127:366f:8bb7 with SMTP id a92af1059eb24-12de2a4b858mr1514450c88.25.1777468822679;
        Wed, 29 Apr 2026 06:20:22 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de321df36sm3336852c88.7.2026.04.29.06.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:20:22 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 29 Apr 2026 10:20:02 -0300
Subject: [PATCH 2/2] ALSA: usb-audio: Update Babyface Pro control caches
 only after successful writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-alsa-usb-quirks-cache-rollback-v1-2-01b35c688b80@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=feuCS+Wde8W7EpfVCWxGj5z6QZqJHZ4hcRmQpIJg2Y8=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmfWLtajwc095kkiQt6yG67uunhz0dcbCv2ZizvXpO19
 ZT3g+UpHaUsDGJcDLJiiiyrkxZZ7ul6cLU+boUHzBxWJpAhDFycAjAR2ceMDC/O8VfwN3XZpQQv
 m6kTe0jx7U7lwL3c7yqd/X2fOal3rmZkWLNdozE37vv6Tb0bz216FvG7dNOFcpHFTvM2TJFztZj
 EwQkA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 3C8B9494C35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[bollie.de,iandouglasscott.com,perex.cz,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241893-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]

snd_bbfpro_ctl_put() and snd_bbfpro_vol_put()
cache the requested packed control state in
kcontrol->private_value before issuing the USB write.

Their get and resume paths use that cached value directly,
so a failed write can leave the driver reporting and later
replaying a setting the hardware never accepted.

Update the cached state only after a successful USB write.

Fixes: 3e8f3bd04716 ("ALSA: usb-audio: RME Babyface Pro mixer patch")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/mixer_quirks.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 229be55e9158..99975c3240a5 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3027,12 +3027,14 @@ static int snd_bbfpro_ctl_put(struct snd_kcontrol *kcontrol,
 	if (val == old_value)
 		return 0;
 
+	err = snd_bbfpro_ctl_update(mixer, reg, idx, val);
+	if (err < 0)
+		return err;
+
 	kcontrol->private_value = reg
 		| ((idx & SND_BBFPRO_CTL_IDX_MASK) << SND_BBFPRO_CTL_IDX_SHIFT)
 		| ((val & SND_BBFPRO_CTL_VAL_MASK) << SND_BBFPRO_CTL_VAL_SHIFT);
-
-	err = snd_bbfpro_ctl_update(mixer, reg, idx, val);
-	return err < 0 ? err : 1;
+	return 1;
 }
 
 static int snd_bbfpro_ctl_resume(struct usb_mixer_elem_list *list)
@@ -3217,11 +3219,13 @@ static int snd_bbfpro_vol_put(struct snd_kcontrol *kcontrol,
 
 	new_val = uvalue & SND_BBFPRO_MIXER_VAL_MASK;
 
+	err = snd_bbfpro_vol_update(mixer, idx, new_val);
+	if (err < 0)
+		return err;
+
 	kcontrol->private_value = idx
 		| (new_val << SND_BBFPRO_MIXER_VAL_SHIFT);
-
-	err = snd_bbfpro_vol_update(mixer, idx, new_val);
-	return err < 0 ? err : 1;
+	return 1;
 }
 
 static int snd_bbfpro_vol_resume(struct usb_mixer_elem_list *list)

-- 
2.54.0


