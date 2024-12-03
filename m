Return-Path: <stable+bounces-97603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F4D9E24B5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29752287E96
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731D51F75BC;
	Tue,  3 Dec 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kpEkrXtu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCC1EE001;
	Tue,  3 Dec 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241085; cv=none; b=n879zJ+3vKKl6lQI0W7phr4L9LLlG9rPxYwSn/RC6qvMrpEBdIeiR9LSgU37v944n/61EzPnnMmHTyH/X+Q28igEsvhgY4Vkvc1r8upOxpTmZ8/BRtPdjuRB+LwcjcOqAjXwVPbe+5BfvElLtkwI80Q4HuYEYidPwCZXopk4VxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241085; c=relaxed/simple;
	bh=haxtY8rP/kAeJe+TUg+dBV5RyegD4LdOU0R4Snns98Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhe/eyhU8JmgvuguxhQqd+qy4RZ3hLpfvPJyRPiGpDFyhgnwWj30Suvtz0/dk3gX4oyfN92y7WpIMKKHqfpMXon2jtEmrdzwVHorQRgrEM5K3T9oqG2jteWGoTqDY7Tlp38Y1Z3LNHz7J78pazBP+W2m2CTrGQ/Q/pagMNdBX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kpEkrXtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D82C4CECF;
	Tue,  3 Dec 2024 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241084;
	bh=haxtY8rP/kAeJe+TUg+dBV5RyegD4LdOU0R4Snns98Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpEkrXtufnWHZ7qvIKZnCOr8pAKsnn88714tbJ8K9LReeXb9iKRDXrgN9yXfj7+KQ
	 2nHOjEBgcUhpWA60z4BQz2PKl+XPjEOK+SUnDzGnSULiSszYLD48/ZI4kVeawTZVBu
	 Tz/a5012rCqLqVJDHaENhpgC9jbZjs2FlSKK5TXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Le Ma <le.ma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 321/826] drm/amdgpu: Fix map/unmap queue logic
Date: Tue,  3 Dec 2024 15:40:48 +0100
Message-ID: <20241203144756.283953295@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit fa31798582882740f2b13d19e1bd43b4ef918e2f ]

In current logic, it calls ring_alloc followed by a ring_test. ring_test
in turn will call another ring_alloc. This is illegal usage as a
ring_alloc is expected to be closed properly with a ring_commit. Change
to commit the map/unmap queue packet first followed by a ring_test. Add a
comment about the usage of ring_test.

Also, reorder the current pre-condition checks of job hang or kiq ring
scheduler not ready. Without them being met, it is not useful to attempt
ring or memory allocations.

Fixes tag refers to the original patch which introduced this issue which
then got carried over into newer code.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Fixes: 6c10b5cc4eaa ("drm/amdgpu: Remove duplicate code in gfx_v8_0.c")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 63 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  7 +++
 3 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4f08b153cb66d..e41318bfbf457 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -834,6 +834,9 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	if (!kiq_ring->sched.ready || adev->job_hang)
+		return 0;
+
 	ring_funcs = kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
 	if (!ring_funcs)
 		return -ENOMEM;
@@ -858,8 +861,14 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES, 0, 0);
 
-	if (kiq_ring->sched.ready && !adev->job_hang)
-		r = amdgpu_ring_test_helper(kiq_ring);
+	/* Submit unmap queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that unmap queues that is submitted before got
+	 * processed successfully before returning.
+	 */
+	r = amdgpu_ring_test_helper(kiq_ring);
 
 	spin_unlock(&kiq->ring_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f1ffab5a1eaed..156abd2ba5a6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -525,6 +525,17 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	if (!kiq_ring->sched.ready || adev->job_hang)
+		return 0;
+	/**
+	 * This is workaround: only skip kiq_ring test
+	 * during ras recovery in suspend stage for gfx9.4.3
+	 */
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
+	    amdgpu_ras_in_recovery(adev))
+		return 0;
+
 	spin_lock(&kiq->ring_lock);
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
 					adev->gfx.num_compute_rings)) {
@@ -538,20 +549,15 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 					   &adev->gfx.compute_ring[j],
 					   RESET_QUEUES, 0, 0);
 	}
-
-	/**
-	 * This is workaround: only skip kiq_ring test
-	 * during ras recovery in suspend stage for gfx9.4.3
+	/* Submit unmap queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that unmap queues that is submitted before got
+	 * processed successfully before returning.
 	 */
-	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
-	    amdgpu_ras_in_recovery(adev)) {
-		spin_unlock(&kiq->ring_lock);
-		return 0;
-	}
+	r = amdgpu_ring_test_helper(kiq_ring);
 
-	if (kiq_ring->sched.ready && !adev->job_hang)
-		r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 
 	return r;
@@ -579,8 +585,11 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	spin_lock(&kiq->ring_lock);
+	if (!adev->gfx.kiq[0].ring.sched.ready || adev->job_hang)
+		return 0;
+
 	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
+		spin_lock(&kiq->ring_lock);
 		if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
 						adev->gfx.num_gfx_rings)) {
 			spin_unlock(&kiq->ring_lock);
@@ -593,11 +602,17 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 						   &adev->gfx.gfx_ring[j],
 						   PREEMPT_QUEUES, 0, 0);
 		}
-	}
+		/* Submit unmap queue packet */
+		amdgpu_ring_commit(kiq_ring);
 
-	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
+		/*
+		 * Ring test will do a basic scratch register change check.
+		 * Just run this to ensure that unmap queues that is submitted
+		 * before got processed successfully before returning.
+		 */
 		r = amdgpu_ring_test_helper(kiq_ring);
-	spin_unlock(&kiq->ring_lock);
+		spin_unlock(&kiq->ring_lock);
+	}
 
 	return r;
 }
@@ -702,7 +717,13 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		kiq->pmf->kiq_map_queues(kiq_ring,
 					 &adev->gfx.compute_ring[j]);
 	}
-
+	/* Submit map queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that map queues that is submitted before got
+	 * processed successfully before returning.
+	 */
 	r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 	if (r)
@@ -753,7 +774,13 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 						 &adev->gfx.gfx_ring[j]);
 		}
 	}
-
+	/* Submit map queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that map queues that is submitted before got
+	 * processed successfully before returning.
+	 */
 	r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index bc8295812cc84..9d741695ca07d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4823,6 +4823,13 @@ static int gfx_v8_0_kcq_disable(struct amdgpu_device *adev)
 		amdgpu_ring_write(kiq_ring, 0);
 		amdgpu_ring_write(kiq_ring, 0);
 	}
+	/* Submit unmap queue packet */
+	amdgpu_ring_commit(kiq_ring);
+	/*
+	 * Ring test will do a basic scratch register change check. Just run
+	 * this to ensure that unmap queues that is submitted before got
+	 * processed successfully before returning.
+	 */
 	r = amdgpu_ring_test_helper(kiq_ring);
 	if (r)
 		DRM_ERROR("KCQ disable failed\n");
-- 
2.43.0




