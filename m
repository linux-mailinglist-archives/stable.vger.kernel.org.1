Return-Path: <stable+bounces-77639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A7985F66
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CFD1F25177
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069CC1D2B10;
	Wed, 25 Sep 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Buc81z9x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634B1D2B0B;
	Wed, 25 Sep 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266548; cv=none; b=kt7xTkkvjSHp3r61mA/CO+ecuMXU4UtDxhotrqsi9gqgmmOoWH7YTHifkF+yEgU3Y8CW7Od8r/auDRL2pyQKGDW0oRqVIJZOrtbi05BtODU5Z90PZLuko6L+GJhN8hWKWQ3weHY7Vk+HJZQfYrPfdL/rpul216SVyW4dVRGXM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266548; c=relaxed/simple;
	bh=5bfg9Np6bY0Jpv5tAQ9Z9bpL4qFbDPQOKp0xgywQmGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI7URLOicQzpjcx3z+f+7QXe2GUgUEDwpmuJ8p++a+y6FTuuYRCS0urP5u0H4f4bwpkQfcwbv6/tP6qaWq3/LQj2XfiKGt3PumK+B/WGLi4G/jEVN1VkInJFO4+x2/FYr75loaXAaW72n4b+a14CX/5R1I/P6tNHZ47NGZ0WCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Buc81z9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D34C4CECD;
	Wed, 25 Sep 2024 12:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266548;
	bh=5bfg9Np6bY0Jpv5tAQ9Z9bpL4qFbDPQOKp0xgywQmGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Buc81z9x9aKAC3hfA+FtsiCtWTYZsxGix5hG2KaOZbrIaeinpeiw8sdQl+ErqTar1
	 UYyggqmlHxq0T7OluxuVJlxoAnlYx22vgXfXCXIfs0cEe9S6nn04Pf2xIITwC3Fsg2
	 u8fkyvRd/IgMRWClY9MsAHZKiJ+BNLZAE0gTcEzWyXzwK8iIKMIQXrTxIwCeRU0Sh+
	 v57xYnBbC5DC7v4RUJ26cX3gpXhDDU1pDJ2j5wa9C3GZg/1VZhWrdFRHqcMmBQxftQ
	 WDtg9fPXgUuT8fuyE4AR98uskzgOE1Ax2sLm1LXmj5jswij1HqfvSHj4Cotea/WXlC
	 uaWRFJdKyjGTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
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
	wayne.lin@amd.com,
	wenjing.liu@amd.com,
	sungjoon.kim@amd.com,
	aurabindo.pillai@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 092/139] drm/amd/display: Check null pointers before using dc->clk_mgr
Date: Wed, 25 Sep 2024 08:08:32 -0400
Message-ID: <20240925121137.1307574-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 95d9e0803e51d5a24276b7643b244c7477daf463 ]

[WHY & HOW]
dc->clk_mgr is null checked previously in the same function, indicating
it might be null.

Passing "dc" to "dc->hwss.apply_idle_power_optimizations", which
dereferences null "dc->clk_mgr". (The function pointer resolves to
"dcn35_apply_idle_power_optimizations".)

This fixes 1 FORWARD_NULL issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0b2eb2a6c8e14..a7a6f6c5c7655 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4716,7 +4716,8 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 	if (allow == dc->idle_optimizations_allowed)
 		return;
 
-	if (dc->hwss.apply_idle_power_optimizations && dc->hwss.apply_idle_power_optimizations(dc, allow))
+	if (dc->hwss.apply_idle_power_optimizations && dc->clk_mgr != NULL &&
+	    dc->hwss.apply_idle_power_optimizations(dc, allow))
 		dc->idle_optimizations_allowed = allow;
 }
 
-- 
2.43.0


