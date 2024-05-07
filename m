Return-Path: <stable+bounces-43322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC08BF1B5
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560C41C20A8B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290FB145FF6;
	Tue,  7 May 2024 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtTM9Hu6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8C146000;
	Tue,  7 May 2024 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123386; cv=none; b=lF792/nEpMAoOkXTvtk2bDTM1z6nzmpxq+Ejym3dJXEzhNbY+K2KCa/36oGc2i6QvV4ZGOwkn9vKaI9+/Wpd5aL7NMaH3ufTmnrmsipU10q9pSvSAm1ZSy5seoAJUS3h0BAhSRBPjWzqK5ebsXgjWheRiTA+w0lat+c39SzB4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123386; c=relaxed/simple;
	bh=cIft+zC2p2nwFimfdBQ8IvSQowxuOf9+IqyHq1DgoPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmaXAALH4Rf/h1Swaa++GpX31p8lvAFTGasvVaS+idjNaugibzpB0GUlL/uWcSN1tV9m2ppsdbC/KLXIV/9w4yXumCXlxfNK1KXTWG5cXPiq2ffye4n6Swf288VKfyz0vDvjx75oIqZ0ptiC77/G5YFROvkprZgA61loUEgrIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtTM9Hu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD79C2BBFC;
	Tue,  7 May 2024 23:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123386;
	bh=cIft+zC2p2nwFimfdBQ8IvSQowxuOf9+IqyHq1DgoPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtTM9Hu6HPQuywbSC7L2AfuqAJ55pQ2jDAn8Hn6E2tmaEzKDckocyfEmQPGjv5k3E
	 ePRjfVvJU58o9ghLxEiWdRMf2tQ4cfwhVFwaC4pctSVcFTlKWjBbZv+B9Vne517Emw
	 Bn+LJB5b7PM0ISTH+NprmCEF9hQIl1aYSJmrD5B9ZEe16hbAitkF/zlpzeraD6z01r
	 Mob+gY/uL8KouY3/+SxlOnHATVldM3beXOjA6B95++c8VK7eTcDQ37Y+cVfwQg+Ex+
	 ctPk7Rdb0eorvH17EEpa9OHRDnq7F3VO8JrctC7fI1GlZnlRziHADc/BjXbbHD0Ju5
	 MmIPK9lGyllCA==
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
Subject: [PATCH AUTOSEL 6.8 43/52] drm/amdkfd: Flush the process wq before creating a kfd_process
Date: Tue,  7 May 2024 19:07:09 -0400
Message-ID: <20240507230800.392128-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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
index 58c1fe5421934..451bb058cc620 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -829,6 +829,14 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
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


