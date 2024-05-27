Return-Path: <stable+bounces-46555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF78D07B4
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB57629816F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9515C16F912;
	Mon, 27 May 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usZBPXAZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E616F8FA;
	Mon, 27 May 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825548; cv=none; b=PW8lNbTvvb8E/Igj1l2RcGKeDja52UUj8h2OuEK7CKNtvBdozW44VyCHXR0wq4rl6UNXawNjgymYsClDn1aPOYgO+yvSD8TbFD7KW/ohCzzSoPNNkPcAggT6n5SaJxmwonhGsxCqWaGktmMD4baGTFCywQ9CktpgP2tuLYmMxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825548; c=relaxed/simple;
	bh=IdZQzUTy07yiTfWnEPuC7U2DYjD5dHJ7GF5GJhkJDJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0RLOo2Z+SfBlJ0ty9QK8b2iqJm7QyJP1GMNzDDZfSE/Rf4VKredqhAeRJp3hUrqzeZbEP65FGW1hej+oRw1f6QlL7AYeufU79gBvhLHtzGbvUnZ5yhyZA9t4yQDTnbiJ7adr40z8L+ocIEHsJaMlMNHrXN520qWqgq4yDS+O+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usZBPXAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99535C2BBFC;
	Mon, 27 May 2024 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825547;
	bh=IdZQzUTy07yiTfWnEPuC7U2DYjD5dHJ7GF5GJhkJDJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usZBPXAZFZKT9rqx5fPT31ZQxBjjotI/qOquCG8OyaQf+L7CnbUWXcCfRqbvcc+ew
	 mKOVfZYp9Cdcu8YRHUKDxzL4EFyqbGkzKtjr3YnAdOgXZUWT2MBQHQxd35C9bDcZ4G
	 7EYeBIDG0c6dXCzGbiA+fBDbHXtvkH+AIWii56HBgyHoe6d3Og60DLZOfCd7s6TlYo
	 b0jP2aNoyxbBccl0qYDgRAB7X8jtWSJjl9iNs6TCQNBqyJy5I/fZ2DJbcolQuo+JZH
	 oZ7XBW6ptFEZli2PD0331ek5W1y2/l1Au2X5Ng0Q1V9cGmMYaGIQs6AonqT8GP82Ox
	 x5sII3Xbt+6eQ==
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
Subject: [PATCH AUTOSEL 5.10 4/7] drm/lima: mask irqs in timeout path before hard reset
Date: Mon, 27 May 2024 11:58:28 -0400
Message-ID: <20240527155845.3866271-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155845.3866271-1-sashal@kernel.org>
References: <20240527155845.3866271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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
index f6e7a88a56f1b..290f875c28598 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -419,6 +419,13 @@ static void lima_sched_timedout_job(struct drm_sched_job *job)
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


