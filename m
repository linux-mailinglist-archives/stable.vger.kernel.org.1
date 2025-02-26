Return-Path: <stable+bounces-119590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742C5A45297
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 03:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5E0420284
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F02B2147FA;
	Wed, 26 Feb 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URTgDunk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0622135AA;
	Wed, 26 Feb 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535221; cv=none; b=IIgZubASAnwGxlv5NeqMBhNU9lTgUQlFTC2mivKYdeNoQUap+h6TCSyUoO0Sisg5yF/CWo9nRnAwXK1MaxtC5u9KW8Ibp7EqHPk51mvRcxvjM/4uEs78IfMkZixSV/ErW/lemm0gQqoqgd6ahJJDn3LMfZD62mj6yVM9nogYNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535221; c=relaxed/simple;
	bh=XCm0UnDl0UjwuDii1VlSg4+CB50UX9yi57hz53MV3T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ht/IH1PLiIf0r7FNDd66V9rjRmt6vttR39HoaM6XoP0jE9dmiRr+lWudJYRf25gRfUotBhfcpjHkQ64c53nGSM81vZzxSO48POu1DO0+zP4wQr3j4jAtykdOrza0eE/eQd8318TQtlJl71Ih9+dyfp56+WK7I5AY2S1nEMQYDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URTgDunk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8C77C4CEDD;
	Wed, 26 Feb 2025 02:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740535220;
	bh=XCm0UnDl0UjwuDii1VlSg4+CB50UX9yi57hz53MV3T8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=URTgDunkhE7ZxnwQ6G530ryao16aRQ6yr6aPNQi2Mj1/GNeeS01NWF2rw1EEi7/0X
	 P/YxyBB70hjT9bCUwXW0RAbLEc1aUVv8HQfVa8JkCM3gEwr/AD1iHWWkVcoX5g9+zD
	 nA2lYJLi0O5kADXNC+UNE+HW5cKAWgBYNe08Tzb+CGh3Fo0CgPFNH6Rs+P344Jia4C
	 kzHUTLmAWxb+sJf3sas7QNFE5S/iv/bJyzI/d24ZsA7m4643x+MnfIjzsuKpCJxR2f
	 mwpfCrAxSot2upcIPC9u7AIHtQt3XvXYNWQXw0uYRqYbKwc9JkwxVAL2c4wGnonTbR
	 GOt4MWtxbIXDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9758C18E7C;
	Wed, 26 Feb 2025 02:00:20 +0000 (UTC)
From: Mingcong Bai via B4 Relay <devnull+jeffbai.aosc.io@kernel.org>
Date: Wed, 26 Feb 2025 10:00:22 +0800
Subject: [PATCH 5/5] drm/xe/query: use PAGE_SIZE as the minimum page
 alignment
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-xe-non-4k-fix-v1-5-80f23b5ee40e@aosc.io>
References: <20250226-xe-non-4k-fix-v1-0-80f23b5ee40e@aosc.io>
In-Reply-To: <20250226-xe-non-4k-fix-v1-0-80f23b5ee40e@aosc.io>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>, 
 Francois Dugast <francois.dugast@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Alan Previn <alan.previn.teres.alexis@intel.com>, 
 Zhanjun Dong <zhanjun.dong@intel.com>, 
 Matt Roper <matthew.d.roper@intel.com>, 
 Mateusz Naklicki <mateusz.naklicki@intel.com>
Cc: Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>, 
 =?utf-8?q?Zbigniew_Kempczy=C5=84ski?= <zbigniew.kempczynski@intel.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Shang Yatsen <429839446@qq.com>, Mingcong Bai <jeffbai@aosc.io>, 
 stable@vger.kernel.org, Haien Liang <27873200@qq.com>, 
 Shirong Liu <lsr1024@qq.com>, Haofeng Wu <s2600cw2@126.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740535218; l=2489;
 i=jeffbai@aosc.io; s=20250225; h=from:subject:message-id;
 bh=kdJ4lbdvf4bhnqSjO+QvoRJ988PIBJrpUHd4FzEvGso=;
 b=3R8diCFFhMKJlehfdNxnm+lVc0U8/QuWXTuFJtjkUklxv2W0a6BEa1EAGiD3JqlnihLtFHEIy
 CZPDU4Ib5uQCxeQzvSEP7qgt23Z1BNi2/uGSACuew5MiAADRW/OmL6l
X-Developer-Key: i=jeffbai@aosc.io; a=ed25519;
 pk=PShXLX1m130BHsde1t/EjBugyyOjSVdzV0dYuYejXYU=
X-Endpoint-Received: by B4 Relay for jeffbai@aosc.io/20250225 with
 auth_id=349
X-Original-From: Mingcong Bai <jeffbai@aosc.io>
Reply-To: jeffbai@aosc.io

From: Mingcong Bai <jeffbai@aosc.io>

As this component hooks into userspace API, it should be assumed that it
will play well with non-4K/64K pages.

Use `PAGE_SIZE' as the final reference for page alignment instead.

Cc: stable@vger.kernel.org
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Fixes: 801989b08aff ("drm/xe/uapi: Make constant comments visible in kernel doc")
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Haien Liang <27873200@qq.com>
Tested-by: Shirong Liu <lsr1024@qq.com>
Tested-by: Haofeng Wu <s2600cw2@126.com>
Link: https://github.com/FanFansfan/loongson-linux/commit/22c55ab3931c32410a077b3ddb6dca3f28223360
Co-developed-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/gpu/drm/xe/xe_query.c | 2 +-
 include/uapi/drm/xe_drm.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index c059639613f7b548c168f808b7b7b354f1cf3c94..8a017c526942d1f2b401e8b9a4244e6083d7b1e5 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -336,7 +336,7 @@ static int query_config(struct xe_device *xe, struct drm_xe_device_query *query)
 		config->info[DRM_XE_QUERY_CONFIG_FLAGS] =
 			DRM_XE_QUERY_CONFIG_FLAG_HAS_VRAM;
 	config->info[DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT] =
-		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : SZ_4K;
+		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : PAGE_SIZE;
 	config->info[DRM_XE_QUERY_CONFIG_VA_BITS] = xe->info.va_bits;
 	config->info[DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY] =
 		xe_exec_queue_device_get_max_priority(xe);
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index f62689ca861a4673b885629460c11d6f3bc6523d..db7cf904926ebd6789a29d620161ac051e59f13f 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -394,7 +394,7 @@ struct drm_xe_query_mem_regions {
  *    - %DRM_XE_QUERY_CONFIG_FLAG_HAS_VRAM - Flag is set if the device
  *      has usable VRAM
  *  - %DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT - Minimal memory alignment
- *    required by this device, typically SZ_4K or SZ_64K
+ *    required by this device, typically PAGE_SIZE.
  *  - %DRM_XE_QUERY_CONFIG_VA_BITS - Maximum bits of a virtual address
  *  - %DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY - Value of the highest
  *    available exec queue priority

-- 
2.48.1



