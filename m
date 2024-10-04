Return-Path: <stable+bounces-80853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD439990BDC
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B49281011
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A841EB9E5;
	Fri,  4 Oct 2024 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6CsfmlA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB7821018C;
	Fri,  4 Oct 2024 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066060; cv=none; b=bz/T8mQgbfpWEDmXbdyQ+85wD1Oucqk0fzm6+tU3hgJXCvUEXz4m23Qs9TW7u4NLdGFnQonB8spa41lBCkRmz5tJhoMks17oyccP5fKBLu4TGBRTcgTpz/CB8TpIYSvmJi1jLiw1u7m4RpUv91cem3gPEKZ/iju3UqehYWxkdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066060; c=relaxed/simple;
	bh=ic5ck5SwteifJGsVSNjzUIwEYiAklP4oj/K3LrScd5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8CiAIxTuAFMdeFPpeXvoaeG7yfmy8f1iCqJgz1fstfJZwfleyw6rrFkG3JNXUTwCDFOIcnd/ZtlwLQOlIvIkSPM0M0S9AT3LREcItiXJMB6e4mK2vcxQR9HB74tc98dG0R+h4wx7AJmI7NaypfcHlLZU5c//cwzVZWelUgyjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6CsfmlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B93C4CEC6;
	Fri,  4 Oct 2024 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066060;
	bh=ic5ck5SwteifJGsVSNjzUIwEYiAklP4oj/K3LrScd5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6CsfmlAcyczXMykg2bCxQCaHdxtCU7GPZ9KGBTF8JybB0hZSKO8/yTAGndQdXJTZ
	 qirVLdgFu791mMG+IdYuT0KZK4MjPHnxAc3XuOMQFDYYUpkiPeVJjr76XV8yskru6J
	 yO8uJcg5rrTHbvpHsa6A7Oe6VK3xzEkHwzf4hF5jbs8chfMfuDU+s40MvRt0nEES63
	 dF6MntMJUzywOHdQAJcEr0tykorJxfu1nFW/w94d44N5BToL+Z2ymLb0Lrwt46U3Zs
	 M4rv5x4t8vlSeYVspqjXH2JN4ABTnE3jDtPrQVpkRiL4gcSZOFIprPIEzEVLTxsMnJ
	 geVR5daNKH8yg==
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
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	chiawen.huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 73/76] drm/amd/display: Check null pointer before dereferencing se
Date: Fri,  4 Oct 2024 14:17:30 -0400
Message-ID: <20241004181828.3669209-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index 85a2ef82afa53..82390814e6c6a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1832,7 +1832,7 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
 			return false;
 
-		if (!se->funcs->dp_get_pixel_format)
+		if (!se || !se->funcs->dp_get_pixel_format)
 			return false;
 
 		if (!se->funcs->dp_get_pixel_format(
-- 
2.43.0


