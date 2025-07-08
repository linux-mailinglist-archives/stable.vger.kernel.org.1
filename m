Return-Path: <stable+bounces-160911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16428AFD236
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD877A689F
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38F92E3385;
	Tue,  8 Jul 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPdNoahz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3468F5B;
	Tue,  8 Jul 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993050; cv=none; b=S2tOTCOC4Cl2B4Lz2BGfLDnYad+vAtSIEHsPoktu/fKpPdnTDI/sT7pGR8u4lKzYMmrZicYTbox9y9RwMGtAu7v6hY9x+/hT0r4rtMUI81KN6ALxabmHWdvwQDkKsBnn/VUBpIMxFGQu6X3b7rIyGh2IaP7IKvV8EKAHChkWfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993050; c=relaxed/simple;
	bh=PbcVN3zPbW0P/oKhOMPUR0lZQ5HeQqMvVk1wtvC9IyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiUotTn3pK/cvfFNTnHwTVc/kFjhwTMI2kVVabkBtDC4X+WUwetse7gHDHyMrW3vF8bxH2yNfV+6gy2e5QFHf6anZnO46JRC6Gw0CURh8qHQmT9FgQwMuVdrZeN4HlAK/Y2Bw0ZWhZj+Pcz8OWcZ4wKCmqlZ9uupVigMJmi5Qj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPdNoahz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E9EC4CEED;
	Tue,  8 Jul 2025 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993050;
	bh=PbcVN3zPbW0P/oKhOMPUR0lZQ5HeQqMvVk1wtvC9IyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPdNoahzPIb16+WO9O12D2K/zIN33G+wR1utjn5r2QYxlSq3w9mrZQ/129R96DjU3
	 tzcc0ZKzdqijKdccVmtsWZIX+XKmhcoWpfQxgBmLUmhFPfga0Kpn3eCSaC0uYm47aT
	 8/F7b1A8xU6KHvPvyfWni2FpGfXfmOtW5ErIF8EE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 171/232] drm/msm: Fix a fence leak in submit error path
Date: Tue,  8 Jul 2025 18:22:47 +0200
Message-ID: <20250708162245.914020184@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 5d319f75ccf7f0927425a7545aa1a22b3eedc189 ]

In error paths, we could unref the submit without calling
drm_sched_entity_push_job(), so msm_job_free() will never get
called.  Since drm_sched_job_cleanup() will NULL out the
s_fence, we can use that to detect this case.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/653584/
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index f775638d239a5..937c1f5d88cbb 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -85,6 +85,15 @@ void __msm_gem_submit_destroy(struct kref *kref)
 			container_of(kref, struct msm_gem_submit, ref);
 	unsigned i;
 
+	/*
+	 * In error paths, we could unref the submit without calling
+	 * drm_sched_entity_push_job(), so msm_job_free() will never
+	 * get called.  Since drm_sched_job_cleanup() will NULL out
+	 * s_fence, we can use that to detect this case.
+	 */
+	if (submit->base.s_fence)
+		drm_sched_job_cleanup(&submit->base);
+
 	if (submit->fence_id) {
 		spin_lock(&submit->queue->idr_lock);
 		idr_remove(&submit->queue->fence_idr, submit->fence_id);
-- 
2.39.5




