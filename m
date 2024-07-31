Return-Path: <stable+bounces-64849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A53943AC7
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D28281747
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FEB2D045;
	Thu,  1 Aug 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfvMYTUW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9ADDD9;
	Thu,  1 Aug 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471049; cv=none; b=LhhaFtnvfCVW3niTXFLWX8sroFYxA/RLVCHMu+ethGqgEVZKcxif6d+xf6NonGkb6fsy/RgpAHm8hpMHKiDOC/bHsmyrutxgV5ryHex/cPU2u2CmtJaTFepOR3yPTVw+HMvQ6P/AcSOepJBpscq8pvKQQW3pFHzqIzeCKlMRb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471049; c=relaxed/simple;
	bh=fxQd2X8/AWGWDdILhCBDxmEVIOC3NkzNyXnUWBQJ46A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMCapMkuq7y2Gtt1UoWDQKbw+BBfttZDoIEntE3TFiDLl5WJm40mJDoHRXhneCyqBRAWranhKj7lOpeUGl5OBaF160+vIxW7F4FXEzzQcVF9JY+bN7h+2WHUQaxLUPhIyoPcgI6t/Xj4dcard+ye4R/Bwl8kJKZML8lSKjtzhz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfvMYTUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D54EC32786;
	Thu,  1 Aug 2024 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471049;
	bh=fxQd2X8/AWGWDdILhCBDxmEVIOC3NkzNyXnUWBQJ46A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nfvMYTUWDvxQDbgL9hAWBWcm1t0kR3Rp/p46RZdQDSkE2GMZhiacJzltPHqVzqb7H
	 ECszKuO2R1XzGQJMXKaVfDl5rpZkgppHa+ZmXT+V8+2xK4SKNGmrojRm6pEJxDIEFX
	 y31hEiuuXZjqq70ABPriZWRnZ45LlN7yoJ+I7oa1al41zDCLBHABjn75LFwDnBSUxu
	 INfFLVR+vBKCWycDLjj5/x0pqR0gb6qyDnNiAjhj/+8rPoLIWpoya6J6pK6RvySM7z
	 4u0/BtYQW3dF1I1/MIi5LrN1SvSITtjmqwLLgj75K3umVZQyd1g94jL5pui0dqum9J
	 D2/g2vQYcHMpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hamza.mahfooz@amd.com,
	ruanjinjie@huawei.com,
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	wayne.lin@amd.com,
	alvin.lee2@amd.com,
	gabe.teeger@amd.com,
	charlene.liu@amd.com,
	sohaib.nadeem@amd.com,
	sunran001@208suo.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 024/121] drm/amd/display: Fix Coverity INTERGER_OVERFLOW within construct_integrated_info
Date: Wed, 31 Jul 2024 19:59:22 -0400
Message-ID: <20240801000834.3930818-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 176abbcc71952e23009a6ed194fd203b99646884 ]

[Why]
For substrcation, coverity reports integer overflow
warning message when variable type is uint32_t.

[How]
Change varaible type to int32_t.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index bc16db69a6636..25fe1a1240298 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2551,8 +2551,8 @@ static enum bp_result construct_integrated_info(
 
 	/* Sort voltage table from low to high*/
 	if (result == BP_RESULT_OK) {
-		uint32_t i;
-		uint32_t j;
+		int32_t i;
+		int32_t j;
 
 		for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
 			for (j = i; j > 0; --j) {
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 9fe0020bcb9c2..c8c8587a059d9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2920,8 +2920,11 @@ static enum bp_result construct_integrated_info(
 	struct atom_common_table_header *header;
 	struct atom_data_revision revision;
 
-	uint32_t i;
-	uint32_t j;
+	int32_t i;
+	int32_t j;
+
+	if (!info)
+		return result;
 
 	if (info && DATA_TABLES(integratedsysteminfo)) {
 		header = GET_IMAGE(struct atom_common_table_header,
-- 
2.43.0


