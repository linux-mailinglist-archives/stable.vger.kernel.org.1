Return-Path: <stable+bounces-64928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B3943CA4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96771288A1F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB88DDDC;
	Thu,  1 Aug 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coKMrR2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33753A7;
	Thu,  1 Aug 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471475; cv=none; b=R5eVwrmOGskVyoOmRK8052vHrWuDSo/3ba8GXiBPXfNxQ9hDnbnHZG1Ug/0uZ77IfnkfSBp6CymnyZP+f3ZK+h91pi6t4oKNP7sh34aqIKMWp/7ZhHeZfnb9dbTK4YmkbzGlC6xD4TmCVIYAIOb80MDYwOVQrrBCjhhwvmofWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471475; c=relaxed/simple;
	bh=9EldqLVt79jH/04O7Ejzc2H3YQpJ5V6AaA3/b0/1UmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct8NbMhuM9+5R11OisE9+OdpsjmvR/ckZ4R2FH+upBZg1cwXmSeVSt4CQ4MgKQE12+1sMridqjNMyBiCbmlcrNcU+CphuB2+Pbm8kOzYDzalZcZ7UKpgqFmZpqkwRheU1sqmBLiXzwYlVDWW07n5a5x2lWLhTJP+b+wbAe1R1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coKMrR2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEFEC116B1;
	Thu,  1 Aug 2024 00:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471475;
	bh=9EldqLVt79jH/04O7Ejzc2H3YQpJ5V6AaA3/b0/1UmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coKMrR2UwQGrwstgdwelxd+jEcAn0qbTgAioII1BdNO5RaBgxRkL5rKepQinJE17y
	 VNnSMmFmmRtAS/T/lhR6t6yqwm0SgldNtqa3YButPZfXU+g/gcxf4ptP7nZYA+46s4
	 zIPDB4NwdIbfxMRQxKxnPgulVlptdPDOEID9VkyR0+4FYRHIf8yOR+/Hl1jDkt77IT
	 v19ngXfVZyQ9fM8Epn6KRCTrxxrkIgODV7LpS7ZdEerMooKYabHvhFaGddH3Gv3jJE
	 EUUegVRMrPKK5PaRMpDNKoGPzE+6mT+epI2IiBW2PxJ+QrUVhKQxLEtIvD1XZnhnj6
	 rMtOiM0xw6sjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
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
Subject: [PATCH AUTOSEL 6.10 103/121] drm/amd/display: Check denominator pbn_div before used
Date: Wed, 31 Jul 2024 20:00:41 -0400
Message-ID: <20240801000834.3930818-103-sashal@kernel.org>
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

[ Upstream commit 116a678f3a9abc24f5c9d2525b7393d18d9eb58e ]

[WHAT & HOW]
A denominator cannot be 0, and is checked before used.

This fixes 1 DIVIDE_BY_ZERO issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 64fdce551e627..6c9a7089537af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7344,7 +7344,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 			}
 		}
 
-		if (j == dc_state->stream_count)
+		if (j == dc_state->stream_count || pbn_div == 0)
 			continue;
 
 		slot_num = DIV_ROUND_UP(pbn, pbn_div);
-- 
2.43.0


