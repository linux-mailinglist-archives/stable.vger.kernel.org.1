Return-Path: <stable+bounces-95127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C963E9D768B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCC3BE75FA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002191E00B5;
	Sun, 24 Nov 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUm+5sar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1B1AB525;
	Sun, 24 Nov 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456088; cv=none; b=A9OfTHaXuqcaLB2Ll1vIlhg79DPL25x7ZaajTzb4EA+At+hljRkMu4JCf1nm6UfMRYFPlmerg/9mNdSn0HRvBJW1AjsX+LUvHSKcycp866djFrJMN+A9V2iN9aNVqeaCOO6bHPZtFdsQIoUH5YOK4fT3US8ZmFGbUxGCZZ8NvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456088; c=relaxed/simple;
	bh=ecwFZVOGUBwMbpiCjh+SZfMoELUsFII1XMh8Wd8j1Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THSvWpT/YdU4x8QZrQkRKyxAQJKYiLIDza3cprtVGZgWPXSUjtd4ExMr9Yb5gAaBWuZK4JCiVZzwfAzWwbYtZDmUm0j6LsC8V8JT/epzyZ/+4CfcoXaRDNKLLPOZRhj6zczQ0q7JnwsqKGN9Ex12UeS8rWjsIlJvffJIK0aeAOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUm+5sar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD83FC4CED1;
	Sun, 24 Nov 2024 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456088;
	bh=ecwFZVOGUBwMbpiCjh+SZfMoELUsFII1XMh8Wd8j1Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUm+5saros1DR21QZMRmq31WKRMH23DOX0Jo8xC70GA7Iak7YTlOYomRtpXSkTn4Y
	 jrx2phCPM7/FsyZPOR5/FVqAyeM2zza01moNA9OXlMjsOYvZjQeBuYmrkSWKr7ZWIG
	 GV/W7Jcd+Rb3MxizgcUb98NOwgGJofzkhu8Kz8re+JW5VnHr5rCQeoQL+xAX9Zs5lD
	 E/7ROf4U7cHl1SpNPfEiYg5KT7Av8THDi+6etgPoDX2qkJdzoWekx/Ddr+4k99O5Bo
	 zpia69kO1F+lHQZOao4hxnd1KUioX0WhbYzyvKeEdOz3BTpdh4ijKWj69mN61bA3zv
	 GjSjS4qxZPM4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Levi Yun <yeoreum.yun@arm.com>,
	Denis Nikitin <denik@chromium.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 37/61] dma-debug: fix a possible deadlock on radix_lock
Date: Sun, 24 Nov 2024 08:45:12 -0500
Message-ID: <20241124134637.3346391-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index e472cc37d7de4..958d4aa77dcad 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1051,9 +1051,13 @@ static void check_unmap(struct dma_debug_entry *ref)
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


