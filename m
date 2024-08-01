Return-Path: <stable+bounces-65015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011FE943D8D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303681C21BA2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151216F0C2;
	Thu,  1 Aug 2024 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMSWwYes"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCF1411E7;
	Thu,  1 Aug 2024 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471947; cv=none; b=t2lO+mRfxyzkGQN+rAMlWpqrK9a+Rz5m2alN6uUPEv0N3W6A0ULDkbTi9hZq3PuBKJ4NwlIOMNlnX6ik4/Wypr/TBlMbl/+IbogIRBoejFdA8PwxgQlveMGwSJb5FAfa8ClZsUdD7iPaQ0dhwlZ5Iv/ioInOoPje5B/ydBD2OfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471947; c=relaxed/simple;
	bh=8jzXVrUUVwaqimc9ISaengSE+2YKB3QjDr/VwTZ2ujo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlRBjFtvAAPdWkb8pHphVe3cXh7hx6vHD0eV94Qn0DmUZ+2iJ2cPIzHgt3DRADqCxE7RjJ3/rHZs4v9kZx2/RS6FimoGNm8kiHmH13k4MPAM8Hkk8RinptQaVAIuxVnA5/zd73WTCq+8tUBs600mQYxy5KXZ2Ws+ZmpKf2XhNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMSWwYes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18D5C116B1;
	Thu,  1 Aug 2024 00:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471947;
	bh=8jzXVrUUVwaqimc9ISaengSE+2YKB3QjDr/VwTZ2ujo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMSWwYes69Go3kvul4gi9N5ODv3de95wEUOlbB0xrw4y7i2iy0Qjqzyyg4kGdBzGl
	 qlvTuOTZ6E7ScP3Ik21XUGLcJ+5I/dQCsg8w8sW+x2XMSo4H5s76ZD0c7DocWFgzv+
	 YM6563UgFXcGQ6uSX28TXL3IItY+Qu76CKrvatg9FIjTJumy6PQUh6ChVhjQb/v34+
	 CoE/9u4HREXWZMTK9Sc3zx7tfahQhTkZiCYdv7lZphnyR/sZoKx1PgaIjnPXShhKSA
	 jwFBf/W4eEorIe/rr4jQPxdI59kCmDqfPLBPsjqG++7IdJnpOTiuUKsObBC1NSqDuP
	 mxuar5Z4UdPdQ==
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
Subject: [PATCH AUTOSEL 6.6 69/83] drm/amd/display: Check denominator pbn_div before used
Date: Wed, 31 Jul 2024 20:18:24 -0400
Message-ID: <20240801002107.3934037-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 875661737f496..03ffb77906382 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7022,7 +7022,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 			}
 		}
 
-		if (j == dc_state->stream_count)
+		if (j == dc_state->stream_count || pbn_div == 0)
 			continue;
 
 		slot_num = DIV_ROUND_UP(pbn, pbn_div);
-- 
2.43.0


