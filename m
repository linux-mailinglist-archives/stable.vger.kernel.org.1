Return-Path: <stable+bounces-238661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOkoO7w75WmTfwEAu9opvQ
	(envelope-from <stable+bounces-238661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:31:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C9425752
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 440833004922
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 20:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1A3093D8;
	Sun, 19 Apr 2026 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXRoY6pa"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4A2DCF61
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776630701; cv=none; b=k38WBvzHAQQh/pK1U8qAlkPC+JSBDAt2zeYG2vyV7rneKhwJxUeU34kGXxPciKDQmEk+NdE+WLHgMBlMR6HUL20uNizcq/XAddKzxu8zkXploiSFLTQi6gaOvvUf5z3KECyk+I2A3VvH2UILqNjHDYZY6cInNQYXBzPYrR4wgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776630701; c=relaxed/simple;
	bh=WebseC0n1uvq36U8Uba9vWPPZlTekN/7JlLiJTYMcdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQon1ZFvn0YbQDoTuMhFZTV3Zw/epN2j5VPjeChzazplqgWk83AYN2H1tvYHrL+4A8R8UQFW5RAUEs+jkz3X4UCGkaFd/1XIy9GjBDCIsCPSzlDzdHUtn6Bu+H23C8CgFjaHJ70zOmzueObU37q7MdCw2hPOXW2AORLI3tfas74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXRoY6pa; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2d868d014a5so2210604eec.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776630699; x=1777235499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMVw5KmBgRtdu9bTOKibgYALvECPF7cHuMU/74qaZtI=;
        b=UXRoY6pafrvCjE8Oq0jjoChbwJxoII9jVJDkF/m4qfwq5pyHPSAwsWezLXchJloSlH
         LAAHFPV1sRhL6XIeyZN9312Pgb+ySg1wzQlKMDqWjQS8USum6bDaNYCGdJ8DcqWCVv/J
         DJtng5v42t+lWEtbE39TYiMpjzGmmXtGHCcK0jLCvcMRw/3SAshEBeNQt0lWpBGmYxhG
         95YMsGSZtsXTx8ff+z7WXR0stX3duHWT4xU8gFwirRuWBmEIt//XNDIQomvFxDz7nrlm
         tqKpA3yiYYLK/3woMGgysiUgN76dPlBQAqmjBX/akSc4Acyd6eJj3oJEuW5cbGF1XuaF
         mrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776630699; x=1777235499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMVw5KmBgRtdu9bTOKibgYALvECPF7cHuMU/74qaZtI=;
        b=qojuaMpg+4xzgtB2gwnjLBIkokjNZc6pf3/3Lv2k9tEfw3KcYxjMvV4VNWNgaapeJv
         W42I0QVarwdIPEFo5/qQn++DKn/hOT/RYX91X0lSTpm/TKjSzowKgq8JIm9jOj+ED+eI
         hWfk/OzJh05IEhKzL+bxvUVKKm2621vFCg5V++DFV+MpOjTfDngRL+1fqxlRE3Zx67mc
         Y4fpulrk1/G6+W3uywy3t2Jn1+5JoVQFuexQl5XJYGt9282Id3RneaUdL/WwCOs9ENUV
         4NlKMOR2WCpdIcuRFeAimAIGlghIEYeUm90L9ZSZX/iH8VyKfeWUb1VVaIKlrFirt/Hg
         KEFw==
X-Forwarded-Encrypted: i=1; AFNElJ/BQPnXZ1SUVGjFEXZkN23JJLVlxT7Zi/VI91yaameTQTRJTxBO7dUR+gEcHTSOFlPaqmglLAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Zg/MSPOH6x4yycR60D3gTt7C29qRKfzH5ENkQK8vVSK9v487
	OdCyYt543zmCF4xYE152NlnB2VQE2tKJXbhLPnBUiirANdapMul4/hBQ
X-Gm-Gg: AeBDieu2/CeqTJ3ai8rat2Goag9uinywQJ6puXzfn5NSAlGmKHw2yFW2ZTsDLJXd0LJ
	oi/3YXkli5jJZyg+XFDMS0pio5qVvv1KM2b5RLHXVZBwQg/GQjE82E9s5SHonJNUKHu7xPYrkCP
	U8kd5iMLeKbd4DVLfC8rkbTxcFybyd86DDRbQN53oh78eGEbK4M5dNrhryzDnTeko7eudbI/nyp
	RM9bhDlSCJImK14/WpkeGS9vgFM79heEx5LAc8xEMMjBk6IODy0avkRbahN9Nkh2rFUWV+E37uU
	fKA0HFFiE9swab8h0AgZ0gFRvhEMTL+4ik0YJEHDTHy39ksebcNg+eZ5yDXei5F86xnNSJg2KeU
	BQ45B/KyaqNgXwwsTBxBQbDRKLnNzCqIlNZNL6Sb2sZgQ68ZO8NO1huE6yXGKFPcuQxCOQst2O2
	EIKhDa2JCOintiIzYHn5dxuzyovpkSG3fFz70cI1W6O9zJpfFz+hKkNh+4hDfJRl668JsFZWHH6
	tenpbpdMwp3Ym/4VxWvjoKZhQ==
X-Received: by 2002:a05:7301:2b07:b0:2cf:3de7:22ad with SMTP id 5a478bee46e88-2e47901764fmr5596867eec.27.1776630698635;
        Sun, 19 Apr 2026 13:31:38 -0700 (PDT)
Received: from [192.168.1.18] (177-4-160-195.user3p.v-tal.net.br. [177.4.160.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm11419096eec.13.2026.04.19.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 13:31:38 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Sun, 19 Apr 2026 17:30:32 -0300
Subject: [PATCH 4/4] ALSA: usb-audio: Update US-16x08 EQ/comp shadow state
 after successful writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260419-usb-write-error-propagation-v1-4-5a3bd4a673ae@gmail.com>
References: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
In-Reply-To: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
To: Takashi Iwai <tiwai@suse.com>, 
 Chris J Arges <chris.j.arges@canonical.com>, 
 Detlef Urban <onkel@paraair.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5067;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=WebseC0n1uvq36U8Uba9vWPPZlTekN/7JlLiJTYMcdM=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJlPrWeJ/N2z4eH3vr+6/Y93lR9f4L+Ja9pB8yrZNQKex
 4MUlzLs6yhlYRDjYpAVU2RZnbTIck/Xg6v1cSs8YOawMoEMYeDiFICJxD9lZPh85nk2sySHo86e
 gp9ODstOnTpcsi3J2uzvAq28wF2z7VwYGZ6vmL/6QOei35vn7mRv+y1tvJE1NP8SX/bWDPs1Lf4
 S/xgA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238661-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 754C9425752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

snd_us16x08_comp_put() and snd_us16x08_eq_put() update their
software stores before sending the USB write. If the transfer
fails, later get callbacks report a value the hardware never
accepted.

Build the outgoing message from the current store plus the
pending value, then commit the store only after a successful
write.

Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/mixer_us16x08.c | 78 +++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index fcf7dfa4aa84..ebff185cbd2c 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -435,6 +435,7 @@ static int snd_us16x08_comp_put(struct snd_kcontrol *kcontrol,
 	int index = ucontrol->id.index;
 	char buf[sizeof(comp_msg)];
 	int val_idx, val;
+	int threshold, ratio, attack, release, gain, switch_on;
 	int err;
 
 	val = ucontrol->value.integer.value[0];
@@ -447,36 +448,61 @@ static int snd_us16x08_comp_put(struct snd_kcontrol *kcontrol,
 	/* new control value incl. bias*/
 	val_idx = elem->head.id - SND_US16X08_ID_COMP_BASE;
 
-	store->val[val_idx][index] = ucontrol->value.integer.value[0];
+	threshold = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_THRESHOLD)]
+		[index];
+	ratio = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_RATIO)][index];
+	attack = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_ATTACK)][index];
+	release = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_RELEASE)]
+		[index];
+	gain = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_GAIN)][index];
+	switch_on = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_SWITCH)]
+		[index];
+
+	switch (val_idx) {
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_THRESHOLD):
+		threshold = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_RATIO):
+		ratio = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_ATTACK):
+		attack = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_RELEASE):
+		release = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_GAIN):
+		gain = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_SWITCH):
+		switch_on = val;
+		break;
+	}
 
 	/* prepare compressor URB message from template  */
 	memcpy(buf, comp_msg, sizeof(comp_msg));
 
 	/* place comp values in message buffer watch bias! */
-	buf[8] = store->val[
-		COMP_STORE_IDX(SND_US16X08_ID_COMP_THRESHOLD)][index]
-		- SND_US16X08_COMP_THRESHOLD_BIAS;
-	buf[11] = ratio_map[store->val[
-		COMP_STORE_IDX(SND_US16X08_ID_COMP_RATIO)][index]];
-	buf[14] = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_ATTACK)][index]
-		+ SND_US16X08_COMP_ATTACK_BIAS;
-	buf[17] = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_RELEASE)][index]
-		+ SND_US16X08_COMP_RELEASE_BIAS;
-	buf[20] = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_GAIN)][index];
-	buf[26] = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_SWITCH)][index];
+	buf[8] = threshold - SND_US16X08_COMP_THRESHOLD_BIAS;
+	buf[11] = ratio_map[ratio];
+	buf[14] = attack + SND_US16X08_COMP_ATTACK_BIAS;
+	buf[17] = release + SND_US16X08_COMP_RELEASE_BIAS;
+	buf[20] = gain;
+	buf[26] = switch_on;
 
 	/* place channel selector in message buffer */
 	buf[5] = index + 1;
 
 	err = snd_us16x08_send_urb(chip, buf, sizeof(comp_msg));
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set compressor, err:%d\n", err);
+		return err;
 	}
 
+	store->val[val_idx][index] = val;
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
 	return 1;
 }
 
@@ -578,11 +604,10 @@ static int snd_us16x08_eq_put(struct snd_kcontrol *kcontrol,
 	/* copy URB buffer from EQ template */
 	memcpy(buf, eqs_msq, sizeof(eqs_msq));
 
-	store->val[b_idx][p_idx][index] = val;
-	buf[20] = store->val[b_idx][3][index];
-	buf[17] = store->val[b_idx][2][index];
-	buf[14] = store->val[b_idx][1][index];
-	buf[11] = store->val[b_idx][0][index];
+	buf[20] = p_idx == 3 ? val : store->val[b_idx][3][index];
+	buf[17] = p_idx == 2 ? val : store->val[b_idx][2][index];
+	buf[14] = p_idx == 1 ? val : store->val[b_idx][1][index];
+	buf[11] = p_idx == 0 ? val : store->val[b_idx][0][index];
 
 	/* place channel index in URB buffer */
 	buf[5] = index + 1;
@@ -592,14 +617,15 @@ static int snd_us16x08_eq_put(struct snd_kcontrol *kcontrol,
 
 	err = snd_us16x08_send_urb(chip, buf, sizeof(eqs_msq));
 
-	if (err > 0) {
-		/* store new value in EQ band cache */
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set eq param, err:%d\n", err);
+		return err;
 	}
 
+	store->val[b_idx][p_idx][index] = val;
+	/* store new value in EQ band cache */
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
 	return 1;
 }
 

-- 
2.53.0


