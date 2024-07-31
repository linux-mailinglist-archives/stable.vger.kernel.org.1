Return-Path: <stable+bounces-64848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D4B943AC5
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B041F2137E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF06F13C3D5;
	Thu,  1 Aug 2024 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJD+W8G3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC513BC18;
	Thu,  1 Aug 2024 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471041; cv=none; b=A6/vfQM+z/Yl4cBLdskL0Ryi9NstPrE+nD980HVlnn25NSUd6zgZ7MLqj7DMhGhWCmQ/yde+kJfSPiIDtKhOcmM/2XFCf4tFC7lynGR6lf7wnVZ+Tew/+S8bE9h3mYTB5LOK2mf5Zc35oAPJjurtZDUxGvT741Rtc0MU0G4hp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471041; c=relaxed/simple;
	bh=mnMifVrjJeYoUbK9vLaCmroHTxiNLT1B5wgQw4CF9EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIPHjTyfvthSQ3US8yzaNzgDXr6DQYnPxVcNmEZSZmZHEZjA1frGY41uEJK3ZJm/MMnta7NK1/DFfA4MRxgLgKJDXvXeu3xBG+exGufnDUJgqFC6KXVyU49jQMLudjX+B0ynoeC4mriHNJ0O8Wtedh80fztKPXRKFYhkkpufZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJD+W8G3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9273C32786;
	Thu,  1 Aug 2024 00:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471041;
	bh=mnMifVrjJeYoUbK9vLaCmroHTxiNLT1B5wgQw4CF9EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJD+W8G3t3mz5Qv52R1yEPEXDuWJ52ECPbLPfZtOQPEFb3JXl0kkXKsTqkZZxNXGh
	 btswSLaRTOuLHxds1DwoZ4hbOPceq1MHR16VPtlv9vpslzq3G4RxjuK3kMttnt5fro
	 mQzjl8iijRrbeI0CiK2/SJ9dH2THhQEfUQ19RTU6SpXuOOJ33B2RA4JD9TZIcjNVC0
	 PbB7d5ympb0vUtqv4ppu0zkRkCpdTANjQxGK9CKcUb1ss5M351/rSRFjfNvK6glWJs
	 m1Yr9b5p49AybX43Zbzgv4GVuphSrE+40jFsPCrE5TYscYlBkflxT+vrbeKNYiC4Ka
	 Z4ci6Mwo4RF1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
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
	jun.lei@amd.com,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	alvin.lee2@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 023/121] drm/amd/display: Add otg_master NULL check within resource_log_pipe_topology_update
Date: Wed, 31 Jul 2024 19:59:21 -0400
Message-ID: <20240801000834.3930818-23-sashal@kernel.org>
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

[ Upstream commit 871cd9d881fa791d3f82885000713de07041c0ae ]

[Why]
Coverity reports NULL_RETURN warning.

[How]
Add otg_master NULL check.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 693d05a98c6fb..76a8e90da0d56 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2279,6 +2279,9 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 					state->stream_status[stream_idx].mall_stream_config.paired_stream);
 			otg_master = resource_get_otg_master_for_stream(
 					&state->res_ctx, state->streams[phantom_stream_idx]);
+			if (!otg_master)
+				continue;
+
 			resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
 		}
 	}
-- 
2.43.0


