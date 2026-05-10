Return-Path: <stable+bounces-245017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OpKJhOFAGo5JwEAu9opvQ
	(envelope-from <stable+bounces-245017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:16:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E3F50447A
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1974300767E
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E365636BCF2;
	Sun, 10 May 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLuyg41x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E325A642
	for <stable@vger.kernel.org>; Sun, 10 May 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778418960; cv=none; b=LAWcLAEYL8iUkpDy0puWUAbTHA+IvPwBHtYNyNmmStKyS0ol8BwLqQSqTbWIhgUJQqfl17cHGGpjtLpXiJXAChRUYCOrIG5kumhGAR6BcpEMaezDX/mNbJzc+NUb0jiOA/7B0i851IuIB3OuHYS2a5vTxsZVCbWOHsSBPG90wRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778418960; c=relaxed/simple;
	bh=xRa3YND595QemzNls0aSVVq29JbAxZvby1r3pRFdddw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwH4OWoLXt/N8BBtWdSOHAzm6lIUGo/+2WX8wFi+LD8dDi0Bwdmux9p415xly2HUV3NwL8T+4okexzwaGSCGbUOtd3QT++oeKXc4rxdUFMcoB9e16Ty7O2gYlqhNWnTnFYJPuuyfD5sJGSWpGomMM67lL/Bg2jnVVPN/2GD3wBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLuyg41x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A09BC2BCB8;
	Sun, 10 May 2026 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778418960;
	bh=xRa3YND595QemzNls0aSVVq29JbAxZvby1r3pRFdddw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aLuyg41x7HO/0rUus0IH4DBHddJJZ1fKlmlltcYg3pWCHkoeVR+evwbPo9ItzLanI
	 xO38wrjiYGYyxmzCAIYclxy7UXarVpOBgL9XbzgopfT1Nm/u8/bF/dEpVne5KpIlEc
	 wRHeEiZvkEEPqfMyhGv4/H7s8FNhn8V5u6cigKeTnh1jvIUz7Fda0aZOjmrp5o3JnP
	 d11075qsHi1wGWC4YXFZGTlq7VgR7lkVB08fi66yMgfwP/yEwB65yNXYKoAGAMCRKj
	 MpYid1KgcBCadNlqzpF1BZWdvk1iu8+s3AGEL9fbZCxh6hjZAdh4b04wF0YBXqOt6a
	 iw3rRy36pCuFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: aloop: Fix peer runtime UAF during format-change stop
Date: Sun, 10 May 2026 09:15:57 -0400
Message-ID: <20260510131557.4115089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050446-calibrate-passivism-6ada@gregkh>
References: <2026050446-calibrate-passivism-6ada@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E0E3F50447A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,suse.com,suse.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245017-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,8fa95c41eafbc9d2ff6f];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit e5c33cdc6f402eab8abd36ecf436b22c9d3a8aff ]

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
[ collapsed inc/snd_pcm_stop/dec into the existing inline call site and used spin_lock_irq/unlock_irq instead of scoped_guard ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/aloop.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 12f12a294df5a..c083b223df85c 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -98,6 +98,9 @@ struct loopback_ops {
 struct loopback_cable {
 	spinlock_t lock;
 	struct loopback_pcm *streams[2];
+	/* in-flight peer stops running outside cable->lock */
+	atomic_t stop_count;
+	wait_queue_head_t stop_wait;
 	struct snd_pcm_hardware hw;
 	/* flags */
 	unsigned int valid;
@@ -341,8 +344,12 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 	if (stream == SNDRV_PCM_STREAM_CAPTURE) {
 		return -EIO;
 	} else {
+		/* close must not free the peer runtime below */
+		atomic_inc(&cable->stop_count);
 		snd_pcm_stop(cable->streams[SNDRV_PCM_STREAM_CAPTURE]->
 					substream, SNDRV_PCM_STATE_DRAINING);
+		if (atomic_dec_and_test(&cable->stop_count))
+			wake_up(&cable->stop_wait);
 	      __notify:
 		runtime = cable->streams[SNDRV_PCM_STREAM_PLAYBACK]->
 							substream->runtime;
@@ -994,24 +1001,29 @@ static void free_cable(struct snd_pcm_substream *substream)
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
-		spin_lock_irq(&cable->lock);
-		cable->streams[substream->stream] = NULL;
-		spin_unlock_irq(&cable->lock);
-	} else {
-		struct loopback_pcm *dpcm = substream->runtime->private_data;
 
-		if (cable->ops && cable->ops->close_cable && dpcm)
-			cable->ops->close_cable(dpcm);
-		/* free the cable */
-		loopback->cables[substream->number][dev] = NULL;
-		kfree(cable);
-	}
+	spin_lock_irq(&cable->lock);
+	cable->streams[substream->stream] = NULL;
+	other_alive = cable->streams[!substream->stream] != NULL;
+	spin_unlock_irq(&cable->lock);
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
@@ -1206,6 +1218,8 @@ static int loopback_open(struct snd_pcm_substream *substream)
 			goto unlock;
 		}
 		spin_lock_init(&cable->lock);
+		atomic_set(&cable->stop_count, 0);
+		init_waitqueue_head(&cable->stop_wait);
 		cable->hw = loopback_pcm_hardware;
 		if (loopback->timer_source)
 			cable->ops = &loopback_snd_timer_ops;
-- 
2.53.0


