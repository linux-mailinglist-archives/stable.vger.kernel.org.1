Return-Path: <stable+bounces-160577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B55AAFD0D8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9685A1C216B4
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64D9217722;
	Tue,  8 Jul 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P5R0qHkW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193E29B797;
	Tue,  8 Jul 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992055; cv=none; b=DccLOLUtVLuv1YuMP/Jcziq6pBdH2abR7bLAew8qdOZbggZKnUfNHmkj3hQnUoJv01iw3oNx3GdQnDHoCD10BNR3/r1+rvAVZBCI7UCrXU4G8dZ2PEa20C428x+ueok9GNbt1zuozQnEiE2rk0Rf5MSlTKFdUMmuwaMR27eGdzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992055; c=relaxed/simple;
	bh=xQ/VBVuUNP79jpzfe3Bw1vDR/i7D8KE41CEYDvwZ6Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YATW6agmpqU0fAIaFuOwiATQQtTD3oYEUf4RYjNabh+BAa46/H4poIzNikXnyFV6Dd5FcjUSxRgA4nEA2whMiF6k6Z1PPmgXRsnlF/0Iwn6aDYBz20OE463AYrWnrYiM1Z0yosQ3OJ0IY5x8VFXe1m36xSljl3yUULEcq2CsElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P5R0qHkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5C4C4CEED;
	Tue,  8 Jul 2025 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992055;
	bh=xQ/VBVuUNP79jpzfe3Bw1vDR/i7D8KE41CEYDvwZ6Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5R0qHkW+dMaqTXuAfslLpzJeUI4yGauvKqUg2eCbXkXf/0jGYpMKRYyzm1hVYCLI
	 yZ9WkANYdCdiFKM4n+6nC+rfIFInVaTWEkxKEseCwJvrl3ViC5pu1LFDGURYx2GrZ/
	 Xm2ShdOYE5OoOSwHrwt97fCQIpO6zsTAfBi/dco0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 44/81] drm/msm: Fix a fence leak in submit error path
Date: Tue,  8 Jul 2025 18:23:36 +0200
Message-ID: <20250708162226.424694505@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162224.795155912@linuxfoundation.org>
References: <20250708162224.795155912@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index c12a6ac2d3840..4ee6aeb23c512 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -71,6 +71,15 @@ void __msm_gem_submit_destroy(struct kref *kref)
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




