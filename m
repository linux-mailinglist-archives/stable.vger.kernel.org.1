Return-Path: <stable+bounces-80923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208BC990CC8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79881F2163C
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8162D2207FB;
	Fri,  4 Oct 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzV6aP0W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0692207F5;
	Fri,  4 Oct 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066263; cv=none; b=FBpTgwVWKCKlcOqDjmjYHnncYAFzQP/Y3XHunVGDMTtLpcaCTqAxUeDnZolmyioV9bmZC5SpD9zjAT54LR471IaEo3u8Eh3Mvgi8gyQSDGC09kjMYMs9B/u3nW5j5F0dG8AOLe3sDe1mnpn7JgSZb551mFr6hOy7UU2u8YjLJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066263; c=relaxed/simple;
	bh=cszQHSgiIse5imySQqkeEZNtFj3mZdir1yrb0GQ8BJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmnIlrVlAWgHRCaHVGgN0SZrW5wZZUx/Uv/lSXZdslio+ZBPYAQXjcHOkdtWxnfC3NH8/Wc6TqF4H78G1bmO1s6M1Zp6nVvQdshFfzv1GVnfwjntr8SCqN5asRqb0GPbggBm8FEk8ho8MHXRExBKd7aOc9mvp7obO1Zuqe362Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzV6aP0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2E8C4CECC;
	Fri,  4 Oct 2024 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066263;
	bh=cszQHSgiIse5imySQqkeEZNtFj3mZdir1yrb0GQ8BJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzV6aP0WjSJf6A6OWkTuf8Fk37Db+gMXsyIHrcKNANFWvOuJYXeFPUZ+boBr7zElc
	 evwgBT97na9i5U+ysmnJqmcPUrlh3BvZItVubjV+Xp2yg9bSsB7lsoxwboOE2uvlpR
	 C+B2Ih9mS2gpAOAvP3tOmr1Cq49o2fjwqty/gR3uTVOpP+qJcXKD067+3yiwPfVpxK
	 /lanj72TDKlNSrvXK5HTD8xRnBQoQ12rcmGobhoH8FUfdoDsU8lUVcaG6RUBFezB//
	 uyJ7opBn7yd676f5EQwQwsDd0xASgR7S15ZPzGj+MeCGYWaU7Z1/z9t7fLy3aSehqJ
	 os7tn2OfkGPpw==
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
	alvin.lee2@amd.com,
	wenjing.liu@amd.com,
	sungjoon.kim@amd.com,
	nicholas.kazlauskas@amd.com,
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	chiawen.huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 67/70] drm/amd/display: Check null pointer before dereferencing se
Date: Fri,  4 Oct 2024 14:21:05 -0400
Message-ID: <20241004182200.3670903-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit ff599ef6970ee000fa5bc38d02fa5ff5f3fc7575 ]

[WHAT & HOW]
se is null checked previously in the same function, indicating
it might be null; therefore, it must be checked when used again.

This fixes 1 FORWARD_NULL issue reported by Coverity.

Acked-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index da237f718dbdd..128fb580b789f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1816,7 +1816,7 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
 			return false;
 
-		if (!se->funcs->dp_get_pixel_format)
+		if (!se || !se->funcs->dp_get_pixel_format)
 			return false;
 
 		if (!se->funcs->dp_get_pixel_format(
-- 
2.43.0


