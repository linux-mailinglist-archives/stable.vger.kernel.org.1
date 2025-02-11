Return-Path: <stable+bounces-114779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD475A3007A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9291887BFA
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1C1F2394;
	Tue, 11 Feb 2025 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/DvhSFc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645071E1A32;
	Tue, 11 Feb 2025 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237482; cv=none; b=Wjx5Abxd/U72hdLJJzIK5XV0ZIdHmW3enQSPNG1Mx2owNAPPWHRgRS3GnzXPDZx3OyzUtq3qiv5jllN7CfA7M7AFaB02vLcQb2YMLSPCnQ5dAF0PO1iNsV2BnTT5fHgwbOs/bXKE/68ezpGDFeg1tw7tTqTC5xct9hdxtg5sYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237482; c=relaxed/simple;
	bh=CldXpmG6Dc3d/Ou2AorcC3lzQ+3tHThCMCZH/1f+pAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9tiQjn25QiM5aWyIiH3kCiDis+nnR1J2Zusi7JYOOx4O8Ol8CL3pjaXULEtlpPLRh8CfDTiavC0S46FGdC3QlkVTedn077sCuMFjGDEefHiTVAgr1EpopRwRS5cxXSdGbHxrwwR1tXiWrc+e0Rs6vcAvVRQQvjKYhordNZCqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/DvhSFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C7AC4CEDF;
	Tue, 11 Feb 2025 01:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237482;
	bh=CldXpmG6Dc3d/Ou2AorcC3lzQ+3tHThCMCZH/1f+pAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/DvhSFcQCZmPf/u0iYTGrHOYs+g7shatVRD+UpdA3K8pSBxBmSlPRbw2sEfRM48g
	 QQIO+2jXKtfCfPnfA0+BF4gdJLwQ4UJNnp/czXOIaz/wUrkQdnavcRfhE8DF91/nhU
	 IZ06qQVV9EViSsDd1lzkkeRW+NyNLBNZV1yumx8EqKPC6VOHoZLPXhriYh79xBI5qG
	 Z8W1qC7FxDfT362nbzlE+/i5eB8vmVx6ICw1sMOLaGTX0MfBWm0QeScHL0fiIPsWgT
	 S26A8OJAs91hSB+YpDoln+B2CvWcntmF76zkgRqAzr8Brv/xglug/JmgiTxjypM02N
	 kVpMiFpZoyRcw==
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
	aurabindo.pillai@amd.com,
	robin.chen@amd.com,
	martin.tsai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 14/19] Revert "drm/amd/display: Use HW lock mgr for PSR1"
Date: Mon, 10 Feb 2025 20:30:42 -0500
Message-Id: <20250211013047.4096767-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
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
index 5bb8b78bf250a..bf636b28e3e16 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -63,8 +63,7 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
-	    link->psr_settings.psr_version == DC_PSR_VERSION_1)
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
 
 	if (link->replay_settings.replay_feature_enabled)
-- 
2.39.5


