Return-Path: <stable+bounces-95632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4719DAB84
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BD281A04
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9146D20013F;
	Wed, 27 Nov 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txiJ8/Z9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B77200B83
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724099; cv=none; b=ifbJHQzG9vCz/UafnRBQgSKBISkvDuk8lX7lxutua0s3Dr/VtbZZXTlKUCRF8gaSkvgnyTElO6VKgIUQWOM3OQ+tnnxfGkSsAm/bI1s0PTaADR0Fi3Heom2W3O1Nw6KTLaCbad8obiKH2VT4zUCr6jkZggBHlYYh1FEH2vBnoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724099; c=relaxed/simple;
	bh=EaHV02DVCMlyaAYCTBfDg/DyE0LRY6q5cpybW0Sj0yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNMnDXvaYK04JSZySfcIFT2FpZnMhMpzp31qGOd8CerWjszaTSgd6I22ynAcQtYR0rKdPIj7sfdpe6PCw5Q9vUhr+wA/dSxS9YYi+Wp7IF+yjfsKem2AOWRus6hGxgKtznybcFlpPtvn4y3Raia55fIESimj8m7zIJ8znNnKwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txiJ8/Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C673C4CECC;
	Wed, 27 Nov 2024 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724098;
	bh=EaHV02DVCMlyaAYCTBfDg/DyE0LRY6q5cpybW0Sj0yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txiJ8/Z9YSQAru7uv9IAzQuA7486xl7Bb0uB21j6JaTN8UEATOsHOa9V8ZJMXtjTv
	 rBW9+K1D1JpE5lPbrY+58s7dN2IHe7ksijzlppLFSf8n03kQNDzlKTmddwxqFuRLzf
	 3cNPhaLRQ0C1l8D+jN8AR2HfdSMxqZWs5/0p+i/AwFhqg0haLYeMggPhhyXo1C07PL
	 fK99RL2MjpSl4i3GJjkn6z1ySM3DXdFTHTRL3aIkt+8uHjDP7NmevF6eeNUZv/3w1O
	 4B5gHYlf5OUurlzqKweS7nuIzGbxmMn9WOGUhokBUIYEhQTZ0DyJfMJ9jnu+u9QL+W
	 9Z+m0pGlfPA4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/6.6] drm/amd/display: Add NULL check for clk_mgr and clk_mgr->funcs in dcn30_init_hw
Date: Wed, 27 Nov 2024 11:14:56 -0500
Message-ID: <20241127080405-de82ed8d0a7f4b7b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127111432.1791356-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: cba7fec864172dadd953daefdd26e01742b71a6a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 56c326577971)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 07:49:27.263865735 -0500
+++ /tmp/tmp.eIVvb9BFuT	2024-11-27 07:49:27.254520787 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit cba7fec864172dadd953daefdd26e01742b71a6a ]
+
 This commit addresses a potential null pointer dereference issue in the
 `dcn30_init_hw` function. The issue could occur when `dc->clk_mgr` or
 `dc->clk_mgr->funcs` is null.
@@ -19,24 +21,27 @@
 Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
 Reviewed-by: Alex Hung <alex.hung@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu: BP to fix CVE: CVE-2024-49917, modified the source path]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 7 ++++---
+ drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)
 
-diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
-index fc5936460ac26..98a40d46aaaec 100644
---- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
-+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
-@@ -625,7 +625,7 @@ void dcn30_init_hw(struct dc *dc)
+diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+index ba4a1e7f196d..b8653bdfc40f 100644
+--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
++++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+@@ -440,7 +440,7 @@ void dcn30_init_hw(struct dc *dc)
+ 	int edp_num;
  	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
- 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
  
 -	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
  		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
  
  	// Initialize the dccg
-@@ -786,11 +786,12 @@ void dcn30_init_hw(struct dc *dc)
+@@ -599,11 +599,12 @@ void dcn30_init_hw(struct dc *dc)
  	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
  		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
  
@@ -51,3 +56,6 @@
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

