Return-Path: <stable+bounces-257129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDGEDFwWG2rJ/AgAu9opvQ
	(envelope-from <stable+bounces-257129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:54:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2720760E976
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4966E301082B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20333A8730;
	Sat, 30 May 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bGBD96zs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E233FE15;
	Sat, 30 May 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159906; cv=none; b=Wuu1Dh6Z0UxzFNsIdMtQyCYK6hmRaSzgHS7wtygqaRPUj3bMIHGS+OdGXMd2JwW6mHc05dVSqtGOHsj1CbW59XNe0Udc8O/4bfDiS94VkiSMNlmZV24aJqD/vqivkIDmQUYBUXYduMJ/ny9stVwFRmqVVV1wjHbfJxjqIn2ZdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159906; c=relaxed/simple;
	bh=zkNJ6qJcJlcjoZWIaIo8+idWOSeGlzwukFn/RQENf3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRXngzZgkW2h1fxwdEIKlDIt1HujYfBH+S2w248aQPYsiLfKajCu6uvgQt8Yux/HfAlI65ITG219G+mPU7yUU049mvww0W1PINfGyxoJFk7AZ2MBsnZDqAduTwExshEv2cznNM1T6YC9Fs0aG7nq8hT3Oc16t1Flf26MCEqH61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bGBD96zs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87381F00898;
	Sat, 30 May 2026 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780159905;
	bh=b6+JD0+ka5ZarM1X14xWF0XZc8onqeNBa3UGySIj9n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGBD96zsSraxTUerdGxXf+VDvQzXwxJSyUs0vVp2iQKKUueiiLw/xTkXF7ITfDJ6T
	 b5UfMSxMwMMJx1uvAPiFNBfMjQToiF0VjhVsvpDraJyyXp+l8FUo1bFQqTIIRG/0NA
	 3zqI9EJ8JY42ItBRz7AVzrcx4xxeSxenpWJo0mOM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 163/969] ALSA: usb-audio: Evaluate packsize caps at the right place
Date: Sat, 30 May 2026 17:54:47 +0200
Message-ID: <20260530160305.025690700@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-257129-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2720760E976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 52521e8398839105ef8eb22b3f0993f9b0d11a57 upstream.

We introduced the upper bound checks of the packet sizes by the
ep->maxframesize for avoiding the URB submission errors.  However, the
check was applied at an incorrect place in the function
snd_usb_endpoint_set_params() where ep->maxframesize isn't defined
yet; the value is defined at a bit later position.  So this ended up
with a failure at the first run while the second run works.

For fixing it, move the check at the correct place, right after the
calculation of ep->maxframesize in the same function.

Fixes: 7fe8dec3f628 ("ALSA: usb-audio: Cap the packet size pre-calculations")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221292
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260410143220.1676344-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/endpoint.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1393,9 +1393,6 @@ int snd_usb_endpoint_set_params(struct s
 		goto unlock;
 	}
 
-	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
-	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
-
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
 	ep->freqshift = INT_MIN;
@@ -1422,6 +1419,9 @@ int snd_usb_endpoint_set_params(struct s
 	ep->maxframesize = ep->maxpacksize / ep->cur_frame_bytes;
 	ep->curframesize = ep->curpacksize / ep->cur_frame_bytes;
 
+	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
+	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
+
 	err = update_clock_ref_rate(chip, ep);
 	if (err >= 0) {
 		ep->need_setup = false;



