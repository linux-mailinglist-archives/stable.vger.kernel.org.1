Return-Path: <stable+bounces-80981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778FE990D7C
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E131C22DDD
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E59B3DAC14;
	Fri,  4 Oct 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldg2YImO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B091DDC1D;
	Fri,  4 Oct 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066406; cv=none; b=WjNi2404c7HorwyWWnPZ9VwBkyZUUk9//k94BfFB2Y2nywFrJTxVckrdw8IARsYOHTq0xQXLPytG3sylTC89r5Y3/JO+o0NTQtRVPU5xz1RcJmEXk+bdje7JrQ7hrN65Q4xGrWvs6AWcIgWeCPRePAnN5rIPvZbrUrEq+yEq054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066406; c=relaxed/simple;
	bh=hQjwcitZL4jkugWpmBt/ij/ECsBXWg7PvGVYFO4uq9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4Uj/xMW1e92Q7O9KidR/DEYwQ0jtJa1q6FOQ8fvWwro1Knm+H69hSTxpd7ggoWmu8v5Y76CvJHnE473uH5rfcaP4y1wrjPIBrvmyybLl+5LAtAym70eX/Rovyce0RN8PcKc2HeUNrAKK2gneUmulbGeipBZ/zAcslFg4S1MUC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldg2YImO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F87C4CEC6;
	Fri,  4 Oct 2024 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066405;
	bh=hQjwcitZL4jkugWpmBt/ij/ECsBXWg7PvGVYFO4uq9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ldg2YImOjNy/FUmWPLP9C1Xl3YawVpanRgaPWYmVlF4aAWky38jBs4o3zR43LjO4P
	 Jz8hm3UaA4Z58KN1QcevONcO6ws+OgN9n3Vnq/xWPCEgqVvfIHsOZYfft7Q00Gx2K+
	 lA7Co61VU2VVvDk/qrXUNaNN4qHzhJwhs9bU/WMkwuXeTp+XmUX8b6tNTUoOtUnzU9
	 J8dkXW6oa02+854ujuSjdo7MH+Ks5hmS717UZpYlibkFL6xO464SYlqH9b5RBfBLna
	 fvg9DqoKzTR4LSA4gY2+2+uuykGCTzx9633cVWXjfLwk3LtBWZ4QV1mVwLCnfgNpJu
	 Nyk+elGBfEqZw==
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
	chiahsuan.chung@amd.com,
	wenjing.liu@amd.com,
	sungjoon.kim@amd.com,
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	chiawen.huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 55/58] drm/amd/display: Check null pointer before dereferencing se
Date: Fri,  4 Oct 2024 14:24:28 -0400
Message-ID: <20241004182503.3672477-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 50e643bfdfbad..cefa1756e1223 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1691,7 +1691,7 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
 			return false;
 
-		if (!se->funcs->dp_get_pixel_format)
+		if (!se || !se->funcs->dp_get_pixel_format)
 			return false;
 
 		if (!se->funcs->dp_get_pixel_format(
-- 
2.43.0


