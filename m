Return-Path: <stable+bounces-241357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FQOFiiB72moBwEAu9opvQ
	(envelope-from <stable+bounces-241357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:30:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9EC475349
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079A6309295E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B330EF8B;
	Mon, 27 Apr 2026 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATqcejAR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF024274B28
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303159; cv=none; b=r25zdmX/5V07T8gGtr8cb/mUapUBQkGIwX4kudPISJIOMTu/iS7GEUnYOmwM/i2JLWyCgGrSIfGCEuoO4EKmGTdv+lAocTzuu+onn0a3hGlZUzInjuFGG4wVTeIUsePzKrUx1cYpRIZQNU/Aek0BJtGbRhrOG6A0QtacRm5/75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303159; c=relaxed/simple;
	bh=fC0+D7BAjjHVQjEAav2fal2m6Gh3G3AOzYlIXZ4Vo70=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YKqZuP1Thtjkd0cYCUiqjLB0Vlfiaj46tvAHnFG42yVJsw6ZWAqGI5VFwGvOPpDzQ2ZHK6rTe0cYveAcnGZfTeHgsQCmZ/Nd0lQjioa1jgVYTbCwy38mXvWKY9XW1sAaoB/WZa3aG8yVXNZJmYz4lblX74DZzJWMYRXTC5SLJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATqcejAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6ECC19425;
	Mon, 27 Apr 2026 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777303159;
	bh=fC0+D7BAjjHVQjEAav2fal2m6Gh3G3AOzYlIXZ4Vo70=;
	h=Subject:To:Cc:From:Date:From;
	b=ATqcejARgDosj/ccxlCz7CyUKFqZESVSerUEmUJv2hevxE36V1+0vT9UIF2BttcZw
	 CfPiSmoLfIW7xpcZldbVjKrNypXw6Uns8cUibzqkz/tO6kZ13cQXYWyfo59r7SPQhd
	 NOsYxBeg6bEGhjB6MlACfHT2kosw1BvsZNO7aStE=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Evaluate packsize caps at the right place" failed to apply to 5.10-stable tree
To: tiwai@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 09:18:43 -0600
Message-ID: <2026042743-snooze-zoologist-8acf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC9EC475349
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241357-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 52521e8398839105ef8eb22b3f0993f9b0d11a57
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042743-snooze-zoologist-8acf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52521e8398839105ef8eb22b3f0993f9b0d11a57 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 10 Apr 2026 16:32:19 +0200
Subject: [PATCH] ALSA: usb-audio: Evaluate packsize caps at the right place

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

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index bf4401aba76c..6fbcb117555c 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1379,9 +1379,6 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 		return -EINVAL;
 	}
 
-	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
-	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
-
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
 	ep->freqshift = INT_MIN;
@@ -1408,6 +1405,9 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	ep->maxframesize = ep->maxpacksize / ep->cur_frame_bytes;
 	ep->curframesize = ep->curpacksize / ep->cur_frame_bytes;
 
+	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
+	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
+
 	err = update_clock_ref_rate(chip, ep);
 	if (err >= 0) {
 		ep->need_setup = false;


