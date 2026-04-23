Return-Path: <stable+bounces-240404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFWSF4yQ6WnQdgIAu9opvQ
	(envelope-from <stable+bounces-240404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 05:22:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA48744C811
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 05:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E83733037D64
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 03:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722A3CAE66;
	Thu, 23 Apr 2026 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwygvMXj"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C280224AFA
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776914557; cv=none; b=EVU0lA+CnOiDA3V6xMQ18W6wMpToAIbnU8H1PRVnQYxJU+bk+2ZqUnt+Lc8ozwPXZCyjK8AXTtRwM3uelsiv6gKKu0qWgdsAqfUkBP4VffOOtLlOqCUuheDu6ksqyZuFct+5v6lm6d7Lz6uKED4nWcWM3JI1Iive0JRCbypjXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776914557; c=relaxed/simple;
	bh=NubATWqIlRQtHd86zU1bKapSR3mZbmlH/41h5Ws8wx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OvUImJRQtWpOssrkmvhWvE+pH8cng0iZ4bGyHDXtQXgtOhp9TieeokM5n01vCvZ/c1XCz7bZIZ4xS0sYvr7xC33LAMeo/Bzyc/QIokv8N1Tp2YzKAdqJPpF0ly0hwZcgtB+f9bPuEEqbGhH1FK7dLPg4e7yte1uejR9doarKaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwygvMXj; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2de831d2b20so3559794eec.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776914554; x=1777519354; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QncE8TBARcMHwtxwUcHJfb/q3J332m6DpzRIhKgNNdc=;
        b=YwygvMXjxbFi76b4v2p16YaztYpwVr3DJeiS53ZHjt1pNcRzOo5RLYVILx6TvtmXtZ
         XhXOpKQFMa8JFwA5Vk91hcbL0gksLTc16Blw+nRxAyAQEu2Y/a9RJ734xQS8T+WeqQ7K
         iFjnfVZO62IzS1T9yfjwju7wXkiKRmg0zZ0W9Efy3QV7ZuFYKEDJ/vZbYetF5lK9/6/t
         EJ0TK9GJleV36r6HRsSmEqIelk1IB58xh1+wP4g0l5eIwHT9PWZnmsBIOvx7hulGpx+B
         zyZMJXItdHauieZenVwUchkBC+QovcIAycdzBPWr3ZN4RU6GqrIunOGCDXa3sOtMnYUj
         AXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776914554; x=1777519354;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QncE8TBARcMHwtxwUcHJfb/q3J332m6DpzRIhKgNNdc=;
        b=mzrJ7AwKiPGcseEGwi7B/O6UArUFiTRIcPsaRfMYN7cFAQ3Zh4eDNT/AQHWwz3wIIm
         PkDfd7COEOvFwVv+vjA8WWWjihFAyXgjT+pNl0Oj3AvxGmcX+95IiWXhOj4TjQLti4ER
         xEuw8FAPg7MHyGiXrZlAR+iyLG42nikBHVua9fOZp7lxnsXkz6E8NO4/+0tnWQPWD8kI
         PHZN8qX3NIxO3xZyb1P49mN+eL9sDSEhgmmp2+eoDoLIncfAXKub2BX7ZvYNTy+W2Oe6
         U3bv1fAgGXAUqkqyUQLFi4SyYaIrDYqs1fFpB3yAs3EiDoUKHdfJLzcIKMoikijhFYrS
         UCNw==
X-Forwarded-Encrypted: i=1; AFNElJ+RagX/jd99ljwyEzLDx0l5Sd1aLqAp/PucK9ck3qbvq4yrrVJDVQcOnP3uqN6wmip3W2t6W08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLGR3wBBPo4rHuKH0WGZaNAFZ1xblR9Ox5XfhB6PBvdMnpz+C
	n+Wd17eUmVcpajPqVU9yNrUt6oTNG5AP1f6Hu4LzoWhB20DDwO2DqCn3
X-Gm-Gg: AeBDietfpUFjO4GV1fqgoIXx4W3GHO6j+dE+1Wdj7cUP326MFMGuh/gNx9CxLHgDqK+
	l8rB/taaT1BMzIcHMvh5D6C+9Tj8MOxPbxaXM38OA1O8moqivPfycH5lnLMfyo6hpXFoaFy7cA0
	rCNbO/27pClUnbN2YkU5ZxY5RMUY27Ui59GOcVqKB+AcCBNy3QP6M2lm4bUkjX2Q9N85MldcipD
	jNZvFuxtBZT8OB/C7Ov9ICUjZRBE1LTv8kM+cQiQrNxzGUsNv5MRe4ketSvCYVYdcP3UyoJ2o7n
	RZNhMQqExRVQUMnEL++5pOVZ0M4gblLRUwZNaF9otIs+FX2p6A9WNB9NSFJAyBG2vRkIlNDr7Fc
	C4iGyZ1bkQsTzrUTAuLupIjHKzDrP1+l7o5HT1KQzc2K+kw2iovC7KHbCZ+lR4F+AxNq4S4iNyP
	lc0V4O47bl4bbSRctdEwPVecYbcbm4E2TOb7sLhyJDgcbyZhbKYgHKyIrDpOU5LK1Y9uXTNgHdD
	lJhRNrWT0cS1WIQSIxzFrI=
X-Received: by 2002:a05:693c:2a07:b0:2e5:8123:c7f3 with SMTP id 5a478bee46e88-2e581244e84mr11175794eec.28.1776914553963;
        Wed, 22 Apr 2026 20:22:33 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm25599854eec.21.2026.04.22.20.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 20:22:32 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 23 Apr 2026 00:22:22 -0300
Subject: [PATCH] ALSA: aloop: Fix peer runtime UAF during format-change
 stop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260423-alsa-aloop-peer-stop-uaf-v1-1-25d8a9745f6c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCQAxFr1KyNpCG6sKriItp+6sR6QyTVoTSu
 xt18/lv8d5GjmpwOjcbVbzMLc8B7aGh4Z7mG9jGYFLRk3SqnJ6eYnIuXIDKvsRb08Qi3QhtVfq
 jUuilYrL3L325/tnX/oFh+fZo3z9cgOsefAAAAA==
X-Change-ID: 20260422-alsa-aloop-peer-stop-uaf-004de2120b52
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5283;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=NubATWqIlRQtHd86zU1bKapSR3mZbmlH/41h5Ws8wx0=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJkvJ5Q6GH73bOneFOY0ZbH+/uMv79fdK/w89cjtrZXSp
 7Kqlsi97ShlYRDjYpAVU2RZnbTIck/Xg6v1cSs8YOawMoEMYeDiFICJNKozMjR4B025vHTXh3nh
 P7+lfnuqbL/2aHxO/N6cN2+P9+ZO3beJ4a+oj/GbFm+bax8/dLaJ/Jq66F9GyLbXkwt+STq9uvV
 gcSsnAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-240404-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,8fa95c41eafbc9d2ff6f];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: EA48744C811
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

loopback_check_format() may stop the capture side when playback starts
with parameters that no longer match a running capture stream. Commit
826af7fa62e3 ("ALSA: aloop: Fix racy access at PCM trigger") moved
the peer lookup under cable->lock, but the actual snd_pcm_stop() still
runs after dropping that lock.

A concurrent close can clear the capture entry from cable->streams[] and
detach or free its runtime while the playback trigger path still holds a
stale peer substream pointer.

Keep a per-cable count of in-flight peer stops before dropping
cable->lock, make free_cable() wait for those stops before detaching the
runtime, and take the peer stream lock around snd_pcm_stop(). This
preserves the existing behavior while making the peer runtime lifetime
explicit.

Reported-by: syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8fa95c41eafbc9d2ff6f
Fixes: 597603d615d2 ("ALSA: introduce the snd-aloop module for the PCM loopback")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/drivers/aloop.c | 56 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index aa0d2fcb1a18..a997ee262740 100644
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
@@ -337,10 +340,10 @@ static bool is_access_interleaved(snd_pcm_access_t access)
 static int loopback_check_format(struct loopback_cable *cable, int stream)
 {
 	struct loopback_pcm *dpcm_play, *dpcm_capt;
+	struct loopback_pcm *stop_dpcm = NULL;
 	struct snd_pcm_runtime *runtime, *cruntime;
 	struct loopback_setup *setup;
 	struct snd_card *card;
-	bool stop_capture = false;
 	int check;
 
 	scoped_guard(spinlock_irqsave, &cable->lock) {
@@ -366,8 +369,11 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 				return 0;
 			if (stream == SNDRV_PCM_STREAM_CAPTURE)
 				return -EIO;
-			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING)
-				stop_capture = true;
+			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING) {
+				/* close must not free the peer runtime below */
+				atomic_inc(&cable->stop_count);
+				stop_dpcm = dpcm_capt;
+			}
 		}
 
 		setup = get_setup(dpcm_play);
@@ -396,8 +402,18 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 		}
 	}
 
-	if (stop_capture)
-		snd_pcm_stop(dpcm_capt->substream, SNDRV_PCM_STATE_DRAINING);
+	if (stop_dpcm) {
+		struct snd_pcm_substream *stop_substream = stop_dpcm->substream;
+		unsigned long flags;
+
+		snd_pcm_stream_lock_irqsave_nested(stop_substream, flags);
+		if (stop_substream->runtime && snd_pcm_running(stop_substream))
+			snd_pcm_stop(stop_substream, SNDRV_PCM_STATE_DRAINING);
+		snd_pcm_stream_unlock_irqrestore(stop_substream, flags);
+
+		if (atomic_dec_and_test(&cable->stop_count))
+			wake_up(&cable->stop_wait);
+	}
 
 	return 0;
 }
@@ -1049,23 +1065,29 @@ static void free_cable(struct snd_pcm_substream *substream)
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
@@ -1260,6 +1282,8 @@ static int loopback_open(struct snd_pcm_substream *substream)
 			goto unlock;
 		}
 		spin_lock_init(&cable->lock);
+		atomic_set(&cable->stop_count, 0);
+		init_waitqueue_head(&cable->stop_wait);
 		cable->hw = loopback_pcm_hardware;
 		if (loopback->timer_source)
 			cable->ops = &loopback_snd_timer_ops;

---
base-commit: 03ef04a70af3ddfa925d78015713fdb4a15e4e88
change-id: 20260422-alsa-aloop-peer-stop-uaf-004de2120b52

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


