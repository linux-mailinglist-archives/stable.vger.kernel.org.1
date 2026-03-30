Return-Path: <stable+bounces-231291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIWjNWr7ymmlBwYAu9opvQ
	(envelope-from <stable+bounces-231291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:38:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2C3362050
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B11A303013C
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201823E5573;
	Mon, 30 Mar 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbTH3+rj"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A493E4C9C
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909680; cv=none; b=eJ14ICgBtIe6kI2kDcnxmpF5A2c3+Trz2V2AxaRDgmVibmKuH4xUdTh1lTIUJD6X6pz+KRcii1Bc4Xlayh8MQw7th4ShtiIOuSDOBYswjiuxEgnpRHBvqXTwf06Svlfpb5lCUGUbfLsYFAH6pDgAdpG42XXYc+JEtnIzE06nxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909680; c=relaxed/simple;
	bh=b41s+FN6uiztHgjfDAeztxkSjquTUWhRy3iOENgs/Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jukPGXcWDQjNTTSP/mcaaPKqp/YyyJWKP44VIh4ps/Id78HDKOOQ+XGNz5+t2lgIDI7nAxoExfJr+EvFWYJ8QWoY+6ZU0OlLoE2ZrFsyI1ZZ7TVeEK5ZhUhWUrxxToA+os25ukEPByG6QHu9jPomn2juZpOyEqe3ew4a3XB1i10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbTH3+rj; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128ebee22caso553580c88.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 15:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909667; x=1775514467; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzyAsYuDiypzhr0nJOs3r8SDJ+17St3td4xXEfgjRxY=;
        b=TbTH3+rjx5y+kih/whZUfjoL6g+BfQGjVlgzZt+Apb4Qdr/XJee7ZDFMaXhoeX0uZK
         aIavg8gPXmCtOsIAASXJgpXUIYGCFraTcODu79tgdC4NvulN4McdRh/4oqRb6HxlvMi+
         91zxgd1D3rQEJPuW1+kxWbNNFI9/wieNE5yPp4l7QaDqXVFXr6eky6cfdXGtfNTBLjTo
         NTTqEOGN/h8CIBuJblLQ4f+QflH45rBYQoGHLXcPuDQrqSbcqR+jXSymTubp2z5SmRhQ
         zid5lHOraAwUW41/l3ErzRvcE+9MpOcB8LG43IosgDwa/U+TopiG+9WeMeIwtLLzWStq
         HXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909667; x=1775514467;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzyAsYuDiypzhr0nJOs3r8SDJ+17St3td4xXEfgjRxY=;
        b=jo0yusoiVfTB9w1Y99bO+86xUcXTMtLFO/NJ9EGomUNFu/2OroqomBb5dzQHqGqfUH
         /9fFY1vMrXI8taXIPPCHe0m1UO2edssCYablkr2xcMqGivANGShyHBa7Hi6Zaa/9HOsJ
         8V3K/OKtYZwX+xdjolJ+HXLOtNLqtCves2iy6f0guwL8EM/7MvAZHnnG/Mtnm81NQ6bQ
         E1J52e3Wqejy0m+4ONqWjV9mZvB4wbfIdmgYE79XVM1lcA/jg7cVXbMkIzmHDg387Zwf
         KozYYqLSD/xqtPpU68r3JjbGNw+5QYhlBZJRb/5Y1CH4qTNeKBL9aXS+wWSZq03zfNMo
         Ya6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDO/EMFzqR/I+vcE9CwJo71mIEBUnqstdmZsJBYmam1d3JT5H3JGPr0VStgbbJv1Adn5AqfPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAtR4EVoGuJOKC61k1uNOUzm6MYj+h5O+8t3DEE/ElvOZISxN
	sU5vkEl/IKBLATVc+dciOAzJ/UAyMfu1Kac+sKc1+4F4tKk8YS2EHwKY
X-Gm-Gg: ATEYQzyImJm2n/04+otUeUE8Wbz+xkb+KmWCnrGByq+ey8KpFelCb3Nv+Qqu31a3LOq
	FYH2NAUdeUjnycZ97dJO6XjWKFh42A8eS+ndjvr7QyH/5szRywL6vvoKEczvHlwX+BlMOM4BOqB
	HKYm8Ee/nSxwp4dx6JiSh/mj27SpMgoxGbRCtSYd3773+rZkdBXG7nOUo47fqEb6sHdouPytJbO
	NhTimM7tT9HFJzMDsCmxnECmQ5vYrSMj3plDwI9j+t0J0lHPuLv9IDdhqFqY8LCG/tuCulPqlPX
	FqruSkh/geX9fRfZV0P1W9mH7jplPJurifu8oe9Cd+SFEc51SS1ngyyLDX8Y94FFCxeIGP4K9pS
	7LQxxqWl31TbTg/7UTA1+82VQHG7cm9SCO63rjrdbnaGjaQUvZ/expjx36yyOtYlbwwllfZmKCK
	5kC0zaxUhAGaybVT4NlFnYgMVaRfPfaiGlNPG0VUnOCzdjUJebZ43hyo3zcRQ4pAGLXhLUjowIh
	xZDEZw3OZV+K1c=
X-Received: by 2002:a05:7022:b98:b0:127:33e0:ea33 with SMTP id a92af1059eb24-12ab28e4da2mr8360408c88.22.1774909666880;
        Mon, 30 Mar 2026 15:27:46 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-254.user3p.v-tal.net.br. [177.4.161.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ac09e3872sm10025298c88.13.2026.03.30.15.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:27:46 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 30 Mar 2026 19:27:28 -0300
Subject: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqCQBAG4FeROTewrWHUq0SH2fG3JkRjR0UQ3
 72tjt/l28iRDU7XaqOMxdzGoeB4qEifMjzA1hZTDLEJdbywjMIWPc3O2kMy+yQ9WHSyBXxq63Q
 OjWpAR+V4Z3S2/v7b/W+f0ws6fVPa9w/IFGDhgQAAAA==
X-Change-ID: 20260329-aoa-i2sbus-clear-stale-active-4d3b706cc0ef
To: Johannes Berg <johannes@sipsolutions.net>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5868;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=b41s+FN6uiztHgjfDAeztxkSjquTUWhRy3iOENgs/Tg=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmnftzW7coz2LdKSCMkoOHoyiO9dRvY1pz01FLj4lq+/
 Lb5kRbmjlIWBjEuBlkxRZbVSYss93Q9uFoft8IDZg4rE8gQBi5OAZhIegXDX/kpFfZ6GZadE9fv
 8FNZzT3n9Orsnx3/pK4eVmTpqVHbmcjIsNhoe9XiF2ffhTXUZn0Uf+J2ynvS9r3/y6sauGxuS0z
 W4gQA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-231291-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C2C3362050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The i2sbus PCM code uses pi->active to constrain the sibling stream to
an already prepared duplex format and rate in i2sbus_pcm_open().

That state is set from i2sbus_pcm_prepare(), but the current code only
clears it on close. As a result, the sibling stream can inherit stale
constraints after the prepared state has been torn down, or after a new
prepare attempt fails before completing.

Clear pi->active when hw_params() or hw_free() drops the prepared state,
clear it before starting a new prepare attempt, and set it again only
after prepare succeeds.

Replace the stale FIXME in the duplex constraint comment with
a description of the current driver behavior: i2sbus still programs a
single shared transport configuration for both directions, so mixed
formats are not supported in duplex mode.

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/aoa/soundbus/i2sbus/pcm.c | 53 ++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 97c807e67d56..47a89da43cff 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -165,17 +165,16 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	 * currently in use (if any). */
 	hw->rate_min = 5512;
 	hw->rate_max = 192000;
-	/* if the other stream is active, then we can only
-	 * support what it is currently using.
-	 * FIXME: I lied. This comment is wrong. We can support
-	 * anything that works with the same serial format, ie.
-	 * when recording 24 bit sound we can well play 16 bit
-	 * sound at the same time iff using the same transfer mode.
+	/* If the other stream is already prepared, keep this stream
+	 * on the same duplex format and rate.
+	 *
+	 * i2sbus_pcm_prepare() still programs one shared transport
+	 * configuration for both directions, so mixed duplex formats
+	 * are not supported here.
 	 */
 	if (other->active) {
-		/* FIXME: is this guaranteed by the alsa api? */
 		hw->formats &= pcm_format_to_bits(i2sdev->format);
-		/* see above, restrict rates to the one we already have */
+		/* Restrict rates to the one already in use. */
 		hw->rate_min = i2sdev->rate;
 		hw->rate_max = i2sdev->rate;
 	}
@@ -283,6 +282,22 @@ void i2sbus_wait_for_stop_both(struct i2sbus_dev *i2sdev)
 }
 #endif
 
+static void i2sbus_pcm_clear_active(struct i2sbus_dev *i2sdev, int in)
+{
+	struct pcm_info *pi;
+
+	guard(mutex)(&i2sdev->lock);
+
+	get_pcm_info(i2sdev, in, &pi, NULL);
+	pi->active = 0;
+}
+
+static inline int i2sbus_hw_params(struct snd_pcm_substream *substream, int in)
+{
+	i2sbus_pcm_clear_active(snd_pcm_substream_chip(substream), in);
+	return 0;
+}
+
 static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
 {
 	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
@@ -291,14 +306,25 @@ static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
 	get_pcm_info(i2sdev, in, &pi, NULL);
 	if (pi->dbdma_ring.stopping)
 		i2sbus_wait_for_stop(i2sdev, pi);
+	i2sbus_pcm_clear_active(i2sdev, in);
 	return 0;
 }
 
+static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream)
+{
+	return i2sbus_hw_params(substream, 0);
+}
+
 static int i2sbus_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	return i2sbus_hw_free(substream, 0);
 }
 
+static int i2sbus_record_hw_params(struct snd_pcm_substream *substream)
+{
+	return i2sbus_hw_params(substream, 1);
+}
+
 static int i2sbus_record_hw_free(struct snd_pcm_substream *substream)
 {
 	return i2sbus_hw_free(substream, 1);
@@ -335,7 +361,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		return -EINVAL;
 
 	runtime = pi->substream->runtime;
-	pi->active = 1;
+	pi->active = 0;
 	if (other->active &&
 	    ((i2sdev->format != runtime->format)
 	     || (i2sdev->rate != runtime->rate)))
@@ -444,9 +470,11 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 
 	/* early exit if already programmed correctly */
 	/* not locking these is fine since we touch them only in this function */
-	if (in_le32(&i2sdev->intfregs->serial_format) == sfr
-	 && in_le32(&i2sdev->intfregs->data_word_sizes) == dws)
+	if (in_le32(&i2sdev->intfregs->serial_format) == sfr &&
+	    in_le32(&i2sdev->intfregs->data_word_sizes) == dws) {
+		pi->active = 1;
 		return 0;
+	}
 
 	/* let's notify the codecs about clocks going away.
 	 * For now we only do mastering on the i2s cell... */
@@ -484,6 +512,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		if (cii->codec->switch_clock)
 			cii->codec->switch_clock(cii, CLOCK_SWITCH_SLAVE);
 
+	pi->active = 1;
 	return 0;
 }
 
@@ -728,6 +757,7 @@ static snd_pcm_uframes_t i2sbus_playback_pointer(struct snd_pcm_substream
 static const struct snd_pcm_ops i2sbus_playback_ops = {
 	.open =		i2sbus_playback_open,
 	.close =	i2sbus_playback_close,
+	.hw_params =	i2sbus_playback_hw_params,
 	.hw_free =	i2sbus_playback_hw_free,
 	.prepare =	i2sbus_playback_prepare,
 	.trigger =	i2sbus_playback_trigger,
@@ -796,6 +826,7 @@ static snd_pcm_uframes_t i2sbus_record_pointer(struct snd_pcm_substream
 static const struct snd_pcm_ops i2sbus_record_ops = {
 	.open =		i2sbus_record_open,
 	.close =	i2sbus_record_close,
+	.hw_params =	i2sbus_record_hw_params,
 	.hw_free =	i2sbus_record_hw_free,
 	.prepare =	i2sbus_record_prepare,
 	.trigger =	i2sbus_record_trigger,

---
base-commit: 46a6512f4a74dd7b18d9a455669c226843fc49ce
change-id: 20260329-aoa-i2sbus-clear-stale-active-4d3b706cc0ef

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


