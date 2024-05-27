Return-Path: <stable+bounces-46487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECDA8D06C7
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D9A28F1DE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1A15F41F;
	Mon, 27 May 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc00nUk2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456415F419;
	Mon, 27 May 2024 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825138; cv=none; b=tqYvi6g/5ffjejzznYCCT8HNOMMW9kmkNY/7uM7jMSSMhNIp0DP8Hj22ZxoVgy9oPx6X0oJdP3z7fRmF9tYJfW67nuD/G5s5uJrLELJMxX3Ew1rY7PmZ1tPMkrQZoUbvfyUlu4JO/cOGlFRJer0RVgWKehs/K0M+Gh7O5BitLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825138; c=relaxed/simple;
	bh=8mfSpIpfHUdnCf/Y4BrDlwEWXBXoLCarxpbY1A4m/Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqgKJRmj2LUjIsCJC1PXCJgGoMR/jSG6JFcjyu0j/5BHAZ2ndu8ksenov386DKDn2kh7x5vpthY3ADNDVbeLA9fYZIC3C1A4U5bp0UTNiGWrnOD1nMZ322deEq/QBQz4Vy86xFD+N8NzyTbk66pbH1U/ZV5UrKXHai7pQcsqpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc00nUk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD13C32781;
	Mon, 27 May 2024 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825137;
	bh=8mfSpIpfHUdnCf/Y4BrDlwEWXBXoLCarxpbY1A4m/Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pc00nUk2eztxf5yfBhOBlUT+9cO+iumFjvxMjc/OtUERoYkhMXycAu4V6aKntzjcO
	 Im1ikh6QZDxFjYcCd5fRvCgScqKGlAUI6IVZBP176tKz3IfL1XnXG2cy0LiJHnEBrv
	 /i8yL6iXXRxcdpBzxCUrfJSsjYTDeTb5Tc3egvJxQbe4i9tZLHg05zXav34Yb3YZ6u
	 JWiIklYM585lEbrcBRn1z3aSXObPnQPUErtcbeboSSL++xzqU/YJnG7dXDsjE0Rxqw
	 2XN/BZHI6JYIiJsx78+Bo/VhDcb1dHM8OGXtj7aNjlxWW9jPNKMUtAgJ6IXEfB83Cz
	 FglVqKQUKRB6Q==
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
Subject: [PATCH AUTOSEL 6.9 12/23] drm/lima: mask irqs in timeout path before hard reset
Date: Mon, 27 May 2024 11:50:13 -0400
Message-ID: <20240527155123.3863983-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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
index 66841503a6183..bbf3f8feab944 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -430,6 +430,13 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 	}
 
+	/*
+	 * The task might still finish while this timeout handler runs.
+	 * To prevent a race condition on its completion, mask all irqs
+	 * on the running core until the next hard reset completes.
+	 */
+	pipe->task_mask_irq(pipe);
+
 	if (!pipe->error)
 		DRM_ERROR("%s job timeout\n", lima_ip_name(ip));
 
-- 
2.43.0


