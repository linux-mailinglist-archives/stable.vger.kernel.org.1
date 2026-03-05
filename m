Return-Path: <stable+bounces-223268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGZBMxXbqWneGQEAu9opvQ
	(envelope-from <stable+bounces-223268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 20:35:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1722179BC
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86414307D632
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286F3C3BF9;
	Thu,  5 Mar 2026 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP/AhDOq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38601481B1
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739327; cv=none; b=GkmN2moGtO7j4+GvyOQN4tEBrqNhlhmZ1fyVxVU903YApymQyMtgNcQzPQ73pSIYviSwGRCh8y48GnYt3D0wj3OThEo1hfLnAevzSHfnUf3gzUiHJ2bAcm73OjUbA1Y5VA7ThCVGGpcfVJNqlbiq0GmlTirwNKUOW4UxsFjAD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739327; c=relaxed/simple;
	bh=PAvtlUAZJV23Ogtz1NgVoBzstnncqqGvH6vEP62bhE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NLfsIBsplk5qpqHOmqMZKuwPz+6S4KLYFXVWIlV/nzAfNF90n9AX6DrMSdRg1nZNgihBraTHA5WC8sO9m9u83GBRELpe1gkmWLHEQ9oNZQ3vny/b2mkQAPn/+CoT0rD5n2kfMpecTbumIddVhwHi8kpzqpSSXgmz+VNBV+nSvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP/AhDOq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7982c3b7dfcso85695317b3.0
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 11:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772739324; x=1773344124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JUsSuBpeeeWw+tAHopXopwOdrzE4R0Nfqxb1XRb2Jes=;
        b=UP/AhDOq7lRRIGG8N9dVPMz5ZmRxqOVJT+jDANcldTi3VO+InAk+eTfKb/IUVh/ITs
         /4SY7j1GK6sSf7A3Kp5IBW3mjsBM28cU2u705i7plaw9NS5MpLaaSeG7kytZGzBP6Xp8
         wu4vJjmNtBTjGzR9m4+ZqUQfWCcwLq9EXi3fb38n4YUuBR3mpxzKAleGtxpLMqMNTlDe
         tGMMayYgKshxO9THLz5hZf73qwin84q/CFY2use14L500S0r9Wwk7RJBDpPJktitby1m
         PUGkzP1C+TQ1L+rWyEp6uwrsinY/2+pCyDoa61qCJE45gJnNVQo0sSSHWgRo6GcFph1H
         v8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739324; x=1773344124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUsSuBpeeeWw+tAHopXopwOdrzE4R0Nfqxb1XRb2Jes=;
        b=bb39o9fAdH0u3K7qTuYYJi3fdookgxGnEsh3UpVSs98UE91S9/aPJ8/wYXWncJW6m9
         h5UNCqfDS/z9yJION1fSxjdkf76gVrxNwATf7rQGL75Wg5IWbdyZBopSL9w/B5Fv3B0Y
         YPDnknWcElOBT0GdT/lJq34qEe4EKqHfscqXpFOxkf6reYYP7uv47MdPom0qrKC927gj
         jnJojsdINoLOLw04mQ7mbQbduDbm/Ht4S/c/AoASAFjos3ShmyZRhQIRYlfwkd0bdQuh
         akQcDwHJOlRJD0zAfXfQz6owtCCwVs14CZFbzgktt8p1I7TO4vogeDZcTdbrjaUDBGBc
         6ADA==
X-Forwarded-Encrypted: i=1; AJvYcCX0KQkRHKWDVH7dZ6hKRw8O9CGbLIvMnQtM4cTGuf1CSg2dbiyXliZuBcCvBnMCbJpN3aYOmdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSlNVZev661zKMi2R7nEM7aG7l9O8j4req8N3lFljOOBVtYZl
	dkOV+s/XZ7S3ehepxb5/EwlASuVFqu904Qe9b1+Z6JS+e2FNsWoT+lLR
X-Gm-Gg: ATEYQzysw4g6rA64TN1CW+AczGL+UjBg2/ofQbLQeHioJkR6yO4GYBqfUkYN+T69Lh9
	mQTIOFIMmB6DPxYni4GCd4ek7NPLmoVCWmzzpzj3XZblS7JHFmtui3GQ5Beif/j0j9EZfXDt/qC
	LCtVovAabYCNm3VZt9z0FnepHjO/0V48rhxNEcZ7uL5rVb2e3+8hfwDWCUtmOfjWz4t3HUCLl/8
	/5VCYvSGreKSfu2PoJk9aokNmYk4eXY/jrV7xhcUzePlXR27/2pCyj300Z/5yjFj4gqKbsAugxv
	39wBsrYQOni3yX5neOuvk88F90pHNU/vbku1tmKD+4VjTgCLFE4E5lb4wrkW90CZunGE7Yt1Ug9
	MoCcTdpOQ81rsbVleIFFvWTN1CFk7ajXD2iPoDQIYgzMa7nygMug7o8yVhXx2OtmIIFIA/R2NBv
	/EsYA7OEmR76L6stjm0Oj/sfDnsH29DXknQIUd9qMatmxkE3232B0IAU6n
X-Received: by 2002:a05:690c:4d09:b0:798:5660:9314 with SMTP id 00721157ae682-798c6d23fd6mr52715547b3.64.1772739324161;
        Thu, 05 Mar 2026 11:35:24 -0800 (PST)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a9004dsm92396307b3.6.2026.03.05.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:35:23 -0800 (PST)
From: Mehul Rao <mehulrao@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH] ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()
Date: Thu,  5 Mar 2026 14:35:07 -0500
Message-ID: <20260305193508.311096-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA1722179BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223268-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
---
 sound/core/pcm_native.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 67cf6a0e1..5a64453da 100644
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
2.48.1

