Return-Path: <stable+bounces-95637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE899DAB89
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D0F28179D
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC6200B82;
	Wed, 27 Nov 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaGsl9BK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04D200B8E
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724108; cv=none; b=KqOksMVKw/qqkrpsvbVBFglZTUfmR1dq1HgPRxGN9PuV8BwgO+aV0w+wV3jMTjt4jwt4VtSbECSVtobkq0yjMnIceoFuVfsJ2KnpH5OABK56h0p4XlLfkgyZLm1XRYEhKsMo1JlJUJZUTxpp4fciEDQZb4rpNhNtgjcuom3N7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724108; c=relaxed/simple;
	bh=vjftAwdDLIFmb+WJ7FsgTBNc7GLiShrRjfKAESgdnqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9o2qPalTzcPlCuyr/2ohFPUN+g8bFKoy/FGteCARgjkgiveKEtKUoGEcnYvw0MtzEoGXsJsuvQemmPDLQu/BNkBvanRjvxs57hHtIUDgMAzTBr0NTNkngKBlg5kPnje+dMUBHyZbo+mlbgGqihSXK5TOEcsKFcPzMbP0Jdu43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaGsl9BK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12864C4CECC;
	Wed, 27 Nov 2024 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724108;
	bh=vjftAwdDLIFmb+WJ7FsgTBNc7GLiShrRjfKAESgdnqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaGsl9BKdHdvvVghIXbHAvduCT2B8wM9lp9nt9wB6+fiYLeyl5gAZGG+Qwj1vr/fK
	 AuOj+nh7gVE2pXvHD80zw2N/V7ESUexFs9amtGjBLktu+4krWJs73rs3omdLduovvp
	 v6LNmx1086dCW+DFsrgJs1cFd9i/1I4VfbioAO3CsUYgI7SGOBRFcma2oxPEd8E9a3
	 UgyAHQfmdscpcKA2B1dp7+lc1zsrNbrar0EWOWcDgy4PPQh58nRmLVSw78fHqAtAE6
	 9X1v9nVLfp6MSCBQtEQK6uXAzG3OlMVTczLnEVa4tcHJu/hcPs71R0bLAXKg7XmfX7
	 IbnnOqXNTbvhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y/6.1.y] drm/amd/display: Add NULL check for function pointer in dcn20_set_output_transfer_func
Date: Wed, 27 Nov 2024 11:15:06 -0500
Message-ID: <20241127084425-2723490acb926c4f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127030058.1179777-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 62ed6f0f198da04e884062264df308277628004f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 827380b114f8)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 08:33:38.668282569 -0500
+++ /tmp/tmp.mkD4NBxa7s	2024-11-27 08:33:38.662291901 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 62ed6f0f198da04e884062264df308277628004f ]
+
 This commit adds a null check for the set_output_gamma function pointer
 in the dcn20_set_output_transfer_func function. Previously,
 set_output_gamma was being checked for null at line 1030, but then it
@@ -19,15 +21,17 @@
 Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
 Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 3 ++-
+ drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)
 
-diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
-index 5a6064999033b..425432ca497f1 100644
---- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
-+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
-@@ -1045,7 +1045,8 @@ bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
+diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+index 9bd6a5716cdc..81b1ab55338a 100644
+--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
++++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+@@ -856,7 +856,8 @@ bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
  	/*
  	 * if above if is not executed then 'params' equal to 0 and set in bypass
  	 */
@@ -37,3 +41,6 @@
  
  	return true;
  }
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

