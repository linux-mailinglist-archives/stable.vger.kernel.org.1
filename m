Return-Path: <stable+bounces-225548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LUQN4UTuGk7YwEAu9opvQ
	(envelope-from <stable+bounces-225548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:28:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA2C29B59D
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42AF83005327
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2363127FB18;
	Mon, 16 Mar 2026 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1w7Q0MED"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39D27EFEE
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671191; cv=none; b=tYDflgVVtBPPcZuCXmlzWdHVqHryWnb9ywKAorFpaBnF9e/G7X5BtCQtnRYe7CZ0w1pIwcYOz+gzvgKagIxI7jid53/Q/hDOZYIsKttyMM72G9u8J6ta1C+PNWi9jgmczdjcfXcZl+TIPPn0OGjVwaa0r3roH8USIaQQSzssV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671191; c=relaxed/simple;
	bh=eTRUeNJ5WCkDAhgUpr4cXaGoI6MOt1K1q6R3dPq7a0k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RqQtfbxvdB45pej1USQoy1SLJF5XushiOvwUw4ApiMqexaf1egy8g8VheQrwglCIb7EPp4mRAA+PL5Xv8fHZ8haQneagz/0ZPwbQ/5d+vvXTvMzMk3M2VXlUcLDgmCzZ0QRQ7xKmLj0dlyEZUFH32/AtF2U4JZOWbJvH0P4lCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1w7Q0MED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B07C19421;
	Mon, 16 Mar 2026 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773671191;
	bh=eTRUeNJ5WCkDAhgUpr4cXaGoI6MOt1K1q6R3dPq7a0k=;
	h=Subject:To:Cc:From:Date:From;
	b=1w7Q0MEDDedtzOgiqI8UapGQ9iNqkVRrcC036eVq+Uduf8sBwqXQCRfAouZBAxrY4
	 70xtnRKnKFVUufEdKjg2XFpib4CQS8OAq/5hwaLWcFWuZI10j59CuIam1fBnhSuFpk
	 u7UDjO8pEaW5nYQQamq+NeaoYV/4iwzB/ItG2NNE=
Subject: FAILED: patch "[PATCH] ALSA: pcm: fix use-after-free on linked stream runtime in" failed to apply to 6.1-stable tree
To: mehulrao@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Mar 2026 15:26:25 +0100
Message-ID: <2026031625-aerobics-detective-3f26@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225548-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,suse.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,msgid.link:url]
X-Rspamd-Queue-Id: DCA2C29B59D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9b1dbd69ba6f8f8c69bc7b77c2ce3b9c6ed05ba6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031625-aerobics-detective-3f26@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b1dbd69ba6f8f8c69bc7b77c2ce3b9c6ed05ba6 Mon Sep 17 00:00:00 2001
From: Mehul Rao <mehulrao@gmail.com>
Date: Thu, 5 Mar 2026 14:35:07 -0500
Subject: [PATCH] ALSA: pcm: fix use-after-free on linked stream runtime in
 snd_pcm_drain()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 67cf6a0e17ba..5a64453da728 100644
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


