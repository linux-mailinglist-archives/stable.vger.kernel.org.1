Return-Path: <stable+bounces-240652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAeYGjFn62mtMAAAu9opvQ
	(envelope-from <stable+bounces-240652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:50:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A535045EA9F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C19263012C52
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A73CF696;
	Fri, 24 Apr 2026 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrIJ/z3Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A5321F5F
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034976; cv=none; b=hgmNVEcCxdgtbaccW17zNUbkTQ3BBNKO3JdbjIAOjjwPLijxrsfZqvVN3vwAwn3hSdXBPvfWC18iqV65C0OUeO+5rTatwuozw8/QULhEA9L/0yCpIf7TPcntkfp049mCQDEGqXI0j9oPne7RxYXuu3XZSycRncpRUriMTGCHWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034976; c=relaxed/simple;
	bh=8DfXZXq4mVPMtrbEJ3azRH0nkf22Z7tVppnYqNc9f54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=csGwVzb37t0ERTvseo53H5wBKGF5tPugl/K9WUeOaonVztLsH5VxPEK1f6P8faoYc+vD6iRYYCD9ynbqhD6TkQ6zetUgXIoE6MKn/eix83RHgL3hcApduirma66dYdTPyM4gxvg5POH6bdAQJ/SdV+coqDNndDanvIN2WiqnIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrIJ/z3Q; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12db7bf1541so4533386c88.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777034974; x=1777639774; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sDFo3WV98TxsiaFURx28Dc3liN7VLrYqdD8rKeIweI=;
        b=GrIJ/z3QWD7AZozMM+bPkLhs5omgGnw0D8xtOEkzBpycKwapo/xGLEjALMOLD9qlAk
         i1ahj/lZwRiF+yN54vy7//WxdEffYFcnRGf03xjvMujrT2rRvqXU5KpcB59X8UowlsbG
         yHfV+RmUOH15A2HNzboPUnEwqOWw/QiM8i3bOQ3dON5BK5xcg2so8hp10Q34wYLNsjbs
         Kfvrvu1WSpLPSg0oxY9WMr/TjydI6zfI5FdyYO4NTtaUgf5B1U1X4uCStgBMr6o39zrv
         JgSiZ0GBWQ4pN75XhOQRT9qGqQ4sqov9xrrNQPYSFH7y2IqFg4FpzraUJ6zKWua2wR5N
         mBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777034974; x=1777639774;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sDFo3WV98TxsiaFURx28Dc3liN7VLrYqdD8rKeIweI=;
        b=DI+noQpItyeoItbbkH8wxv5WsXwIvMKYeg/vebwO7Ef46Z9Po3EbRN98xua9Kp2H5x
         dSpoj4rfYZI6nWXlZY2HcDmQfFaXvWf3Xq8jFryHbP2XVsbDJB2i1oQarTYgJmhZXrHJ
         Jy/3c/xAb3ZKbFyLJi9Z4E1IqOKT9jIU6pF+oJHjwvuQBjdzGybiTJnrU+GguHUozR7r
         InZP0mH4GFubHKNsjO4s7rMqGE47J3LY5+74V2lGY61XIdjvrHiwBTOLxyet25KER6Ck
         kcCd8dpr5HnaGlqnL0MkG903o35dbL1wI3NMlTvlhoCXOXAUEouiASVlcqC+cCRfk+CU
         6cLA==
X-Forwarded-Encrypted: i=1; AFNElJ+1Dc5aAU9RsAfy2+0k3bbco65//UJ0cPLyKYy7giJHaSdiJGChvrx+yeV9l4Sr5gVLsYErmDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMmI4zXf9CFhEd2IRn81UCl7mDhJAWiQADTSA4ks+9wu7uE7B
	0CbXsqSDeThT9ZhkPOFuZtTz8BHvZZ6u4kfyQCbwyG0gVWk7Qn9/fYWM+NeWdqJW
X-Gm-Gg: AeBDietO5v/UrAVarFjl3ATfW8xS4OMwfoyRtBAFXNsfPXuPAnzK1NP5Dj1AlmXf3hB
	kQzNi7aJXIwDpp6yZ5H99aoIRsSZZP5wgRzDyapcNPIWpZbhdEc1iG862rFFeSHDb1b1s2e8XQm
	/VVR5rpnOO1ix6ObEWbwk2EyRxzQ1SfzAg5sigaDoqb5VoCyRwCyUyrVrb0NXGqfvniFO5/SluG
	gofY8Mj25e/QTsGo9hvJYDMuv+kpDprKGa2J4PgEQAJH6Vb+NozcFmYAnbc6h0QmzdQPvLZo2P3
	4PhMdR7/RxUIo8tFf3rm8J3pGCzopyWM2jSWUHlJpmN7sf+wHWeDZC3zDqyfu0gJrKaRtWTdtWf
	o+LESx41EosdfQ0aDlFb+k8HqFX6XIkEkaRXjZ+EgjWIQzYqV4D0oweazv1rOMHvghw0NJWs/N/
	B5h5HyQLAYx1Lg+I2S78ok1HX2KZiGHkSg3Qy7e1gRuZtiBiqxVLoX4QAqMFz43CkemmIjD6KFJ
	0oYzaf+c5K8
X-Received: by 2002:a05:7022:418e:b0:12c:87f1:f41a with SMTP id a92af1059eb24-12c87f1f772mr14051063c88.21.1777034974262;
        Fri, 24 Apr 2026 05:49:34 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm40524524c88.14.2026.04.24.05.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:49:33 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Fri, 24 Apr 2026 09:48:41 -0300
Subject: [PATCH v2] ALSA: aloop: Fix peer runtime UAF during format-change
 stop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260424-alsa-aloop-peer-stop-uaf-v2-1-94e68101db8a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2jHtCPhY+R+GRSkD1ABtWiAaw
 r9bMC7dTOYk996zQGBvOMAtWcDzbIKxQwQ6JKBbNTSMpooMJCgXKRGqLqh4rHXomD2GMX6TqlG
 ItGKSJMqMINad59q89ulH8eUwlU/W47a3JVoTy/69u2e55X6a03/NLFEiZdVFXc9pVuf63vTKd
 EdteyjWdf0ANcApM9IAAAA=
X-Change-ID: 20260422-alsa-aloop-peer-stop-uaf-004de2120b52
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4746;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=8DfXZXq4mVPMtrbEJ3azRH0nkf22Z7tVppnYqNc9f54=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmv026ZFe6/UGn8a6p9X3f5tG1dvM9r7hm6BPryTr3Hk
 r6J/VJTRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAExEYTPD/+wjbo4NDyKuGDFG
 3VtTtWxbNEcn41Rxy5tzfX05g5bbKjMyvCmsbtx3t//9Be55giv2/5ptlyTwINf9jN2Pre7hEi8
 TGQA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: A535045EA9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240652-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,8fa95c41eafbc9d2ff6f];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,suse.com:email,msgid.link:url,appspotmail.com:email]

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
---
Changes in v2:
- simplify the peer-stop path in loopback_check_format()
- drop the extra stop_dpcm indirection and runtime/running recheck
- keep only the stop_count/stop_wait lifetime serialization
- Link to v1: https://patch.msgid.link/20260423-alsa-aloop-peer-stop-uaf-v1-1-25d8a9745f6c@gmail.com
---
 sound/drivers/aloop.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

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

---
base-commit: 876c495d412ef67bd4d0bdc4b74b0bd3d9f4e890
change-id: 20260422-alsa-aloop-peer-stop-uaf-004de2120b52

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


