Return-Path: <stable+bounces-46486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F578D06C3
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D078828AB7F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADDF15F3E5;
	Mon, 27 May 2024 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8oHOD+a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF513A248;
	Mon, 27 May 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825135; cv=none; b=EKMuUFeK2+70GykTGlFMMW55zYF9YvlqkEAt4T1v/Z38DZRQn/uKLa6Z+Dmz4JbghIkZyugBZHGEs6A17mjqH2s3/Zu6IDWbbL7h3OtVx+nMeKi2yTjNE0/Cxl8PbKWKCFxXcLWIw7d81efV2DVQPucKHHJQwGEOsOpcGdZpQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825135; c=relaxed/simple;
	bh=w3cDm44p+/3gFORFyqiEPB8zQtnbKhxFtPfevHoWq1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aw/CQ4HqHzIE8Ls34cTZyN3C+8fIpyzYQRzUv7t6U4jy3TXLTj8fpVz/ta8d9IGcO3Un4JKBlCJqZ65qvFvG06SAPws81I+lRS06aPQNZKWAz9/HVmMMN5eMEQzV90kt25/ra9MYF+z/IuUZiwGo00nClhOEfMofLhD2g1LzG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8oHOD+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51318C4AF09;
	Mon, 27 May 2024 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825135;
	bh=w3cDm44p+/3gFORFyqiEPB8zQtnbKhxFtPfevHoWq1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8oHOD+aBvz81B890q1lztYM+7YI4WilCxlmwpDwp9gdiFqXT8H/FiZEfr05Frrxc
	 IWKJTgoDS0Hy7a7n6datgXPktgKrIfQwG103JO5qUE2LFa9Gr3Ht4eZbcUBMffjx6E
	 UX9OZ1lvy3a6urD+zzVGV5RZ9wGnbSmOgxdhPqFEZY1U0BhIRLtvurxUTmEgKsf/wo
	 tWctBkkgMTXL2bmoo3ecwzmLIwG1KTbwDPwPa1re7WbLwtX+TepSoN0eGvmTOD+ipm
	 G0Bwa+DrKDMH+XtIKVbbcGTY/6aKq6uV2Dy8mQafZjHMzG2xA8sWw3FF53PeCEA6nZ
	 +Xbm3Zo/L8tIA==
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
Subject: [PATCH AUTOSEL 6.9 11/23] drm/lima: include pp bcast irq in timeout handler check
Date: Mon, 27 May 2024 11:50:12 -0400
Message-ID: <20240527155123.3863983-11-sashal@kernel.org>
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

[ Upstream commit d8100caf40a35904d27ce446fb2088b54277997a ]

In commit 53cb55b20208 ("drm/lima: handle spurious timeouts due to high
irq latency") a check was added to detect an unexpectedly high interrupt
latency timeout.
With further investigation it was noted that on Mali-450 the pp bcast
irq may also be a trigger of race conditions against the timeout
handler, so add it to this check too.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240405152951.1531555-3-nunes.erico@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/lima/lima_sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 00b19adfc8881..66841503a6183 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -422,6 +422,8 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 	 */
 	for (i = 0; i < pipe->num_processor; i++)
 		synchronize_irq(pipe->processor[i]->irq);
+	if (pipe->bcast_processor)
+		synchronize_irq(pipe->bcast_processor->irq);
 
 	if (dma_fence_is_signaled(task->fence)) {
 		DRM_WARN("%s unexpectedly high interrupt latency\n", lima_ip_name(ip));
-- 
2.43.0


