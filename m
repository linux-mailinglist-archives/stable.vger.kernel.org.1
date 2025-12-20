Return-Path: <stable+bounces-203134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AEDCD2D90
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EAB630102BF
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718402877EA;
	Sat, 20 Dec 2025 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDHFOZj/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA92EBBB4
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228138; cv=none; b=gCN5tn1M3+kp16B5UJDQ5Oeiej3taeoAVN4lcQxiqr7KSbp7+D+S9jsfIYPlRF7rJfGAHliITqimOuuBTB8b3A4AoGX08axngKTH1ZV5NHq7b0ckNY06LgnCryf1pSCySOYNAt9J09i5h0A4DPCxDCZQBUvbW7LZjBY8n83CDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228138; c=relaxed/simple;
	bh=qZiaWUijlwHeE8abhYVQrGh0Ck6Xhq/A2Ir5bDcfcM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHMKb6s+8R0mE4i3/rE99E8/TdGFyrBNqf6CRGfGQsv8gNbqdIHBwbhwpTIhEdnX6+U/XqL3vSJOAGpMwb/8wRrSWz47d7bFHi1EjafoCRMvqlIz5MRar1Fehqg8PxF1raeJ2Skj6hrBcj9Tm0oHu6q+bZKGn0tJdqRiqacXg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDHFOZj/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso1460181a91.0
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766228136; x=1766832936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS9W7wjkO+D9K7hG07rgBpqwDj1jVarCsyxehEZuYco=;
        b=TDHFOZj/St6fKtbHwBDiYiKVMThNDY6ZA+cnSsIvUhk24Zp061+OC3RTnZLaWLwFLn
         mhO/Dx3Ec27CoUMyKvSdg4cGNE1NAvedBCbd1rQtAFXTFAibSBrF5OV9Gehmb7cJvCBh
         2IL2LDkkt4TarNEzpVnPWLJF7qbYkLwTxsNikMcI5jPGMdcqi2VjIeST75To5F/Xwn7/
         IlEDWDGPYzcQ1qnOToh6kDHTqGEPjKFSEM89dUoT9KegkkvJ9+22z69J8jV/zHGppj0Y
         hwdPnYnyAiy9buv3oXEiXCiNDf7gv1NCYKV77Kn2qamEoml19zFFyitm6dkca+2fnhOF
         bfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766228136; x=1766832936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS9W7wjkO+D9K7hG07rgBpqwDj1jVarCsyxehEZuYco=;
        b=nHXGbenfClNExLdxCyx5a4kqkgBjJC2eQPfqsPf9l1UvqZzHsc9MMx+lDJ3ym3xKv5
         u8YKdnPvSVQuM3ho0Ty756W4XjVGfufPqOi9oaM//5u/INRZb2W2oAsVW2jOEECc58Tw
         +MDlIcSu0J3otsKR+QvPFYPFhw0/Ek0pUui0RIfSHFGobVitOTT5Kj8eV990TkiYI2Hk
         /XmFkXwIS8yJXVREi++lqvdFzRO+ccjkNyx6pdU1vqaxoIhA1LIgqR+kEWWul7ExKQhD
         tY1If7BSVBVWt+/qaCEZI5A+OT66Qe6rMlZYcu+XRNzl/HtjsQFIbijQbmAYv4CKrD20
         Ku7A==
X-Forwarded-Encrypted: i=1; AJvYcCXfbbU1OyKQxRH973eTzcMgjuXfMoz+18gklCqi/4wpZ+3y5mMSiXfwXO8akC1ZSJ9Sy4c+foo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxta3n5m6KdABSvBKqL+pCP2PKcjOBs98BE2raRV7qDk0+3Hdz/
	zSZm3rhVDnewxNnwteYSw451pQuRwBr5h7V4yXGrkYU7wHyMvtmVaJa+rgvTsA==
X-Gm-Gg: AY/fxX4gsj/qtkUmAchy3ZuyF0QGFKgkVIP5TvJLd2QZa7tKdS71nb9iDpI+81xwdxg
	JURCEDZVGY+MyqwGNjpq51ndYELEBHc5tgOY9kHX361XiAS/i8mhJ3mGBelYNEvr/CCzc4WqmW7
	c+n3+/AqCr/4cPLnz9g5LDhbNECNtcSpUGjqgppjETyLPruspiw3BAja60IIL06JKQ2eOEgg1fK
	ai7zxTNPH9GLJFFJz11TGoYLimp1C2I8bq+95pZ67ml1UWTZB4eow1EH5CmGVRww0ezQZn3TNoS
	pCYxSRKTc+6WdFAsyFUKMz9mwaN51wu6KE0qIUrxTonlghfoNfybFOjmeMSBWmECZVYjogdMmP8
	3t7KEUu9pAxPuaxvZifiHApacBIOFUr7tiZBP8vtGl0Iode71ga9tCrirpe0luqQkC8pU3U348V
	f9aw4pdwMXhMlTOULHd+o0yCczsRfFpD3K/V/a4w9u3qw3ym9wCbg=
X-Google-Smtp-Source: AGHT+IGgjhYccElI5VxMdDEJFMt3N4QtCIbnKhXndvFpPDvVNCxAbMZyTf5AHwqJkUmE/RWNLN1GBA==
X-Received: by 2002:a17:90b:37ce:b0:32e:8ff9:d124 with SMTP id 98e67ed59e1d1-34e90de1ee6mr5153370a91.15.1766228135895;
        Sat, 20 Dec 2025 02:55:35 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f0e:c406:a500:4e4:f8f7:202b:9c23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc4dcsm7704222a91.14.2025.12.20.02.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 02:55:35 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ionut_n2001@yahoo.com
Cc: Ionut Nechita <ionut.nechita@windriver.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] block/blk-mq: convert blk_mq_cpuhp_lock to raw_spinlock for RT
Date: Sat, 20 Dec 2025 12:54:48 +0200
Message-ID: <20251220105448.8065-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220105448.8065-1-ionut.nechita@windriver.com>
References: <20251220105448.8065-1-ionut.nechita@windriver.com>
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


