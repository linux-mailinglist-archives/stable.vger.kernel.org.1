Return-Path: <stable+bounces-77476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA10C985D9E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FB8283F00
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377611B3B10;
	Wed, 25 Sep 2024 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtzCTGR4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985E1B3B0C;
	Wed, 25 Sep 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265957; cv=none; b=oLgfewh7AjG4l6ny7+f5yV0WdTbgQVgTQm8VZWC9Kujvx9C/j/cET2LliWhyisYEWNhwkWOZlZ+Xovj3PeE5Pcgwj0K6zFefD6dtJrOPSw6RCm2Au5AzziG2nw+TfViAUCbtWa1brmShh6EUG8D+l/FuSnn8vC6QB/8D4w5sCfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265957; c=relaxed/simple;
	bh=ujap9nP6fJ3nYvuMwyBy8y6L9hzDKrCNpRzePXstE3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDQP8kppmN9kAAVIZs3NLNAuoCw20PIRngVlLyytZPa+acA6xO0jv5WN25Khwg8LhTLyB7pCasQO9lArlONSoe4SxAhho61PYWccmCTw5BCVhLVG9LJFKv6mnG9DZavD4WbQ29wc1XKKoBKU2gFeuIPZ+XnFHbmBz8DTrKejFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtzCTGR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E7BC4CEC3;
	Wed, 25 Sep 2024 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265956;
	bh=ujap9nP6fJ3nYvuMwyBy8y6L9hzDKrCNpRzePXstE3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtzCTGR4dtXlrvoWiTTWEZpcwd704LOe0zuc0g/V56LNj9fwsIcVhhRkjEvX35dda
	 6GmgreX93FSFduzKTyHhbF23/q9KqbxIi8bPKTsr6l3YqdofefzqvgQw2tg8DWTO7Z
	 0zH/veuq6TxIqz9CUNLO9dt+4PZ81Gw4quicetFWlifGcTGfkvsOywabbOmwbmwhA7
	 dfIr710av6sopIZJDBG0K6NTxia8/pAGRyj+8/U285GGpd+fXSYwvZxFDVYFfRgxcX
	 PIRlBFNCR1UlwhGN1+6HKLRJD3ugRw5Lbce0Rr11qKGL7hZvC5JDIWr3asoSkX9F3d
	 w+Sy5suQFIWxg==
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
	wenjing.liu@amd.com,
	sungjoon.kim@amd.com,
	aurabindo.pillai@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 131/197] drm/amd/display: Check null pointers before using dc->clk_mgr
Date: Wed, 25 Sep 2024 07:52:30 -0400
Message-ID: <20240925115823.1303019-131-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 3bd18e862945f..daeb80abf435f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5211,7 +5211,8 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 	if (allow == dc->idle_optimizations_allowed)
 		return;
 
-	if (dc->hwss.apply_idle_power_optimizations && dc->hwss.apply_idle_power_optimizations(dc, allow))
+	if (dc->hwss.apply_idle_power_optimizations && dc->clk_mgr != NULL &&
+	    dc->hwss.apply_idle_power_optimizations(dc, allow))
 		dc->idle_optimizations_allowed = allow;
 }
 
-- 
2.43.0


