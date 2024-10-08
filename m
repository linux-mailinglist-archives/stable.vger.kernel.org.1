Return-Path: <stable+bounces-82317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1996994C22
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F67C1C24F26
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250E21C9B61;
	Tue,  8 Oct 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iOYjzaEK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2B1DE4CC;
	Tue,  8 Oct 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391857; cv=none; b=mM5e4En9E1JDr6JkbcKLAzMIzZGks24/ytYwX1DtWbSJYOcxy7/8X2rLcH4/pOW0m+0COqe8pfCEwltaNTjh1cFRstED1xAA5Od8FqtiQQt9K042hjoyz7Rse6rJEArQwmSYH9+kplCsBRI0qNgoDBWy1X409r3+08OlMsNmVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391857; c=relaxed/simple;
	bh=JrLdAu7BjIsP4QCrb1W39ZP9SZJHnjeaSS13/x6f5gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgVeeAVswta/F07E8m3RMxhYZ7/ORgXE/ZxBr+cLhLoZodSU4IL0qMr05XyiKE1Rz2KFr3cG+hSIJGRDdCz9/i/O1lRN4nxpzbF/WshDKiOjMci8fP0K/jDQZ2WlC2aARF0hpRMcDTKDdYD/rLXez4PgkbCC+WwQ5+yUBXgRXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iOYjzaEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBE7C4CEC7;
	Tue,  8 Oct 2024 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391857;
	bh=JrLdAu7BjIsP4QCrb1W39ZP9SZJHnjeaSS13/x6f5gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOYjzaEKJW77eFN95FYgu6gWsWtEPKH4y6tuz3d+a5FE5UZj0DX3/yPzJYhjj/nqn
	 hayzLW2nv9EkGzWKMBwAW0fj8Q0pLr7nsM5nH5RkeBXD4VjnGo6IrT0cJrr36obNhL
	 6+15aOYbMV6TLWtjz0YZ91tafh2kvgdh/uNUhaMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 213/558] drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw
Date: Tue,  8 Oct 2024 14:04:03 +0200
Message-ID: <20241008115710.727286814@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit c395fd47d1565bd67671f45cca281b3acc2c31ef ]

This commit addresses a potential null pointer dereference issue in the
`dcn32_init_hw` function. The issue could occur when `dc->clk_mgr` is
null.

The fix adds a check to ensure `dc->clk_mgr` is not null before
accessing its functions. This prevents a potential null pointer
dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:961 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 782)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index df80072174b79..9a912b9c1f2e9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -779,7 +779,7 @@ void dcn32_init_hw(struct dc *dc)
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 	// Initialize the dccg
@@ -958,10 +958,11 @@ void dcn32_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.43.0




