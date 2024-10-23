Return-Path: <stable+bounces-87860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F69ACC9E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617121C211B6
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AFD1C243C;
	Wed, 23 Oct 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpjxtX3R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547B1D220E;
	Wed, 23 Oct 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693857; cv=none; b=h1bpwtnmq+jV/B7Qg90GYLs9SAttBdvFoD+uQO5YRqHJIQ1p8NEqquEl74wTESX6kf1oZGeQGYEx02D7uR4UajIq8BsDE2ToYxYVZcp1AQvrygbtWgW2pT3ZlcB6GdU1HUyyHjx9GmzYejHx9Dc1xOZMnVvcaO+M3qbW7X3b2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693857; c=relaxed/simple;
	bh=Nk8qCWQ307kmEpfsHVOuCm6C4sREZOR7OsOzfBSl3g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy7qQq7iaIrG+yggJhWIM+nV/NvoQCHVAFPtZ6Lfo378fQ4ly6kDCL3mS++abrgcufMeo2xwYV2EoWN+tjLNDQpPCAN9PKdolvPuElIYB1afpebhS4bSiJJCWLhfuVOMJzSFPwKb5IwIGpfBVxfEKx0sBOyL2gZMDTUGTG5b5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpjxtX3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003B6C4CEC6;
	Wed, 23 Oct 2024 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693857;
	bh=Nk8qCWQ307kmEpfsHVOuCm6C4sREZOR7OsOzfBSl3g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpjxtX3Rx7+ZL1tOnAvamtWQQYSYJn1mIbzhYJWmythzBtIixUwMcNWv8tHkWa31M
	 ISdDzXQtKagJeqhU7Yy47sh34+1a9yvmyDFewduCF9MTac/c/RH05t34DZLmNx///Z
	 +5aiNrrLuvdhayU2u7CCTa3meqT4qLoKcGsPhTY318VVjaXxyLzDk5YQaPTpOk3zAL
	 YqNJSIo+CW6nLcMsP28Gg4o5A1jIQH7t8lRId/3uE9MSlt1BiI+q+M7OOQgZWGaxwh
	 QxhvwgiJk+R/gKPp+evOxdVbJwlETLbU68DdOPcFsOWabvZWV9LED8udTn4rqBSMSd
	 mItrTH6lq48Bw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 25/30] drm/amdkfd: Accounting pdd vram_usage for svm
Date: Wed, 23 Oct 2024 10:29:50 -0400
Message-ID: <20241023143012.2980728-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 68d26c10ef503175df3142db6fcd75dd94860592 ]

Process device data pdd->vram_usage is read by rocm-smi via sysfs, this
is currently missing the svm_bo usage accounting, so "rocm-smi
--showpids" per process VRAM usage report is incorrect.

Add pdd->vram_usage accounting when svm_bo allocation and release,
change to atomic64_t type because it is updated outside process mutex
now.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 98c0b0efcc11f2a5ddf3ce33af1e48eedf808b04)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 26 ++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 546b02f2241a6..5953bc5f31192 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1170,7 +1170,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 
 		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
 			size >>= 1;
-		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(size));
+		atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
 	}
 
 	mutex_unlock(&p->mutex);
@@ -1241,7 +1241,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		kfd_process_device_remove_obj_handle(
 			pdd, GET_IDR_HANDLE(args->handle));
 
-	WRITE_ONCE(pdd->vram_usage, pdd->vram_usage - size);
+	atomic64_sub(size, &pdd->vram_usage);
 
 err_unlock:
 err_pdd:
@@ -2346,7 +2346,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		bo_bucket->restored_offset = offset;
 		/* Update the VRAM usage count */
-		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + bo_bucket->size);
+		atomic64_add(bo_bucket->size, &pdd->vram_usage);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2b3ec92981e8f..f35741fade911 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -766,7 +766,7 @@ struct kfd_process_device {
 	enum kfd_pdd_bound bound;
 
 	/* VRAM usage */
-	uint64_t vram_usage;
+	atomic64_t vram_usage;
 	struct attribute attr_vram;
 	char vram_filename[MAX_SYSFS_FILENAME_LEN];
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e44892109f71b..8343b3e4de7b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -306,7 +306,7 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 	} else if (strncmp(attr->name, "vram_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_vram);
-		return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
+		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
 	} else if (strncmp(attr->name, "sdma_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_sdma);
@@ -1599,7 +1599,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
 	pdd->runtime_inuse = false;
-	pdd->vram_usage = 0;
+	atomic64_set(&pdd->vram_usage, 0);
 	pdd->sdma_past_activity_counter = 0;
 	pdd->user_gpu_id = dev->id;
 	atomic64_set(&pdd->evict_duration_counter, 0);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bd9c2921e0dcc..7d00d89586a10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -404,6 +404,27 @@ static void svm_range_bo_release(struct kref *kref)
 		spin_lock(&svm_bo->list_lock);
 	}
 	spin_unlock(&svm_bo->list_lock);
+
+	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
+		struct kfd_process_device *pdd;
+		struct kfd_process *p;
+		struct mm_struct *mm;
+
+		mm = svm_bo->eviction_fence->mm;
+		/*
+		 * The forked child process takes svm_bo device pages ref, svm_bo could be
+		 * released after parent process is gone.
+		 */
+		p = kfd_lookup_process_by_mm(mm);
+		if (p) {
+			pdd = kfd_get_process_device_data(svm_bo->node, p);
+			if (pdd)
+				atomic64_sub(amdgpu_bo_size(svm_bo->bo), &pdd->vram_usage);
+			kfd_unref_process(p);
+		}
+		mmput(mm);
+	}
+
 	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
 		/* We're not in the eviction worker. Signal the fence. */
 		dma_fence_signal(&svm_bo->eviction_fence->base);
@@ -531,6 +552,7 @@ int
 svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			bool clear)
 {
+	struct kfd_process_device *pdd;
 	struct amdgpu_bo_param bp;
 	struct svm_range_bo *svm_bo;
 	struct amdgpu_bo_user *ubo;
@@ -622,6 +644,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	list_add(&prange->svm_bo_list, &svm_bo->range_list);
 	spin_unlock(&svm_bo->list_lock);
 
+	pdd = svm_range_get_pdd_by_node(prange, node);
+	if (pdd)
+		atomic64_add(amdgpu_bo_size(bo), &pdd->vram_usage);
+
 	return 0;
 
 reserve_bo_failed:
-- 
2.43.0


