Return-Path: <stable+bounces-64853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DCD943AD1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79E5B21EA1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79573F4E2;
	Thu,  1 Aug 2024 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjhja9Ig"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D4F50F;
	Thu,  1 Aug 2024 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471118; cv=none; b=jqEZ7qlSefsaQ4mkflhermjyiMDaX1133X/VkEsu1QSGYEut1PClr9V3HdF7FJ967U2peIGS/RLZzS54hmFpsYWlsm5vBqQksLhggW/ILoeM/KuemssDPqEKcrH98VKxvH/AfCKKS7yAA+6rLLzNW93TCorh3nHofH1iVcidgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471118; c=relaxed/simple;
	bh=A/toJ8UkdmHj2o2fpAPk5vuotSbv3TWTkCCdZeYA7Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVLv7ReyzZklFFmCxnR+vwQcXmzr/vP602uoSYkWbkb5Biv8roFCulpNjFh6YU77EyftExAW9ekgHa/ym66s5H7D+fwE57mhwfxbEEEc7XE2XRHF+a0jeJlc0FRhFy9sg7FTA3igUpYJWuc01bgdKb4ctNMS82l5d3Ech5eGM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjhja9Ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D974C4AF0C;
	Thu,  1 Aug 2024 00:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471118;
	bh=A/toJ8UkdmHj2o2fpAPk5vuotSbv3TWTkCCdZeYA7Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vjhja9IgQxz/xk0dOSCBD6SZwNiIsE4cRaUR7EjUaQJy/FJPeqqrFo1xveZ6sYKBR
	 3KifTUISd1Hl5ZHPXbhZlQezHhe7WHwYcdIImk7A+SNSEWoiJR/1Jq/9DJsKHAf2tN
	 PKnb0jGKEG5AGy0nANALDyUe9kZ4B3mYAnklzAzkyDHlvwhyQdUtQC+KHbede2JtMx
	 TWPu0zK2wDG0w04HUCyk/eZev4XwuS7L+Q3jseOFeY69fWbbPSmusOLPpeS+N/ig+o
	 5pBvQkoWieXzbSxrzuMj1TlUadTYWO+3t6BNEVc8JdE4Uvv6nD9k6htCq5KGB0bky7
	 UXJNs9Fs7N8ZQ==
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
	wenjing.liu@amd.com,
	george.shen@amd.com,
	zaeem.mohamed@amd.com,
	michael.strauss@amd.com,
	Bhawanpreet.Lakha@amd.com,
	sungjoon.kim@amd.com,
	daniel.sa@amd.com,
	ran.shi@amd.com,
	yao.wang1@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 028/121] drm/amd/display: Fix Coverity INTEGER_OVERFLOW within decide_fallback_link_setting_max_bw_policy
Date: Wed, 31 Jul 2024 19:59:26 -0400
Message-ID: <20240801000834.3930818-28-sashal@kernel.org>
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

[ Upstream commit 83c0c8361347cf43937348e8ca0a487679c003ae ]

[Why]
For addtion (uint8_t) variable + constant 1,
coverity generates message below:
Truncation due to cast operation on "cur_idx + 1" from
32 to 8 bits.

Then Coverity assume result is 32 bits value be saved into
8 bits variable. When result is used as index to access
array, Coverity suspects index invalid.

[How]
Change varaible type to uint32_t.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index d487dfcd219b0..b26faed3bb206 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -534,7 +534,7 @@ static bool decide_fallback_link_setting_max_bw_policy(
 		struct dc_link_settings *cur,
 		enum link_training_result training_result)
 {
-	uint8_t cur_idx = 0, next_idx;
+	uint32_t cur_idx = 0, next_idx;
 	bool found = false;
 
 	if (training_result == LINK_TRAINING_ABORT)
-- 
2.43.0


