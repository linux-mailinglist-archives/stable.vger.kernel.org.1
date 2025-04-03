Return-Path: <stable+bounces-128063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8478A7AECD
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFB0173270
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C9224B07;
	Thu,  3 Apr 2025 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8hokcfl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07373224AF9;
	Thu,  3 Apr 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707881; cv=none; b=GVEFWXwZXAF2I8cPhU+vgzaAOvt/UbGL/UgqWH9pOzxqzOuJDHWBWh2v2hBEBFw2LtsOmdVbhw9HrBPGtINARLHdQ/a50HzyMKCZeUoL0Tnc/WRZRl/TW9ItZxK3/vYwd1vz7p6lAFWZcb3vteSwM7fJg/GegP0kGdm/dNLCxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707881; c=relaxed/simple;
	bh=X4xFh0c3hoeQlHdQxeeQPYkoirMgwJJycyh1alAO5As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmMAagbWXnUDIrZKKJuGFVF3tmupcy12fHmR9hK+ueMXdZiHwfT3EoC2kNJ5jgh2AUy8Y1wQAmMer+gJIyocA8nkjyuEq9kCrzE16kcsOHw2N6a4OGgBRdU4a98ErADsIF/6tOvUlKOPlJ1ie2aZG1UmmQhGvgMAzmplWcmDOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8hokcfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B22C4CEE9;
	Thu,  3 Apr 2025 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707879;
	bh=X4xFh0c3hoeQlHdQxeeQPYkoirMgwJJycyh1alAO5As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8hokcflZtluLoGVzTZN5qV0Vr62iStR7cGeDDXNI4X7hq+W7SFdFBCY03re1Z+on
	 BS2MvvsEsgQugAmm5YYMNG8bEq/H82S28inabrK+PaMDCaLnVgyxJemJlGkJrhOV6H
	 tLxC8BBXXy3yHYf2VaYwdmKo2u6uAF6pznl1B4HvaiYsKRJBdmdaqgwBCyubpQROJY
	 NKsxsXOO94mkXLitO3dNvEM0UK0iAN3heThfS/aVVwq6dexzahEVL/ZrEvYsO86+Wx
	 Uq8QpTJ/N41dOb6RZUsvyuhAw6s3L+/N8sxd4ZlSDYdoacd3cIFdnUIpcGjQqR03tI
	 Y/ENKVi1QIeVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emily Deng <Emily.Deng@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 25/33] drm/amdgpu: Fix the race condition for draining retry fault
Date: Thu,  3 Apr 2025 15:16:48 -0400
Message-Id: <20250403191656.2680995-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Emily Deng <Emily.Deng@amd.com>

[ Upstream commit f844732e3ad9c4b78df7436232949b8d2096d1a6 ]

Issue:
In the scenario where svm_range_restore_pages is called, but
svm->checkpoint_ts has not been set and the retry fault has not been
drained, svm_range_unmap_from_cpu is triggered and calls svm_range_free.
Meanwhile, svm_range_restore_pages continues execution and reaches
svm_range_from_addr. This results in a "failed to find prange..." error,
 causing the page recovery to fail.

How to fix:
Move the timestamp check code under the protection of svm->lock.

v2:
Make sure all right locks are released before go out.

v3:
Directly goto out_unlock_svms, and return -EAGAIN.

v4:
Refine code.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 31 +++++++++++++++-------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8c61dee5ca0db..b50283864dcd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2992,19 +2992,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	/* check if this page fault time stamp is before svms->checkpoint_ts */
-	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
-			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
-			r = 0;
-			goto out;
-		} else
-			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
-			 * to zero to avoid following ts wrap around give wrong comparing
-			 */
-			svms->checkpoint_ts[gpuidx] = 0;
-	}
-
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
 		r = -EFAULT;
@@ -3024,6 +3011,21 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&svms->lock);
+
+	/* check if this page fault time stamp is before svms->checkpoint_ts */
+	if (svms->checkpoint_ts[gpuidx] != 0) {
+		if (amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
+			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+			r = -EAGAIN;
+			goto out_unlock_svms;
+		} else {
+			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
+			 * to zero to avoid following ts wrap around give wrong comparing
+			 */
+			svms->checkpoint_ts[gpuidx] = 0;
+		}
+	}
+
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
@@ -3148,7 +3150,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
 
-	svm_range_count_fault(node, p, gpuidx);
+	if (r != -EAGAIN)
+		svm_range_count_fault(node, p, gpuidx);
 
 	mmput(mm);
 out:
-- 
2.39.5


