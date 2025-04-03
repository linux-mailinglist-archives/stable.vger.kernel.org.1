Return-Path: <stable+bounces-128030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3743A7AE76
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43D03B3569
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436C5206F06;
	Thu,  3 Apr 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTEhP7EL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D02066F8;
	Thu,  3 Apr 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707799; cv=none; b=J9MY3APtX/Lioyxl4+178t7ecf2YI4bWS9UPIrfoYz4qc6tqgWUC/+4yqM4TMlb/tZPGSXTr4C+sBKLN+u3un7pWKNjbe6nwsI3edV3MR4Z4gRMGsuck69Ccu4bQbOXoDEHLFqM9EagneSIqkfkVTBj9PBP3T+tbKm8kr/EqYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707799; c=relaxed/simple;
	bh=N5vEAPhIXp8QThO2m4vvumB+oYonZK64P/jqdtUmfak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJihgo2ljlEB2B9a59IMJkA3VnEQxfAbIYgWZbyCTt5zxETvixFNH3pp98/FfN366K1v45V0H4CxNifN3MFER8YGcPN+rFi7GeueeQ8TwZTppzu95SUS8uuhSu1V5t8BcjvWo9rL50eflaE5eFal7nkUFl5x5y47WKGXdTT5eAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTEhP7EL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D88AC4CEE8;
	Thu,  3 Apr 2025 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707798;
	bh=N5vEAPhIXp8QThO2m4vvumB+oYonZK64P/jqdtUmfak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTEhP7EL5GhLxhrzULjrQidertxXT6WZvMa9jfFjrX+rzNdryDxG323s0mXAPWDD4
	 Y0le3a7Y1Z4dFN8PbcHRIQcru9smpAIGd8y8uJTljFrgQe79SwY84WhSLt8pda6DXh
	 s+vGGyPDMhadiuB/+zyfuz8NxNTWtW8ucfagdyW0VQoJkC9pjXXsXUK7fGk24UtC14
	 amk2spKxFK6OQoinifv/rlmFL9QsWdvE2JCbSIPvLQ/R2eUKArJ6l+f5Xtgo6Zad6g
	 PghZI2IBjvpvc1bxoTdS5P67p11lw3t98OpVQKOslt3w0AAT8+woefc6umQXQnarsO
	 GCxHhpYxMYizA==
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
Subject: [PATCH AUTOSEL 6.13 29/37] drm/amdgpu: Fix the race condition for draining retry fault
Date: Thu,  3 Apr 2025 15:15:05 -0400
Message-Id: <20250403191513.2680235-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 1b04d54f9a69c..4eeea51c9a0eb 100644
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
@@ -3149,7 +3151,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
 
-	svm_range_count_fault(node, p, gpuidx);
+	if (r != -EAGAIN)
+		svm_range_count_fault(node, p, gpuidx);
 
 	mmput(mm);
 out:
-- 
2.39.5


