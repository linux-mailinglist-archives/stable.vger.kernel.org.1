Return-Path: <stable+bounces-264707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 68uyKjZ6MWptkQUAu9opvQ
	(envelope-from <stable+bounces-264707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:30:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7769226D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Sr2SJJU6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264707-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264707-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE2D73038F58
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18DF47277E;
	Tue, 16 Jun 2026 16:30:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1A466B79;
	Tue, 16 Jun 2026 16:30:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627442; cv=none; b=G8PyBU23EcUCtIq2+mwiUgPAYWO7PpB4H+Hzx/qohBwyQuftoLjrxKhWb2HVywlSLf2PSpcobdhZf+wyapOJwcntht+jDBnbX8LVVIbz+viQb+cBbWp2kN+toMG7DsCSgC4qpd9gy4crhpDrCKppK8vlJvNDVCCEU9960EBzD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627442; c=relaxed/simple;
	bh=F2ffQaJzh7XPFRtZftclpK0dVuo4ChXcNFVhFe3aCYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JurLpd1W+Q6hhFzmFzqX55avX9xql6ODMjKnnXk42GBikGO7L50BfGlcZ6WgWihBA4fOSAEFf6uHIXhz21X4Fyn7bPyVwku4Gw0xY5taweTulXF5L7euWnw83TVB7ZeeP5EhuE0cGKnLJTCTHjOjK+RJWS7Wlp8Qut5F8ZNp6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sr2SJJU6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287F01F000E9;
	Tue, 16 Jun 2026 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627441;
	bh=Iq4YLlUOYBFKKyfXYUKyoS0PgeQ5PqV4HcBfImJ3Y3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sr2SJJU63RFe2ATnpMhkajeUzL7+mNSf02wr1lyh7iUSJLCc8heHuUCdRl842H95d
	 4huI+dMKs6S1T+XoXYp+a7tzb7hA3SSu2NvPo5QoL66zknIWJmdCaG6qh2Hs/ZzBlh
	 RXO9c7OWM7mx/CuzSvltHoUTMS4Q95peipIuLo1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Zeng <kylebot@openai.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 144/261] ALSA: timer: Fix UAF at snd_timer_user_params()
Date: Tue, 16 Jun 2026 20:29:42 +0530
Message-ID: <20260616145051.753054636@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264707-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kylebot@openai.com,m:tiwai@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,suse.de:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,openai.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40D7769226D

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 053a401b592be424fea9d57c789f66cd5d8cec11 upstream.

At releasing a timer object, e.g. when a userspace timer
(CONFIG_SND_UTIMER) gets closed and snd_timer_free() is called, it
tries to detach the timer instances and release the resources.
However, it's still possible that other in-flight tasks are holding
the timer instance where the to-be-deleted timer object is associated,
and this may lead to racy accesses.

Fortunately, most of ioctls dealing with the timer instance list
already have the protection with register_mutex, and this also avoids
such races.  But, SNDRV_TIMER_IOCTL_PARAMS isn't protected, hence the
concurrent ioctl may lead to use-after-free.

This patch just adds the guard with register_mutex to protect
snd_timer_user_params() for covering the code path as a quick
workaround.  It's no hot-path but rather a rarely issued ioctl, so the
performance penalty doesn't matter.

Reported-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Kyle Zeng <kylebot@openai.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260606161145.1933447-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/timer.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1791,6 +1791,7 @@ static int snd_timer_user_params(struct
 	struct snd_timer *t;
 	int err;
 
+	guard(mutex)(&register_mutex);
 	tu = file->private_data;
 	if (!tu->timeri)
 		return -EBADFD;



