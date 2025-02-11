Return-Path: <stable+bounces-114806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD32A300C5
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65131166E02
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5C261390;
	Tue, 11 Feb 2025 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqN3dYvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36A1E7C18;
	Tue, 11 Feb 2025 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237540; cv=none; b=dO4OpH0aGAdsGmqa72akgYzEvRMWyZCoKVsAxxhRvt4OKMC/a6IOUStMzDhLUcjU0zEayQiev4Dabe2WEE9ag/wF1w9Z2jvKiYXEHMtAGsRGBOPCGTqRso7/RvQo34L71v77I8aRkrSDCZ0wpXWLvDyJbRG9uxixilW1OtcqJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237540; c=relaxed/simple;
	bh=NmqdavnhcYMYJi7NzOk/aLK8R3nAiUSCjBp6O2Qp7LI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7zWw8KjdrFEYk2oCXj/YcXyTHbWe6lQomPxB+pmv1LYzIr+uO6acLMLzbKXeeb23qOl9DhZ4h2cd70jecZT0ms5UvQJ2ft0zHVt3pgPoRcggYUqZMiyHcm0Cb+Y5Es/eaE5fFFHyEfCtTA42LQ1Z41uC3oaWCR4cjvuCVfBpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqN3dYvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A96C4CED1;
	Tue, 11 Feb 2025 01:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237539;
	bh=NmqdavnhcYMYJi7NzOk/aLK8R3nAiUSCjBp6O2Qp7LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqN3dYvvUfgd9p6lkujfOCgZJJNujImv9ylprpw8nnPIthXi/DxnnTr7OaXv8IHvT
	 Dd9B+2d1rJyZMT7UQdqY/vlLLfeT8luwEwfPnSjDRSzIxA0O5e72Z2Eyz24eM0aoOi
	 nzxav9Rk6O2rFebNfyPkfen26cXU3+I7+ejLULEEPyazcnElqZlaLA3vAguFKPRV8G
	 XyfDMxYl0X25gGhVtatDE+mvQxFWrYXmsmRhc3RLi2gDaaye9ra6GyvxcOoeA5aIQp
	 t0PIrf9hH7eQVdggTvSRJ6mNNt4aAcXT1x0t4dqag01NFijKDRzipDNuWpD8hEdkCq
	 ixn4iCC9E5nfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tom Chung <chiahsuan.chung@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	robin.chen@amd.com,
	aurabindo.pillai@amd.com,
	martin.tsai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 07/11] Revert "drm/amd/display: Use HW lock mgr for PSR1"
Date: Mon, 10 Feb 2025 20:32:02 -0500
Message-Id: <20250211013206.4098522-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013206.4098522-1-sashal@kernel.org>
References: <20250211013206.4098522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit f245b400a223a71d6d5f4c72a2cb9b573a7fc2b6 ]

This reverts commit
a2b5a9956269 ("drm/amd/display: Use HW lock mgr for PSR1")

Because it may cause system hang while connect with two edp panel.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 8d7b2eee8c7c3..3f32e9c3fbaf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -65,8 +65,7 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
-	    link->psr_settings.psr_version == DC_PSR_VERSION_1)
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
 	return false;
 }
-- 
2.39.5


