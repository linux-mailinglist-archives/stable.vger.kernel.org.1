Return-Path: <stable+bounces-10811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3480A82CCEC
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 15:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F02028483B
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF121345;
	Sat, 13 Jan 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="W8JhhEZ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25521342
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so6363147f8f.1
        for <stable@vger.kernel.org>; Sat, 13 Jan 2024 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1705154535; x=1705759335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9b2y71JQ/rv7KyOs+L9oV8vduucSu03AVFujHy9XAM=;
        b=W8JhhEZ/rWpbiWyGBSig5aY4i4g+xAJgU774bBxYbEtXo7INtJRsJ0YnW2j31A7DlN
         n2u/GgaezdScHu3Cmv5AfUobmaPJg3/o/E/ArlK/UPml6PCpNc+C8mhpTF9QoUzNc1lQ
         3m14FKatzbXOZDXxT0WLOFCQ+Sh1ynoAZeaiLRrYfoKPuSZYM1qTuzrq6L5mutxKNlio
         +zq2Y0ifp6uB+Ay9K88AKOF/jvA0igMMcYuccpaGxYUhIraFDE4NbTHZS36i2OmjHIVB
         j8l75cCo3CU0yLvX6afsCsd6ujrv8fnV+xLYC20F9IaIoNXNljYoe5w5PRwcZBLFkUn3
         iGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705154535; x=1705759335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9b2y71JQ/rv7KyOs+L9oV8vduucSu03AVFujHy9XAM=;
        b=NwrqSeYBIPgT5fBpTWXrZPgSZ5EL6Bf/w5aNGEA1WnKOf6NYWnWF5zQzz5P0ydKKAQ
         TdLoEqvvcBCcHHE5YZnmxQ4zaSG+5svZupEuYcOcZ7hGPdVbL83DKfN0gjDrOP5adH43
         XVQWcHJGQ5kBBOeNmiDdut/E6nV60yRWx3cZGcmjS+NboPznD4/RXJE4nRRRV0o3uRKF
         NDMWgIVWbohqd7S+RVVVTUp4Zd5h6XmnlHIxmEfzYS/dH8JWMrMLYg/bcOvAwIu2G4wJ
         XTnFfS/wr9vGTcR5A5E6+axvLdxPScokrAtt0RjVYaRuEhs4QByXnsQZxpcuvjCJlwsN
         6LJQ==
X-Gm-Message-State: AOJu0YzCb9SL6SXxIWO5QjWRHVJ3uXE+5PSV6N9ioepJX5E9e6E5ypSY
	Gt/vrC7q3IvMaSv1aybypoOr0PRwzUh+9Q==
X-Google-Smtp-Source: AGHT+IGJr9EkzuMM1pESlHnrgGakKr5k2LoOBYPyvcYTyAs4lRuS+mD2XB/lOqA84Y1jiHAic0yW1w==
X-Received: by 2002:a05:6000:1084:b0:336:81b:7b3e with SMTP id y4-20020a056000108400b00336081b7b3emr1606885wrw.84.1705154534804;
        Sat, 13 Jan 2024 06:02:14 -0800 (PST)
Received: from localhost.localdomain (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id z17-20020a056000111100b003377cb92901sm6756540wrw.83.2024.01.13.06.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 06:02:14 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/amdgpu: Pass amdgpu_job directly to amdgpu_ring_soft_recovery
Date: Sat, 13 Jan 2024 14:02:03 +0000
Message-ID: <20240113140206.2383133-1-joshua@froggi.es>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We will need this to change the karma in the future.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 9 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 78476bc75b4e..c1af7ca25912 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -52,7 +52,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	adev->job_hang = true;
 
 	if (amdgpu_gpu_recovery &&
-	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
+	    amdgpu_ring_soft_recovery(ring, job)) {
 		DRM_ERROR("ring %s timeout, but soft recovered\n",
 			  s_job->sched->name);
 		goto exit;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 45424ebf9681..25209ce54552 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -425,14 +425,13 @@ void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
  * amdgpu_ring_soft_recovery - try to soft recover a ring lockup
  *
  * @ring: ring to try the recovery on
- * @vmid: VMID we try to get going again
- * @fence: timedout fence
+ * @job: the locked-up job
  *
  * Tries to get a ring proceeding again when it is stuck.
  */
-bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
-			       struct dma_fence *fence)
+bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, struct amdgpu_job *job)
 {
+	struct dma_fence *fence = job->base.s_fence->parent;
 	unsigned long flags;
 	ktime_t deadline;
 
@@ -452,7 +451,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	atomic_inc(&ring->adev->gpu_reset_counter);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
-		ring->funcs->soft_recovery(ring, vmid);
+		ring->funcs->soft_recovery(ring, job->vmid);
 
 	return dma_fence_is_signaled(fence);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index bbb53720a018..734df88f22d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -354,8 +354,7 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring);
 void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
 						uint32_t reg0, uint32_t val0,
 						uint32_t reg1, uint32_t val1);
-bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
-			       struct dma_fence *fence);
+bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, struct amdgpu_job *job);
 
 static inline void amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
 							bool cond_exec)
-- 
2.43.0


