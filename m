Return-Path: <stable+bounces-95221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F69D744C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43164283C1E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F21F7B49;
	Sun, 24 Nov 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1hXDpDW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B241F7B40;
	Sun, 24 Nov 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456386; cv=none; b=ALVtLyPZYbjM6G5ZHVcLkwEGmFmCCmV+rqlvAKlWnYl2RLGoBgbkoG023w/l9W74vkKgWixxX3BsS8+27Q5Vcx2UtlRHPjxpLXtTjTH8pR2dHhfzba/caPpFAWZQGaND1ZmEFVrCLnlRK0Rl0vLOIvobfyr5u861YWLGbKtowXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456386; c=relaxed/simple;
	bh=bpNykeNycoZKTjEd5Ld2byQXCO4HJy/3xSAxpSOY60E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+HYpz3ZVoZYglZ5I0mkWkxmzxWCw6wdUp1gjSEcnk4BmpD0hWgdha1FcBmOKA0KEymfD/R8xrgMdm2X8JyPDFrP9mLYK+EOxuLzmpiEKpLcUwIrvGgPLb0qjoym4zASEKhOC9W7oTuAl32I2TNvZ/AGKjx+wR4lKxJN2fqK9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1hXDpDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C933EC4CED3;
	Sun, 24 Nov 2024 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456385;
	bh=bpNykeNycoZKTjEd5Ld2byQXCO4HJy/3xSAxpSOY60E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1hXDpDW95KnHhhAD5jAAt+NqV22I3KgHaX2PjAIVzCfE6ggciUH6GiUeGZQoI3IR
	 FzBf/7lGGf/eCi/8mveXoIEFQX1PLcKCwRvmOIxrY4dJC92HXxE/vNwY5cW5/qau55
	 BZfHSS5W9L4mus2ZSjbp+hq4lPn7kmWMgrZWpe007kpCzeGxLbM8ZujOw0VmJIDOHy
	 Zfe/eqdvQGsAIZVBYGCLM875Pude9990ps3qdUgNY8dDK2KyfgbXbHJilrpwZ+LKDx
	 gxZphJcAelgqj4GYiO+zwrhBm1xoYVst3WnlkALG+dTs+/iJ6NIeBtOCoT+87Pnn6C
	 drNG+t4/WJfWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Levi Yun <yeoreum.yun@arm.com>,
	Denis Nikitin <denik@chromium.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 22/36] dma-debug: fix a possible deadlock on radix_lock
Date: Sun, 24 Nov 2024 08:51:36 -0500
Message-ID: <20241124135219.3349183-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 09ccb4d6bc7b6..b3961b4ae1696 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1046,9 +1046,13 @@ static void check_unmap(struct dma_debug_entry *ref)
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


