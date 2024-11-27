Return-Path: <stable+bounces-95633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805519DAB86
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323EE1650E0
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078DB200B93;
	Wed, 27 Nov 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyQJNWtd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9181200B83
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724101; cv=none; b=l0aiDI6bqFvqFiwE8GlkRqouMZBoV7Q/JolrB+2Aqn7Acj2cFfRFITaUdPiemnFsfXX0YzP6c32i141EZsEI0Y7hZMXLYhqrUuBtK4a2oajaN9Gp7Z8Hd3DA1GXD+vcbkcPLWRdCerhi/G70uvPI3MGIZW0AdLXsif8EU3zx8Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724101; c=relaxed/simple;
	bh=n9uQIRiK7G/OcUDztqNbmqKnHUwSMQArxGcIUq26IOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqxqxA12R+fycviC2mGd46rk6T8yn3wnbuaczSd0e1x5e/rkpufgmeIy4fGTgHZM814nOMaez00XUTsqoC9GuYhdbp/g/olu7XpgDJ3RMSnhJ54rdV0EoVl6tePRlSJgtXdz/B//u7l5A/t4PM7IgWlEUBZJHFX7HEnBk/FHqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyQJNWtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA816C4CECC;
	Wed, 27 Nov 2024 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724101;
	bh=n9uQIRiK7G/OcUDztqNbmqKnHUwSMQArxGcIUq26IOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyQJNWtdCT0F4wt00MdvdqDcFJ6i4D0+mjEXOW9V1eAitpPIfAma0R/8Td0a87vul
	 OS+MFVYNfdHg8/IakLSf8SNkb/GAqcAXHgRN8ePHbjZBQ3NHzqfe64Uqw8j3N1qL4O
	 7pPvsklPUcnRdc2xNBLb70ZMyop+5ctII7NRVCeBDGKi/4bHUAbCSMlGzzseCjzGHx
	 wbwCduwEULG9CPydBu/1S4OGy2913xRc+i4xcffJUE7T7tpK0CJui0+CaNGkMn/QEc
	 R3Ou0qMGD0s94p0FepBb9BLqp+vOGfv0AY1U+rMHUGika8jUFVbzeWPN3m271vgee8
	 1ybmz3wbTW3Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/6.6] drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw
Date: Wed, 27 Nov 2024 11:14:59 -0500
Message-ID: <20241127082632-72366dbfd3d8f8ae@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127104229.1559467-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: c395fd47d1565bd67671f45cca281b3acc2c31ef

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 7d1854c86d02)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 08:13:56.535837686 -0500
+++ /tmp/tmp.D5591VsMbI	2024-11-27 08:13:56.530278146 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit c395fd47d1565bd67671f45cca281b3acc2c31ef ]
+
 This commit addresses a potential null pointer dereference issue in the
 `dcn32_init_hw` function. The issue could occur when `dc->clk_mgr` is
 null.
@@ -19,24 +21,27 @@
 Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
 Reviewed-by: Alex Hung <alex.hung@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu: BP to fix CVE: CVE-2024-49915, modified the source path]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 7 ++++---
+ drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)
 
-diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
-index a7cb003f1dfb7..fcaabad204a25 100644
---- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
-+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
-@@ -779,7 +779,7 @@ void dcn32_init_hw(struct dc *dc)
+diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+index d3ad13bf35c8..55a24d9f5b14 100644
+--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
++++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+@@ -811,7 +811,7 @@ void dcn32_init_hw(struct dc *dc)
+ 	int edp_num;
  	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
- 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
  
 -	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
  		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
  
  	// Initialize the dccg
-@@ -958,10 +958,11 @@ void dcn32_init_hw(struct dc *dc)
+@@ -970,10 +970,11 @@ void dcn32_init_hw(struct dc *dc)
  	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
  		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
  
@@ -50,3 +55,6 @@
  		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
  
  	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
+-- 
+2.25.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

