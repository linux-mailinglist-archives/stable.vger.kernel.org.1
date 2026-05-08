Return-Path: <stable+bounces-244677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNXsG7aJ/WnWfgAAu9opvQ
	(envelope-from <stable+bounces-244677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:59:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BC4F2AFB
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADBC5303672A
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 06:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631937C107;
	Fri,  8 May 2026 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="GGgwzGrD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9437A4BA
	for <stable@vger.kernel.org>; Fri,  8 May 2026 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223454; cv=none; b=UsIvxy2WAsZFCBwH/Ixi4XOZL4UuBQ9LVwwZTnZonlRMDJ1qHSpAEFRd7liY9p5KbujCmfTkO8q5NGI6gOwN/zvulAzfm8r3u8MO0tuSUhvLok8pTdRsR63naz3wJGR2vFN1cpKyslKh37v6peIe29YkkWO4Xjv2CJ4vbkpenoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223454; c=relaxed/simple;
	bh=DEMWSZM9KxA3IK075yW/Z0nxHb2UrjCm4MgZr+2y00I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpRBWxmSIfKsF5FPJq7zR4k9zhjvauVW1cDjMTCXxs47L2qhOsXawd9n5Dzk90vFRewCXck0TYvDanc1iw6cXI2KPYKoG/Tj+SBBJaWN41QvI2JB3483YU4V7M+xVoGjnNoqPIMlaVRfmMaeH08zKWtJzUIfR0Bn+Lgkp7ZR1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=GGgwzGrD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaed195901so8487255ad.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1778223450; x=1778828250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TetnCK6YoCpHxJceDDOD/QB+oKi7cDlyFmiU7j9vyl4=;
        b=GGgwzGrD9FPyFDtB8wGt1o191LNDsH8psWrXBVBYj0DZAH2vpUvf2u4fHYVQxTIGFh
         qH//m1fGQnXC4Y47d+ZcbPoGuXUDF5Tj5IR1wxUBBzY7XD+AP5j+hx+1F1KaOEjuR5pE
         rfP6IMbBIDqAcHkXssstXn9EQ3EqMUT3CN7Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778223450; x=1778828250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TetnCK6YoCpHxJceDDOD/QB+oKi7cDlyFmiU7j9vyl4=;
        b=Fe1k99gH8V6waBQN6V9pbJ/IqEyxubAvkC2b7KfoBNFALOgSAI1Wnrshr+8l7OAvLG
         zrk9M3u/qxokOAQaZx3Pg3pPcr0t+cBxYn85XHpmIeKqbUnZWNDDM6XOYcAxSrwkw7L8
         doamHkPHV44H8UgxjVIYVshc5cVfeX1kqG1/FzMmcM7gaXYewoXej8sTdka/Yzg7Krtk
         P5eImPcM8uCAg33XOEcTF4VV+Z1WkPTQYfMPKXV8slDaCwzr+NURqJT6DuKbxiRq6Utl
         Rch+SEVLO3CdmO5JPb/dVNVswtWxUiJbQP4QTiG1mRI9wYWz0ciKekfL9kaef3wOh6tq
         /fkg==
X-Forwarded-Encrypted: i=1; AFNElJ/Yl6LMwqWj+lkz10noFrNL/EeF2t69PuBcjFA+WMDs8MY7vtMDFXKRQ8plem5tRHTHRxBV2vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OEaeFMLF2BNrap0hivPg1stB23hIx6DJIOZjlL6SgyJMSoJi
	pH/IS7Tnc9TnMXvZ1MjG+ONQBDvJphYNssCCbCL6EPiBg7Q8VjSsQMg9EdVd8DkrfXM=
X-Gm-Gg: Acq92OHaW9DWyee6VY5LbcwlSVgfSJauXp4UBPQ7cawegzR1tbO5QSUl+8x2HZnb1Th
	eoLFv+3mxSyVYmBbu05ydtNDj35j+PxGUYYuVwQmtZe6ms+T1fYw+2IL/kXBC9CYlcC7+9FfVft
	aVIbO1k6hD15LMQNoS9U9bb6yn8GoOv1ukEvqCxd8SaMOx9xuEHxbmmiGp20nOcxcSp/2ot61Iq
	5XRwlJhRyY9FrH4/T1c7FJ/DlKQWdCzRSAU/c6DUvOg7n2VQuTdP7gMfNSgqMW7PUWgSYZJrnQh
	wbvdc/QoE0HlAGrR3lQJwAjN+zsu4glb9O0k9UkEGR28ypWiSVHAwS4DbvfBNDMUs4nu2OVPIjU
	qCeAn5mS00P/xheBACw8G2nTgSu+thp4fdYIxnBPGQhZZ/5NCDn2Qk2bYBBFsUWP2ob15TBs/5o
	uUthGosuoTsalGz1QM/0ZTpibeYxSmryxYnYFOrTlOjUjt7Zqjjxd780i17jPkhgkbkYRHkuvEC
	vvsAu4RqIwiG6r4GZd4TRWVUQcyPzfR4vGy4xU4PVlnZjm/RzGzwro2RAEJwXvcWRYH7yfNi++W
	G+GJhYWDNDLLa/CQ5lZM4G6Q5HMhxIb03JMWoQYvPczyFJ4eIJe9cUGYamp++n8T
X-Received: by 2002:a17:903:3c2b:b0:2b9:ea53:4cfc with SMTP id d9443c01a7336-2ba794b8118mr117896365ad.19.1778223450102;
        Thu, 07 May 2026 23:57:30 -0700 (PDT)
Received: from aegis ([2001:fd8:4d01:3602:5317:86f3:5298:5270])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead938sm10650785ad.73.2026.05.07.23.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:57:29 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Antonino Maniscalco <antomani103@gmail.com>
Cc: Daniel J Blueman <daniel@quora.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/msm: Fix shrinker deadlock
Date: Fri,  8 May 2026 14:57:21 +0800
Message-ID: <20260508065722.18785-1-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D95BC4F2AFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[quora.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244677-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[quora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
	DKIM_TRACE(0.00)[quora.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@quora.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quora.org:email,quora.org:mid,quora.org:dkim]
X-Rspamd-Action: no action

With PROVE_LOCKING on an Snapdragon X1 and VM reclaim pressure, we see:

"""
kswapd0/121 is trying to acquire lock:
ffff800080ed3800 (reservation_ww_class_acquire){+.+.}-{0:0}, at:
  msm_gem_shrinker_scan (drivers/gpu/drm/msm/msm_gem_shrinker.c:189)

but task is already holding lock:
ffffbf4ddb44ca40 (fs_reclaim){+.+.}-{0:0}, at:
  balance_pgdat (mm/vmscan.c:7236 (discriminator 2))

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5825)
fs_reclaim_acquire (mm/page_alloc.c:4325 mm/page_alloc.c:4339)
dma_resv_lockdep (drivers/dma-buf/dma-resv.c:798)
do_one_initcall (init/main.c:1392)
kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.c:1470
  (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:1703
  (discriminator 1))
kernel_init (init/main.c:1593)
ret_from_fork (arch/arm64/kernel/entry.S:858)

-> #1 (reservation_ww_class_mutex){+.+.}-{4:4}:
lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5825)
dma_resv_lockdep (./include/linux/ww_mutex.h:164 (discriminator 1)
  drivers/dma-buf/dma-resv.c:791 (discriminator 1))
do_one_initcall (init/main.c:1392)
kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.c:1470
  (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:1703
  (discriminator 1))
kernel_init (init/main.c:1593)
ret_from_fork (arch/arm64/kernel/entry.S:858)

-> #0 (reservation_ww_class_acquire){+.+.}-{0:0}:
check_prev_add (kernel/locking/lockdep.c:3165)
__lock_acquire (kernel/locking/lockdep.c:3284
  kernel/locking/lockdep.c:3908 kernel/locking/lockdep.c:5237)
lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5825)
drm_gem_lru_scan (./include/linux/ww_mutex.h:163 (discriminator 1)
  drivers/gpu/drm/drm_gem.c:1681 (discriminator 1))
msm_gem_shrinker_scan (drivers/gpu/drm/msm/msm_gem_shrinker.c:189)
do_shrink_slab (mm/shrinker.c:436)
shrink_slab (mm/shrinker.c:667)
shrink_one (mm/vmscan.c:5071)
shrink_node (mm/vmscan.c:5132 mm/vmscan.c:5210 mm/vmscan.c:6198)
balance_pgdat (mm/vmscan.c:7052 mm/vmscan.c:7228)
kswapd (mm/vmscan.c:7501)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/arm64/kernel/entry.S:858)

other info that might help us debug this:

Chain exists of:
reservation_ww_class_acquire --> reservation_ww_class_mutex --> fs_reclaim
"""

kswapd0 holding fs_reclaim calls the MSM shrinker, which calls
dma_resv_lock. This in turn acquires fs_reclaim.

Fix this deadlock by using dma_resv_trylock() instead, dropping the
subsequently unused passed wait-wound lock 'ticket'.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
Fixes: fe4952b5f27c ("drm/msm: Convert vm locking")
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 34 ++++++++++----------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 31fa51a44f86..5320ef57dd90 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -43,8 +43,7 @@ msm_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 }
 
 static bool
-with_vm_locks(struct ww_acquire_ctx *ticket,
-	      void (*fn)(struct drm_gem_object *obj),
+with_vm_locks(void (*fn)(struct drm_gem_object *obj),
 	      struct drm_gem_object *obj)
 {
 	/*
@@ -52,7 +51,7 @@ with_vm_locks(struct ww_acquire_ctx *ticket,
 	 * success paths
 	 */
 	struct drm_gpuvm_bo *vm_bo, *last_locked = NULL;
-	int ret = 0;
+	bool locked = true;
 
 	drm_gem_for_each_gpuvm_bo (vm_bo, obj) {
 		struct dma_resv *resv = drm_gpuvm_resv(vm_bo->vm);
@@ -60,23 +59,14 @@ with_vm_locks(struct ww_acquire_ctx *ticket,
 		if (resv == obj->resv)
 			continue;
 
-		ret = dma_resv_lock(resv, ticket);
-
 		/*
-		 * Since we already skip the case when the VM and obj
-		 * share a resv (ie. _NO_SHARE objs), we don't expect
-		 * to hit a double-locking scenario... which the lock
-		 * unwinding cannot really cope with.
+		 * dma_resv_lock can't be used due to acquiring 'ticket' before the
+		 * fs_reclaim lock, which is held in shrinker context
 		 */
-		WARN_ON(ret == -EALREADY);
-
-		/*
-		 * Don't bother with slow-lock / backoff / retry sequence,
-		 * if we can't get the lock just give up and move on to
-		 * the next object.
-		 */
-		if (ret)
+		if (!dma_resv_trylock(resv)) {
+			locked = false;
 			goto out_unlock;
+		}
 
 		/*
 		 * Hold a ref to prevent the vm_bo from being freed
@@ -108,7 +98,7 @@ with_vm_locks(struct ww_acquire_ctx *ticket,
 		}
 	}
 
-	return ret == 0;
+	return locked;
 }
 
 static bool
@@ -120,7 +110,7 @@ purge(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
 	if (msm_gem_active(obj))
 		return false;
 
-	return with_vm_locks(ticket, msm_gem_purge, obj);
+	return with_vm_locks(msm_gem_purge, obj);
 }
 
 static bool
@@ -164,7 +154,6 @@ static unsigned long
 msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 {
 	struct msm_drm_private *priv = shrinker->private_data;
-	struct ww_acquire_ctx ticket;
 	struct {
 		struct drm_gem_lru *lru;
 		bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket);
@@ -185,11 +174,14 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 	for (unsigned i = 0; (nr > 0) && (i < ARRAY_SIZE(stages)); i++) {
 		if (!stages[i].cond)
 			continue;
+		/*
+		 * 'ticket' not needed on trylock paths
+		 */
 		stages[i].freed =
 			drm_gem_lru_scan(stages[i].lru, nr,
 					 &stages[i].remaining,
 					 stages[i].shrink,
-					 &ticket);
+					 NULL);
 		nr -= stages[i].freed;
 		freed += stages[i].freed;
 		remaining += stages[i].remaining;
-- 
2.53.0


