Return-Path: <stable+bounces-141131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F05AAB0BB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C5F176A15
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740293272A2;
	Tue,  6 May 2025 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su/4tt43"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0C375318;
	Mon,  5 May 2025 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485263; cv=none; b=cp0cbZoZR3C23TJESi/UX6dh/zW+6wE0dV6iOQxGN08IDkPbEecveqFm4haOR8lyekV2sxPttCAjxyC6oOqUOhp+kP+OUGQrFEMLN0BPGQUvfHG3Czc+lxxLiVIaXdE1tECXPuypPPK29Yrgx0ICO8SSpV0J+9pXVRPHGzhoflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485263; c=relaxed/simple;
	bh=kPtgYJ1ylrGPtrzBL0qY+5FRkGigw4idpT1KKc/S+MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+nwz61jOMTWRXpAtOk9zmPzHbrfixTJA38TuGv/wyJGTpQMfKlw9HlnaCfAwDuU5HE+Xrg2HBl3JGjwrNLV8ycPnQHobNl7dbPzXAU3SDQNk/rDDBwJvX6EII8pmo7YYqo1RZw2IZAaf7TDM74sCr9uOLdOzzagOSqyUys9LCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su/4tt43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89A4C4CEE4;
	Mon,  5 May 2025 22:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485263;
	bh=kPtgYJ1ylrGPtrzBL0qY+5FRkGigw4idpT1KKc/S+MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=su/4tt433OBO4ppA2zdB6X/1gE6MWkcZg9k1czP1k6+Q/icQ9h4SpxPTpH36Q7+Lj
	 KDaqrgComQbxTThP7C4HaV3Z7sc/KKqRMv7cJazR3zHr8rOQIgNYOEQKLyLzW0NoOa
	 XcbOHj/774OWabM7fVHKRgeBm4KVce3/XEfRkMotfxvMcIAl5n3QC7WXQ/hlNoliCm
	 bG04+53UdbeF0k2ssXc2W+KVB6lC3MQceVAvOsEvtZanajtvWPbsnkRDXiQd0IsNES
	 q6r9a3NXoaV8iiUzfUiYq7dyb4OHvdCva9elH+Rfy2C/6pjhfY18rkhTPe0RdXEaEz
	 t5Fk9yAtCeTkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 241/486] drm/amdkfd: KFD release_work possible circular locking
Date: Mon,  5 May 2025 18:35:17 -0400
Message-Id: <20250505223922.2682012-241-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 1b9366c601039d60546794c63fbb83ce8e53b978 ]

If waiting for gpu reset done in KFD release_work, thers is WARNING:
possible circular locking dependency detected

  #2  kfd_create_process
        kfd_process_mutex
          flush kfd release work

  #1  kfd release work
        wait for amdgpu reset work

  #0  amdgpu_device_gpu_reset
        kgd2kfd_pre_reset
          kfd_process_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&p->release_work));
                  lock((wq_completion)kfd_process_wq);
                  lock((work_completion)(&p->release_work));
   lock((wq_completion)amdgpu-reset-dev);

To fix this, KFD create process move flush release work outside
kfd_process_mutex.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0ec8b457494bd..45923da7709fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -842,6 +842,14 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* If the process just called exec(3), it is possible that the
+	 * cleanup of the kfd_process (following the release of the mm
+	 * of the old process image) is still in the cleanup work queue.
+	 * Make sure to drain any job before trying to recreate any
+	 * resource for this process.
+	 */
+	flush_workqueue(kfd_process_wq);
+
 	/*
 	 * take kfd processes mutex before starting of process creation
 	 * so there won't be a case where two threads of the same process
@@ -860,14 +868,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
-		/* If the process just called exec(3), it is possible that the
-		 * cleanup of the kfd_process (following the release of the mm
-		 * of the old process image) is still in the cleanup work queue.
-		 * Make sure to drain any job before trying to recreate any
-		 * resource for this process.
-		 */
-		flush_workqueue(kfd_process_wq);
-
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
-- 
2.39.5


