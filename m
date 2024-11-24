Return-Path: <stable+bounces-94955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B99D716A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1536628590E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712651ABEB8;
	Sun, 24 Nov 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOOkvGCw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01F1A76D0;
	Sun, 24 Nov 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455374; cv=none; b=UqbgmYDyexJvUzPG3XaN+yXlNxdXmvC7UVEr0PJJWB+We+N7Ba+KsdkCOLZzNlZDvoW20CbRC6RiUuE9jZuIuGhi0cnrz8o1Bk3K/hXIgk0i6l+Y5BY8XTzV2MXjAJUenPWogbjiersISK6dVqIle/078PNwjKeq/wKNdj2Hj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455374; c=relaxed/simple;
	bh=ABW8IDQzptZt8hgjem9Zz0lXmf5YPyWvyj+fMjBrMEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K43t0iW0Refk+tmBqVFlHQRufmb/SjV01H0ZyC/dsx6shZn9XBCnTPlDWtuGMv2fQy8b7Kgn17S5yPtQPyNSp81STEiPgTGe11ZJonHX4dUffJBi2+pd9tsBZQV+4KdUGYnsPOjBC61X2/Uj+bNbby/pMFOJtGnPk5y+MVukOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOOkvGCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCBAC4CECC;
	Sun, 24 Nov 2024 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455374;
	bh=ABW8IDQzptZt8hgjem9Zz0lXmf5YPyWvyj+fMjBrMEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOOkvGCw6sOq9okQa/GpTAB4s3sPHuECjbEUw2ysEy8qGe6pkmgQdxJRLeG7ctm5t
	 M94VR44e+hp3pXmRI3mx3bwwXuzyL+vM6SCbs8wN2xqK3fyZvvN9UHHplrqyIhJZFU
	 hrehCCPd4GmgkJRHzMMvdoJXfwxzjOlDGpKLDBpu8CEBfoxlgH+Y58fV2geW5807GQ
	 4qbEzghOU+mzsTwR/cgZA21+CPrUSwi60u6dwn6ruwlAppffuWU1O6o1Zmn5+TUtlt
	 BXsClB1B3GzikD29FBJG53ovLiZbrdKwigTM5i9FrNbFJprbbx5ya4P7C6YKexPuPL
	 bqbm6ZmYnyiBw==
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
	sungjoon.kim@amd.com,
	roman.li@amd.com,
	zhongwei.zhang@amd.com,
	michael.strauss@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 059/107] drm/amd/display: Adding array index check to prevent memory corruption
Date: Sun, 24 Nov 2024 08:29:19 -0500
Message-ID: <20241124133301.3341829-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index b46a3afe48ca7..7d68006137a97 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -257,11 +257,11 @@ static void dcn35_notify_host_router_bw(struct clk_mgr *clk_mgr_base, struct dc_
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
@@ -271,6 +271,8 @@ static void dcn35_notify_host_router_bw(struct clk_mgr *clk_mgr_base, struct dc_
 			continue;
 
 		hr_index = (link->link_index - lowest_dpia_index) / 2;
+		if (hr_index >= MAX_HOST_ROUTERS_NUM)
+			continue;
 		host_router_bw_kbps[hr_index] += dc_bandwidth_in_kbps_from_timing(
 			&stream->timing, dc_link_get_highest_encoding_format(link));
 	}
-- 
2.43.0


