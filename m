Return-Path: <stable+bounces-260381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xYehI+NVIWoaEAEAu9opvQ
	(envelope-from <stable+bounces-260381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:39:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F221563F1E2
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:39:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tXrGJcqx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260381-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260381-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D95743012BC3
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176B53E5A15;
	Thu,  4 Jun 2026 10:32:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5283C09EB
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:32:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569154; cv=none; b=O8NrmV+y8OlE3bc0Deb7jLbW9rvHnjf41mF/r8//5hteCSn8idY6actPRQh8S85Oem/sw58Cji7e/ZTYTSHeHNA/5ZY/L2shhp54/SjBbaZPEoB60d/qysLF+TlSWZUUpcAlzpX00llKpXVQbwmWD7v/cd8xUkGbAMkHzOnA4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569154; c=relaxed/simple;
	bh=y0gUNh3OEoPH9V6GRgQ9Kskr11ZKUDW5nmkGN+WIgOc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eJHfnpRGpI52oYWAMzBy1YX1/uw9zCtI4+dGFrp1ZFgN+cA9F9AQTqkz1o09xNJfKzekWImjJfz467EtYZAb2IyxxXCSD/VjlyombNtz2kpZKmms8vaQgpq9300JSpTckg/zO6srWUEVts4BHR8DJ/SgM7FWgVi0c4cxIB0Q4Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXrGJcqx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFCA1F00893;
	Thu,  4 Jun 2026 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569153;
	bh=eB2eznbY2IYMROFmQ7DDbIOKvJ2AhqK7AWIlkIwPaec=;
	h=Subject:To:Cc:From:Date;
	b=tXrGJcqxCaeGVxp/1+n6GGXdq8B+2FnBGmNhUAe/CTSJuDMHdNywNq6QOOn/j92oB
	 IoWRr67Jvimt5WdVzDag0H+I5H12PcI4+9Ouo9xWCU0OpH9mSKB9DTw/9o9DmOS8Jj
	 eFrmRlmqfAkEwSSpEdoasTaSwSY3N3RbTkwwl7q0=
Subject: FAILED: patch "[PATCH] ALSA: firewire-motu: Protect register DSP event queue" failed to apply to 6.12-stable tree
To: cassiogabrielcontato@gmail.com,o-takashi@sakamocchi.jp,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:31:36 +0200
Message-ID: <2026060436-lumpish-nemeses-2d25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260381-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cassiogabrielcontato@gmail.com,m:o-takashi@sakamocchi.jp,m:tiwai@suse.de,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,sakamocchi.jp,suse.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F221563F1E2


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 98fb1c1bb11e29eb609b7200a25e136e05aa4498
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060436-lumpish-nemeses-2d25@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98fb1c1bb11e29eb609b7200a25e136e05aa4498 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 21 May 2026 08:01:23 -0300
Subject: [PATCH] ALSA: firewire-motu: Protect register DSP event queue
 positions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The register DSP event queue is updated under parser->lock, but
snd_motu_register_dsp_message_parser_count_event() reads pull_pos and
push_pos without the lock.
snd_motu_register_dsp_message_parser_copy_event() also reads both queue
positions before taking the lock.

Protect these accesses with parser->lock as well. This keeps the hwdep
poll/read path consistent with the producer side and with the cached
meter/parameter accessors.

Fixes: 634ec0b2906e ("ALSA: firewire-motu: notify event for parameter change in register DSP model")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260521-alsa-firewire-motu-event-locking-v1-1-708e1c2b5e56@gmail.com

diff --git a/sound/firewire/motu/motu-register-dsp-message-parser.c b/sound/firewire/motu/motu-register-dsp-message-parser.c
index a8053e3ef065..4ec23e6880d9 100644
--- a/sound/firewire/motu/motu-register-dsp-message-parser.c
+++ b/sound/firewire/motu/motu-register-dsp-message-parser.c
@@ -386,6 +386,8 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 {
 	struct msg_parser *parser = motu->message_parser;
 
+	guard(spinlock_irqsave)(&parser->lock);
+
 	if (parser->pull_pos > parser->push_pos)
 		return EVENT_QUEUE_SIZE - parser->pull_pos + parser->push_pos;
 	else
@@ -395,13 +397,14 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 bool snd_motu_register_dsp_message_parser_copy_event(struct snd_motu *motu, u32 *event)
 {
 	struct msg_parser *parser = motu->message_parser;
-	unsigned int pos = parser->pull_pos;
-
-	if (pos == parser->push_pos)
-		return false;
+	unsigned int pos;
 
 	guard(spinlock_irqsave)(&parser->lock);
 
+	if (parser->pull_pos == parser->push_pos)
+		return false;
+
+	pos = parser->pull_pos;
 	*event = parser->event_queue[pos];
 
 	++pos;


