Return-Path: <stable+bounces-95051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC489D745A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68AFDBC11D3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA16D201028;
	Sun, 24 Nov 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqt70pBl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B31990C4;
	Sun, 24 Nov 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455813; cv=none; b=bzEI9pANPIJQ4MKoN6SQOXjHKAGTUFjeBqMS/PKOsdKozrzBiD+ItUX2iF3vcNXnka4MBpS9dRrewfiid1dXQqr6ZSMS8iwZwHM4ztK00LW5V7cVOkgE4NKwwmrPeJQEhe4F89EimRPCvSFL9IaKra7CvblZk6mK/aKzLMxQ/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455813; c=relaxed/simple;
	bh=uiHgRdqlSB+iJL3r7mgXiN+bUM+nQs/odsN0rgewpMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNmrjE6F72F0VaFkTs3l7SDSuGX9uD0h0ImYGXnKx/FMWfiL1peac+tYSlTVRiOa+TTNXBRMq3xj6uiM9/Q/y1pkzGbdbleUqjdOSy95ABr0/LF9wKtxPBVF15Mleh5Zl5Ip8Fs8HxEZXXDIQjR1qQsDTQe3Y5l3FZaCE+pIr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqt70pBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508B5C4CED1;
	Sun, 24 Nov 2024 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455813;
	bh=uiHgRdqlSB+iJL3r7mgXiN+bUM+nQs/odsN0rgewpMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqt70pBlWhR1LQBxC++HMOmPvJtQP/08zjsNzkVkbpthT26a9YbRq4tRTGsG/H/4n
	 khCtk3o0Eb7t1jvG7YFYQLX46wfVaaQalWQIjNSlfQOaTS1pkPmUJ8TiR8F8X5DgVB
	 dd24i3BtzBeHlmXxwd5Eg/G1DWX9VWlQ98KbU1WdB4JMOsxUjswzhkCYxdRrY9cUlt
	 nDeZBDYhfv+ijlL/dHmlCcd5BkmI6R5GjhNDMw5WFsWnOiMaRqwj7bNPxBa0ewtzhI
	 s00IKkiVS9jdVhjiWBqRMCXFXLEZPMtZdmNmvBCdTxr8cyZQIrJel39ztfhhf4SEOq
	 ijAC16cEyB67A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Chen <leo.chen@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
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
	Charlene.Liu@amd.com,
	chiahsuan.chung@amd.com,
	hamza.mahfooz@amd.com,
	Nicholas.Susanto@amd.com,
	roman.li@amd.com,
	sungjoon.kim@amd.com,
	zhongwei.zhang@amd.com,
	michael.strauss@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 48/87] drm/amd/display: Adding array index check to prevent memory corruption
Date: Sun, 24 Nov 2024 08:38:26 -0500
Message-ID: <20241124134102.3344326-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Leo Chen <leo.chen@amd.com>

[ Upstream commit 2c437d9a0b496168e1a1defd17b531f0a526dbe9 ]

[Why & How]
Array indices out of bound caused memory corruption. Adding checks to
ensure that array index stays in bound.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index a54d7358d9e9b..c6867b0849a87 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -242,11 +242,11 @@ static void dcn35_notify_host_router_bw(struct clk_mgr *clk_mgr_base, struct dc_
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	uint32_t host_router_bw_kbps[MAX_HOST_ROUTERS_NUM] = { 0 };
 	int i;
-
 	for (i = 0; i < context->stream_count; ++i) {
 		const struct dc_stream_state *stream = context->streams[i];
 		const struct dc_link *link = stream->link;
-		uint8_t lowest_dpia_index = 0, hr_index = 0;
+		uint8_t lowest_dpia_index = 0;
+		unsigned int hr_index = 0;
 
 		if (!link)
 			continue;
@@ -256,6 +256,8 @@ static void dcn35_notify_host_router_bw(struct clk_mgr *clk_mgr_base, struct dc_
 			continue;
 
 		hr_index = (link->link_index - lowest_dpia_index) / 2;
+		if (hr_index >= MAX_HOST_ROUTERS_NUM)
+			continue;
 		host_router_bw_kbps[hr_index] += dc_bandwidth_in_kbps_from_timing(
 			&stream->timing, dc_link_get_highest_encoding_format(link));
 	}
-- 
2.43.0


