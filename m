Return-Path: <stable+bounces-140231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD41AAA688
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A349863FB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCA73247A2;
	Mon,  5 May 2025 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owspGIS/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86D32479F;
	Mon,  5 May 2025 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484461; cv=none; b=pvVxSwYZQxuS+K1mr3QWIIrY5GGt8LidpRcq8TWLL3ysGgD4vII0+PPNqrnG2AL3EVTV6Jy6xuFzktGGyq7cdWUfsBGvxj6rK0PxHfAKJNO6EkiTmarO9dFUOH3KErVnI++xjNYCwnVvz3QTMPJS9n9ayH+R3MWucf25Rtg3AoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484461; c=relaxed/simple;
	bh=a2czUlsCVEntuKFZnGczC/M4K8j+fsa0mkMpdl8Ybu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uo9APZBR6waCgCxINguXvrgdSgeUvCird62fGhdCBQGO0PcA5SZ3jZsQ9/YjTxi7gG2ZFXaN+blqCMVWxY6UcA7Hy97Wx8JcvsFLdEna5dQHJO25TWTHetsL3eXgN1KWvuR+RrwRkIVjU0Qg4cXc9ycdusMnKUs/hXBzU0RWnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owspGIS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28060C4CEED;
	Mon,  5 May 2025 22:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484459;
	bh=a2czUlsCVEntuKFZnGczC/M4K8j+fsa0mkMpdl8Ybu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owspGIS/WJE3dBGsenwmPSQo+94ty0JURXo3g8wqj7jKY/X7l6Zq6a1IfOvVzLkoU
	 ht57Edp/e95PzqAvBFmPy7H+D4+0gr2/lAKozspH3VA+U7vtnrUUxAFSROneH7lPq2
	 haDk5Sf+mKBm2L3RnLkO6LnMNj7kNieV6fnOcNPY8HoRgsuThDl1CFkd9BpHoeKe3N
	 cxlqgqDFb/Ex6Tyfn8nDYomllZYn/fzr4J53Ua82n1Ev3ecG1ZoDU7zdtznWh4hVVJ
	 pJ2mNKGBa3/y0sLWOQOCylD69VlTuE84Y/kezIqGPAKfC96p3R/VB2Ku6ulS1Ntoqz
	 5ky3TyzCn+3oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	roman.li@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 483/642] drm/amd/display/dc: enable oem i2c support for DCE 12.x
Date: Mon,  5 May 2025 18:11:39 -0400
Message-Id: <20250505221419.2672473-483-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 2ed83f2cc41e8f7ced1c0610ec2b0821c5522ed5 ]

Use the value pulled from the vbios just like newer chips.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/resource/dce120/dce120_resource.c        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index c63c596234333..eb1e158d34361 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -67,6 +67,7 @@
 #include "reg_helper.h"
 
 #include "dce100/dce100_resource.h"
+#include "link.h"
 
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
 	#define mmDP0_DP_DPHY_INTERNAL_CTRL		0x210f
@@ -659,6 +660,12 @@ static void dce120_resource_destruct(struct dce110_resource_pool *pool)
 
 	if (pool->base.dmcu != NULL)
 		dce_dmcu_destroy(&pool->base.dmcu);
+
+	if (pool->base.oem_device != NULL) {
+		struct dc *dc = pool->base.oem_device->ctx->dc;
+
+		dc->link_srv->destroy_ddc_service(&pool->base.oem_device);
+	}
 }
 
 static void read_dce_straps(
@@ -1054,6 +1061,7 @@ static bool dce120_resource_construct(
 	struct dc *dc,
 	struct dce110_resource_pool *pool)
 {
+	struct ddc_service_init_data ddc_init_data = {0};
 	unsigned int i;
 	int j;
 	struct dc_context *ctx = dc->ctx;
@@ -1257,6 +1265,15 @@ static bool dce120_resource_construct(
 
 	bw_calcs_data_update_from_pplib(dc);
 
+	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
+		ddc_init_data.ctx = dc->ctx;
+		ddc_init_data.link = NULL;
+		ddc_init_data.id.id = dc->ctx->dc_bios->fw_info.oem_i2c_obj_id;
+		ddc_init_data.id.enum_id = 0;
+		ddc_init_data.id.type = OBJECT_TYPE_GENERIC;
+		pool->base.oem_device = dc->link_srv->create_ddc_service(&ddc_init_data);
+	}
+
 	return true;
 
 irqs_create_fail:
-- 
2.39.5


