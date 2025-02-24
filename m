Return-Path: <stable+bounces-118700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9D5A41564
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 07:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8083C16A1A8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 06:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205A1A76AC;
	Mon, 24 Feb 2025 06:32:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301F155CB3;
	Mon, 24 Feb 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378768; cv=none; b=QKI2fmw/DhKq+pVsbrAWh7chLmnicwXRpRzsRU/9girIPAyEgG9T7NtosSiSiE9ZBugdsXgVJuyN8X11AkIxsW10WinBdF8XhY650HPrjKn8ptWIcsuvnxeevZFJbiVWfoDJOJaHL0vbr+0ajhjf1bx15/34gDmZ/m+w3fr9+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378768; c=relaxed/simple;
	bh=alqqsKVkfMgJ0mBzCGDL8ZQOv8hgioR6Z+KL/cL1SFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c24hMik3dtB5+rYb9A118wDvGwBYjPB+AjBGioMThBboMnyqdmWcC0Dnj++qtqx6GmxQB0AikCzvBTngYz1JkXw7154B1Q25mV05Zb48WeT0hY8KNQ5DUOVEIsBhbAF++V3Wq1VXaNywOiiQ9xrjyx82aMeGjk0B1M3Bk4u/MAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAC3vVV0ErxnL6j0Dw--.49149S2;
	Mon, 24 Feb 2025 14:32:29 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	dillon.varone@amd.com,
	Samson.Tam@amd.com,
	yi-lchen@amd.com,
	chris.park@amd.com,
	aurabindo.pillai@amd.com,
	george.shen@amd.com,
	gabe.teeger@amd.com,
	Yihan.Zhu@amd.com,
	Tony.Cheng@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix null check for pipe_ctx->plane_state in resource_build_scaling_params
Date: Mon, 24 Feb 2025 14:32:18 +0800
Message-Id: <20250224063218.2953217-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3vVV0ErxnL6j0Dw--.49149S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr45GrW5XF1rZr4UJr47urg_yoWDKrg_KF
	48urn3tr1fAanF9F10vw4fuFyF9rZ5urZaqFW2yFWYyry7WrWkX34xXr1rWryxZFsrKF98
	A3Wqkr15ZwnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKCJmDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Null pointer dereference issue could occur when pipe_ctx->plane_state
is null. The fix adds a check to ensure 'pipe_ctx->plane_state' is not
null before accessing. This prevents a null pointer dereference.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 3be5262e353b ("drm/amd/display: Rename more dc_surface stuff to plane_state")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 520a34a42827..88e8ae63a07f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1452,6 +1452,9 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	struct scaling_taps temp = {0};
 	bool res = false;
 
+	if (!plane_state)
+		return false;
+
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
 	/* Invalid input */
-- 
2.25.1


