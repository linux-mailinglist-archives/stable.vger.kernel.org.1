Return-Path: <stable+bounces-225623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPsvHqg0uGnXaQEAu9opvQ
	(envelope-from <stable+bounces-225623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:49:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D165129DA40
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABACD309F0B3
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6913CD8C5;
	Mon, 16 Mar 2026 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUKO1zSx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4D3CD8BA
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679504; cv=none; b=dPDiBqaTvS+kKM7s3qkoYpvlzGzLn6UlAlHg1iCjXvkPzPX+eqsxDYw2GazvegeEIUhVTRd0zxbt2JhcD18r0axVn5jHGPk2ACniLdshrSJjnv+T29grXofT20zkk4HX+2ejQCoi1MlAW4ngas8zl8LSj0RCyAsvWtY0rlNTcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679504; c=relaxed/simple;
	bh=jZgP9vRbn/1PtWSc68dmfAY0rH/kP7mm4Lhq1dZwZrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1rQrGkZou5TtcEt8u+kY8oBxCSG4QkdqLkTPd+g78yc7k5LOdXgU+THZscbMyXSdjb2zvYdiOF1Ow8sQHFnx1xphagqhXwDEmTEALCpNWkLvbhTFwKhQurhQCUCcm4dHwLAcsEOQdJwn2bnJdydKDBbkPqk8cXkOxriDE3irJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUKO1zSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6974DC2BC87;
	Mon, 16 Mar 2026 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773679503;
	bh=jZgP9vRbn/1PtWSc68dmfAY0rH/kP7mm4Lhq1dZwZrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUKO1zSxhSPjWmw3bANKzs2NOLX+6QSJJ2BfFDhhvDsW4uX5oQeqJ1klVEFm/N658
	 BVRltk5AEbQqTP2C8XT4JoDNnqf8EE3fSGDVEcXzwq6QAJKxJykYWHWHCRK2EZXwpY
	 wKhxEQYAawqf6OhwKHCa4A8qTTL4O+67aGAABDaT2zT94HbOrk8uDgtEDDQWnEnNys
	 dvSNMWH+CC3Oud7EMBooCN4F5+Ee+kwS1IrDZmZUpt7Ru/YLe4gM4mt/BIMqpYl4P5
	 lAsYbVFfgbsjyx2uhqn6VDHX7peUAAl4SgNaEpTPDy4wLuqc6kp7Ce+d1djoq3IqL7
	 GbTVdVjvg5DUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mehul Rao <mehulrao@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()
Date: Mon, 16 Mar 2026 12:44:59 -0400
Message-ID: <20260316164459.944343-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316164459.944343-1-sashal@kernel.org>
References: <2026031626-glowworm-observant-79df@gregkh>
 <20260316164459.944343-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225623-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: D165129DA40
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
index f55f476b0a148..1680f542e79ab 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2144,6 +2144,10 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
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
@@ -2163,16 +2167,25 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
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


