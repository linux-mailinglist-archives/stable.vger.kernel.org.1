Return-Path: <stable+bounces-180220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39060B7ECA6
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C8B7AF1D1
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A031A7F6;
	Wed, 17 Sep 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFJOq+Q/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA030CB5D;
	Wed, 17 Sep 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113764; cv=none; b=thhjfW5O0XG0wngD6r109G/4bw3KP69xBQq1LrNkqxv/6Cp2vb4Vt62iHQe+C+xiODWJPYaQHsezpZegp0Idjj8/plKL/aIAQEW3gHByQDn9af4jS70rP2q0M6NXg9Q3GAz5PFkCeusL/x3MC1v0JmUvoHgM7/cqFUgP8+eaM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113764; c=relaxed/simple;
	bh=rjeAla/1JH5sLmA/HfE4rhrmUzhAmfm6MTSOnM2R/Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fp07Ox4h9axbsDYlhhC5e+Yz7QHFAKi07TDDHUMSGoxEiRcdcDjC6jcVvCm+Ojyg8oobSdb1hj/B4Fr7pguLQfOl4ld0KQ86r/u+Ud+dSVKyUn4exmr/t67BLxlhZ+/y3bXzm6xvYtOZSedAn9oNO61mysguRJWK1VCzH41eUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dFJOq+Q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8249CC4CEF0;
	Wed, 17 Sep 2025 12:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113764;
	bh=rjeAla/1JH5sLmA/HfE4rhrmUzhAmfm6MTSOnM2R/Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFJOq+Q/qymDSp+VmnH5b6V005lsARGmPjLJOdzlkyiZT19N50fkuPVF8stM2uTyy
	 3tw95OoFhzI05hF3AZcyXGzfUdUnjjldWajCxgCFLEm7TZC2jo43YLX6YNaiomoaeQ
	 9sG7Iz134FG7ijippoJtulIjpWCSNb78ZuVosXRA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Rosca <david.rosca@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 045/101] drm/amdgpu/vcn: Allow limiting ctx to instance 0 for AV1 at any time
Date: Wed, 17 Sep 2025 14:34:28 +0200
Message-ID: <20250917123337.933349623@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
References: <20250917123336.863698492@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rosca <david.rosca@amd.com>

commit 3318f2d20ce48849855df5e190813826d0bc3653 upstream.

There is no reason to require this to happen on first submitted IB only.
We need to wait for the queue to be idle, but it can be done at any
time (including when there are multiple video sessions active).

Signed-off-by: David Rosca <david.rosca@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8908fdce0634a623404e9923ed2f536101a39db5)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c |   12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c |   12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1765,15 +1765,19 @@ static int vcn_v3_0_limit_sched(struct a
 				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
-
-	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&job->base.entity->fence_seq))
-		return -EINVAL;
+	struct dma_fence *fence;
 
 	/* if VCN0 is harvested, we can't support AV1 */
 	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
 		return -EINVAL;
 
+	/* wait for all jobs to finish before switching to instance 0 */
+	fence = amdgpu_ctx_get_fence(p->ctx, job->base.entity, ~0ull);
+	if (fence) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+	}
+
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
 		[AMDGPU_RING_PRIO_DEFAULT].sched;
 	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1644,15 +1644,19 @@ static int vcn_v4_0_limit_sched(struct a
 				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
-
-	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&job->base.entity->fence_seq))
-		return -EINVAL;
+	struct dma_fence *fence;
 
 	/* if VCN0 is harvested, we can't support AV1 */
 	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
 		return -EINVAL;
 
+	/* wait for all jobs to finish before switching to instance 0 */
+	fence = amdgpu_ctx_get_fence(p->ctx, job->base.entity, ~0ull);
+	if (fence) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+	}
+
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
 		[AMDGPU_RING_PRIO_0].sched;
 	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);



