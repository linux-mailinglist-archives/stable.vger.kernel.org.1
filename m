Return-Path: <stable+bounces-246876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBa3GDeVBGqrLgIAu9opvQ
	(envelope-from <stable+bounces-246876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:13:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4364535DA4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF5D318407A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035431197B;
	Wed, 13 May 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy3s3tj7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF930FC21
	for <stable@vger.kernel.org>; Wed, 13 May 2026 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681375; cv=none; b=DK9EOJ9SjuoXh82+Fy765enmm9yodNg+AxJOKNuDpBaJLKrlYYC4BJZzSK32bPxSxWu8OvcEfieaZNOzOy7WHazkLwydsl8rUmxDyeKHIDF1aP9CZihOmEJPNl6cUd8XSAagD7X8AD+P2gi05jIdcZa3N0DB4P6hmDMHaLhOC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681375; c=relaxed/simple;
	bh=Jt72KMKDAtatV1TAyYusPXwAKB4Pds8ft6HQvXf7efg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2gGzxpnkD/5+EG0Wqoy0BXXLaDg2gF90JUs/wjKXzkE7WCvX8P1LVsK885cRRyqSX2mQrv0cprfkl+rQdTbpj8VljjBiDpRmhaIa59V/PhJhmJb8EQ6OpH12J15P4E9+wvC/1Ozz8WIKzByaJ6TDalScLKHRch5ueInUFEe9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy3s3tj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D676CC2BCB7;
	Wed, 13 May 2026 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778681375;
	bh=Jt72KMKDAtatV1TAyYusPXwAKB4Pds8ft6HQvXf7efg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xy3s3tj7+lTOt44uYmLaczyGnz3cA3PcgyPbmbIJsRz8DPKfA7bvTF6VI9KczmCeO
	 RyfJHVlbKVz0fwBTak/roclteu+u8fWFLxOA6ShgVoKKB1Fkw9HiSQEl0rS2d8ywSV
	 ev/fPZeZ7PjBl4dcf8SxMSDkLIc6MfTXjEEjeDs1hB00/E6/m+7RlVVeH2WoN1RRD0
	 y7z3qD+nyl6zXV90xg4wtGAnekHLOqxyNqV4h81kskuzSvmUdmhmY61JJtXFj0cHJV
	 JilTYK4af5KMdARPOO677RrFfG7hrzGGDUqTUCY1df2pBR+6PRs4CNF4E8VBBbTbLp
	 34duJwRKSS8Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ALSA: seq: Fix UMP group 16 filtering
Date: Wed, 13 May 2026 10:09:32 -0400
Message-ID: <20260513140932.3747146-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513140932.3747146-1-sashal@kernel.org>
References: <2026051221-campus-grafting-01b1@gregkh>
 <20260513140932.3747146-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4364535DA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246876-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,suse.de:email]
X-Rspamd-Action: no action

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 92429ca999db99febced82f23362a71b2ba4c1d8 ]

The sequencer UAPI defines group_filter as an unsigned int bitmap.
Bit 0 filters groupless messages and bits 1-16 filter UMP groups 1-16.

The internal snd_seq_client storage is only unsigned short, so bit 16
is truncated when userspace sets the filter. The same truncation affects
the automatic UMP client filter used to avoid delivery to inactive
groups, so events for group 16 cannot be filtered.

Store the internal bitmap as unsigned int and keep both userspace-provided
and automatically generated values limited to the defined UAPI bits.

Fixes: d2b706077792 ("ALSA: seq: Add UMP group filter")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260506-alsa-seq-ump-group16-filter-v1-1-b75160bf6993@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_clientmgr.c  | 2 +-
 sound/core/seq/seq_clientmgr.h  | 5 ++++-
 sound/core/seq/seq_ump_client.c | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 80b73bb199edd..0ddf84b36c13f 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1328,7 +1328,7 @@ static int snd_seq_ioctl_set_client_info(struct snd_seq_client *client,
 	if (client->user_pversion >= SNDRV_PROTOCOL_VERSION(1, 0, 3))
 		client->midi_version = client_info->midi_version;
 	memcpy(client->event_filter, client_info->event_filter, 32);
-	client->group_filter = client_info->group_filter;
+	client->group_filter = client_info->group_filter & SND_SEQ_GROUP_FILTER_MASK;
 
 	/* notify the change */
 	snd_seq_system_client_ev_client_change(client->number);
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index 915b1017286e7..05c8758f50ad8 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -14,6 +14,9 @@
 
 /* client manager */
 
+#define SND_SEQ_GROUP_FILTER_MASK	GENMASK(SNDRV_UMP_MAX_GROUPS, 0)
+#define SND_SEQ_GROUP_FILTER_GROUPS	GENMASK(SNDRV_UMP_MAX_GROUPS, 1)
+
 struct snd_seq_user_client {
 	struct file *file;	/* file struct of client */
 	/* ... */
@@ -40,7 +43,7 @@ struct snd_seq_client {
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
 	DECLARE_BITMAP(event_filter, 256);
-	unsigned short group_filter;
+	unsigned int group_filter;
 	snd_use_lock_t use_lock;
 	int event_lost;
 	/* ports */
diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index 27c4dd9940ffb..d39cea7f341d4 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -369,7 +369,7 @@ static void setup_client_group_filter(struct seq_ump_client *client)
 	cptr = snd_seq_kernel_client_get(client->seq_client);
 	if (!cptr)
 		return;
-	filter = ~(1U << 0); /* always allow groupless messages */
+	filter = SND_SEQ_GROUP_FILTER_GROUPS; /* always allow groupless messages */
 	for (p = 0; p < SNDRV_UMP_MAX_GROUPS; p++) {
 		if (client->ump->groups[p].active)
 			filter &= ~(1U << (p + 1));
-- 
2.53.0


