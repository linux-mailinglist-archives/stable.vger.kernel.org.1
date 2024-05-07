Return-Path: <stable+bounces-43269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17DE8BF112
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F0B1F25DB7
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9813BAED;
	Tue,  7 May 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1Y0y/91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4A8062E;
	Tue,  7 May 2024 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122887; cv=none; b=GmB2Z7u59zI61xt9bnJwPG01u5yO6fJenAfyMIZl2CwINv8/pBmgYVMF+VX19CqRfH0D2/5Vs/DfsI4ZfhZocdl9jvWRT4UCDrsw4b/1/IYRyfcOdqXqq054sThTz01SbANfM82Kbn+jMzlKURvePKL7bGCbWlU+g33Pnfny85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122887; c=relaxed/simple;
	bh=KUAitZWbXVAws+bXSiDUjKzkQzpNldCHsg6f2mgWWQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmokBxn5wNVHC77kEoFpaoNCZPTlyQ/e6jwFiaxz6XaRN/QBaQ4dj1urIABPKPzqdOjWSL3esb3Njyo4mUeVTR5MWn4bQ7ZrP1m37+gjPrmfogFCGPyVzafnRpVQQlNWj6fjxjUgop7j8d7FXmXLLf2yrHYciLGHyknPucFfqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1Y0y/91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15AFC4AF17;
	Tue,  7 May 2024 23:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122887;
	bh=KUAitZWbXVAws+bXSiDUjKzkQzpNldCHsg6f2mgWWQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1Y0y/91pQIirBfHwJ83/0Xya091W64dm+12QfDMyORmZJpS7WicRkoJAAJ7OLplk
	 ONiyN26TOLRvchZ/xUhQo8Sb1EgI/T9fXub2LwvFC90lZQA7TcbAe9P9eSAA9tdCtm
	 CN0slfrZYTmifDhK2KafiD4o/7wELilz1SMBWQsB17vvm3TTW5TL4EfXiDsyMJdTQW
	 XIKzXmD4rAWPm/qMNE9v2B+L5cirSonkeObuRRXlSuURSCG0k++tYCyT8JZK9LYAqn
	 4y/Sa3o2xXmonkN34hn4N+Oj5oX4WRmvOZ995/mlIgN8EZzb1wEReUyasLFoDL9Bhd
	 /F/Wk3vEHQpzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joshua Ashton <joshua@froggi.es>,
	Harry Wentland <harry.wentland@amd.com>,
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
	wayne.lin@amd.com,
	srinivasan.shanmugam@amd.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 4/5] drm/amd/display: Set color_mgmt_changed to true on unsuspend
Date: Tue,  7 May 2024 19:01:08 -0400
Message-ID: <20240507230115.391725-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230115.391725-1-sashal@kernel.org>
References: <20240507230115.391725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
Content-Transfer-Encoding: 8bit

From: Joshua Ashton <joshua@froggi.es>

[ Upstream commit 2eb9dd497a698dc384c0dd3e0311d541eb2e13dd ]

Otherwise we can end up with a frame on unsuspend where color management
is not applied when userspace has not committed themselves.

Fixes re-applying color management on Steam Deck/Gamescope on S3 resume.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b7b8a2d77da67..b821abb56ac3b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2772,6 +2772,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-- 
2.43.0


