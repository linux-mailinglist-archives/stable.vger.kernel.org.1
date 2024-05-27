Return-Path: <stable+bounces-46525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CE38D0753
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C4E1C22670
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6816B748;
	Mon, 27 May 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSydWsvk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202C816B743;
	Mon, 27 May 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825371; cv=none; b=Ng+22e/tPcqRCLlNPe1WnIYkxfOVssE/UIZ1c01kFlvkUKpUQStXv4m1w7KTuBWl7IwxfXLIccBK+n16U1pinQ9nzJ9qicwyu2QnMZIi///M01aorpPMFLrSOTajZvTq2CsJsjyaao9nDceliHAHb52vzhT1hymnqbgC6+eLVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825371; c=relaxed/simple;
	bh=cf8XzjTe6lVStDhowj3ysukGsoEDDfWWJU9f3Jmwcns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJGr56r2p+Wtt+i2aXnchaj13q6y6XRLrvk7GV59e0+f5rBMXRIO6l2R5a4tVXkjt45lPXaD0UIzjT+lt5TLCfY7j5LdD6VC8agSBHYB01V1URrhogzAxfN2gdYv3ONL5N/FCsIGUnAHDY5hBMDJIPTEJ9SX/aPPLZy3V7Na4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSydWsvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BC4C4AF0B;
	Mon, 27 May 2024 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825370;
	bh=cf8XzjTe6lVStDhowj3ysukGsoEDDfWWJU9f3Jmwcns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSydWsvka3gT1kpcHrVuN/JbOUb47lzJG+03M9XVKrnewTfoKCXgjzJQKzDR2+mJ/
	 htHL4F3owvxMWEdQlO1/lOvvR2wO/LFkOas4dUvQMYB+R7N8HUVOblpCnxW8naD6aI
	 iiqxQw06l/sglkXhuVWd5BBsqF3V0BFeexGIBwjT0fXbVOxwhulUYmJknxjo2APuux
	 QdPR/rrhdv2GhRt6ldIVa+6Q8FKCIF77bXy2S9+kcXtdwrEHRpTKaaeiWZ2JZAxBjl
	 BZcG+rHuunT9niQqF4tY7W8AH7JzQLVyGPh+kTJXAI4JXH/htTv9wwumB4efuugpsC
	 8V5xYzExO2L4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erico Nunes <nunes.erico@gmail.com>,
	Qiang Yu <yuq825@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 07/16] drm/lima: mask irqs in timeout path before hard reset
Date: Mon, 27 May 2024 11:54:58 -0400
Message-ID: <20240527155541.3865428-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155541.3865428-1-sashal@kernel.org>
References: <20240527155541.3865428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Erico Nunes <nunes.erico@gmail.com>

[ Upstream commit a421cc7a6a001b70415aa4f66024fa6178885a14 ]

There is a race condition in which a rendering job might take just long
enough to trigger the drm sched job timeout handler but also still
complete before the hard reset is done by the timeout handler.
This runs into race conditions not expected by the timeout handler.
In some very specific cases it currently may result in a refcount
imbalance on lima_pm_idle, with a stack dump such as:

[10136.669170] WARNING: CPU: 0 PID: 0 at drivers/gpu/drm/lima/lima_devfreq.c:205 lima_devfreq_record_idle+0xa0/0xb0
...
[10136.669459] pc : lima_devfreq_record_idle+0xa0/0xb0
...
[10136.669628] Call trace:
[10136.669634]  lima_devfreq_record_idle+0xa0/0xb0
[10136.669646]  lima_sched_pipe_task_done+0x5c/0xb0
[10136.669656]  lima_gp_irq_handler+0xa8/0x120
[10136.669666]  __handle_irq_event_percpu+0x48/0x160
[10136.669679]  handle_irq_event+0x4c/0xc0

We can prevent that race condition entirely by masking the irqs at the
beginning of the timeout handler, at which point we give up on waiting
for that job entirely.
The irqs will be enabled again at the next hard reset which is already
done as a recovery by the timeout handler.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Reviewed-by: Qiang Yu <yuq825@gmail.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240405152951.1531555-4-nunes.erico@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/lima/lima_sched.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index ffd91a5ee2990..1114bffe38c83 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -402,6 +402,13 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 	struct lima_sched_task *task = to_lima_task(job);
 	struct lima_device *ldev = pipe->ldev;
 
+	/*
+	 * The task might still finish while this timeout handler runs.
+	 * To prevent a race condition on its completion, mask all irqs
+	 * on the running core until the next hard reset completes.
+	 */
+	pipe->task_mask_irq(pipe);
+
 	if (!pipe->error)
 		DRM_ERROR("lima job timeout\n");
 
-- 
2.43.0


