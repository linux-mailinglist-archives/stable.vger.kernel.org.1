Return-Path: <stable+bounces-257263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F00KisZG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:06:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5760EE76
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E033073759
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFBE34D38B;
	Sat, 30 May 2026 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AoRmQe20"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7B21B191;
	Sat, 30 May 2026 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160389; cv=none; b=YaaAXCqdjVqUwBPwQ2+TKEykrSGNb0d/qtxIb4esD/X2GM+A1cabm5nobttbGriUaVA4rG4Y76JDSq6Xp0qPx8Re5TB4zpcEMWakBXzeqsDbc6oap1xSH+wJteJmtXd7X+0fUUcEYwBhDXnx+vzxRVG2PwvX40Kx2k9fXrrGC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160389; c=relaxed/simple;
	bh=4WEESecgNvMoEnqVLLo8n0Byx87LzBOQDNJ3rSisSOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jITj4ox/4SkV8altLgN0XnnfIDFEL44yLaF8NLymMG+lKHfv6m4acVsuw4BWKcbz+SOEkn0jr2MbbgOvxs+N33gKYDGAavhBcb/xcjNzcH1jII7rMg9JlCna1EliWc1MMO8xOn5mpxRqUuxH0+eR8itz/QUPL8LU8J5OwY/bnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AoRmQe20; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF541F00893;
	Sat, 30 May 2026 16:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160388;
	bh=cfw4dEzv7z1LeisX4dcJlfII3qrASyGk0Ex1HHrU/hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AoRmQe20hqFAkhqnih5DS/CJjQygqt+Rz0O/Xhb1wNM1tjyFxnDnOAHJhvv3lAd6n
	 PUpSsH1vq6vulguNOWNIHGSt7lHt9hidL/fOLDNmVAtizxUmFAZDIu6YLIPOgYcwub
	 91Wt09Y0PodhYwY3qHSzDzQgRO9uh5ZdsYwNbp8g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 324/969] sound: ua101: fix division by zero at probe
Date: Sat, 30 May 2026 17:57:28 +0200
Message-ID: <20260530160309.342280949@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257263-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 30E5760EE76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeungJu Cheon <suunj1331@gmail.com>

commit d1f73f169c1014463b5060e3f60813e13ddc7b87 upstream.

Add a missing sanity check for bNrChannels in detect_usb_format()
to prevent a division by zero in playback_urb_complete() and
capture_urb_complete().

USB core does not validate class-specific descriptor fields such
as bNrChannels, so drivers must verify them before use. If a
device provides bNrChannels = 0, frame_bytes becomes zero and is
later used as a divisor in the URB completion handlers, leading
to a kernel crash.

Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
Cc: stable@vger.kernel.org
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
Link: https://patch.msgid.link/20260426111239.103296-1-suunj1331@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/misc/ua101.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -994,6 +994,13 @@ static int detect_usb_format(struct ua10
 
 	ua->capture.channels = fmt_capture->bNrChannels;
 	ua->playback.channels = fmt_playback->bNrChannels;
+	if (!ua->capture.channels || !ua->playback.channels) {
+		dev_err(&ua->dev->dev,
+			"invalid channel count: capture %u, playback %u\n",
+			ua->capture.channels, ua->playback.channels);
+		return -EINVAL;
+	}
+
 	ua->capture.frame_bytes =
 		fmt_capture->bSubframeSize * ua->capture.channels;
 	ua->playback.frame_bytes =



