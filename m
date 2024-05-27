Return-Path: <stable+bounces-46504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE88D070B
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36981C20621
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA21315F415;
	Mon, 27 May 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS48Vn9W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E615F411;
	Mon, 27 May 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825255; cv=none; b=nGTWxN5TUmC5gtB3XS/7GOPHC7Pu2G/dFbQalzV25ZI9cyqKT14/I7qt9ctq0C/OcPNX1pdjE8JIfOJJ4HBXRxjjmNbRvgYFpGEwbENcJI1Gs98zfBDh4tjii2a8vXN38L1YGGqHE7AzoqhXE0Ut2DHHqTZyOQm+lgUIi8NOTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825255; c=relaxed/simple;
	bh=hSoxJtACmv/83j56N2qI1nRQXowbbOKE8x2vsRg61d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXtmTLGKTqKleTjPy1IW6aTESujd9PRcLyVmbigJu7PstXwRemCjcXOy8cUbq4SRCFMcr4DgKgTHFr4baGOud3NvVXVDZpAGa0UZpfi0L+Mn/SMeCIfqxtoZadWwaN7DyJ8QNLXeUgWLBOndNIl8yorA4mXZLfHiqVbD2Yf7lDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS48Vn9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0315C2BBFC;
	Mon, 27 May 2024 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825255;
	bh=hSoxJtACmv/83j56N2qI1nRQXowbbOKE8x2vsRg61d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GS48Vn9WgLKM0SFqzzkHqSl/y+mwPD74HGSGNCRsENDiL5/PQVzZwTu6rAJkc/VL5
	 RRo3RVM5lfVixp3YUtFNJCxLOwxHBMHrBC7DZXPQVdRWxHo5D4Q7MrOT7T/7j4ScaP
	 tKazlB2+IcWIVzFcM1c659khZSYngmQE+m9S9tYN7MVDs95/QXELK5yBK90FJBYS8o
	 KvOnq2uvPZh0MfdVgmcTqdoZGHCQNV0IPmgx6fJLkIZTLN/xOZ/ptKvHH5CrZ4Ea6l
	 99wUl3DRIvLPJeWgbS9LU60VhiKoSWfrYUPggkJMHXVRNdjND+3qX1zbsk+l3bZHbd
	 kIMzZFDGYoeeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Xi (Alex) Liu" <xi.liu@amd.com>,
	Daniel Miess <daniel.miess@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	charlene.liu@amd.com,
	sungjoon.kim@amd.com,
	chiahsuan.chung@amd.com,
	jun.lei@amd.com,
	danny.wang@amd.com,
	alvin.lee2@amd.com,
	allen.pan@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 06/20] drm/amd/display: add root clock control function pointer to fix display corruption
Date: Mon, 27 May 2024 11:52:49 -0400
Message-ID: <20240527155349.3864778-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155349.3864778-1-sashal@kernel.org>
References: <20240527155349.3864778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: "Xi (Alex) Liu" <xi.liu@amd.com>

[ Upstream commit de2d1105a3757742b45b0d8270b3c8734cd6b6f8 ]

[Why and how]

External display has corruption because no root clock control function. Add the function pointer to fix the issue.

Reviewed-by: Daniel Miess <daniel.miess@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Xi (Alex) Liu <xi.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 143d3fc0221cf..069e48573f4a9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -147,6 +147,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	//.hubp_pg_control = dcn35_hubp_pg_control,
 	.enable_power_gating_plane = dcn35_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
+	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
-- 
2.43.0


