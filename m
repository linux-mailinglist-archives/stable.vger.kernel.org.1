Return-Path: <stable+bounces-103502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1659EF856
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF551654E6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1413222D62;
	Thu, 12 Dec 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSnDT+SF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4F20A5EE;
	Thu, 12 Dec 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024763; cv=none; b=UUgpvkGbM/phNh+uivRQQR/f5XwCe7rar/CSDA/CTBpUK57gAIISQFQ18RWLA3RG5Hd1AaFMhOLocOQHPCTsvNECQenD8hoQPoRh+EEiOOQfBBRXsZqmSk0C7l+rpkXIygMXCvxkNTnVVwIt3ndGWGksp4P9d0VsCOhLRPvaxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024763; c=relaxed/simple;
	bh=XAFCdz/ZEWmKSsqajo0bqbMu3ReOae8OJOz9NY1WtGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOnaGHR4KcObCEkmJvdU4x/A4t+uUUSJMfSflDbhjWDchrMp844Myuc4R/bjyJ1tGngfE4c6tc7IPsqRxq3Xyjs+9KdrZM3gEhBm8YUSSm09U2oOqGr6hdW8z4Xek54cpkabmC61YYJBYkAHVSIZmHl6Y3KUINW1VSZOILQPqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSnDT+SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5C1C4CED0;
	Thu, 12 Dec 2024 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024763;
	bh=XAFCdz/ZEWmKSsqajo0bqbMu3ReOae8OJOz9NY1WtGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSnDT+SFqmVk6b7nntE0b56GIPWt8Jc7RLlV1Hnd64Fzyg86AMjk8tmymWgQl/6D2
	 Ewjdn2BO07z+uIZNAUBE50VWJj8mGdQv+q93amCkmgRtG0rYG8P8nXuO92VaqZczNE
	 VFFXCKS475E/61EIvcpwbT3DH3IAwTKW9KMHSs5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Denis Nikitin <denik@chromium.org>,
	Levi Yun <yeoreum.yun@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 403/459] dma-debug: fix a possible deadlock on radix_lock
Date: Thu, 12 Dec 2024 16:02:21 +0100
Message-ID: <20241212144309.682798698@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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




