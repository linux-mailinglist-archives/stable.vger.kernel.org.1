Return-Path: <stable+bounces-69772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D87E9593A5
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 06:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E82F284F67
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 04:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8AB155332;
	Wed, 21 Aug 2024 04:28:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317E4206B;
	Wed, 21 Aug 2024 04:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724214479; cv=none; b=LO0mKoGwLuYuuLK2/0d7Wm1gHFhdnp6M1CuyPYxWBZ7zT0uZi1r4zn/cNZYsUOnkg5jppEYrxSc0Gb0mwr0+tAoFpocS9DQUksMnXB7Fsrqyh1PDRskbu9PJx9smaoH+N7XiS2akt67qPpJ9aXlZ7pK4CEZig5J35momdvBCM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724214479; c=relaxed/simple;
	bh=6AS+qYUwNebFbttHVuG2nph/lVb1HMXJzLaPkWSC0uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bKCEwLMlbyZh8LQKfI44fOgudomwUxPCuAyKve4AufNrnuqwTRBW/pxc75WiDAhWuD8Q9bjBPmuM4fgSD45RDwJQbL5IjYe3pAitpwPYJ85gd6B9ZV1f/o9/axo6QDroyTuFcGk4ka0fq7sruAyCHwXvgjbf/2JXmKniZ47fu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowABHTPivbMVmUjqrCA--.1206S2;
	Wed, 21 Aug 2024 12:27:36 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mwen@igalia.com,
	aurabindo.pillai@amd.com,
	joshua@froggi.es,
	hamza.mahfooz@amd.com,
	marek.olsak@amd.com,
	HaoPing.Liu@amd.com,
	akpm@linux-foundation.org
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm/amd/display: avoid using null object of framebuffer
Date: Wed, 21 Aug 2024 12:27:24 +0800
Message-Id: <20240821042724.1391169-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHTPivbMVmUjqrCA--.1206S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4xWF4xKw18Ar48KFWUCFg_yoW8Xw43pF
	sxAFy5Xr1UZF47t347CF1I9FZ0ka93XF1xKrWUuw1Svw15trn8Zws8Grs2gF4xXFWjkw4S
	qFy7ArW2yF1qvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRBVb9UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Instead of using state->fb->obj[0] directly, get object from framebuffer
by calling drm_gem_fb_get_obj() and return error code when object is
null to avoid using null object of framebuffer.

Cc: stable@vger.kernel.org
Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index a83bd0331c3b..5cb11cc2d063 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -28,6 +28,7 @@
 #include <drm/drm_blend.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fourcc.h>
 
 #include "amdgpu.h"
@@ -935,10 +936,14 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	}
 
 	afb = to_amdgpu_framebuffer(new_state->fb);
-	obj = new_state->fb->obj[0];
+	obj = drm_gem_fb_get_obj(new_state->fb, 0);
+	if (!obj) {
+		DRM_ERROR("Failed to get obj from framebuffer\n");
+		return -EINVAL;
+	}
+
 	rbo = gem_to_amdgpu_bo(obj);
 	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
-
 	r = amdgpu_bo_reserve(rbo, true);
 	if (r) {
 		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
-- 
2.25.1


