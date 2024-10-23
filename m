Return-Path: <stable+bounces-87884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0362F9ACCE3
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883471F260D5
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F2204943;
	Wed, 23 Oct 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYOfheQE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55F20493C;
	Wed, 23 Oct 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693908; cv=none; b=Rm8I0d8N6mUmHseFviq8ixV/HmorYNftiHJGXQdHQIuZOVkArSVFDajfOTSqxPrVXCq5b+5312mo+rGVs1F5Z24+wBXroovichEZnYrrRFT2JpDZ227flG9ZsIscSZ6acPKrGNJziGsZHZHk/fjulLKkrDRB0Unb+hgOXbpbuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693908; c=relaxed/simple;
	bh=OMBE3KBL5e4ENj1cJuFJt/+43Jy8xNIpcLf5cWGb9hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BN/fUriHLv4wtAm+7OHP0in/f9xCXcQ2gaG5Nh7n0FGW5nyM9OX//icHndvUsfrSyTOk0D+xVOc5KEurCKD5nQncCNXAJ0+uTNNfv7iFG92yUIhbqWgUU4ddzmEtEKya3i2muNRtpitgWZRqo4Cx7klCwNL1Cye5/oG6pcJavVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYOfheQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9375C4CECD;
	Wed, 23 Oct 2024 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693908;
	bh=OMBE3KBL5e4ENj1cJuFJt/+43Jy8xNIpcLf5cWGb9hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYOfheQElOSqK8n3XXpS7tKaM+71eed2jNf95XUWULTRj3zFiYGOX+5/zXSFSHL2+
	 cW1fD12ni3wmMxIKwXTYqVcr509o0PPjiMu8uZHNezLgGrPB/iaQLZBhulLG18+66I
	 EGWj3op6nFzqMOtemCtXhfT0ZJWRcxzCNhdhUapJ2nVlBXmvAsVwjx2ubnarLyMrfR
	 s6DqEwPI3WPakySEqQYFQjjWnHNLwAqP0KDMoCdl4Izjhu6O3xqUocv82uEnWOAtqI
	 GGX7K1rWsmtfW/pPXumAcsuO9BkUvG0r2ura6n/FMlZVt3PWJo4BM1KKXGEb4Kqiph
	 cexzGxIWxfh3g==
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
Subject: [PATCH AUTOSEL 6.6 19/23] drm/amdkfd: Accounting pdd vram_usage for svm
Date: Wed, 23 Oct 2024 10:31:03 -0400
Message-ID: <20241023143116.2981369-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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
index 19d46be639429..8669677662d0c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1164,7 +1164,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 
 		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
 			size >>= 1;
-		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(size));
+		atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
 	}
 
 	mutex_unlock(&p->mutex);
@@ -1235,7 +1235,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		kfd_process_device_remove_obj_handle(
 			pdd, GET_IDR_HANDLE(args->handle));
 
-	WRITE_ONCE(pdd->vram_usage, pdd->vram_usage - size);
+	atomic64_sub(size, &pdd->vram_usage);
 
 err_unlock:
 err_pdd:
@@ -2352,7 +2352,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		bo_bucket->restored_offset = offset;
 		/* Update the VRAM usage count */
-		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + bo_bucket->size);
+		atomic64_add(bo_bucket->size, &pdd->vram_usage);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 67204c3dfbb8f..27c9d5c43765a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -765,7 +765,7 @@ struct kfd_process_device {
 	enum kfd_pdd_bound bound;
 
 	/* VRAM usage */
-	uint64_t vram_usage;
+	atomic64_t vram_usage;
 	struct attribute attr_vram;
 	char vram_filename[MAX_SYSFS_FILENAME_LEN];
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 43f520b379670..6c90231e0aec2 100644
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
@@ -1589,7 +1589,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
 	pdd->runtime_inuse = false;
-	pdd->vram_usage = 0;
+	atomic64_set(&pdd->vram_usage, 0);
 	pdd->sdma_past_activity_counter = 0;
 	pdd->user_gpu_id = dev->id;
 	atomic64_set(&pdd->evict_duration_counter, 0);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ce76d45549984..6b7c6f45a80a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -391,6 +391,27 @@ static void svm_range_bo_release(struct kref *kref)
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
@@ -518,6 +539,7 @@ int
 svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			bool clear)
 {
+	struct kfd_process_device *pdd;
 	struct amdgpu_bo_param bp;
 	struct svm_range_bo *svm_bo;
 	struct amdgpu_bo_user *ubo;
@@ -609,6 +631,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
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


