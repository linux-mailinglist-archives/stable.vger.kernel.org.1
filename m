Return-Path: <stable+bounces-243358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBBAI76q+GnXxgIAu9opvQ
	(envelope-from <stable+bounces-243358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:18:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B03464BF0C5
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF9DB3034047
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C3D3DE44B;
	Mon,  4 May 2026 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DerN77QU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD933DDDD6;
	Mon,  4 May 2026 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903680; cv=none; b=W90vYqfQ6X64YXP5vd92figCSpz3RWu/YLWsgRqvBhPihOwSjynhF6znF8hUhuepDHpHVtNny1JpqnmLySNtJPPtRNLkrwMAooKKuK+L1arWyLD8bLsvUYIUQZC2YplyQOCBArSioZgG31i/ct7t/Uv02tDvkzD3fDpQAvpWeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903680; c=relaxed/simple;
	bh=g2JBxknvJRqh/gFra0FIf9TtNmGF+sOG+/laPS6iEec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmq9CXxIJymB5D2sf4LIqOjMcwumX7+ReFwOe/gVAlZkDKOSKQ93bgPaEJwGlw0l3fxWZF3RcKhMtToyEUp31MYQ+4Q0iwcm1ApaHCDXpAfYgupQHsihNFGOATlJk0P87KX+x1ZrGqp3YuahX87wVVRpOnpz64sETa5mdwMVCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DerN77QU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C7CC2BCB8;
	Mon,  4 May 2026 14:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903680;
	bh=g2JBxknvJRqh/gFra0FIf9TtNmGF+sOG+/laPS6iEec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DerN77QUBqed2eocb4J+bQo18crDu6UmCOOIv0KerWsc1Q117UFAQMjW8UnbKAqM1
	 rSnIWi6i7WiPYjNYcpMax38yl6crqm4dBwVAAIvryR8Jp/Zkvj8q0ger9iVb9badg8
	 gZYm2Fgx044ZPicofVQ9iSdtYgOi6eY8PDqYvfXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 007/275] ALSA: usb-audio: Evaluate packsize caps at the right place
Date: Mon,  4 May 2026 15:49:07 +0200
Message-ID: <20260504135143.210600918@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B03464BF0C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243358-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.de:email,msgid.link:url]

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1375,9 +1375,6 @@ int snd_usb_endpoint_set_params(struct s
 		return -EINVAL;
 	}
 
-	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
-	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
-
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
 	ep->freqshift = INT_MIN;
@@ -1404,6 +1401,9 @@ int snd_usb_endpoint_set_params(struct s
 	ep->maxframesize = ep->maxpacksize / ep->cur_frame_bytes;
 	ep->curframesize = ep->curpacksize / ep->cur_frame_bytes;
 
+	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
+	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
+
 	err = update_clock_ref_rate(chip, ep);
 	if (err >= 0) {
 		ep->need_setup = false;



