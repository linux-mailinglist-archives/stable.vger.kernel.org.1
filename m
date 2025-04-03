Return-Path: <stable+bounces-127957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E8A7AD9D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB76188BF06
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380DC25C6E9;
	Thu,  3 Apr 2025 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4iU5CCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BA25C6E1;
	Thu,  3 Apr 2025 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707601; cv=none; b=U5NOJax7OXFztZap9dGvuf+4Bt1x9Ofn2hq8pu7o7YTWNdfZPpBBANQEhIdcyXWI/asol7DwHjAZhgKrOvA1azDIVNLwRLWAFTORnV+a2smY2+KBKo0Go/vjse9ZaitrhLMGiEwA212hTHJxRADDPQhYoLLCMAYXd0ZDzloUmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707601; c=relaxed/simple;
	bh=gN5SRJ/jkhN4jUG5zwwxY3uWuQjgxLrfGnbO4Sw5yLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnxZpSjqarWNxh8iC/Wj3vFYb5MG9HvqV6udYZcdgF6+RV2VaIsQSRyUIAiCaFF3/hlTfUEg/BOQQBYYoVix/L5+SPwDce0/a3xQXDASZMzKcfYuuRbjgiYJapQ7mUrlY86ibuvvfKyHzxeCyCmYXxvSmDO3pFXt4h7uYlWDC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4iU5CCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68015C4CEE8;
	Thu,  3 Apr 2025 19:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707600;
	bh=gN5SRJ/jkhN4jUG5zwwxY3uWuQjgxLrfGnbO4Sw5yLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4iU5CCcCo5NEhClcrMboYFsEhnXFYODerptmVzP1KitRi2LnbiqmuV0OwrQD+ss1
	 PEDavpblY4+Q0eahWsjNAcXWQY4qMH8Z320G2JqbdNUQM53LEe8sw4an0jmgyOsFDF
	 PLqpbvdasvCcm0YwXLoomjDfNFsJh8LEb5ysxft2b0dBQU6Q1BHNPycuuf+yQ+RmQ3
	 Z8UNuTdf5EJesAjy+Xr844TpsSoUpNoy5s9jwMB8AZWiw36E44mxx4SfLncjyIzPKr
	 WMHkOONy4fsCQsJEHQe1yuIMJoExNEuvaZ7uoLEGgjOK73pF9EQ6CBQpEGRlIv8g+d
	 wcyGU+OP9Y+zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 02/44] drm/virtio: Set missing bo->attached flag
Date: Thu,  3 Apr 2025 15:12:31 -0400
Message-Id: <20250403191313.2679091-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

[ Upstream commit ffda6454267d0b870f3a09945a7ce88137b914a6 ]

VirtIO-GPU driver now supports detachment of shmem BOs from host, but
doing it only for imported dma-bufs. Mark all shmem BOs as attached, not
just dma-bufs. This is a minor correction since detachment of a non-dmabuf
BOs not supported today.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241129155357.2265357-1-dmitry.osipenko@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 1 -
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index f92133a01195a..4837076308615 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -250,7 +250,6 @@ static int virtgpu_dma_buf_init_obj(struct drm_device *dev,
 	virtio_gpu_cmd_resource_create_blob(vgdev, bo, &params,
 					    ents, nents);
 	bo->guest_blob = true;
-	bo->attached = true;
 
 	dma_buf_unpin(attach);
 	dma_resv_unlock(resv);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index ad91624df42dd..062639250a4e9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1300,6 +1300,9 @@ virtio_gpu_cmd_resource_create_blob(struct virtio_gpu_device *vgdev,
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	bo->created = true;
+
+	if (nents)
+		bo->attached = true;
 }
 
 void virtio_gpu_cmd_set_scanout_blob(struct virtio_gpu_device *vgdev,
-- 
2.39.5


