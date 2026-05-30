Return-Path: <stable+bounces-259212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPX9OhgyG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807D612BBE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F7A330D9D65
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6861D63E4;
	Sat, 30 May 2026 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uqLyUxyg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450D2E7398;
	Sat, 30 May 2026 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166983; cv=none; b=bnaaIaWwTUNFeMJn/296j4OnR4PfQ1Wgyky8K23CRgQ3e0+XOLszswAf1JRPsfpMTpSGPhA8tDjVPoHPsYskTcJ2qh/eWgSTqEa8R+q6owMfvRrXKBIE/PjRG8ULbMCnejTJw6XFcTx/zIUsbpEtBHcqv9vADKbtY+BggrGylQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166983; c=relaxed/simple;
	bh=3J0pvNm+fp3QiVVT8CdGyKbvC2ieFqULpNzYwM+0SNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMiXQqKRPLXd5238otNoXvg3pFDk+Mlv3LsWQW7uECAIT8UoQaEmYy4867JgwlQ5R/5PqWEJ796/Zd78dwXjUl39aJOl8y5HjVgSdWwUMzMR8l+iG/8jyiegsY0IGPLX4mK/bXEMzO8EsuKNAc6dzX3VJFZzzFNGohiF0Lfdy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uqLyUxyg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BEB1F00893;
	Sat, 30 May 2026 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166982;
	bh=O+VE/CuX6Bw2yc4O8j0Jh/mgacXuj3z30615mhefc0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uqLyUxygZNDCxUSyUyjp6zkUAzz0ecBCpXet19QMv4IbQWGGYA8yv4Lr98lCJJtgV
	 HQsUdH6jWhUZAlY5TR8DQWN/YNO0O6ENDZ2YNZNLSyep4Lg6hRqvNcXEHwRpBN/9K/
	 9PgnSS6oz6TLEZ35IJYUgAmLo1V32zuxdyJDPV3M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 529/589] ALSA: ua101: Reject too-short USB descriptors
Date: Sat, 30 May 2026 18:06:50 +0200
Message-ID: <20260530160238.573428134@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259212-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email]
X-Rspamd-Queue-Id: 8807D612BBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit b59d5c51bb328a60749b4dd5fe7e649bfb4089b4 upstream.

find_format_descriptor() walks the class-specific interface extras by
advancing with bLength. It rejects descriptors that extend past the
remaining buffer, but it does not reject descriptor lengths smaller than
a USB descriptor header.

Reject too-short descriptors before using bLength to advance the local
scan. This keeps the UA-101 parser robust against malformed descriptor
data and matches the usual USB descriptor walking rules.

Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260519-alsa-ua101-desc-len-v1-1-4307d1a5e054@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/misc/ua101.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -915,8 +915,9 @@ find_format_descriptor(struct usb_interf
 		struct uac_format_type_i_discrete_descriptor *desc;
 
 		desc = (struct uac_format_type_i_discrete_descriptor *)extra;
-		if (desc->bLength > extralen) {
-			dev_err(&interface->dev, "descriptor overflow\n");
+		if (desc->bLength < sizeof(struct usb_descriptor_header) ||
+		    desc->bLength > extralen) {
+			dev_err(&interface->dev, "invalid descriptor length\n");
 			return NULL;
 		}
 		if (desc->bLength == UAC_FORMAT_TYPE_I_DISCRETE_DESC_SIZE(1) &&



