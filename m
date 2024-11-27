Return-Path: <stable+bounces-95638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B859DAB8C
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81414B2164F
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F7D2581;
	Wed, 27 Nov 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRfs45Fv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3296200B93
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724110; cv=none; b=RmR+xO9j26LbasOLfozbuSYSbyR8t0RO5lYPduth1LL3NpsR3Yvp+202eDaDbNDpf6SbkUe65LopIKPyUtFpH4u1IBph1FGA9HbHSlimHT6S/Ou/XHZZFy9idOct5RHHX72rZu5s+TGy52O9kAFOdJs0W+BhGQOAAln3BlJHUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724110; c=relaxed/simple;
	bh=7W8gokUDZvzQJR7ZlccTHOPy84Gg08puhDmoItYxqvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLQjGC3ic595GsPk0Nx5/fS+Nbkmz7+jh0hTVPy7waIiXrG4swHDlbiNnFOU49x2JoqWLKz2n9Dm6MGID0thi+c7aHE96qCpriTCLACwB4QbuCS1kHQRdcYYiz88wj9ruW7N2T26DC5166dFxNPMn+gcrpImaGOpkF/znjCg1jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRfs45Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83C5C4CECC;
	Wed, 27 Nov 2024 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724110;
	bh=7W8gokUDZvzQJR7ZlccTHOPy84Gg08puhDmoItYxqvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRfs45FvH+kNh5fOw4ymb8HhaRHoIMlSm1dU/Clnmb7xm0C0Zq5MHc4qiXbkBraz0
	 F0+NK6D9h7aKkkagyM5e9r5bcGt2BVp32ZxBFEk40bMa0DMl8zam5Sy9e5eWhiyG4L
	 b6iwh8QISSTCDSJSnad/baBKohDccd4QaAfVzwK2sFEe+RJzngkSPmDkOqtHK0Bd2D
	 pJYFEGqWm4+DhwY28g+o7rz913uF/jy3MXwAhggiXJTzghxl7t5vP+6Zb/iZmdzHDB
	 u0vurM6hiqVedlyaGM5nb29vR/lZPeRgO4smmknJ3HzpII7jCN0v3ok3TQzZrjAube
	 KpdgfktUy7I6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/6.6] drm/amd/display: Check phantom_stream before it is used
Date: Wed, 27 Nov 2024 11:15:08 -0500
Message-ID: <20241127085829-2182f128e7c6e45b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127101950.1190303-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 3718a619a8c0a53152e76bb6769b6c414e1e83f4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Alex Hung <alex.hung@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 3ba1219e299a)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 08:50:16.132173096 -0500
+++ /tmp/tmp.AYYDMHqI5u	2024-11-27 08:50:16.128684474 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 3718a619a8c0a53152e76bb6769b6c414e1e83f4 ]
+
 dcn32_enable_phantom_stream can return null, so returned value
 must be checked before used.
 
@@ -8,15 +10,18 @@
 Signed-off-by: Alex Hung <alex.hung@amd.com>
 Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu: BP to fix CVE: CVE-2024-49897, modified the source path]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 3 +++
+ drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 3 +++
  1 file changed, 3 insertions(+)
 
-diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
-index 3ed6d1fa0c440..ee009716d39b1 100644
---- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
-+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
-@@ -1717,6 +1717,9 @@ void dcn32_add_phantom_pipes(struct dc *dc, struct dc_state *context,
+diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+index 2b8700b291a4..ef47fb2f6905 100644
+--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
++++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+@@ -1796,6 +1796,9 @@ void dcn32_add_phantom_pipes(struct dc *dc, struct dc_state *context,
  	// be a valid candidate for SubVP (i.e. has a plane, stream, doesn't
  	// already have phantom pipe assigned, etc.) by previous checks.
  	phantom_stream = dcn32_enable_phantom_stream(dc, context, pipes, pipe_cnt, index);
@@ -26,3 +31,6 @@
  	dcn32_enable_phantom_plane(dc, context, phantom_stream, index);
  
  	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+-- 
+2.25.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

