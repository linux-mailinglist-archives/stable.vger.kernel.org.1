Return-Path: <stable+bounces-43393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7B8BF25F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B39F286F33
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0FF1C68B2;
	Tue,  7 May 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCFmQkPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD50139D05;
	Tue,  7 May 2024 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123591; cv=none; b=fyfS9knE9STMIA20fFkogV21Lwms8guFbhHYo0kGB4PmyUrjwepG+rEcz4zmJScakZLpa/gKTfITMOSkTfrvp4Q44POfiViAwZnS2TvV+3ZRB60Z5SZX3Dl6eg9yQYPK4YHE+wBwRp35QEiDhfw0wbGUT6atTvz4Lgab6qGK+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123591; c=relaxed/simple;
	bh=DC7neKFHwIo/r287uUkN7M0ZZX/HR1SgUCjGC8iEKeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9C/O5nzrafudXy7A/K6M6JnmJD/BO8sWk1873o3GoOSHqFsnF25iP58aJ3PIFUFcGOuOknPAiWb53CSlOpTl7+Sgw01Hc5bpBaYkwXas/H3Bnwj5BcpnStRx9oFIUiXPBKCCYGLPXVRhRsFvsBsVLElSjHK/X4PqbDlnFrTxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCFmQkPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F57C4AF67;
	Tue,  7 May 2024 23:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123590;
	bh=DC7neKFHwIo/r287uUkN7M0ZZX/HR1SgUCjGC8iEKeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCFmQkPIl0q6W32WaI5eIMPW9QnOcs2mIZLgmjTO4i2FIee0houygnqXSAQMxznTp
	 mX9PNcA62f2t+zs4nEdilf7x7lXlusRgAGq7tyLXbAFQqhfqx58jSU70J+vf2cCM9l
	 Ee0RyD+BvRM2OJqrtTYCuAVftkoNGZWADMgKeEkGLjyMcJRy9N49Jy6kdY+F/GNY3Y
	 Zcr6OT3sbKpXDSXumX/rvm8mMp/57Rcf5c3O+hKfOUcSaPFALnYqZZjBrGV1KuDE9C
	 kufq8kMNNWEUqKkuhuRhD5kcJ+BDsPrZ5tY6+0Zv79scVRD+AlXR/DI0EVD/POqM9Q
	 raIJ2nHWbyqdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lancelot SIX <lancelot.six@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 18/25] drm/amdkfd: Flush the process wq before creating a kfd_process
Date: Tue,  7 May 2024 19:12:05 -0400
Message-ID: <20240507231231.394219-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Lancelot SIX <lancelot.six@amd.com>

[ Upstream commit f5b9053398e70a0c10aa9cb4dd5910ab6bc457c5 ]

There is a race condition when re-creating a kfd_process for a process.
This has been observed when a process under the debugger executes
exec(3).  In this scenario:
- The process executes exec.
 - This will eventually release the process's mm, which will cause the
   kfd_process object associated with the process to be freed
   (kfd_process_free_notifier decrements the reference count to the
   kfd_process to 0).  This causes kfd_process_ref_release to enqueue
   kfd_process_wq_release to the kfd_process_wq.
- The debugger receives the PTRACE_EVENT_EXEC notification, and tries to
  re-enable AMDGPU traps (KFD_IOC_DBG_TRAP_ENABLE).
 - When handling this request, KFD tries to re-create a kfd_process.
   This eventually calls kfd_create_process and kobject_init_and_add.

At this point the call to kobject_init_and_add can fail because the
old kfd_process.kobj has not been freed yet by kfd_process_wq_release.

This patch proposes to avoid this race by making sure to drain
kfd_process_wq before creating a new kfd_process object.  This way, we
know that any cleanup task is done executing when we reach
kobject_init_and_add.

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 7f68d51541e8e..5bca6abd55aef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -823,6 +823,14 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
+		/* If the process just called exec(3), it is possible that the
+		 * cleanup of the kfd_process (following the release of the mm
+		 * of the old process image) is still in the cleanup work queue.
+		 * Make sure to drain any job before trying to recreate any
+		 * resource for this process.
+		 */
+		flush_workqueue(kfd_process_wq);
+
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
-- 
2.43.0


