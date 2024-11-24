Return-Path: <stable+bounces-95181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98ED9D73F3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893F928B48A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB801F8703;
	Sun, 24 Nov 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uph4N7ck"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942D1B0F36;
	Sun, 24 Nov 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456255; cv=none; b=gRz3qrhvwUxMFFepm3WmOU7q9jyVel24yUi5wvX9mRGtWBAhxGyGXWuRyVzhMGpl/U7rYGgkXt4ObGx6s+AqyPM8MRMRMjUBcALUSAh4zkevZWF6CnmFMkZanHbxxuIpC2EPmejbc9KfQbjvH5JjVLURCB60edNxIV+9wRnRZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456255; c=relaxed/simple;
	bh=pBZ5xxcEVnsY4o6Auj6hl5iczWwwi3GoOZOpbG3j0+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fr8FCj1Jqfr+mQXLH2NdNrLfHKp2qUICNKkmktOGO2iS45AmzqUQtjcNEHXeOCLhU9sdslD++a0O861NBiGbfHUZd0U4pFL1jO0af2LseEWHMQ41eULWnnogkpmzFZ4R0RNv/yXdKe5VVHUJbdMbBkIwS6mA35+rd9x6/T6wdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uph4N7ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B70C4CECC;
	Sun, 24 Nov 2024 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456255;
	bh=pBZ5xxcEVnsY4o6Auj6hl5iczWwwi3GoOZOpbG3j0+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uph4N7ckwMlQtXpDCU6cfrO+/cNuHfVxTHzF+WGRA9OohpinEq9+pnn8ByPhiCuHE
	 x874GGZhh/9XOLlUQBKoujojbwJB8sJ2KP+RNfLWcEUgzJuzIgbyPSs2G7ULOL3mNg
	 SbDF0F0Vyst/YCt4ovnh/BKIn5Cbbw3SVb0PzWe5Bs7KlXMCZdo3XU0jQFJwIiMS1c
	 VH60fkL2ZBOBS4mdv7OnSc3Ocp7fISv2qxORPYpwjIkPSOQ5ACN8DZ5NyKDlJjKZKW
	 oX2HPdE6dAUXsBGYSKiY3PWuntH3OgAVo5IPeNvIE/RqLfwq44ttiCspVAuyCIlKjU
	 dZ3tAkuFxUl4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Levi Yun <yeoreum.yun@arm.com>,
	Denis Nikitin <denik@chromium.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 30/48] dma-debug: fix a possible deadlock on radix_lock
Date: Sun, 24 Nov 2024 08:48:53 -0500
Message-ID: <20241124134950.3348099-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Levi Yun <yeoreum.yun@arm.com>

[ Upstream commit 7543c3e3b9b88212fcd0aaf5cab5588797bdc7de ]

radix_lock() shouldn't be held while holding dma_hash_entry[idx].lock
otherwise, there's a possible deadlock scenario when
dma debug API is called holding rq_lock():

CPU0                   CPU1                       CPU2
dma_free_attrs()
check_unmap()          add_dma_entry()            __schedule() //out
                                                  (A) rq_lock()
get_hash_bucket()
(A) dma_entry_hash
                                                  check_sync()
                       (A) radix_lock()           (W) dma_entry_hash
dma_entry_free()
(W) radix_lock()
                       // CPU2's one
                       (W) rq_lock()

CPU1 situation can happen when it extending radix tree and
it tries to wake up kswapd via wake_all_kswapd().

CPU2 situation can happen while perf_event_task_sched_out()
(i.e. dma sync operation is called while deleting perf_event using
 etm and etr tmc which are Arm Coresight hwtracing driver backends).

To remove this possible situation, call dma_entry_free() after
put_hash_bucket() in check_unmap().

Reported-by: Denis Nikitin <denik@chromium.org>
Closes: https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/2WMS7BBSF5OZYB63VT44U5YWLFP5HL6U/#RWM6MLQX5ANBTEQ2PRM7OXCBGCE6NPWU
Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index de02c0808fb83..3e6f2a39beb3b 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1044,9 +1044,13 @@ static void check_unmap(struct dma_debug_entry *ref)
 	}
 
 	hash_bucket_del(entry);
-	dma_entry_free(entry);
-
 	put_hash_bucket(bucket, flags);
+
+	/*
+	 * Free the entry outside of bucket_lock to avoid ABBA deadlocks
+	 * between that and radix_lock.
+	 */
+	dma_entry_free(entry);
 }
 
 static void check_for_stack(struct device *dev,
-- 
2.43.0


