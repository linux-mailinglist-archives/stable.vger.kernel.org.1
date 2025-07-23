Return-Path: <stable+bounces-164397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D4B0EC45
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D34E1C25454
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 07:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA886274B22;
	Wed, 23 Jul 2025 07:46:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0EF272E42
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256773; cv=none; b=ByXSAcRmXugmXYZiLHc0KYQ1kRVhSDLQJglmelTC3srZbrCkwtnHMauTn5g0/s2z09ntpcaQZ2hK8xaVQ3lDHIMXi6Uub6kQkUf2C/P1+B/7e8eJdy1/KJje5HOEObQ3ZCrnnhhESOVUgOkxtv9Tqno74REDcFgd3eHdJiytucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256773; c=relaxed/simple;
	bh=5FG86Bn0EslNtjgZGlkbvC06HSVlEBSYddZqMave0DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lr/sYD5tVNOAAsfXghf4ITOmkfj+znG+HjB/2gbhmMr78nOIlNJnQVUvJYswqtaoVvdzvegRFY9blK830c7Z/Bn7FCHYd3rMEfD4qbWhas+W0bHtAh1v4rSSOzZBBGOtCg9zSEBaX427PPev6lyFFRIiuNobum3VhNd1Jj7n62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id CBC563F1F5;
	Wed, 23 Jul 2025 09:46:06 +0200 (CEST)
From: Simon Richter <Simon.Richter@hogyros.de>
To: intel-xe@lists.freedesktop.org
Cc: jeffbai@aosc.io,
	Simon Richter <Simon.Richter@hogyros.de>,
	stable@vger.kernel.org,
	Wenbin Fang <fangwenbin@vip.qq.com>,
	Haien Liang <27873200@qq.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Shirong Liu <lsr1024@qq.com>,
	Haofeng Wu <s2600cw2@126.com>,
	Shang Yatsen <429839446@qq.com>
Subject: [PATCH v3 5/5] drm/xe/query: use PAGE_SIZE as the minimum page alignment
Date: Wed, 23 Jul 2025 16:45:17 +0900
Message-ID: <20250723074540.2660-6-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723074540.2660-1-Simon.Richter@hogyros.de>
References: <20250723074540.2660-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mingcong Bai <jeffbai@aosc.io>

As this component hooks into userspace API, it should be assumed that it
will play well with non-4KiB/64KiB pages.

Use `PAGE_SIZE' as the final reference for page alignment instead.

Cc: stable@vger.kernel.org
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Fixes: 801989b08aff ("drm/xe/uapi: Make constant comments visible in kernel doc")
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Wenbin Fang <fangwenbin@vip.qq.com>
Tested-by: Haien Liang <27873200@qq.com>
Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Tested-by: Shirong Liu <lsr1024@qq.com>
Tested-by: Haofeng Wu <s2600cw2@126.com>
Link: https://github.com/FanFansfan/loongson-linux/commit/22c55ab3931c32410a077b3ddb6dca3f28223360
Link: https://t.me/c/1109254909/768552
Co-developed-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/gpu/drm/xe/xe_query.c | 2 +-
 include/uapi/drm/xe_drm.h     | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index 44d44bbc71dc..f695d5d0610d 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -347,7 +347,7 @@ static int query_config(struct xe_device *xe, struct drm_xe_device_query *query)
 	config->info[DRM_XE_QUERY_CONFIG_FLAGS] |=
 			DRM_XE_QUERY_CONFIG_FLAG_HAS_LOW_LATENCY;
 	config->info[DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT] =
-		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : SZ_4K;
+		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : PAGE_SIZE;
 	config->info[DRM_XE_QUERY_CONFIG_VA_BITS] = xe->info.va_bits;
 	config->info[DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY] =
 		xe_exec_queue_device_get_max_priority(xe);
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index e2426413488f..5ba76b9369ba 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -397,8 +397,11 @@ struct drm_xe_query_mem_regions {
  *      has low latency hint support
  *    - %DRM_XE_QUERY_CONFIG_FLAG_HAS_CPU_ADDR_MIRROR - Flag is set if the
  *      device has CPU address mirroring support
- *  - %DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT - Minimal memory alignment
- *    required by this device, typically SZ_4K or SZ_64K
+ *  - %DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT - Minimal memory alignment required
+ *    by this device and the CPU. The minimum page size for the device is
+ *    usually SZ_4K or SZ_64K, while for the CPU, it is PAGE_SIZE. This value
+ *    is calculated by max(min_gpu_page_size, PAGE_SIZE). This alignment is
+ *    enforced on buffer object allocations and VM binds.
  *  - %DRM_XE_QUERY_CONFIG_VA_BITS - Maximum bits of a virtual address
  *  - %DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY - Value of the highest
  *    available exec queue priority
-- 
2.47.2


