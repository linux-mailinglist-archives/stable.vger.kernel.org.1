Return-Path: <stable+bounces-64838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A14943AA3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B47C1F225DF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5372B1369AE;
	Thu,  1 Aug 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzU7+V7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7622EE8;
	Thu,  1 Aug 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470983; cv=none; b=shxjyAn/+d9l97jBCCTPmtLRPwutK7a4jUzhXgLnM+ZxWE5C40TKnAVFXTxLHn7c3i1ghzV8FEoOsOtdEGZYJrmbiOcwBL95BsCn7bhaue+OpnSTsv4jKH5VV1GafPN8X88vFX65Ox5x6OjnYReCj4C8rldWXsvTWKZDcYRwSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470983; c=relaxed/simple;
	bh=8RRPYlCzYxgIVD2o9XY/HLxhzMN0ulZ0FnIuCKvu+hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe4w/5YiHHeUSLQapVF510hhEFgHSR6SQON9UB0W8vXh8+NQICO4lFHqcU1WkJExkbYSDuseTjP8HzMuKQ9UpfAay61/XLz8E0HFhiuvucRO28LvUeogxtIvk+h/1pihH0tTHn0+j0I+ahQrf290lE46n9vlHGpDwJGD+A/JMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzU7+V7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5CBC116B1;
	Thu,  1 Aug 2024 00:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470982;
	bh=8RRPYlCzYxgIVD2o9XY/HLxhzMN0ulZ0FnIuCKvu+hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzU7+V7er3EIvKff6VF5/HMacGkvUSRFXiTp35FZlpf4yyRZimJ7OCk19tnSZ7ETX
	 Vqj1A+sqmUSb1Iq0R4bXkLb2bQxV4TgtpDiyWafedkybOproyzlXpE9hqwhiADq+aF
	 3Eawl86u74rPdhb3WwzFlbmiiJh4J7fjzE8V6faNEFF+Tar8Q+EPJkIj4IgjIkm9L7
	 lfuhXKvpoiHhrXLdBhoZfkXOKQxqlZ7Rv8LjbOUeh87EXmRfg6SEHvtq6bKJgN71QB
	 ktKSIqs6JJs7u4aLCQPcQCNhnKpUkN7bB5WQa9e//ZnctaL3blfl2pvTwa0Ty22HiR
	 SAIx+rJR11VbA==
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
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	mario.limonciello@amd.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 013/121] drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
Date: Wed, 31 Jul 2024 19:59:11 -0400
Message-ID: <20240801000834.3930818-13-sashal@kernel.org>
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

[ Upstream commit cf8b16857db702ceb8d52f9219a4613363e2b1cf ]

[Why]
Coverity report OVERRUN warning. There are
only max_links elements within dc->links. link
count could up to AMDGPU_DM_MAX_DISPLAY_INDEX 31.

[How]
Make sure link count less than max_links.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9b440b26c6505..c893cf8f2d36e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4664,17 +4664,17 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
+	if (link_cnt > MAX_LINKS) {
+		DRM_ERROR(
+			"KMS: Cannot support more than %d display indexes\n",
+				MAX_LINKS);
+		goto fail;
+	}
+
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
 
-		if (i > AMDGPU_DM_MAX_DISPLAY_INDEX) {
-			DRM_ERROR(
-				"KMS: Cannot support more than %d display indexes\n",
-					AMDGPU_DM_MAX_DISPLAY_INDEX);
-			continue;
-		}
-
 		link = dc_get_link_at_index(dm->dc, i);
 
 		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
-- 
2.43.0


