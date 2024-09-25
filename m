Return-Path: <stable+bounces-77223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0365985A9A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D621C23849
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9618CC19;
	Wed, 25 Sep 2024 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgmoahIJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988E18CBE3;
	Wed, 25 Sep 2024 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264561; cv=none; b=XHZYJgfNZatKLx0bfDcacG6Q0RrS867vXdXfi0IAITWQYgRFp9mhayMMd0Y4IBhVPdnjUJEGq/Hv1XNaURazlrAzdziVJqawLbDdFhbKKcn4YNfphZnTp9vbxliQdaSwzfLbGvoANGlfSNdwDNXdb+EgWcByFsIFgZRYQIZoan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264561; c=relaxed/simple;
	bh=JMFMOS9h1SFcfE3PvZXqJVWrSsGQtahNL+7V3qP+mYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMCdIEQKa0AGsXFfhf1qgqMYZh6e4zs19XMQJNdW4zgBy4CkqTXWiTQWjysdio6ZT7HJDAnN5U7IbC2Y3GpcCJu92FbyTvvBvtR3DawqV0fcrvJHVkOGDyLrumE6glwksO1NsmMYGapGw9NPno8W9lfEpclnvmmwB8XPXBTTJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgmoahIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F11C4CEC3;
	Wed, 25 Sep 2024 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264561;
	bh=JMFMOS9h1SFcfE3PvZXqJVWrSsGQtahNL+7V3qP+mYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgmoahIJNxJoPfSHjrugM6I9QL7tFEk+GsXWiVnuuHb7Dc3SxTH/IQeN7ha5MV5eN
	 riI9mCEFckGrTzyrJVs19Klu/FfbzObF3KiJR4A5MrOrY6b8bXYPzUlnSoNOqRqDT0
	 IRFHShJrwWX2WfjQdPmMGg/3DPC+HOKs1CMslIE4ARUT8y22r5SKzkD1IVkS0b6rqP
	 dVtoZ0k8FRZJq+PBtHt+nw0yDfKoBYcdbobbUCLpYp3sGaKNnyC7zn4ZGEE8IhcYoS
	 cm7LSh1x0UOY1b/Bu5ZH5RKwOV5TI7YqMQLv/9NUJWT6hsaOfxiw9GCBJ0JdZLBYVx
	 Dkhnfr7ZtkcXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 125/244] iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count
Date: Wed, 25 Sep 2024 07:25:46 -0400
Message-ID: <20240925113641.1297102-125-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Sanjay K Kumar <sanjay.k.kumar@intel.com>

[ Upstream commit 3cf74230c139f208b7fb313ae0054386eee31a81 ]

If qi_submit_sync() is invoked with 0 invalidation descriptors (for
instance, for DMA draining purposes), we can run into a bug where a
submitting thread fails to detect the completion of invalidation_wait.
Subsequently, this led to a soft lockup. Currently, there is no impact
by this bug on the existing users because no callers are submitting
invalidations with 0 descriptors. This fix will enable future users
(such as DMA drain) calling qi_submit_sync() with 0 count.

Suppose thread T1 invokes qi_submit_sync() with non-zero descriptors, while
concurrently, thread T2 calls qi_submit_sync() with zero descriptors. Both
threads then enter a while loop, waiting for their respective descriptors
to complete. T1 detects its completion (i.e., T1's invalidation_wait status
changes to QI_DONE by HW) and proceeds to call reclaim_free_desc() to
reclaim all descriptors, potentially including adjacent ones of other
threads that are also marked as QI_DONE.

During this time, while T2 is waiting to acquire the qi->q_lock, the IOMMU
hardware may complete the invalidation for T2, setting its status to
QI_DONE. However, if T1's execution of reclaim_free_desc() frees T2's
invalidation_wait descriptor and changes its status to QI_FREE, T2 will
not observe the QI_DONE status for its invalidation_wait and will
indefinitely remain stuck.

This soft lockup does not occur when only non-zero descriptors are
submitted.In such cases, invalidation descriptors are interspersed among
wait descriptors with the status QI_IN_USE, acting as barriers. These
barriers prevent the reclaim code from mistakenly freeing descriptors
belonging to other submitters.

Considered the following example timeline:
	T1			T2
========================================
	ID1
	WD1
	while(WD1!=QI_DONE)
	unlock
				lock
	WD1=QI_DONE*		WD2
				while(WD2!=QI_DONE)
				unlock
	lock
	WD1==QI_DONE?
	ID1=QI_DONE		WD2=DONE*
	reclaim()
	ID1=FREE
	WD1=FREE
	WD2=FREE
	unlock
				soft lockup! T2 never sees QI_DONE in WD2

Where:
ID = invalidation descriptor
WD = wait descriptor
* Written by hardware

The root of the problem is that the descriptor status QI_DONE flag is used
for two conflicting purposes:
1. signal a descriptor is ready for reclaim (to be freed)
2. signal by the hardware that a wait descriptor is complete

The solution (in this patch) is state separation by using QI_FREE flag
for #1.

Once a thread's invalidation descriptors are complete, their status would
be set to QI_FREE. The reclaim_free_desc() function would then only
free descriptors marked as QI_FREE instead of those marked as
QI_DONE. This change ensures that T2 (from the previous example) will
correctly observe the completion of its invalidation_wait (marked as
QI_DONE).

Signed-off-by: Sanjay K Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240728210059.1964602-1-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/dmar.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 1c8d3141cb55c..01e157d89a163 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1204,9 +1204,7 @@ static void free_iommu(struct intel_iommu *iommu)
  */
 static inline void reclaim_free_desc(struct q_inval *qi)
 {
-	while (qi->desc_status[qi->free_tail] == QI_DONE ||
-	       qi->desc_status[qi->free_tail] == QI_ABORT) {
-		qi->desc_status[qi->free_tail] = QI_FREE;
+	while (qi->desc_status[qi->free_tail] == QI_FREE && qi->free_tail != qi->free_head) {
 		qi->free_tail = (qi->free_tail + 1) % QI_LENGTH;
 		qi->free_cnt++;
 	}
@@ -1463,8 +1461,16 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		raw_spin_lock(&qi->q_lock);
 	}
 
-	for (i = 0; i < count; i++)
-		qi->desc_status[(index + i) % QI_LENGTH] = QI_DONE;
+	/*
+	 * The reclaim code can free descriptors from multiple submissions
+	 * starting from the tail of the queue. When count == 0, the
+	 * status of the standalone wait descriptor at the tail of the queue
+	 * must be set to QI_FREE to allow the reclaim code to proceed.
+	 * It is also possible that descriptors from one of the previous
+	 * submissions has to be reclaimed by a subsequent submission.
+	 */
+	for (i = 0; i <= count; i++)
+		qi->desc_status[(index + i) % QI_LENGTH] = QI_FREE;
 
 	reclaim_free_desc(qi);
 	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
-- 
2.43.0


