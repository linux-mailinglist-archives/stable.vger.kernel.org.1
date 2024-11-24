Return-Path: <stable+bounces-95254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EF39D749C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C625C167077
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7A243F48;
	Sun, 24 Nov 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDR+BlkA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E1243F40;
	Sun, 24 Nov 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456487; cv=none; b=dQ9lB/3f5IKCt38hNCQbPGMBj1Wj8Bp7EzJ2MPDiktsRJ34jVa4oNp+0lXIBRYOYkrCrXW09I3viK/tQNtmu8/8RH1fNLCnaHxm35Tyk5cfo/zPYwH3Jb61cFZKhCqgSbzMlrj2YJ5J6+MDTDQIAMCgeWvQknoh960tL7s5jEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456487; c=relaxed/simple;
	bh=JXIjwxav2mmSu9zJnIHqUqu6fT03HYX+ngk815ZGjWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRHrqEBDvAH6k0oU5mK31VSmDa8dtwJs91eT/Zz+B2q2rM6orDqi9FXV8huzbbuyH8PH9OtAio+4JXURxyfdn8FphmZcDmaMXAJiRjSFDVs8zUgnCcLfuqPCU8vU3nyXxKkP6wKXWbAzDIU8linE1FYrhapYuuBGWzATHqV7fcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDR+BlkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79083C4CECC;
	Sun, 24 Nov 2024 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456487;
	bh=JXIjwxav2mmSu9zJnIHqUqu6fT03HYX+ngk815ZGjWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDR+BlkA64zzx6YntkahbjjmdO+dNw44Ez3zTIHwofoQMqFLJnY3OIxQzs6Bdu5W9
	 9/Y22mWep4y4WVLxjyuBP0yQ9czBOCEAKhAqiWWnu4y7evssutwwLD2scwO/BmHuzk
	 hgpCBhXX4vUzMONXLh67LNZQLmKSvxeACmvW5qOdI5a4/MuwDHnvhEWXGmXjuXoVr1
	 Kk/PNpV0gQR2Kgqsbn4Etq8CBBAWPusAvJKW/Z77hUQJ82tfECOUa2ItEkIC8YqcVr
	 IcL7cdOnqcNXlB5YLPBP84yx81Eo7IUL+BuMIWOY4lRGGm2eecBClC18mowd02vlhv
	 OK3nzi9FgiWXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Levi Yun <yeoreum.yun@arm.com>,
	Denis Nikitin <denik@chromium.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 19/33] dma-debug: fix a possible deadlock on radix_lock
Date: Sun, 24 Nov 2024 08:53:31 -0500
Message-ID: <20241124135410.3349976-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 654b039dfc335..d19f610c9eef8 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1047,9 +1047,13 @@ static void check_unmap(struct dma_debug_entry *ref)
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


