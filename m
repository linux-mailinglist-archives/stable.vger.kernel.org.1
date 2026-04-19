Return-Path: <stable+bounces-238660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGNIIL875WmTfwEAu9opvQ
	(envelope-from <stable+bounces-238660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:31:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C188425759
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3522D30055DD
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7766C2DCF61;
	Sun, 19 Apr 2026 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRyj7fpF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB830B53A
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776630698; cv=none; b=LjrLPuHKyPg8tJCoIAmX6zmSsdMarGVVwWA6J0dJk0JyLe15cN1yLACbVg442f9pgxFfCSSDxRjysaB8Wm1ZgkAZbnjceqa5H/PyXrBNQY54ht09yYMyIfEKk4MqkMY50/++TZ0jbmaIoDKRGsszwi4AG4ZVMbeRoXSCeS1lD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776630698; c=relaxed/simple;
	bh=Sd3lBuRPc4TVt8+YNxlMtKK90gkr9B3jK01uoIEBfEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ObL17csaSOVoXWlmWz9WbUkr4WNNDzcdjfPSe8wNApiLio27wmeaL5UjsKo+HC4XtENjhxi/zM1gERzJaetAHFfHg/m3zsk85arAyHoe/Iji+S2REFQbWkC2Yo1R4vCeYu2SnJ4KJ1QM1Zmm0SwiHTgyiXn7r1GZo2zunSAlVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRyj7fpF; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba895adfeaso2508016eec.0
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776630695; x=1777235495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwHh11ZJDmP6iTnoktuVwH7YOEWIPLJREiHNq2gv16w=;
        b=MRyj7fpFe2GtubX72KWC23vnyiG1FfwbHlGd3NFYthnnftpM/yFyo2ymb6M9N4a9/a
         PEiVYfbMHBSp0BHi9EufOMtef2AIyikXr4S2kDnjVGOogPNyB1VHZ5cTrwr8RHZFW7hb
         rl2VSg9cNs6SgII2klI6mWazOE8h+RPCEdSUIvB1cqardsV5INv1NKoTUQcTai0xA4xN
         fWFspxcdskGNG9xybJBMq7omWMqLx0sKJaC146vblJUabHX2XI/lJIF82u6NEcX++lDK
         NAlkDXOo4RtOQf7XmLv08o0hspzQ+GZlzqPSQBOv8PNoN28uURtbvcyYyw6IzZzLRG2M
         mVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776630695; x=1777235495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JwHh11ZJDmP6iTnoktuVwH7YOEWIPLJREiHNq2gv16w=;
        b=EblOGLfLfAbR8pQi7RDbqQAliMhQo0uRwYKgIt/SsOYsXIqrnXTsUOxBygV+RSnIwH
         DVhpZs8oAvc+glt/24+JAgZlVWhxcdtzHJaxd8PaBLx0GQZgXIJUaRiGWPiIKqYz7YCj
         qRYgCqZm+5SdK4U4tO0yQYAz0/aO9zU/mSitXuDbkKMjtoPM0P/FO7OjmCPR9wtHyIoj
         9M2IyHAnwncQIunR/+lXyfxERScroSR/SzfeDZnpYJB84ODF+Gccf+DUTU1DduXo//zx
         sRSSEGmERzTZrSgsHlBYsLWGAj2vbdWjyDEGThjelz+ysuKJhmCKxdfNOm9VqYHJUPxl
         IeXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rGo7EwkN4X5mUbwBOXuoTk0bToRt8H9EB+3ZTp0Sdwj8nVZtL1FuZE2eELITAQMFQOw6+sQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhcx9viu4ADPqmLJI6XyL7PVa/ebhoOgAElAG1aXhtxfd66SyA
	tsyOaHUEVTW81ZjRTOAE6aEvFfZLHJ+CmIv4K7IgipKeXSqhpjwLBgKC
X-Gm-Gg: AeBDiev+Q2IaTLwe2SWBmtlKmyTvEnV6/8xFcHRacUlVpng5zBDd+bdBOONLwCDjBdb
	R0SYpUoF1aCDksle75T/4APgRmEGEfT9jN7d/f6CIfJM+gftBO327dho1cYQ+cwsBZu1q0FDaCB
	bcyHmBMCY+clnuIpjXl/YAohsvh7xlo1kjJZLabTnxyOjK7767j17rGFI8ksF28yiWAX0GQ6Ijo
	kIxC37GIY16baeyJiSBZZliUJyp3VrBFR4Fzyod7NXKQOEU1xK8MxSoTFhACi5w6RC6UClNqI9V
	D9NUp38DZQOlLbdho2xbI33n9qunQoHYbIyIWUbn5ws+lWWJxJk/qx1SJDgRT0B5V12zqb9wnzq
	LYaj7G/tetmfmIniTz43fm1BTiJVOuRLaaZJ/OpdcKT1JZifz7KG2f8PK6lXTkut0cBj7yoy/nw
	Y10ABYZjP4mhkkNXt0bilvB/El1hgwxFAJiI+6XQXEbz0iQgmU8insg7SBPmGMB5bu3E4lm8GsK
	FIcrQ8JrCariGQ=
X-Received: by 2002:a05:7300:e684:b0:2e2:5bc5:f8eb with SMTP id 5a478bee46e88-2e46538c8b5mr4826430eec.9.1776630695261;
        Sun, 19 Apr 2026 13:31:35 -0700 (PDT)
Received: from [192.168.1.18] (177-4-160-195.user3p.v-tal.net.br. [177.4.160.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm11419096eec.13.2026.04.19.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 13:31:34 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Sun, 19 Apr 2026 17:30:31 -0300
Subject: [PATCH 3/4] ALSA: usb-audio: Propagate US-16x08 write errors in
 route/mix EQ-switch put callbacks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260419-usb-write-error-propagation-v1-3-5a3bd4a673ae@gmail.com>
References: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
In-Reply-To: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
To: Takashi Iwai <tiwai@suse.com>, 
 Chris J Arges <chris.j.arges@canonical.com>, 
 Detlef Urban <onkel@paraair.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3397;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=Sd3lBuRPc4TVt8+YNxlMtKK90gkr9B3jK01uoIEBfEc=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJlPrWddWlIdqfDPU5r7iW932Ckmj33VXIwpwdeEm1O1+
 vYtCvvUUcrCIMbFICumyLI6aZHlnq4HV+vjVnjAzGFlAhnCwMUpABOZfZCRYWGqqb21JJ/s6r9L
 boaFFNz0VAnmFm1ymuJoydckdvtmKsM/Zav/7QVpvbHrFGew/pywm1lJjGnttQU7MzzfB+73N+x
 jBQA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238660-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C188425759
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several US-16x08 mixer put callbacks log failed control URBs but
still return success to userspace. That hides device write failures
even though the requested value was not applied.

Return the negative write error instead in the route, master, bus,
channel, and EQ switch put callbacks.

Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/mixer_us16x08.c | 49 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 8a02964e5d7b..fcf7dfa4aa84 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -224,14 +224,14 @@ static int snd_us16x08_route_put(struct snd_kcontrol *kcontrol,
 
 	err = snd_us16x08_send_urb(chip, buf, sizeof(route_msg));
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set routing, err:%d\n", err);
+		return err;
 	}
 
-	return err > 0 ? 1 : 0;
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
+	return 1;
 }
 
 static int snd_us16x08_master_info(struct snd_kcontrol *kcontrol,
@@ -283,14 +283,14 @@ static int snd_us16x08_master_put(struct snd_kcontrol *kcontrol,
 	buf[5] = index + 1;
 	err = snd_us16x08_send_urb(chip, buf, sizeof(mix_msg_out));
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set master, err:%d\n", err);
+		return err;
 	}
 
-	return err > 0 ? 1 : 0;
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
+	return 1;
 }
 
 static int snd_us16x08_bus_put(struct snd_kcontrol *kcontrol,
@@ -324,14 +324,14 @@ static int snd_us16x08_bus_put(struct snd_kcontrol *kcontrol,
 		break;
 	}
 
-	if (err > 0) {
-		elem->cached |= 1;
-		elem->cache_val[0] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set bus parameter, err:%d\n", err);
+		return err;
 	}
 
-	return err > 0 ? 1 : 0;
+	elem->cached |= 1;
+	elem->cache_val[0] = val;
+	return 1;
 }
 
 static int snd_us16x08_bus_get(struct snd_kcontrol *kcontrol,
@@ -392,14 +392,14 @@ static int snd_us16x08_channel_put(struct snd_kcontrol *kcontrol,
 
 	err = snd_us16x08_send_urb(chip, buf, sizeof(mix_msg_in));
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set channel, err:%d\n", err);
+		return err;
 	}
 
-	return err > 0 ? 1 : 0;
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
+	return 1;
 }
 
 static int snd_us16x08_mix_info(struct snd_kcontrol *kcontrol,
@@ -529,13 +529,13 @@ static int snd_us16x08_eqswitch_put(struct snd_kcontrol *kcontrol,
 		msleep(15);
 	}
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set eq switch, err:%d\n", err);
+		return err;
 	}
 
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
 	return 1;
 }
 
@@ -1418,4 +1418,3 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
 
 	return 0;
 }
-

-- 
2.53.0


