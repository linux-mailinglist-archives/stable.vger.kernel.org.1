Return-Path: <stable+bounces-151290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A84ACD640
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 05:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D3F17F36C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61487233723;
	Wed,  4 Jun 2025 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzmOPzlc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C152327A1;
	Wed,  4 Jun 2025 02:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005881; cv=none; b=KtPLpSk9QFSb/1wRrZFcRh9di5dSpMbNn4tdnulhIohPfkvlECgQ8zrn1Jeu3PPs/JqtglvnnaQKvRZ3TDImKuQPVRhdAyqI8Kl7IVoM7oWfFI/MHxW5Oik2rkxbR4yQxTBpmdI1Uago5sWpS83OGF/c0A4UQOzRkv4szW+V6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005881; c=relaxed/simple;
	bh=fYjZRivWn2Fn+oWmzNXQqN7xuN63eEwOfSVBHQpA9yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUdGE3ZH9p+i+0vXldrVRb4C2EIumK1MTu33jF9FR8Az5kofRo/ULiYye9zo2YdO6m/5MpuqDysgdilC5R6l1VCldGZwJXb7tCIOA9IQw8bzcxK+tSHQrUpDf1XXYtECgLtKMbQ6LvKhFmpa4TFpqsF3RXtDdjHykp9CpTXMa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzmOPzlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60BD9C4CEF8;
	Wed,  4 Jun 2025 02:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749005880;
	bh=fYjZRivWn2Fn+oWmzNXQqN7xuN63eEwOfSVBHQpA9yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tzmOPzlcgHGjZGee02gOEJaooaeiPs6Hq2uTgVrRFWafpP9RNER3zkljIebv6FXa+
	 hTZBI6iBod0WT/TKZ706Yrggh57ak3c4oKk3Ht6d4xA4Xi7FhVKoMsEqnSokqq/ZGB
	 xXxiqhYOtAavbpQE6eBTb7WH7iNVWnellAU088j5ZL4LXbaUCJkBg6p9pdp+cKw92v
	 jasip2nA3BEg7RIFwBqIbO/024UCyV7JlAN5FrRzhGu3LjZMaGkPl8qnQoZc7Iyz+M
	 hn5BAxZAUlN4qMgGkl+4zHr3q7VqP5RfbPizwkr0Dl354YkKH8U7Q3jPvAidLEk/Cx
	 35AJUACPOtEGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55682C61CE7;
	Wed,  4 Jun 2025 02:58:00 +0000 (UTC)
From: Mingcong Bai via B4 Relay <devnull+jeffbai.aosc.io@kernel.org>
Date: Wed, 04 Jun 2025 10:57:59 +0800
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
Message-Id: <20250604-upstream-xe-non-4k-v2-v2-5-ce7905da7b08@aosc.io>
References: <20250604-upstream-xe-non-4k-v2-v2-0-ce7905da7b08@aosc.io>
In-Reply-To: <20250604-upstream-xe-non-4k-v2-v2-0-ce7905da7b08@aosc.io>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749005878; l=3034;
 i=jeffbai@aosc.io; s=20250604; h=from:subject:message-id;
 bh=gWL8RWOcZ+T5Uids7FBARXCOIx0PC8BeNHiC9X6HMCs=;
 b=SYj4MCax89jyQea100fjLf4kZD36vhAK0FGEdfap8OjkmEqmBIJy1U6DSXpbD8+A6LNaB4VOa
 HFLJ8fi3pqUCLJqcyuS8rHEFY0aR/tgQFeec9DKh2shI8/4m+0UoZyq
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



