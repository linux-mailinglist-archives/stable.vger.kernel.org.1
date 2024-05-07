Return-Path: <stable+bounces-43318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2248BF1AE
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245781C20C6A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8E145B0B;
	Tue,  7 May 2024 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI/gZx5W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D5135A6E;
	Tue,  7 May 2024 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123372; cv=none; b=Pxb5zay7US6bmoxqCJXOW00ilYRi1xeJ2MlrO3zqfQ7p49YxoVurusn4zfbPMsbhZVeGVvgIFWrVJb10KgIjD74KYi2RA6X6e2Nt5FVHKBOTaNV66u7yFHtKw0qTLGyJcEKi+fxRrmTNXyqR7uNypuOtF3H0FTWVQWmW/Ex/sKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123372; c=relaxed/simple;
	bh=qsBXv4eT55IdMwxy9x8mbzOnTPPBcW0txYfRfwsRTOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7wVk/oHtZR1t5u5dM2uBb2Y8CwebPXQpuHAmf4Qv3+DO0HXd8DLWN8jf3Bw36HEhGnVVsb3wmlcypEh3AJeE7ivAiptuyrUMFJ/gk63JI3JLl3B+T6/Wt906o4CJMHulsN2gBdASGmtUTMz1unwdXTrTKJxbrX/aaPbcwZOqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI/gZx5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24218C3277B;
	Tue,  7 May 2024 23:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123371;
	bh=qsBXv4eT55IdMwxy9x8mbzOnTPPBcW0txYfRfwsRTOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uI/gZx5WnRWJC+6PMPlWeY135Tysx0JsP5biVBNj4LNFlolwJuDwvyrt08VoFemIN
	 rVbYaEhEXCaZMagmvT+b0W8J9bseUWn6QDyr21cBsERJHVy/zSBn5vJZKrQQxrpNXB
	 bmraCeI65R3GDcqsc4x3o9X1rz9n2OBDejcHpbK3n3U7GUMs2ULgarOdE9/OnTGC4g
	 4SiXRVcI3aSzfexZgATV+uRF8iJrESXMb8dBF7BHW1VsxKPa3/mlzHaABbHEMIayzd
	 ZNggkyBsHUXhgIwO1IjbVEdKVlTePUo3vzL7cqFBpBFt5VSkgau9j6ff9RruyWfDOq
	 VkGdc9Ccdotow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
	PeiChen Huang <peichen.huang@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	nathan@kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 39/52] drm/amd/display: Allocate zero bw after bw alloc enable
Date: Tue,  7 May 2024 19:07:05 -0400
Message-ID: <20240507230800.392128-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[ Upstream commit 46fe9cb1a9e62f4e6229f48ae303ef8e6c1fdc64 ]

[Why]
During DP tunnel creation, CM preallocates BW and reduces
estimated BW of other DPIA. CM release preallocation only
when allocation is complete. Display mode validation logic
validates timings based on bw available per host router.
In multi display setup, this causes bw allocation failure
when allocation greater than estimated bw.

[How]
Do zero alloc to make the CM to release preallocation and
update estimated BW correctly for all DPIAs per host router.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/link/protocols/link_dp_dpia_bw.c    | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 5491b707cec88..5a965c26bf209 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -270,7 +270,7 @@ static void set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 
 	/* Error check whether requested and allocated are equal */
 	req_bw = requested_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-	if (req_bw == link->dpia_bw_alloc_config.allocated_bw) {
+	if (req_bw && (req_bw == link->dpia_bw_alloc_config.allocated_bw)) {
 		DC_LOG_ERROR("%s: Request bw equals to allocated bw for link(%d)\n",
 			__func__, link->link_index);
 	}
@@ -341,6 +341,14 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 			ret = true;
 			init_usb4_bw_struct(link);
 			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
+
+			/*
+			 * During DP tunnel creation, CM preallocates BW and reduces estimated BW of other
+			 * DPIA. CM release preallocation only when allocation is complete. Do zero alloc
+			 * to make the CM to release preallocation and update estimated BW correctly for
+			 * all DPIAs per host router
+			 */
+			link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, 0);
 		}
 	}
 
-- 
2.43.0


