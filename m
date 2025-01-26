Return-Path: <stable+bounces-110566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 146D1A1C9F5
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C60188423C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B61FC10E;
	Sun, 26 Jan 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W45a9Xix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28F1CF5E2;
	Sun, 26 Jan 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903371; cv=none; b=MgP7Ky5ayn2FABdCm4PKGb3PIZCZuNe9MAXjUZNLHntAmat0xAiip8iyD3hzfRrBMtgN9E/o7x3faMoZUJ5nL5qKlYWSw2yFEG9HCoB3mMV+qTMrq8zQ3PqOe0okC706qSZe+jF4UyJxZSD4qsjMia4kUvdoAHvgaQR19fliZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903371; c=relaxed/simple;
	bh=p75+67CQSvwC2Ah/9YcMBAgYcG8U2BuzHzywnXyrnjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJ9xoE0lnuP+AsI9YoxFkTJIscsAbfT6kSz1HDHnQaRpHeyLEj+1gHjyQgxMRPbdkQLQVBL2jEiJQwaC2cTvcdSBSgglvEFS/WPIMSVHT+PA7fZCnF8VRHZopGeMOnIk0jf4Yi+ynm95HFo4GG6fiK7ZF8dh793++iMiOSEEQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W45a9Xix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B967C4CEE3;
	Sun, 26 Jan 2025 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903370;
	bh=p75+67CQSvwC2Ah/9YcMBAgYcG8U2BuzHzywnXyrnjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W45a9XixeZvjIrblx7HVqGIi04D/sxbscQrdduyxE2VMZdtcs+8pGBgXeyMelymF8
	 YfSqcGVSEe9rLOB9S1PKs0FOHMHw/O3cHx+xu8yZYe/40cpEgVweXzDQ5TaXtglu6M
	 RZlGoUDi1sYMYYiPoEUarX3hqvJ182hA41/GK9CbBxtLAFgrh23L4AD4Jg0vuvm28l
	 VgFULrDMhciAz1VcQq+rbkv9nMrxDh2yxB6vHO40ZHFSIMqla80yQ+vhoKMMkuq2xC
	 EoELFGhCBz9KszjOnVPfbvqr5oIfYcNHa71mrJv4eIKpQc7ovZ47qTw4ahhiowL6HD
	 DFVZ1GtyPbrIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabe Teeger <Gabe.Teeger@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	roman.li@amd.com,
	rostrows@amd.com,
	linux@treblig.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 30/31] drm/amd/display: Limit Scaling Ratio on DCN3.01
Date: Sun, 26 Jan 2025 09:54:46 -0500
Message-Id: <20250126145448.930220-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Gabe Teeger <Gabe.Teeger@amd.com>

[ Upstream commit abc0ad6d08440761b199988c329ad7ac83f41c9b ]

[why]
Underflow and flickering was occuring due to high scaling ratios
when resizing videos.

[how]
Limit the scaling ratios by increasing the max scaling factor

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Gabe Teeger <Gabe.Teeger@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/resource/dcn301/dcn301_resource.c  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 7d04739c3ba14..4bbbe07ecde7d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -671,9 +671,9 @@ static const struct dc_plane_cap plane_cap = {
 
 	/* 6:1 downscaling ratio: 1000/6 = 166.666 */
 	.max_downscale_factor = {
-			.argb8888 = 167,
-			.nv12 = 167,
-			.fp16 = 167 
+			.argb8888 = 358,
+			.nv12 = 358,
+			.fp16 = 358
 	},
 	64,
 	64
@@ -694,7 +694,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 7680,/*upto 8K*/
+	.max_downscale_src_width = 4096,/*upto true 4k*/
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
 	.underflow_assert_delay_us = 0xFFFFFFFF,
-- 
2.39.5


