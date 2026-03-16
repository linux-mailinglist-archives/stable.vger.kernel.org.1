Return-Path: <stable+bounces-225616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA+UCDIzuGmvaAEAu9opvQ
	(envelope-from <stable+bounces-225616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:43:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C019B29D944
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635643056D9A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237CC3CD8AD;
	Mon, 16 Mar 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPxyMExK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A43CD8AA
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679091; cv=none; b=iNP72mG+LVefP+WiNsoqRbhVEHahSppuG0PliKafacFQ8NS94dgpdj6xMEF8D1CGDLhJEaowZeFrU+9NFor6Qex5dhcBxs9WcPqwLll55BvaUzo3QxWSzAgW4OmhWLJU+fLZDg1q8yyfSg1qo9Jsa8lJRyMn02jV/qthdc48qbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679091; c=relaxed/simple;
	bh=DVfJys24aTuYn8DGas00CgrMVZhkhceJeAfOr1I57uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYmqq6w2kMoKSLfjnTGSHoBaqIuguaTPCKLGeEIKSuipRre7OZmkytX09y3+MNEcsTRPfUovCtFNkIx2bIUK25ZVrl/BrUv6OzLbfjWrk4fu8q1waKKFvTMS/VDG+2JfgbnRjjU/Xoi2EeGcZxTXRK/a/PQ0H2gRT7gqZ68rEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPxyMExK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39477C2BC9E;
	Mon, 16 Mar 2026 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773679091;
	bh=DVfJys24aTuYn8DGas00CgrMVZhkhceJeAfOr1I57uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPxyMExKx1OQ5w2p6Vj/bvK609tn+0v85T0RHkaVTd9p131U+8rxrvCI04cGUZJ8k
	 S/H9E794i2gyhWGnHT2IBR0JszqetBxpBWwPMRaTNvcFHp/Akt9N0dUSAi88fTGik3
	 Y0CzzvgMHPu6yBNSbEisdFxiYxEPn2DgtaLRYdwT7V292k9df8pojfSHUKNb/mHK0/
	 L6hinkZsq7l2/CpBrugzTncje7bQuIoRfaZiLekSloa7oy9iTgHV0EhMCrrmQC/Xky
	 IEeMuIHYSpG26oqTj+y3sBQN3UOsg2cdLZgqyPZYlbJ6gtZHWr2uiD3DYWMqj/osRC
	 SUF16qnDVydQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mehul Rao <mehulrao@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()
Date: Mon, 16 Mar 2026 12:38:08 -0400
Message-ID: <20260316163808.925386-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316163808.925386-1-sashal@kernel.org>
References: <2026031625-aerobics-detective-3f26@gregkh>
 <20260316163808.925386-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-225616-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C019B29D944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mehul Rao <mehulrao@gmail.com>

[ Upstream commit 9b1dbd69ba6f8f8c69bc7b77c2ce3b9c6ed05ba6 ]

In the drain loop, the local variable 'runtime' is reassigned to a
linked stream's runtime (runtime = s->runtime at line 2157).  After
releasing the stream lock at line 2169, the code accesses
runtime->no_period_wakeup, runtime->rate, and runtime->buffer_size
(lines 2170-2178) — all referencing the linked stream's runtime without
any lock or refcount protecting its lifetime.

A concurrent close() on the linked stream's fd triggers
snd_pcm_release_substream() → snd_pcm_drop() → pcm_release_private()
→ snd_pcm_unlink() → snd_pcm_detach_substream() → kfree(runtime).
No synchronization prevents kfree(runtime) from completing while the
drain path dereferences the stale pointer.

Fix by caching the needed runtime fields (no_period_wakeup, rate,
buffer_size) into local variables while still holding the stream lock,
and using the cached values after the lock is released.

Fixes: f2b3614cefb6 ("ALSA: PCM - Don't check DMA time-out too shortly")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
Link: https://patch.msgid.link/20260305193508.311096-1-mehulrao@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_native.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 256fcadf8e599..7be5f25612b95 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2146,6 +2146,10 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 	for (;;) {
 		long tout;
 		struct snd_pcm_runtime *to_check;
+		unsigned int drain_rate;
+		snd_pcm_uframes_t drain_bufsz;
+		bool drain_no_period_wakeup;
+
 		if (signal_pending(current)) {
 			result = -ERESTARTSYS;
 			break;
@@ -2165,16 +2169,25 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		snd_pcm_group_unref(group, substream);
 		if (!to_check)
 			break; /* all drained */
+		/*
+		 * Cache the runtime fields needed after unlock.
+		 * A concurrent close() on the linked stream may free
+		 * its runtime via snd_pcm_detach_substream() once we
+		 * release the stream lock below.
+		 */
+		drain_no_period_wakeup = to_check->no_period_wakeup;
+		drain_rate = to_check->rate;
+		drain_bufsz = to_check->buffer_size;
 		init_waitqueue_entry(&wait, current);
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&to_check->sleep, &wait);
 		snd_pcm_stream_unlock_irq(substream);
-		if (runtime->no_period_wakeup)
+		if (drain_no_period_wakeup)
 			tout = MAX_SCHEDULE_TIMEOUT;
 		else {
 			tout = 100;
-			if (runtime->rate) {
-				long t = runtime->buffer_size * 1100 / runtime->rate;
+			if (drain_rate) {
+				long t = drain_bufsz * 1100 / drain_rate;
 				tout = max(t, tout);
 			}
 			tout = msecs_to_jiffies(tout);
-- 
2.51.0


