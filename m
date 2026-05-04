Return-Path: <stable+bounces-243017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNbbCDaV+GkQwwIAu9opvQ
	(envelope-from <stable+bounces-243017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:46:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5124BD2E3
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3850B3008443
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E33D333D;
	Mon,  4 May 2026 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ClBQQHOk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870523A9624
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898758; cv=none; b=kKyIMKRTzCrXV8UHyNLRqzA78Se1f0DoRA9BbBfB9wDjgGEfkv2FXxOVmf5JkKCvnHc1EeQ1wevHk9TmL72jZFtpTlaLYdi/yBhN4cc10TOao7zY4fxL45Lw6YdFpxyO7p+zBLQDVeW3VAI5J90ajq8Fvp/hAe/hMtO3tqmeo4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898758; c=relaxed/simple;
	bh=6vvhT6TC5E7Dpp36SNT/WNBGpuBA9CZhpqq9H2dmPZY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dm94uj6WrZwVoT3oBeA1e6aEabyVsFJUypQYHqNLTGq50lkHz//DGph0bYb6xK1U7b+97VsAdJ/pnTPT+zU4faWG11W5vgpDLkfszCjHIHFnTzW5C06F0ILQRRVFep4svPorKgwpCmWu5mtt38/UR8KsOAGraUYTmdggJ5WJ+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ClBQQHOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D703EC2BCF4;
	Mon,  4 May 2026 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777898758;
	bh=6vvhT6TC5E7Dpp36SNT/WNBGpuBA9CZhpqq9H2dmPZY=;
	h=Subject:To:Cc:From:Date:From;
	b=ClBQQHOk/xump+dyLbcZhWoqx/CbIo+faIfjJQReoljwF4XEmIGFk+fXbQZapBmjk
	 OVjMw4TSqOqmA7cUEZxZePA7KqaUMXOiup7PUMXPuOCEcXJqtpl1RXs2cp+SrQRgyS
	 Z7Hb1BDWmlK2oCSzob6O80Z0F7UWWzyKkS+KuPZw=
Subject: FAILED: patch "[PATCH] ALSA: aloop: Fix peer runtime UAF during format-change stop" failed to apply to 6.6-stable tree
To: cassiogabrielcontato@gmail.com,tiwai@suse.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 14:45:45 +0200
Message-ID: <2026050445-detention-cussed-a8c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B5124BD2E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243017-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,suse.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:dkim,syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e5c33cdc6f402eab8abd36ecf436b22c9d3a8aff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050445-detention-cussed-a8c0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e5c33cdc6f402eab8abd36ecf436b22c9d3a8aff Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Fri, 24 Apr 2026 09:48:41 -0300
Subject: [PATCH] ALSA: aloop: Fix peer runtime UAF during format-change stop
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

loopback_check_format() may stop the capture side when playback starts
with parameters that no longer match a running capture stream. Commit
826af7fa62e3 ("ALSA: aloop: Fix racy access at PCM trigger") moved
the peer lookup under cable->lock, but the actual snd_pcm_stop() still
runs after dropping that lock.

A concurrent close can clear the capture entry from cable->streams[] and
detach or free its runtime while the playback trigger path still holds a
stale peer substream pointer.

Keep a per-cable count of in-flight peer stops before dropping
cable->lock, and make free_cable() wait for those stops before
detaching the runtime. This preserves the existing behavior while
making the peer runtime lifetime explicit.

Reported-by: syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8fa95c41eafbc9d2ff6f
Fixes: 597603d615d2 ("ALSA: introduce the snd-aloop module for the PCM loopback")
Cc: stable@vger.kernel.org
Suggested-by: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260424-alsa-aloop-peer-stop-uaf-v2-1-94e68101db8a@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index aa0d2fcb1a18..a37a1695f51c 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -99,6 +99,9 @@ struct loopback_ops {
 struct loopback_cable {
 	spinlock_t lock;
 	struct loopback_pcm *streams[2];
+	/* in-flight peer stops running outside cable->lock */
+	atomic_t stop_count;
+	wait_queue_head_t stop_wait;
 	struct snd_pcm_hardware hw;
 	/* flags */
 	unsigned int valid;
@@ -366,8 +369,11 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 				return 0;
 			if (stream == SNDRV_PCM_STREAM_CAPTURE)
 				return -EIO;
-			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING)
+			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING) {
+				/* close must not free the peer runtime below */
+				atomic_inc(&cable->stop_count);
 				stop_capture = true;
+			}
 		}
 
 		setup = get_setup(dpcm_play);
@@ -396,8 +402,11 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 		}
 	}
 
-	if (stop_capture)
+	if (stop_capture) {
 		snd_pcm_stop(dpcm_capt->substream, SNDRV_PCM_STATE_DRAINING);
+		if (atomic_dec_and_test(&cable->stop_count))
+			wake_up(&cable->stop_wait);
+	}
 
 	return 0;
 }
@@ -1049,23 +1058,29 @@ static void free_cable(struct snd_pcm_substream *substream)
 	struct loopback *loopback = substream->private_data;
 	int dev = get_cable_index(substream);
 	struct loopback_cable *cable;
+	struct loopback_pcm *dpcm;
+	bool other_alive;
 
 	cable = loopback->cables[substream->number][dev];
 	if (!cable)
 		return;
-	if (cable->streams[!substream->stream]) {
-		/* other stream is still alive */
-		guard(spinlock_irq)(&cable->lock);
-		cable->streams[substream->stream] = NULL;
-	} else {
-		struct loopback_pcm *dpcm = substream->runtime->private_data;
 
-		if (cable->ops && cable->ops->close_cable && dpcm)
-			cable->ops->close_cable(dpcm);
-		/* free the cable */
-		loopback->cables[substream->number][dev] = NULL;
-		kfree(cable);
+	scoped_guard(spinlock_irq, &cable->lock) {
+		cable->streams[substream->stream] = NULL;
+		other_alive = cable->streams[!substream->stream];
 	}
+
+	/* Pair with the stop_count increment in loopback_check_format(). */
+	wait_event(cable->stop_wait, !atomic_read(&cable->stop_count));
+	if (other_alive)
+		return;
+
+	dpcm = substream->runtime->private_data;
+	if (cable->ops && cable->ops->close_cable && dpcm)
+		cable->ops->close_cable(dpcm);
+	/* free the cable */
+	loopback->cables[substream->number][dev] = NULL;
+	kfree(cable);
 }
 
 static int loopback_jiffies_timer_open(struct loopback_pcm *dpcm)
@@ -1260,6 +1275,8 @@ static int loopback_open(struct snd_pcm_substream *substream)
 			goto unlock;
 		}
 		spin_lock_init(&cable->lock);
+		atomic_set(&cable->stop_count, 0);
+		init_waitqueue_head(&cable->stop_wait);
 		cable->hw = loopback_pcm_hardware;
 		if (loopback->timer_source)
 			cable->ops = &loopback_snd_timer_ops;


