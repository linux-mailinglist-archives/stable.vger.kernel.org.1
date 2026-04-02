Return-Path: <stable+bounces-233010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDrTEnlszmmpngYAu9opvQ
	(envelope-from <stable+bounces-233010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:17:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BA2389863
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19296315F4AE
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63562773C3;
	Thu,  2 Apr 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j7xjMX0t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dT3LP55G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r/QGOAE6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RCvV3DjM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3F282F35
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134864; cv=none; b=PncWRhAWo+tXfsmsBxX0etM70kpfACm/dUoV2L976jKDd5haxwzMiZ5n5/n0woGq4WAZSHd27J4dNL2qv1kswDkgpsx5YWMa0r+zTK7DMM4KcPB4tXSMNcoDTQRVauFqP6C1KJhniA7JWk7K5KddNLjWMI3l1RF9/3JKbF2kQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134864; c=relaxed/simple;
	bh=TpUrGNltROE18LX7Qy8Sf5Nx9sgQN9pa7veuPLn7F18=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8/HFkC7HciGOlGgBIcgCif1+TneHJRzSZRhUPR0aFLklE4SyQYaeKqLRsvKcs4ltYK3XQ01wbPmLGxy8gRltJdI/r1A7NXvpmI8jHmq18tw5XvDCvslhonxjnEY/6NYr/e5oOUgTEk905UZfywZczWVY3G6zeB16yqg05PuL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j7xjMX0t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dT3LP55G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r/QGOAE6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RCvV3DjM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 490385BDE7;
	Thu,  2 Apr 2026 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775134849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAvU/VKtp81oZ2x66yU92Cc1uykzV5+KFXptNkvusiU=;
	b=j7xjMX0t9GCsHg4hHd/3ycm4v7agtyxNDh5L5/VbJgaW5Urdn7Lzshewv2F4FlpzifSVWL
	rmdI0AuZG+0lo702b0Q+NIRGVHqSokWlNLx5izh15uV++StAy8J138LPvo+bSI8BKpgyIV
	K2M1fx9RQGTRsM9T6GHQB10ffIWk1cE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775134849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAvU/VKtp81oZ2x66yU92Cc1uykzV5+KFXptNkvusiU=;
	b=dT3LP55Gb7/SnRbTo3ENcJV0x2HeT9+2aqZb/u3rYQuhKtC1ld0WhmYRXNKr8YOgdjgciy
	XABu43iVhNsPJqCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="r/QGOAE6";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RCvV3DjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775134848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAvU/VKtp81oZ2x66yU92Cc1uykzV5+KFXptNkvusiU=;
	b=r/QGOAE6OVH3VOTbcAH44ukCfCKXePA0tZPOLcg6SPmzYXNhr6y9PNaFzi1qseyUvUrQzq
	H3V8cSUm1SQO3twvE2xgNW4tUNzYrwid1wnm++M35utYFrK2q6w0GCNSy2NO6emIoyUGan
	3JFPqdnp5UU9eHzkmojlne9KJRKk234=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775134848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAvU/VKtp81oZ2x66yU92Cc1uykzV5+KFXptNkvusiU=;
	b=RCvV3DjME+/W4idMM79cvokoGZJB3ObMLBnnxrQVXqPIqINaAEd1bjGVCDnxgiOzQgnLUK
	1QCZdnDh6VdlisDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF1544A0B0;
	Thu,  2 Apr 2026 13:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rFgAOX9ozmmFPwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 02 Apr 2026 13:00:47 +0000
Date: Thu, 02 Apr 2026 15:00:47 +0200
Message-ID: <87mrzlikjk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,	niecheng1@uniontech.com,	kernel@uniontech.com,
	=?GB2312?B?uvrBrMfa?= <hulianqin@vivo.com>,	Kagura <me@mail.kagurach.uk>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: apply quirk for MOONDROP JU Jiu
In-Reply-To: <87qzoxiqnm.wl-tiwai@suse.de>
References: <20260402-syy-v1-1-068d3bc30ddc@linux.dev>
	<87qzoxiqnm.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233010-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kagurach.uk:email]
X-Rspamd-Queue-Id: 86BA2389863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 02 Apr 2026 12:48:45 +0200,
Takashi Iwai wrote:
> 
> On Thu, 02 Apr 2026 07:36:57 +0200,
> Cryolitia PukNgae wrote:
> > 
> > It(ID 31b2:0111 JU Jiu) reports a MIN value -12800 for volume control, but
> > will mute when setting it less than -10880.
> > 
> > Thanks to my girlfriend Kagura for reporting this issue.
> > 
> > Cc: Kagura <me@mail.kagurach.uk>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
> 
> Applied to for-next branch now.
> 
> > ---
> > Btw, is it a good idea for turn the volume_control_quirks from
> > switch-case to a table and sort it accroding to USB VID&PID?
> 
> Yeah, this might be better, indeed.
> 
> But the quirk isn't really straightforward for those, maybe we need a
> matching of USB id plus kctl id name string, then update the cval
> fields conditionally with flags.  Let me cook later...

This doesn't look easy.  A quick hack is like below, but it doesn't
reduce the code, ended up with more lines.

So, unless any other clever implementation is given, still not much
worth for it, as it seems.


Takashi

-- 8< --
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1070,11 +1070,107 @@ void snd_usb_mixer_elem_free(struct snd_kcontrol *kctl)
  * interface to ALSA control for feature/mixer units
  */
 
+#define VOL_QUIRK_MIN	BIT(0)
+#define VOL_QUIRK_MAX	BIT(1)
+#define VOL_QUIRK_RES	BIT(2)
+
+struct mixer_volume_quirk {
+	unsigned int id;
+	const char *ctl_name;
+	unsigned int to_update;
+	int min, max, res;
+};
+
+#define QUIRK_ENTRY(vid, pid, name) \
+	.id = USB_ID(vid, pid), .ctl_name = (name)
+#define QUIRK_MIN(v) \
+	.to_update = VOL_QUIRK_MIN, .min = (v)
+#define QUIRK_RES(v) \
+	.to_update = VOL_QUIRK_RES, .res = (v)
+#define QUIRK_MINMAX(vmin, vmax) \
+	.to_update = VOL_QUIRK_MIN | VOL_QUIRK_MAX, .min = (vmin), .max = (vmax)
+#define QUIRK_MINMAXRES(vmin, vmax, vres) \
+	.to_update = VOL_QUIRK_MIN | VOL_QUIRK_MAX | VOL_QUIRK_RES, \
+	.min = (vmin), .max = (vmax), .res = (vres)
+
+static const struct mixer_volume_quirk mixer_volume_quirk_entries[] = {
+	/* M-Audio Fast Track C400 */
+	{ QUIRK_ENTRY(0x0763, 0x2030, "Effect Duration"),
+	  QUIRK_MINMAXRES(0x0000, 0xffff, 0x00e6) },
+	{ QUIRK_ENTRY(0x0763, 0x2030, "Effect Volume"),
+	  QUIRK_MINMAX(0x00, 0xff) },
+	{ QUIRK_ENTRY(0x0763, 0x2030, "Effect Feedback Volume"),
+	  QUIRK_MINMAX(0x00, 0xff) },
+	{ QUIRK_ENTRY(0x0763, 0x2030, "Effect Return"),
+	  QUIRK_MINMAXRES(0xb706, 0xff7b, 0x0073) },
+	{ QUIRK_ENTRY(0x0763, 0x2030, "Playback Volume"),
+	  QUIRK_MINMAXRES(0xb5fb, 0xfcfe, 0x0073) }, /* -73 dB = 0xb6ff */
+	{ QUIRK_ENTRY(0x0763, 0x2030, "Effect Send"),
+	  QUIRK_MINMAXRES(0xb5fb, 0xfcfe, 0x0073) }, /* -73 dB = 0xb6ff */
+
+	/* M-Audio Fast Track C600 */
+	{ QUIRK_ENTRY(0x0763, 0x2031, "Effect Duration"),
+	  QUIRK_MINMAXRES(0x0000, 0xffff, 0x00e6) },
+	{ QUIRK_ENTRY(0x0763, 0x2031, "Effect Volume"),
+	  QUIRK_MINMAX(0x00, 0xff) },
+	{ QUIRK_ENTRY(0x0763, 0x2031, "Effect Feedback Volume"),
+	  QUIRK_MINMAX(0x00, 0xff) },
+	{ QUIRK_ENTRY(0x0763, 0x2031, "Effect Return"),
+	  QUIRK_MINMAXRES(0xb706, 0xff7b, 0x0073) },
+	{ QUIRK_ENTRY(0x0763, 0x2031, "Playback Volume"),
+	  QUIRK_MINMAXRES(0xb5fb, 0xfcfe, 0x0073) }, /* -73 dB = 0xb6ff */
+	{ QUIRK_ENTRY(0x0763, 0x2031, "Effect Send"),
+	  QUIRK_MINMAXRES(0xb5fb, 0xfcfe, 0x0073) }, /* -73 dB = 0xb6ff */
+
+	/* M-Audio Fast Track Ultra 8R */
+	{ QUIRK_ENTRY(0x0763, 0x2081, "Effect Duration"),
+	  QUIRK_MINMAXRES(0x0000, 0x7f00, 0x0100) },
+	{ QUIRK_ENTRY(0x0763, 0x2081, "Effect Volume"),
+	  QUIRK_MINMAX(0x00, 0x7f) },
+	{ QUIRK_ENTRY(0x0763, 0x2081, "Effect Feedback Volume"),
+	  QUIRK_MINMAX(0x00, 0x7f) },
+
+	/* M-Audio Fast Track Ultra */
+	{ QUIRK_ENTRY(0x0763, 0x2080, "Effect Duration"),
+	  QUIRK_MINMAXRES(0x0000, 0x7f00, 0x0100) },
+	{ QUIRK_ENTRY(0x0763, 0x2080, "Effect Volume"),
+	  QUIRK_MINMAX(0x00, 0x7f) },
+	{ QUIRK_ENTRY(0x0763, 0x2080, "Effect Feedback Volume"),
+	  QUIRK_MINMAX(0x00, 0x7f) },
+
+	/* CM102-A+/102S+ */
+	{ QUIRK_ENTRY(0x0d8c, 0x0103, "PCM Playback Volume"),
+	  QUIRK_MIN(-256) },
+
+	/* MS LifeChat LX-3000 Headset */
+	{ QUIRK_ENTRY(0x045e, 0x070f, "Speaker Playback Volume"),
+	  QUIRK_RES(192) },
+
+	/* QuickCam E3500 */
+	{ QUIRK_ENTRY(0x046d, 0x09a4, "Mic Capture Volume"),
+	  QUIRK_MINMAXRES(6080, 8768, 192) },
+
+	/* MOONDROP Quark2 */
+	{ QUIRK_ENTRY(0x3302, 0x12db, "PCM Playback Volume"),
+	  QUIRK_MIN(-14208) }, /* Mute under it */
+
+	/* Huawei Technologies Co., Ltd. CM-Q3 */
+	{ QUIRK_ENTRY(0x12d1, 0x3a07, "PCM Playback Volume"),
+	  QUIRK_MIN(-11264) }, /* Mute under it */
+
+	/* MOONDROP JU Jiu */
+	{ QUIRK_ENTRY(0x31b2, 0x0111, "PCM Playback Volume"),
+	  QUIRK_MIN(-10880) }, /* Mute under it */
+
+	{} /* terminator */
+};
+
 /* volume control quirks */
 static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 				  struct snd_kcontrol *kctl)
 {
 	struct snd_usb_audio *chip = cval->head.mixer->chip;
+	const struct mixer_volume_quirk *q;
 
 	if (chip->quirk_flags & QUIRK_FLAG_MIC_RES_384) {
 		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
@@ -1090,71 +1186,21 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 		}
 	}
 
-	switch (chip->usb_id) {
-	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
-	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C600 */
-		if (strcmp(kctl->id.name, "Effect Duration") == 0) {
-			cval->min = 0x0000;
-			cval->max = 0xffff;
-			cval->res = 0x00e6;
-			break;
-		}
-		if (strcmp(kctl->id.name, "Effect Volume") == 0 ||
-		    strcmp(kctl->id.name, "Effect Feedback Volume") == 0) {
-			cval->min = 0x00;
-			cval->max = 0xff;
-			break;
-		}
-		if (strstr(kctl->id.name, "Effect Return") != NULL) {
-			cval->min = 0xb706;
-			cval->max = 0xff7b;
-			cval->res = 0x0073;
-			break;
-		}
-		if ((strstr(kctl->id.name, "Playback Volume") != NULL) ||
-			(strstr(kctl->id.name, "Effect Send") != NULL)) {
-			cval->min = 0xb5fb; /* -73 dB = 0xb6ff */
-			cval->max = 0xfcfe;
-			cval->res = 0x0073;
-		}
-		break;
-
-	case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
-	case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra */
-		if (strcmp(kctl->id.name, "Effect Duration") == 0) {
-			usb_audio_info(chip,
-				       "set quirk for FTU Effect Duration\n");
-			cval->min = 0x0000;
-			cval->max = 0x7f00;
-			cval->res = 0x0100;
+	for (q = mixer_volume_quirk_entries; q->id; q++) {
+		if (q->id == chip->usb_id &&
+		    !strcmp(q->ctl_name, kctl->id.name)) {
+			if (q->to_update & VOL_QUIRK_MIN)
+				cval->min = q->min;
+			if (q->to_update & VOL_QUIRK_MAX)
+				cval->max = q->max;
+			if (q->to_update & VOL_QUIRK_RES)
+				cval->res = q->res;
 			break;
 		}
-		if (strcmp(kctl->id.name, "Effect Volume") == 0 ||
-		    strcmp(kctl->id.name, "Effect Feedback Volume") == 0) {
-			usb_audio_info(chip,
-				       "set quirks for FTU Effect Feedback/Volume\n");
-			cval->min = 0x00;
-			cval->max = 0x7f;
-			break;
-		}
-		break;
-
-	case USB_ID(0x0d8c, 0x0103):
-		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
-			usb_audio_info(chip,
-				 "set volume quirk for CM102-A+/102S+\n");
-			cval->min = -256;
-		}
-		break;
-
-	case USB_ID(0x045e, 0x070f): /* MS LifeChat LX-3000 Headset */
-		if (!strcmp(kctl->id.name, "Speaker Playback Volume")) {
-			usb_audio_info(chip,
-				"set volume quirk for MS LifeChat LX-3000\n");
-			cval->res = 192;
-		}
-		break;
+	}
 
+	/* other exceptional cases */
+	switch (chip->usb_id) {
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
@@ -1172,16 +1218,6 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 		}
 		break;
 
-	case USB_ID(0x046d, 0x09a4):
-		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
-			usb_audio_info(chip,
-				"set volume quirk for QuickCam E3500\n");
-			cval->min = 6080;
-			cval->max = 8768;
-			cval->res = 192;
-		}
-		break;
-
 	case USB_ID(0x0495, 0x3042): /* ESS Technology Asus USB DAC */
 		if ((strstr(kctl->id.name, "Playback Volume") != NULL) ||
 			strstr(kctl->id.name, "Capture Volume") != NULL) {
@@ -1190,27 +1226,6 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 1;
 		}
 		break;
-	case USB_ID(0x3302, 0x12db): /* MOONDROP Quark2 */
-		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
-			usb_audio_info(chip,
-				"set volume quirk for MOONDROP Quark2\n");
-			cval->min = -14208; /* Mute under it */
-		}
-		break;
-	case USB_ID(0x12d1, 0x3a07): /* Huawei Technologies Co., Ltd. CM-Q3 */
-		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
-			usb_audio_info(chip,
-				       "set volume quirk for Huawei Technologies Co., Ltd. CM-Q3\n");
-			cval->min = -11264; /* Mute under it */
-		}
-		break;
-	case USB_ID(0x31b2, 0x0111): /* MOONDROP JU Jiu */
-		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
-			usb_audio_info(chip,
-				       "set volume quirk for MOONDROP JU Jiu\n");
-			cval->min = -10880; /* Mute under it */
-		}
-		break;
 	}
 }
 

