Return-Path: <stable+bounces-152594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D2AD8007
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 03:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355291897720
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0761DE3C8;
	Fri, 13 Jun 2025 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtpVAedd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3A1D7E4A;
	Fri, 13 Jun 2025 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777092; cv=none; b=VG7SXRFmG/IqHaHFOHcISmL8drKw5hte0GB1jFllHrIuduBkxuYq3oYVLfjUoXWzRCnn/YeowssL5AsmAz1VRbu2Pgct36WEgI0JC5BTYfkmYAk9Rwp2s8JO2RJvsf4eD3q7vjPMgQ0E9axfpbtXu4l/oTh6kw/w0Lmsqrb9pp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777092; c=relaxed/simple;
	bh=fYjZRivWn2Fn+oWmzNXQqN7xuN63eEwOfSVBHQpA9yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOHhusVfQH31aCv5ywFY+7o8iF98Y6sBuz2DOLvmVPIh+dVV0NwwnZOxQAfqZ7UopNlEnOZCnIYCukeImJTuZtF56QShu5CgjmkwXMG035UWAzBbCnZSF1FJukuedC5zCXYp75QPzlVo6yBLC0WarS28pFh72DThZa/VQAk5ois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtpVAedd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4E2EC4CEF7;
	Fri, 13 Jun 2025 01:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749777091;
	bh=fYjZRivWn2Fn+oWmzNXQqN7xuN63eEwOfSVBHQpA9yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rtpVAedd66sPrM+hY2oxPRDpPvlpiJObu0GevyQv0K3W7FSGgwJf3jgI8nZqCFvtn
	 oP1zqeQTAbTSqS9MPDhf9sPqOKcu4RzJkIP7ONPyUw3P+Gv4RyH3rH4I4jep+dkIUS
	 zsNn4uqIfj/4C/dbFOSZU74AoaSEk1d6hXgY9f9FSKJQbXDbUbXLQZDm4dqgkG9tHG
	 1Jze3d93xNlrVPXrYkr2Rbr13b/ksCl9g0MvOWHpFwuk+A1xQS/GUw7aNDDtmbxRAl
	 81EKT/BtkCE0/zEFEQ6BsfNfz9h8/XdQzkz4bpo8tenLzglELRAmLY9NvEaoNWBKP5
	 1mf0qMJJVmefg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92E7C71148;
	Fri, 13 Jun 2025 01:11:31 +0000 (UTC)
From: Mingcong Bai via B4 Relay <devnull+jeffbai.aosc.io@kernel.org>
Date: Fri, 13 Jun 2025 09:11:33 +0800
Subject: [PATCH v2 5/5] drm/xe/query: use PAGE_SIZE as the minimum page
 alignment
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-upstream-xe-non-4k-v2-v2-5-934f82249f8a@aosc.io>
References: <20250613-upstream-xe-non-4k-v2-v2-0-934f82249f8a@aosc.io>
In-Reply-To: <20250613-upstream-xe-non-4k-v2-v2-0-934f82249f8a@aosc.io>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Francois Dugast <francois.dugast@intel.com>, 
 =?utf-8?q?Zbigniew_Kempczy=C5=84ski?= <zbigniew.kempczynski@intel.com>, 
 =?utf-8?q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>, 
 Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Zhanjun Dong <zhanjun.dong@intel.com>, 
 Matt Roper <matthew.d.roper@intel.com>, 
 Alan Previn <alan.previn.teres.alexis@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Mateusz Naklicki <mateusz.naklicki@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kexy Biscuit <kexybiscuit@aosc.io>, Shang Yatsen <429839446@qq.com>, 
 Mingcong Bai <jeffbai@aosc.io>, Wenbin Fang <fangwenbin@vip.qq.com>, 
 Haien Liang <27873200@qq.com>, Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Shirong Liu <lsr1024@qq.com>, Haofeng Wu <s2600cw2@126.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749777090; l=3034;
 i=jeffbai@aosc.io; s=20250604; h=from:subject:message-id;
 bh=gWL8RWOcZ+T5Uids7FBARXCOIx0PC8BeNHiC9X6HMCs=;
 b=Q0CPOLyStGLjhT6+x+gKKShN9k6MBkZEp9SYnxxZoRQbNmntY5WlakCsLQqecRGX4JzCl7Kmi
 swRCsXXAkwoCPO5anbatDazKDXA2TuDS/6jE0TkX9SncSqJk4cINnRb
X-Developer-Key: i=jeffbai@aosc.io; a=ed25519;
 pk=MJdgklflDF+Xz9x2Lp+ogEnEyk8HRosMGiqLgWbFctY=
X-Endpoint-Received: by B4 Relay for jeffbai@aosc.io/20250604 with
 auth_id=422
X-Original-From: Mingcong Bai <jeffbai@aosc.io>
Reply-To: jeffbai@aosc.io

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
index 2dbf4066d86ff225eee002d352e1233c8d9519b9..fe94a7781fa04fb277d5cc8b973b145293d3d066 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -346,7 +346,7 @@ static int query_config(struct xe_device *xe, struct drm_xe_device_query *query)
 	config->info[DRM_XE_QUERY_CONFIG_FLAGS] |=
 			DRM_XE_QUERY_CONFIG_FLAG_HAS_LOW_LATENCY;
 	config->info[DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT] =
-		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : SZ_4K;
+		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : PAGE_SIZE;
 	config->info[DRM_XE_QUERY_CONFIG_VA_BITS] = xe->info.va_bits;
 	config->info[DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY] =
 		xe_exec_queue_device_get_max_priority(xe);
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 9c08738c3b918ee387f51a68ba080057c6d5716f..f92eb8c3317a09baad4550024bb3beea02850010 100644
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
2.49.0



