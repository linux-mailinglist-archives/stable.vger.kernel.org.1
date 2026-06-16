Return-Path: <stable+bounces-264633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ae3MORJ6MWpgkQUAu9opvQ
	(envelope-from <stable+bounces-264633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:30:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B2692244
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:30:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=H7HLEADv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264633-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264633-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F0FD303F247
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90D046AEC5;
	Tue, 16 Jun 2026 16:22:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5461E8320;
	Tue, 16 Jun 2026 16:22:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626929; cv=none; b=iNFL31tHgIvAsjGlJzfwzx/EiAoFHqmnWIkfnKmEvBblPUIV4kLp9z6vteuBboxrAhCuKt1s55M+4ctyXLTxuEJut/AsRbaGqlkqJumxe9tkBsEZk5DpOwIaAO9Nafxf1XCl8qShAB/NdA/LeQrlJ6nZGWIMBEM5KbFlHvRdpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626929; c=relaxed/simple;
	bh=Wh6TXmoWIG9E8X2t9bmtjnQ/wJW30qxlkyiXjNwDFSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+Bep8u6UGwiDRBaEeO5eeFRhVuGihqCtMyx+Z0OmRx8STzw2c5N3WB3MLaVlnyCIxVwxSCWGkBg+7beD7IY6PNbh3mm5U64hT81JdvjpACFdZxQC7RyqYvfknvV/o9RY/sub64xoBYFXC32JxhKIUZ8oERRPwebY/8PWEWD9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H7HLEADv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE27D1F000E9;
	Tue, 16 Jun 2026 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626928;
	bh=gA3sqH9vbhftDkuQghgC96NnVh6uXLGA+GI/E9UZ5UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H7HLEADvLAqk3Mrw4gyMsB1Ckah2k2F9YxFQpFdfkzWuw7Fpk3ePdvI+7RTJBZlIH
	 pO2ksseLC1mWvxA/HhAFZZYLbOgAjYhRZgTq0KlTdhogVKxBIFM5NANQCCmYIdKh/d
	 DiggUrRggGYBVe6fOqk2fy1iPT6pHOFlAMaMKC0A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Zeng <kylebot@openai.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 064/261] ALSA: seq: dummy: fix UMP event stack overread
Date: Tue, 16 Jun 2026 20:28:22 +0530
Message-ID: <20260616145048.098750039@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264633-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kylebot@openai.com,m:tiwai@suse.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,vger.kernel.org:from_smtp,msgid.link:url,suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 600B2692244

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit 2b5ff4db5d7aa5b981d966df02e687f79ad7b311 ]

The dummy sequencer port forwards events by copying an incoming
struct snd_seq_event into a stack temporary, rewriting source and
destination, and dispatching the temporary to subscribers. That legacy
event storage is smaller than struct snd_seq_ump_event.

When a UMP event reaches the dummy client, the copy leaves the UMP flag
set but only provides legacy-sized stack storage. The subscriber
delivery path then uses snd_seq_event_packet_size() and copies a
UMP-sized packet from that stack object, reading past the end of the
temporary.

Use the existing union __snd_seq_event storage and copy the packet size
reported for the incoming event before rewriting the common routing
fields. This preserves the full UMP packet for UMP events while keeping
legacy event handling unchanged.

Fixes: 32cb23a0f911 ("ALSA: seq: dummy: Allow UMP conversion")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Link: https://patch.msgid.link/20260605080204.32045-1-kylebot@openai.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_dummy.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/core/seq/seq_dummy.c b/sound/core/seq/seq_dummy.c
index 783fc72c2ef673..bc11e4d1edd956 100644
--- a/sound/core/seq/seq_dummy.c
+++ b/sound/core/seq/seq_dummy.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include "seq_clientmgr.h"
+#include "seq_memory.h"
 #include <sound/initval.h>
 #include <sound/asoundef.h>
 
@@ -81,19 +82,21 @@ dummy_input(struct snd_seq_event *ev, int direct, void *private_data,
 	    int atomic, int hop)
 {
 	struct snd_seq_dummy_port *p;
-	struct snd_seq_event tmpev;
+	union __snd_seq_event tmpev;
+	size_t size;
 
 	p = private_data;
 	if (ev->source.client == SNDRV_SEQ_CLIENT_SYSTEM ||
 	    ev->type == SNDRV_SEQ_EVENT_KERNEL_ERROR)
 		return 0; /* ignore system messages */
-	tmpev = *ev;
+	size = snd_seq_event_packet_size(ev);
+	memcpy(&tmpev, ev, size);
 	if (p->duplex)
-		tmpev.source.port = p->connect;
+		tmpev.legacy.source.port = p->connect;
 	else
-		tmpev.source.port = p->port;
-	tmpev.dest.client = SNDRV_SEQ_ADDRESS_SUBSCRIBERS;
-	return snd_seq_kernel_client_dispatch(p->client, &tmpev, atomic, hop);
+		tmpev.legacy.source.port = p->port;
+	tmpev.legacy.dest.client = SNDRV_SEQ_ADDRESS_SUBSCRIBERS;
+	return snd_seq_kernel_client_dispatch(p->client, &tmpev.legacy, atomic, hop);
 }
 
 /*
-- 
2.53.0




