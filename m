Return-Path: <stable+bounces-43219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13668BF02E
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EE41F23985
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9327F7F7;
	Tue,  7 May 2024 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edrur4Yx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709B7F7ED;
	Tue,  7 May 2024 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122667; cv=none; b=KfkzNPOJzV4I8AlQB0MrtZ3Ui8mSl77fisLIQb5Oc4E2pI5kpFIHfUKXiDS7d2Hhg5NC4NKlubWIDqRsT9kS8y7y8+ea1hk9P1MWk8dkYB0U7LjkOPCvEq7+XEAxNU6ls7qaFLxT7mvlOSRcJjndxcyU+IdAWabqC9XZtHrHjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122667; c=relaxed/simple;
	bh=B2SVtDrO0dHn6s0eDtwIbIP11hKGInd/f7i7UiMIyqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOtm8r7CBGCnkZVNQYSlL3/rO5okGnveJwIR7uxiO3sBUTAZpU5x/oz/8BnHWJvw0e9cMJNsRYp0bcF85k7HiFUhwLKwbkQK9axXGF+lBSh/OEvXdgoOK1oEJRsdmzigO6yYpV4wd9hZMKi8/vfii/LQVYxh2+CrzVWgzc4l3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edrur4Yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5E4C4AF67;
	Tue,  7 May 2024 22:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122666;
	bh=B2SVtDrO0dHn6s0eDtwIbIP11hKGInd/f7i7UiMIyqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edrur4YxaVMyWf9KQx9bf+CiWhtnQSXEkBpJmkbSI84uXqQ0RjXLCFB7+RamIuHtD
	 uyRexgSkhzwFIHAI/m2AgD1PAuDXmR48sK29wi46uCTpUMQt5Yg/fXXqzd8qsnoW4W
	 OID06Qm5ddtTX7bFUyHVaahLJu4DNGtH225epiExQogz4GFP9m9WwSh9pOtLQset22
	 BDhteNzeE3XNu3xedLjZPnaBHlREo/aGRgpK67M1GJJ3FyyVrGj0jp4m//YM3mHbfo
	 j1s5dnfsH8x+VlSiZEVPMj8xegaGNLV0B6VCO0JZN0T6nx6or+wZpF05TX7605Reln
	 pivwHZKuGbE/g==
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
Subject: [PATCH AUTOSEL 6.8 09/23] drm/amd/display: Set color_mgmt_changed to true on unsuspend
Date: Tue,  7 May 2024 18:56:35 -0400
Message-ID: <20240507225725.390306-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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
index 718e533ab46dd..f33b7f09c3f3d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3007,6 +3007,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-- 
2.43.0


