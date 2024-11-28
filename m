Return-Path: <stable+bounces-95717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312CE9DB906
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD785162329
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C61A9B30;
	Thu, 28 Nov 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1A89yUW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7F19CD01
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801389; cv=none; b=ABud6o+DZplcsnzUSTdc+YuhnCRroK8riEmbG7CpLdheA5MgKoxK79vsn5/g9+Z1K+UA+74YEvJQorGnnt8bSOLd4J+92OJTj7G8XYT/I+lSZC4FkNj0hvFDDckVZcTokk0TCIBY4ib9TShYWaB5vpYAerhd29Fmc2b+Gmk8I8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801389; c=relaxed/simple;
	bh=3Aup2d1aeSNMNBUFE+TPTRws2rPEY3PKdskYtKp4Los=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRtvFnMUoqrXsBmrnHKpEyDFvJJVfSA/sW6Ua9FX+RmVnk5AOw89kii1DltThv4mfQelHKE/9f8kMQBtAtBK4hOICfW/Ycp7ioYGUtUGH+CQx+MKibnczyMfxOoz2zKWNvEo9eAMhZCW/rzXTcuYC7Nm5NLVYUAySOV6s2Ak4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1A89yUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963CAC4CECE;
	Thu, 28 Nov 2024 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732801389;
	bh=3Aup2d1aeSNMNBUFE+TPTRws2rPEY3PKdskYtKp4Los=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1A89yUWUTJOE8suAsd0Fm6wOWAwjmP+9uY/pcaq7Byjimc9wPEaTFE0Suu6fe5jQ
	 dkUoppcPk836V5s/Dx8EzTGT4ZXO0mES3kVCiA/4BZfkcBp6/jhDLE7ds4NhSt8znP
	 s0ikapEMaTskhOsqOXA+IkdUf8WbfhjaeJ5AbM7Vm4mJl9SAtTcHZknsfawaVfcC/y
	 XeVp1o7ltfvr+DXaZVp4csvxjp0w2FgLkFFYvjD4OgKBRsHvwMCpi7AC+Nu760Uk6m
	 XapOdDKgNlu6zkz4FOM1T3oYrAoLoA/OC8NIBBSAKWkw4WkBMpASYuMgfYCON1Hc5x
	 qwJcDAKfk96uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1] drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer
Date: Thu, 28 Nov 2024 07:56:52 -0500
Message-ID: <20241127185354-55c4b20d9fef4523@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241113121030.2405520-1-vamsi-krishna.brahmajosyula@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: c86ad39140bbcb9dc75a10046c2221f657e8083b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Commit author: Philip Yang <Philip.Yang@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 6c9289806591)
6.6.y | Present (different SHA1: 30ceb873cc2e)
6.1.y | Present (different SHA1: e7831613cbbc)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 18:53:41.547836112 -0500
+++ /tmp/tmp.rI5o4mVBXo	2024-11-27 18:53:41.540011125 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit c86ad39140bbcb9dc75a10046c2221f657e8083b ]
+
 Pass pointer reference to amdgpu_bo_unref to clear the correct pointer,
 otherwise amdgpu_bo_unref clear the local variable, the original pointer
 not set to NULL, this could cause use-after-free bug.
@@ -6,6 +8,8 @@
 Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
 Acked-by: Christian König <christian.koenig@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
 ---
  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         | 14 +++++++-------
  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  2 +-
@@ -18,10 +22,10 @@
  8 files changed, 16 insertions(+), 16 deletions(-)
 
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
-index 03205e3c37463..c272461d70a9a 100644
+index 5d9a34601a1a..c31e5f9d63da 100644
 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
-@@ -364,15 +364,15 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
+@@ -344,15 +344,15 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
  	return r;
  }
  
@@ -45,10 +49,10 @@
  
  int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
-index 66b1c72c81e59..6e591280774b9 100644
+index 4b694886715c..c7672a1d1560 100644
 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
-@@ -235,7 +235,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
+@@ -210,7 +210,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
  int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
  				void **mem_obj, uint64_t *gpu_addr,
  				void **cpu_ptr, bool mqd_gfx9);
@@ -58,45 +62,45 @@
  				void **mem_obj);
  void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
 diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
-index 1d9b21628be7e..823f245dc7d08 100644
+index e3cd66c4d95d..f83574107eb8 100644
 --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
-@@ -423,7 +423,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
+@@ -408,7 +408,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
  
  err_create_queue:
  	if (wptr_bo)
 -		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
 +		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
  err_wptr_map_gart:
+ err_alloc_doorbells:
  err_bind_process:
- err_pdd:
 diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
-index f4d20adaa0689..6619028dd58ba 100644
+index 27820f0a282d..e2c055abfea9 100644
 --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
-@@ -907,7 +907,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
+@@ -673,7 +673,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
  kfd_doorbell_error:
  	kfd_gtt_sa_fini(kfd);
  kfd_gtt_sa_init_error:
 -	amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
 +	amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
  alloc_gtt_mem_failure:
- 	dev_err(kfd_device,
- 		"device %x:%x NOT added due to errors\n",
-@@ -925,7 +925,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
+ 	if (kfd->gws)
+ 		amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
+@@ -693,7 +693,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
  		kfd_doorbell_fini(kfd);
  		ida_destroy(&kfd->doorbell_ida);
  		kfd_gtt_sa_fini(kfd);
 -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
 +		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
+ 		if (kfd->gws)
+ 			amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
  	}
- 
- 	kfree(kfd);
 diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
-index 4f48507418d2f..420444eb8e982 100644
+index 1b7b29426480..3ab0a796af06 100644
 --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
-@@ -2621,7 +2621,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
+@@ -2392,7 +2392,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
  {
  	WARN(!mqd, "No hiq sdma mqd trunk to free");
  
@@ -106,10 +110,10 @@
  
  void device_queue_manager_uninit(struct device_queue_manager *dqm)
 diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
-index 50a81da43ce19..d9ae854b69084 100644
+index 623ccd227b7d..c733d6888c30 100644
 --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
-@@ -225,7 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
+@@ -204,7 +204,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
  	      struct kfd_mem_obj *mqd_mem_obj)
  {
  	if (mqd_mem_obj->gtt_mem) {
@@ -119,12 +123,12 @@
  	} else {
  		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
 diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
-index 17e42161b0151..9e29b92eb523d 100644
+index 5bca6abd55ae..9582c9449fff 100644
 --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
-@@ -1048,7 +1048,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
+@@ -1052,7 +1052,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
  
- 		if (pdd->dev->kfd->shared_resources.enable_mes)
+ 		if (pdd->dev->shared_resources.enable_mes)
  			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
 -						   pdd->proc_ctx_bo);
 +						   &pdd->proc_ctx_bo);
@@ -132,18 +136,21 @@
  		 * before destroying pdd, make sure to report availability
  		 * for auto suspend
 diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
-index 21f5a1fb3bf88..36f0460cbffe6 100644
+index 99aa8a8399d6..1918a3c06ac8 100644
 --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
-@@ -204,9 +204,9 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
- 	}
- 
- 	if (dev->kfd->shared_resources.enable_mes) {
--		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
-+		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
- 		if (pqn->q->wptr_bo)
--			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
-+			amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
- 	}
- }
+@@ -441,9 +441,9 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
  
+ 		if (dev->shared_resources.enable_mes) {
+ 			amdgpu_amdkfd_free_gtt_mem(dev->adev,
+-						   pqn->q->gang_ctx_bo);
++						   &pqn->q->gang_ctx_bo);
+ 			if (pqn->q->wptr_bo)
+-				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
++				amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
+ 
+ 		}
+ 		uninit_queue(pqn->q);
+-- 
+2.39.4
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Failed     |  N/A       |

