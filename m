Return-Path: <stable+bounces-203137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8BCD2DC7
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 12:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB259302168A
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDA8309F0E;
	Sat, 20 Dec 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvL7IudY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1DB304BBF
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228606; cv=none; b=p3LSe2hPXrFyr79U57/H2a/ipKERTfKUSs/Ql/cOAfVHeprl9/JZYKWE9Eg48h1DIM6gWjcCYgM7XATwpjFYflUib8BIS7cNOBkYwA+7C9h8OcdbVe0nNLo4x8l0CAdgrlYG5Z4EisxaqIl5KS0Sib0efQlko8ZwBWGiIv0OKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228606; c=relaxed/simple;
	bh=qZiaWUijlwHeE8abhYVQrGh0Ck6Xhq/A2Ir5bDcfcM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wo1K2DuGRz4QwAruQpeBijOeAKsd0IBzcU8FOjxlfvaY7k5b6yPs9QP4M0uRRSn+Ukc18LwdGBlf3LSk1IjNWM3bzEwo1GHQguyY2h7GME/nERulxz4TvvxB2OiWirRh8SSpUl/lOxH8vk5lsC+tc8/qQGpozdNv719cEPCDmUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvL7IudY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7baf61be569so2883671b3a.3
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 03:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766228602; x=1766833402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS9W7wjkO+D9K7hG07rgBpqwDj1jVarCsyxehEZuYco=;
        b=GvL7IudYsd4mNxLK9s83kWth3f0hrFRMnhM2YW18kHzvM1Xb71vc9Lvs+wBSeF+Irr
         pPUV4J/PzyGOmDSO01LJhQBzICQ2YBQjQfCnt2g69miig6RfX9+JKtNtc+44Z/BmpAxt
         UhoJIpQw3aUwT9FiAo5XguuopElwL697cyFwZyANfNuCW2mCwRsmqrESkveiQ+II1QyQ
         Z+t5r59/DNVQVsXx/JK1qXrjP8aeJRZqopucPiM7USrKEFGp3kUObFLDIajHeFa/W+/N
         ztGoy386UXlKzDXwpoAiDgxsZQi3aR8zm3UYfSuFSmQddgOG5Hc7whK7Z/TCaW9f2E6+
         YDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766228602; x=1766833402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS9W7wjkO+D9K7hG07rgBpqwDj1jVarCsyxehEZuYco=;
        b=IFn9dXvP9yLDHQxJaPpymDTVs4c/rj0rDM/DFs3QmjyoCg/EQlbfDqnnoYOFpj0eAA
         OMOk/s8uassPiMbV332pXVvc9oCVk7WT9/oeWCzPBvSXxI5E0uBKqaQdxgKjMtlyxTdl
         vTsh1fHObF2WJJMg2euH8X4yfOV4o1fNyoCUMhUNpJODnZO6GhFec+vPfGFTW3ms8kYR
         2DCxSvv0/vllVWJi94Ea/jDrPdDJYRy3xb0biKdU0wLZxsTXs6gbBWbvlpVsXCsWRJN6
         oTSy6xdWhMogrl3DaIKRklE4WlS9ikfLfElCh9TnxX9KouOZWft5026jMiWITw8dbq6S
         q8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Jx6hTnWdgeo216+uqDu8fdwEXtAhFgPqR4bAgqvQGXpYQ65/92+mrFJeveF9HL83QqqT1Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdTF6cZVjRM6K1w60y25zHm9Ijmc/Wc3t8cajgHqtaQQ3n6aX
	cl+JfGCTAz3La8uVDPL/Y3N4ClM4Q6g93qdi99cvJoBR/Qrj+cCgbTkZ
X-Gm-Gg: AY/fxX7EORuoqIHpSosjE9MVNPlGyeNPCY345pasZfaKaysnjSqKFKo/WQhiXX86X1l
	B9V9aacXkFrxrrLN6N4WrMg+35eDSSvPR+wp/Ur2EZHomoXdooG7DIIYcgHNZNq4Y4fkAIzvRtk
	fZqdIx3cr84MzQK9KqsCpcvFx9x0UFsiVi+Avk7+2pFQH6mTlC+qvIoJKlTcZbhnIdpxlo+HAlC
	1RI3hrAXAHAerzDduoliZAv7Xzohu+zgI7OycnnPLwq7EbntkNc7CicBXldNAXLUPqzEuGoznPq
	Bg7SbFCvFxmtfv84sUtjOSlFv2SAPGuv7gOEu678/o7/SgWeEZIbpZHWkxzauqygkdBacFbgtDp
	8paZ4Rbi2kJV+kbfyNMlOrcwViRSP033mvaxw6881tia3crBxbmde58IgagwX8yvH2GUyToIED8
	8Ou01ivHpDq4GvFXbs/PQ7pvXc1A61oWXui2nfln+QJmCGktqC4G8=
X-Google-Smtp-Source: AGHT+IF/P/WLJTzCtGkWHYUlpb9xLBtbrMR9kXyxku3L04FO5e2ykvbYbKXn1q2ANA8kjw0xzemWug==
X-Received: by 2002:a05:6a00:3014:b0:7e1:b7ba:d5a2 with SMTP id d2e1a72fcca58-7ff61b8b53fmr5213055b3a.0.1766228602348;
        Sat, 20 Dec 2025 03:03:22 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f0e:c406:a500:4e4:f8f7:202b:9c23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a84368dsm5015547b3a.2.2025.12.20.03.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 03:03:21 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: gregkh@linuxfoundation.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 2/2] block/blk-mq: convert blk_mq_cpuhp_lock to raw_spinlock for RT
Date: Sat, 20 Dec 2025 13:02:41 +0200
Message-ID: <20251220110241.8435-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220110241.8435-1-ionut.nechita@windriver.com>
References: <20251220110241.8435-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Commit 58bf93580fec ("blk-mq: move cpuhp callback registering out of
q->sysfs_lock") introduced a global mutex blk_mq_cpuhp_lock to avoid
lockdep warnings between sysfs_lock and CPU hotplug lock.

On RT kernels (CONFIG_PREEMPT_RT), regular mutexes are converted to
rt_mutex (sleeping locks). When block layer operations need to acquire
blk_mq_cpuhp_lock, IRQ threads processing I/O completions may sleep,
causing additional contention on top of the queue_lock issue from
commit 679b1874eba7 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding").

Test case (MegaRAID 12GSAS with 8 MSI-X vectors on RT kernel):
- v6.6.68-rt with queue_lock fix: 640 MB/s (queue_lock fixed)
- v6.6.69-rt: still exhibits contention due to cpuhp_lock mutex

The functions protected by blk_mq_cpuhp_lock only perform fast,
non-sleeping operations:
- hlist_unhashed() checks
- cpuhp_state_add_instance_nocalls() - just hlist manipulation
- cpuhp_state_remove_instance_nocalls() - just hlist manipulation
- INIT_HLIST_NODE() initialization

The _nocalls variants do not invoke state callbacks and only manipulate
data structures, making them safe to call under raw_spinlock.

Convert blk_mq_cpuhp_lock from mutex to raw_spinlock to prevent it from
becoming a sleeping lock in RT kernel. This eliminates the contention
bottleneck while maintaining the lockdep fix's original intent.

Fixes: 58bf93580fec ("blk-mq: move cpuhp callback registering out of q->sysfs_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-mq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5fb8da4958d0..3982e24b1081 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,7 +43,7 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
-static DEFINE_MUTEX(blk_mq_cpuhp_lock);
+static DEFINE_RAW_SPINLOCK(blk_mq_cpuhp_lock);
 
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_request_bypass_insert(struct request *rq,
@@ -3641,9 +3641,9 @@ static void __blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 
 static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
-	mutex_lock(&blk_mq_cpuhp_lock);
+	raw_spin_lock(&blk_mq_cpuhp_lock);
 	__blk_mq_remove_cpuhp(hctx);
-	mutex_unlock(&blk_mq_cpuhp_lock);
+	raw_spin_unlock(&blk_mq_cpuhp_lock);
 }
 
 static void __blk_mq_add_cpuhp(struct blk_mq_hw_ctx *hctx)
@@ -3683,9 +3683,9 @@ static void blk_mq_remove_hw_queues_cpuhp(struct request_queue *q)
 	list_splice_init(&q->unused_hctx_list, &hctx_list);
 	spin_unlock(&q->unused_hctx_lock);
 
-	mutex_lock(&blk_mq_cpuhp_lock);
+	raw_spin_lock(&blk_mq_cpuhp_lock);
 	__blk_mq_remove_cpuhp_list(&hctx_list);
-	mutex_unlock(&blk_mq_cpuhp_lock);
+	raw_spin_unlock(&blk_mq_cpuhp_lock);
 
 	spin_lock(&q->unused_hctx_lock);
 	list_splice(&hctx_list, &q->unused_hctx_list);
@@ -3702,10 +3702,10 @@ static void blk_mq_add_hw_queues_cpuhp(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	mutex_lock(&blk_mq_cpuhp_lock);
+	raw_spin_lock(&blk_mq_cpuhp_lock);
 	queue_for_each_hw_ctx(q, hctx, i)
 		__blk_mq_add_cpuhp(hctx);
-	mutex_unlock(&blk_mq_cpuhp_lock);
+	raw_spin_unlock(&blk_mq_cpuhp_lock);
 }
 
 /*
-- 
2.52.0


