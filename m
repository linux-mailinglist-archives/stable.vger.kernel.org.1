Return-Path: <stable+bounces-265260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HDxkBZuHMWoXlwUAu9opvQ
	(envelope-from <stable+bounces-265260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:27:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6E69326B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:27:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DNKovTCg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265260-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265260-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D670304AE59
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA0478E2B;
	Tue, 16 Jun 2026 17:18:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AC4657D0;
	Tue, 16 Jun 2026 17:18:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630297; cv=none; b=Fb3KCJA7tD8qkOwA65ciO4T5ATOOfiB7l5P7PHvLEFNG+GNKXkiLXaUwVWI6YyuS9cuWlAZZsO4CpWvJVCw5Iz+YUzqCgJFrM42Rw+Wa8J3YzMJXeAtEWEY/k/LZB3nZgNMmFUty34ZozQ+mTFvtZ2tjfVIxuLN7eIUMnaWLAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630297; c=relaxed/simple;
	bh=cFqaA0iGsj57JQv//R+7D/nvXHqA0TIFk2vLKCu1f/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPpHmaEFH7NT318n2ZV8Y3rXRqhAcahp9SExd31I36DVBZjzr7fR7ZM4TL745gqZW8sqqgKCLe1qsw0LkCo8DFiqKXCwcbpwFmW6sS2y4VkiOWgmgnYsIMFXBpFp+kQ9NE3A9PwCNKDOrpWDn92uU6nOUou9cLOa2IMuOIfJwTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNKovTCg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECE41F000E9;
	Tue, 16 Jun 2026 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630296;
	bh=1fiirbpAbdY6izSbk3cTrb1qTO0o1Ya80Vpf1XqSUAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DNKovTCgfJ+9yNPN3B8Gb7bdp95/qL1F+N/X1Ic8rjm1/VxqgFMMoMNzjsmQa9t9U
	 +YI6Vhz50SspgaQpcg2YBrUufJbd8EpMDExVLh2Fx1lzp+CFzMK2drnoiprfiWHOb0
	 kkSx2TtL4pXeDXNGs+1VADhq7fRp0OxSzS9KBTEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 415/452] ALSA: firewire-motu: Protect register DSP event queue positions
Date: Tue, 16 Jun 2026 20:30:42 +0530
Message-ID: <20260616145138.581454539@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,sakamocchi.jp,suse.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-265260-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:cassiogabrielcontato@gmail.com,m:o-takashi@sakamocchi.jp,m:tiwai@suse.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34D6E69326B

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 98fb1c1bb11e29eb609b7200a25e136e05aa4498 ]

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
[ converted copy_event() from manual spin_lock_irqsave/spin_unlock_irqrestore to guard(spinlock_irqsave) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/firewire/motu/motu-register-dsp-message-parser.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/sound/firewire/motu/motu-register-dsp-message-parser.c
+++ b/sound/firewire/motu/motu-register-dsp-message-parser.c
@@ -393,6 +393,8 @@ unsigned int snd_motu_register_dsp_messa
 {
 	struct msg_parser *parser = motu->message_parser;
 
+	guard(spinlock_irqsave)(&parser->lock);
+
 	if (parser->pull_pos > parser->push_pos)
 		return EVENT_QUEUE_SIZE - parser->pull_pos + parser->push_pos;
 	else
@@ -402,14 +404,14 @@ unsigned int snd_motu_register_dsp_messa
 bool snd_motu_register_dsp_message_parser_copy_event(struct snd_motu *motu, u32 *event)
 {
 	struct msg_parser *parser = motu->message_parser;
-	unsigned int pos = parser->pull_pos;
-	unsigned long flags;
+	unsigned int pos;
 
-	if (pos == parser->push_pos)
-		return false;
+	guard(spinlock_irqsave)(&parser->lock);
 
-	spin_lock_irqsave(&parser->lock, flags);
+	if (parser->pull_pos == parser->push_pos)
+		return false;
 
+	pos = parser->pull_pos;
 	*event = parser->event_queue[pos];
 
 	++pos;
@@ -417,7 +419,5 @@ bool snd_motu_register_dsp_message_parse
 		pos = 0;
 	parser->pull_pos = pos;
 
-	spin_unlock_irqrestore(&parser->lock, flags);
-
 	return true;
 }



