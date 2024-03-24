Return-Path: <stable+bounces-31369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63841889C87
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 12:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEC22936BE
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D1F24EDA2;
	Mon, 25 Mar 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJTOIbln"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838112D76E;
	Sun, 24 Mar 2024 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321134; cv=none; b=oaEOItlF4GgZDZDjqKuiI803XQ8RHY/eeMqhS++OFLbabzUELa7hGYXP1hcpPI4v+mFa3jTWSSViPMqX01OavUWYMz9XgfkIGgtlov2rtQfPwItXmayKlDbUvh2yGBLb16cLeTjAuFjuwfZlX1uP5NVqsMB8iYBFCthgGQ2t6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321134; c=relaxed/simple;
	bh=VbR4fQBjLC7Rzjg/ep21s0JziHQ4SL9IpGKzUXBLVfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgFjEyTO4E+ewiEZhkV+m9T/h8dFH4I8jlZklUXsdK7MgDEYHIiZ04NaDxaw2cdqUJ2WcEXz0jpBNz530tHRAzj51L7WLNsMSkIHd5s/9NuADaPZL54oEtke53Aby825L42VSODJKqPL/v4QNmgtxOr2WbZQCdxcxdirg3HInd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJTOIbln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D10C43390;
	Sun, 24 Mar 2024 22:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321133;
	bh=VbR4fQBjLC7Rzjg/ep21s0JziHQ4SL9IpGKzUXBLVfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJTOIblnc6pdXsSHv1M5ZfpiShIErUvjqBsux/v1yiZFKJsm7MZxe8n0THXDc9SVM
	 85KwVn/g90HxowQy12VcFgHjBU1DmEAA2ENWGSIXp7jBKBOuv/zc1MIMPtjU8GOoUU
	 Zgd5S13bo9QtkcHk9EcXUfX9suWOQIaUiYYbBolW9ZsNSQyxxv/Pxx9oJfviaQAOgZ
	 yiNB9M4Eskbek11gXnKTzM4H4CEzpt0h9ee0EwNNj8IqIeJvtQl+YQxaaJyYDg7Z/G
	 wFg8T1Za5/2NtrxLfc+AktzWh3EUiSiiHXtos7KpZn9dS9cKx/+0dvVb+R19XlSKzn
	 IfUhFGBXLL4RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yifan Zhang <yifan1.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 695/713] drm/amdgpu: add MMHUB 3.3.1 support
Date: Sun, 24 Mar 2024 18:47:01 -0400
Message-ID: <20240324224720.1345309-696-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yifan Zhang <yifan1.zhang@amd.com>

[ Upstream commit 31e0a586f3385134bcad00d8194eb0728cb1a17d ]

This patch to add MMHUB 3.3.1 support.

v2: squash in fault info fix (Alex)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 6540ff6482c1 ("drm/amdgpu: fix mmhub client id out-of-bounds access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c9c653cfc765b..3f1692194b7ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -570,6 +570,7 @@ static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
 		adev->mmhub.funcs = &mmhub_v3_0_2_funcs;
 		break;
 	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 1):
 		adev->mmhub.funcs = &mmhub_v3_3_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index dc4812ecc98d6..b3961968c10c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -98,6 +98,7 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 1):
 		mmhub_cid = mmhub_client_ids_v3_3[cid][rw];
 		break;
 	default:
-- 
2.43.0


