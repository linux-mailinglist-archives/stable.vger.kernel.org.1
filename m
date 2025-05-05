Return-Path: <stable+bounces-141238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B7AAB679
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9479A3A3917
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C518E33520F;
	Tue,  6 May 2025 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGmZIQCp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE492D3A8E;
	Mon,  5 May 2025 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485589; cv=none; b=d6TaWuPUE68+vlzele5+jAkD/I4bK3fJmNg5Sex5vHsZj3mc3ePJZnPx7LJU8y/AHhuDYPTwemWh4fgFNDSzLgLf2QHnrRw/XPIbxiB4yjdGbeDtSjRaaRYOt97UEuLmEZ730nZRZ0BsjfuKPWIQ1NFp8qswNf2SvDzXBqEltTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485589; c=relaxed/simple;
	bh=eDTYqeU+oQFr7SWa5485eL3s49zALyACKCo9B5nM0kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q425d5a04VYEwNKAdsIZy6t6RpwoIkrlAWbXdz7q14XbCggTRZAFLTSA2Vdgy84b+hFaXdabiOxVFVlTIGKMchCoXx2Q1Txr9Rfqss8yK1YlWRskX4Ugp1bpvXHZwpJcwT9YTAYy1Gj8y81A11ZEimOUVT745uNOiLCmRrGA6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGmZIQCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68D2C4CEE4;
	Mon,  5 May 2025 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485588;
	bh=eDTYqeU+oQFr7SWa5485eL3s49zALyACKCo9B5nM0kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGmZIQCp0QBO6PSYwxw/BT3Z9JTt7N0lBQZ3YpbGg46E4qYjbe4G/QUV7PriMr17b
	 2oaWe60bGwr5Ghac0hikl8eXNOlZzRPFU748yQMtSeO0XG/dP2E4GnNKC5PR9g4bcN
	 KXRIJVhixxILqqC1JJ0D1oBpIsgCDdcqMDL4mRJbf/1Y0DhnqSRJq7JOgx9PPaoQeU
	 bZzQ/Ibqb8YmarXT/gZdvi5w5auYInrnvfuk3fTa0a+VltKRpH1cejZBn+7PqSFh12
	 nc3Q3YF7tCF6xCCA1yz0U5m9iIa/fzop6Ny67Ern00ffnCJEpH37CKSmniCIevB3Ah
	 xPxI4JGwBG3gg==
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
Subject: [PATCH AUTOSEL 6.12 376/486] drm/amd/display/dc: enable oem i2c support for DCE 12.x
Date: Mon,  5 May 2025 18:37:32 -0400
Message-Id: <20250505223922.2682012-376-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 621825a51f46e..a2ab6776b8855 100644
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


