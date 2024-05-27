Return-Path: <stable+bounces-46548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CBB8D079D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2F81F21BB7
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1386B16F26F;
	Mon, 27 May 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAOyBqeK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796816F269;
	Mon, 27 May 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825500; cv=none; b=Y12rQfDYITlFHcl3oI3WVH9SkZkEHfTDPHAz1ymVEAfixavBqrFQlnWiOpd+T52zYQabOnDlib2n7uW4/8Nsz7Q9M3HBUmmjJECCBpPc1swf7kTpNBWAxtq39t9i79lXsK/m3bawF3oIwtHu3g2i+56EfpIPX5O4g9t+aK2026w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825500; c=relaxed/simple;
	bh=27bWrgDdeb62lVzoFAPV4+VUCQd6HL4QhkxOqbAeME0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgfQj1eu2tKT9CyYVYTh4sTn2Q3v1JnwFukniyIajv3zHT2MELCSGppzHX7ym2Fz25FE6fkyZj6Hhs3GO0xkHvKPEsOhfEBo9cgnIddymwlUYJ71INP6pN3XOZfo5KkrNS8tAu17bo0bWjXto6nCvYxD6d8tOeTyGtdoyH3Jph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAOyBqeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB5AC4AF08;
	Mon, 27 May 2024 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825500;
	bh=27bWrgDdeb62lVzoFAPV4+VUCQd6HL4QhkxOqbAeME0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AAOyBqeKCIun3PWRTNZXEGNE6tZYp+OoGXznkEzPzAlf/rNZlZb+o/hT0b50mAIn5
	 JiBY1Heui4kvy6v3WdvxySbefPpNqQHG1NBNDGg9tKZfo6cQ8sW8W+6llB63L4wDmW
	 m1pTOyIA3MFSh1xv+hgTdgcQIL0Fnk6zkjzIFvrzuhPXmtCIG+50UVKvgG2WuTw3DE
	 N25Ah/qYarlPxybsUhTPSJtA1m0fBDanVPKviV9FnPz7ToSqpRetlQYFwo442uQ5x+
	 T26jc0PCi3+oK6BxUWvqEbRGmE6JErKS6TXajgKVuJmC0Zg5195Z/mqbHeE191JNJ6
	 CsNmG/a5VnL3w==
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
Subject: [PATCH AUTOSEL 5.15 3/6] drm/lima: mask irqs in timeout path before hard reset
Date: Mon, 27 May 2024 11:57:53 -0400
Message-ID: <20240527155808.3866107-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155808.3866107-1-sashal@kernel.org>
References: <20240527155808.3866107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 2e817dbdcad75..a7572123fee15 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -421,6 +421,13 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
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


