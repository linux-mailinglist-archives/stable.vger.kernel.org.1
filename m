Return-Path: <stable+bounces-43429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F688BF2B5
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E41A283838
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA60A145A05;
	Tue,  7 May 2024 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBzBCNkQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0661844B5;
	Tue,  7 May 2024 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123674; cv=none; b=OHVroCJo9N2KYh54k8dD9/0Xwadz5eky5iNcBjvu2XJvt+2kpbqqQSOpqBng7AAOuhX1PSM3tdizC8PmXCfFlTRuQzbd6Xz8pAT5kce9qNAm92fizQVgeT86VRGpourktjqFbHZj/4e4+BWxUOwTyflHUDv/pVUtlxpgEynXAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123674; c=relaxed/simple;
	bh=uGaz81u//ikxr+CCjdWRrcxgzw6GnAiHPyHKN2atUig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeXv0dfOeTBMsUY1SRwH4FtyRTFZma9HSNMcHxedAhBmTYo/co3QR7xHUV7tp2IcUffKdf5Ixwy5zAF0jE9dK87zpQghaZqxMrwx5o80kR+5rQq7j7sbUgIWzLdW5klrF1QUDgMGkMyomBemQRrdg2kguBdr17uGIlNHEjLCYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBzBCNkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F026DC4AF17;
	Tue,  7 May 2024 23:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123673;
	bh=uGaz81u//ikxr+CCjdWRrcxgzw6GnAiHPyHKN2atUig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBzBCNkQs2bocHhupLvuKIr+bQ2a05qDl1vhlaBlY9OEgj6082hD5QksQNyYkUilH
	 qY9R7y++b05zxHaYUoYjuZGkBpPapMXcy+tyP5MJWUx4gcTxpTiw0gmk/iwIAHhCtS
	 cw4weMLvtBmXJfMSCdKmEgZCyAumIUQ5n6TadJwznRzv3Rv8Ho4zQ6kABNf7OhBRTk
	 dIVd9ShZMxR3K+64Q42DdGbh4xn9jCpyJVxLLZxNs2/gwDTzKNsadqwJf54o+3wkqk
	 OMJystvlTwDMchZMw/IxjL2bT9a2H3B39ZonzYPueM+/nd4z6yHMJpTqah4QxF0lWJ
	 qe7eWJA6Jt7lA==
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
Subject: [PATCH AUTOSEL 5.4 5/6] drm/amdkfd: Flush the process wq before creating a kfd_process
Date: Tue,  7 May 2024 19:14:21 -0400
Message-ID: <20240507231424.395315-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231424.395315-1-sashal@kernel.org>
References: <20240507231424.395315-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.275
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
index aa0a617b8d445..662e4d973f13a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -289,6 +289,14 @@ struct kfd_process *kfd_create_process(struct file *filep)
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


