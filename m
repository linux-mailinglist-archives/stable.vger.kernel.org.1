Return-Path: <stable+bounces-258124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMTNDeYiG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:48:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F6F610680
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71D443001059
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9563546EA;
	Sat, 30 May 2026 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ONSfxpqc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51722342CA7;
	Sat, 30 May 2026 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163297; cv=none; b=dB2QXMn1gwhjKOUvTCXUDvLUx78jM/SXX2htoCENZza5b1bbzZ0KJwFFo7umqM+Rt66EjSli11Jjdl+lZKQGth7c25R12P1aEN0EOvQ8XUojGR9LtHIAMozSBn4zeVQxszGWVg5uJxsJRgxTKdVE4N7UxlljOejkWCF6VD992aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163297; c=relaxed/simple;
	bh=o+h4gdVSuugZGnGLKwYNpEDFtm6iRjBhC1N8IZRx2w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9A+zQHtxdLGso9bSvT3D2JvLehxjYrzfLj7e1LPHK3Dj5EFzfgdPB5OZxFr7mbZ8Q+YErOm0z964CehKsaijn8CCQ5PODYC55wEHKhG2C5lbyXVzVDzY9jtIF44n+bhl/0UueB7XgTNJ402fbl10yI+chYj5zobUivZJxTuMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ONSfxpqc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A6A1F00893;
	Sat, 30 May 2026 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163296;
	bh=spZEckbYR3s+E4ksPBiIHd0SBOvRp7FyZ2Pm8Wia3Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ONSfxpqcR11ahx5L58rLnY4S/LxnLAiv5E5gWZichPXR3MyuhEGDEk3JGBKbCioWR
	 vDjeSLGlzSFENFZ8GFbQONQHNiLmuENx8EPm8k06LnBTDfUeiEH4ADNhpi+xKRPSYe
	 3/vWdYWKsSrPC5xRsDYl7Krfz0P4EUBIfLCXo5Ug=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 215/776] ALSA: caiaq: Fix control_put() result and cache rollback
Date: Sat, 30 May 2026 17:58:49 +0200
Message-ID: <20260530160246.074713404@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258124-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: 42F6F610680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit a3542d1b30f92307f545f2def14e8d988dffdff0 upstream.

control_put() always returns 1 and updates cdev->control_state[]
before sending the USB command. It also ignores transport errors
from usb_bulk_msg(), snd_usb_caiaq_send_command(), and
snd_usb_caiaq_send_command_bank().

That breaks the ALSA .put() contract and can leave control_get()
reporting a cached value the device never accepted.

Return 0 for unchanged values, propagate transport failures,
and restore the cached byte when the write fails.

Fixes: 8e3cd08ed8e59 ("[ALSA] caiaq - add control API and more input features")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260417-caiaq-control-put-v1-1-c37826e92447@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/caiaq/control.c |   54 +++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 17 deletions(-)

--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -87,6 +87,7 @@ static int control_put(struct snd_kcontr
 	struct snd_usb_caiaqdev *cdev = caiaqdev(chip->card);
 	int pos = kcontrol->private_value;
 	int v = ucontrol->value.integer.value[0];
+	int ret;
 	unsigned char cmd;
 
 	switch (cdev->chip.usb_id) {
@@ -103,6 +104,10 @@ static int control_put(struct snd_kcontr
 
 	if (pos & CNT_INTVAL) {
 		int i = pos & ~CNT_INTVAL;
+		unsigned char old = cdev->control_state[i];
+
+		if (old == v)
+			return 0;
 
 		cdev->control_state[i] = v;
 
@@ -113,10 +118,11 @@ static int control_put(struct snd_kcontr
 			cdev->ep8_out_buf[0] = i;
 			cdev->ep8_out_buf[1] = v;
 
-			usb_bulk_msg(cdev->chip.dev,
-				     usb_sndbulkpipe(cdev->chip.dev, 8),
-				     cdev->ep8_out_buf, sizeof(cdev->ep8_out_buf),
-				     &actual_len, 200);
+			ret = usb_bulk_msg(cdev->chip.dev,
+					   usb_sndbulkpipe(cdev->chip.dev, 8),
+					   cdev->ep8_out_buf,
+					   sizeof(cdev->ep8_out_buf),
+					   &actual_len, 200);
 		} else if (cdev->chip.usb_id ==
 			USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_MASCHINECONTROLLER)) {
 
@@ -128,21 +134,36 @@ static int control_put(struct snd_kcontr
 				offset = MASCHINE_BANK_SIZE;
 			}
 
-			snd_usb_caiaq_send_command_bank(cdev, cmd, bank,
-					cdev->control_state + offset,
-					MASCHINE_BANK_SIZE);
+			ret = snd_usb_caiaq_send_command_bank(cdev, cmd, bank,
+							      cdev->control_state + offset,
+							      MASCHINE_BANK_SIZE);
 		} else {
-			snd_usb_caiaq_send_command(cdev, cmd,
-					cdev->control_state, sizeof(cdev->control_state));
+			ret = snd_usb_caiaq_send_command(cdev, cmd,
+							 cdev->control_state,
+							 sizeof(cdev->control_state));
 		}
-	} else {
-		if (v)
-			cdev->control_state[pos / 8] |= 1 << (pos % 8);
-		else
-			cdev->control_state[pos / 8] &= ~(1 << (pos % 8));
 
-		snd_usb_caiaq_send_command(cdev, cmd,
-				cdev->control_state, sizeof(cdev->control_state));
+		if (ret < 0) {
+			cdev->control_state[i] = old;
+			return ret;
+		}
+	} else {
+		int idx = pos / 8;
+		unsigned char mask = 1 << (pos % 8);
+		unsigned char old = cdev->control_state[idx];
+		unsigned char val = v ? (old | mask) : (old & ~mask);
+
+		if (old == val)
+			return 0;
+
+		cdev->control_state[idx] = val;
+		ret = snd_usb_caiaq_send_command(cdev, cmd,
+						 cdev->control_state,
+						 sizeof(cdev->control_state));
+		if (ret < 0) {
+			cdev->control_state[idx] = old;
+			return ret;
+		}
 	}
 
 	return 1;
@@ -640,4 +661,3 @@ int snd_usb_caiaq_control_init(struct sn
 
 	return ret;
 }
-



