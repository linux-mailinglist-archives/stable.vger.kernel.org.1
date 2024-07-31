Return-Path: <stable+bounces-64852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE19943AD0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6CCB23718
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B213C836;
	Thu,  1 Aug 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+zzF/om"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E90F50F;
	Thu,  1 Aug 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471112; cv=none; b=YkhXdIgPgIqk2rkzmtQ0HNX4iPnJY7+StWB0Fp91aOM303rlFGrF46JyoHiVdLVUeP4ubBs2lHLtWFTsgkcoyThb/SFdAXZTw0VSR/+wtZsu2bt7E8uCUD6j647f22paYMAQ/GWLgxZl+WAv6dU9Hd4YPl/rGQQ0lJWTylbgwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471112; c=relaxed/simple;
	bh=0+QL90+Gb8x8GtV7RLEM7xeaiQpl9HP+ymxO9MJ0uHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tty3xgD6eHCEq4L/VBS/liGWCnpxc9j6O28g1rar6guTM43hAAMdIosuD+kTffZtZNfmtMaWr0PD60dqSGUCih8FG54UZ+z/TCNXz5mnUKlJIG9Tyei0g136khtq4h2WS5+ahaIKI+bfF7otmI34Yyu2ytioyPdgJgfsh6CdnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+zzF/om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78ADEC32786;
	Thu,  1 Aug 2024 00:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471112;
	bh=0+QL90+Gb8x8GtV7RLEM7xeaiQpl9HP+ymxO9MJ0uHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+zzF/omcrLeNKsyW+lc/5loWLoDSXR3lxvAYDvKhACfbYLA3AavWeG8ibXV6+dmp
	 Obbb4TlyvcpgR4NjYrKrBhNlncq5FlhlKcyUCxOEX+Xkz0aMsdNug1Cwf31Wp7ZEMw
	 bxjFz26ZYjbWlxYtoIKhYHADsROjA6cagOklDiAeA9uvFNCQ4o9pZwZ8pOKaai43vz
	 JnmT3oPmMsvGUhfaWgqVgtjq8R3+zE5U8DAgI3lYFL4USi7N89QWIkEqtD/oupeBl0
	 H2Ti6QkioFdhmPhvPj9WnGp10f+eRs8dOZhItTa0g+2Sv2/WmYkIZwanWIuXEgmS6T
	 LEMzVW6drEY/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
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
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	mario.limonciello@amd.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 027/121] drm/amd/display: Spinlock before reading event
Date: Wed, 31 Jul 2024 19:59:25 -0400
Message-ID: <20240801000834.3930818-27-sashal@kernel.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit ae13c8a5cff92015b9a3eb7cee65ebc75859487f ]

[WHY & HOW]
A read of acrtc_attach->base.state->event was not locked so moving it
inside the spinlock.

This fixes a LOCK_EVASION issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fca6f7d4c28e2..64fdce551e627 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8698,15 +8698,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				bundle->stream_update.vrr_infopacket =
 					&acrtc_state->stream->vrr_infopacket;
 		}
-	} else if (cursor_update && acrtc_state->active_planes > 0 &&
-		   acrtc_attach->base.state->event) {
-		drm_crtc_vblank_get(pcrtc);
-
+	} else if (cursor_update && acrtc_state->active_planes > 0) {
 		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-
-		acrtc_attach->event = acrtc_attach->base.state->event;
-		acrtc_attach->base.state->event = NULL;
-
+		if (acrtc_attach->base.state->event) {
+			drm_crtc_vblank_get(pcrtc);
+			acrtc_attach->event = acrtc_attach->base.state->event;
+			acrtc_attach->base.state->event = NULL;
+		}
 		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 	}
 
-- 
2.43.0


