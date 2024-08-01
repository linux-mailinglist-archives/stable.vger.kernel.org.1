Return-Path: <stable+bounces-65013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54787943D89
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BB31F21F5F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF391CAAAF;
	Thu,  1 Aug 2024 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtRhbAD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927D1CAAAB;
	Thu,  1 Aug 2024 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471936; cv=none; b=iIeNF06kcuufqyFEUgU10dBtfqnxQ4WVKrKhhbHHrrNuWHnKs52f7cdNdgAHpkbVITMKGCJakko7ANg2t1SCIMy/gKPVpBF+xkm3QGPKGl2FyW2a4MYNYqUQH07u8ZV2qIVbeqXgsND2P2SAzddNAGDj3Vr6djjyZAH/mpxxMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471936; c=relaxed/simple;
	bh=veTy5hYIktW6fruqh7pQ7drkU4PYX3Gpmz9FNbyPwIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGaCeFh1evxL9q/GoQeHOxs/OXNcLAaQ2DLkJznl/abVtcV3yDQevhC607iyp70yXyds7iG+r6piPsLPtV1sEJpv4NhLPQqSfPZFWoKPyPmmbJxCP74qMausnsBF8wAxzsMbemhuZ3xW+XCESYo2RZvnrkpz6JgCF1BTCHvbzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtRhbAD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3593DC116B1;
	Thu,  1 Aug 2024 00:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471935;
	bh=veTy5hYIktW6fruqh7pQ7drkU4PYX3Gpmz9FNbyPwIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtRhbAD5iXb4ilMRXL8V4t1XgqLAsghskBwINrSwP846GprzZo3MKiNsBnVx81I6t
	 OShzY3Fvq7/OhHe+Zl4PmKKsFpGBreYJH/i4B2mmuESk+KCWt2j0VLFks2ciZctD2n
	 VtB9CtoElnqq5RzcfvTVju8ThpvyAyEvuBUBVEZvctapfipWv9U02/aYu0au7P76fJ
	 fswgV4emkkemexdFifkafB4J4q752RZIHtVtAefC6pn2GwkJZ400Y+EVSoO9865llI
	 ylRuQSMmS0fUuv3xKomk4vhte44Z2EanUcT4HqonjQ0CCj1G5FjmAq8dvefMT8nnA/
	 Pp+gUVigOxa8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hamza.mahfooz@amd.com,
	lewis.huang@amd.com,
	george.shen@amd.com,
	mghaddar@amd.com,
	chiahsuan.chung@amd.com,
	dennis.chan@amd.com,
	srinivasan.shanmugam@amd.com,
	Bhawanpreet.Lakha@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 67/83] drm/amd/display: Run DC_LOG_DC after checking link->link_enc
Date: Wed, 31 Jul 2024 20:18:22 -0400
Message-ID: <20240801002107.3934037-67-sashal@kernel.org>
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

[ Upstream commit 3a82f62b0d9d7687eac47603bb6cd14a50fa718b ]

[WHAT]
The DC_LOG_DC should be run after link->link_enc is checked, not before.

This fixes 1 REVERSE_INULL issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 6fc0cb918b9e5..00119aa395589 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -629,14 +629,14 @@ static bool construct_phy(struct dc_link *link,
 	link->link_enc =
 		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
 
-	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
-	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
-
 	if (!link->link_enc) {
 		DC_ERROR("Failed to create link encoder!\n");
 		goto link_enc_create_fail;
 	}
 
+	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
+	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
+
 	/* Update link encoder tracking variables. These are used for the dynamic
 	 * assignment of link encoders to streams.
 	 */
-- 
2.43.0


