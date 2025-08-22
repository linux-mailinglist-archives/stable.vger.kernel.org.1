Return-Path: <stable+bounces-172511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59B2B3233A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF79B172DB0
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E262D6406;
	Fri, 22 Aug 2025 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss25trTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74212D5C9B
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892414; cv=none; b=kY6zKqIsbRq2+QKMpNgsesk2UFiZRWap6FKVq3Uahr/kAiB09PxmM6XMK50oqX6yLnQOviXQPFMjTLh24eHCDG7SPdFbligiz/CG3cDBojNgRcq6YsFA0ol7PzYqrL6eUuCOsA9o0O9KLLsJ/depBM1k1f0mCxky6a5nAFsK5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892414; c=relaxed/simple;
	bh=d9MA8uiriHF15PiPGOA4M9rN0XyFrynoSJ6A6w67zBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIIqICTEHM3PQ1FgE7j7My4JvwPdpsmrCa6H2sL3DhZxtmrWUhqhKyl7/hEOqykqCdT2Lm+93vbFFY9pQ2ZylpThrpdEuBuJvkIw74WLpcRD0bwE48K0oi/wbgOEHRsIQ3H+IWhvzT+C+URjjft+KgQSwYSNlbDjDIdsm6LOlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss25trTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DCFC116C6;
	Fri, 22 Aug 2025 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755892414;
	bh=d9MA8uiriHF15PiPGOA4M9rN0XyFrynoSJ6A6w67zBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ss25trTc1gP7+epHgDIrNis/6r1YGkhK5OMlj2rk4u4y0dYghlOTvW5pgfmQ6AYlz
	 m6ctO5T8LI0TQKvUr2phFYgr/ztgEY0VLA4QAtF+SqnJ4vv5q3fHOdxmZoPVI0CkEE
	 EjbPiMnYz4d1PuhDWIAB4gsLekhGlvj8QWDfMUFXZb+b5Avr5rdIjvb9WKbZDW5azI
	 VPDxFsBbY/BVjDQWearPOOABYauOjhCOjUGIOMk+zRw08K+PWsQyq+Rz53WttbSoxI
	 IX+TqiHoA/LXq0bbICGJyh6MQcXHp5qYO7XEtn5gk4VHSluJaXk9jKM8xqqoiA9o47
	 HPQxPe2GsIyiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] asm-generic: Add memory barrier dma_mb()
Date: Fri, 22 Aug 2025 15:53:29 -0400
Message-ID: <20250822195330.1458412-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822195330.1458412-1-sashal@kernel.org>
References: <2025082153-saline-camcorder-75cb@gregkh>
 <20250822195330.1458412-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit ed59dfd9509d172e4920994ed9cbebf93b0050cc ]

The memory barrier dma_mb() is introduced by commit a76a37777f2c
("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
which is used to ensure that prior (both reads and writes) accesses
to memory by a CPU are ordered w.r.t. a subsequent MMIO write.

Reviewed-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20220523113126.171714-2-wangkefeng.wang@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: aa6956150f82 ("wifi: ath11k: fix dest ring-buffer corruption when ring is full")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/memory-barriers.txt | 11 ++++++-----
 include/asm-generic/barrier.h     |  8 ++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 17c8e0c2deb4..774816cf15be 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1894,6 +1894,7 @@ There are some more advanced barrier functions:
 
  (*) dma_wmb();
  (*) dma_rmb();
+ (*) dma_mb();
 
      These are for use with consistent memory to guarantee the ordering
      of writes or reads of shared memory accessible to both the CPU and a
@@ -1925,11 +1926,11 @@ There are some more advanced barrier functions:
      The dma_rmb() allows us guarantee the device has released ownership
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
-     can see it now has ownership.  Note that, when using writel(), a prior
-     wmb() is not needed to guarantee that the cache coherent memory writes
-     have completed before writing to the MMIO region.  The cheaper
-     writel_relaxed() does not provide this guarantee and must not be used
-     here.
+     can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
+     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
+     to guarantee that the cache coherent memory writes have completed before
+     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
+     this guarantee and must not be used here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
      relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 05aae2922485..ce75c53dd338 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -37,6 +37,10 @@
 #define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
 #endif
 
+#ifdef __dma_mb
+#define dma_mb()	do { kcsan_mb(); __dma_mb(); } while (0)
+#endif
+
 #ifdef __dma_rmb
 #define dma_rmb()	do { kcsan_rmb(); __dma_rmb(); } while (0)
 #endif
@@ -64,6 +68,10 @@
 #define wmb()	mb()
 #endif
 
+#ifndef dma_mb
+#define dma_mb()	mb()
+#endif
+
 #ifndef dma_rmb
 #define dma_rmb()	rmb()
 #endif
-- 
2.50.1


