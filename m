Return-Path: <stable+bounces-81024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0C990E88
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF54B2319B
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991452185AA;
	Fri,  4 Oct 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgaybzOK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781B2185A6;
	Fri,  4 Oct 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066513; cv=none; b=RLk/yXmvI1kUe3otPHj/Vwxb7+dDWUvJmL6VEQIngDPiKdtPIqcSTGIYVC4xndU1kWTrQdMpjRUg7faofdT7uI/iLdB6B00u+RHqYXR0m2UDvjuABRzM+1RuN1ex6H61qEdtXJSGpJyKd07CeoKN2oiWUfdqeBMf5kaWGLzGeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066513; c=relaxed/simple;
	bh=C16IEkzhseK1MgeBXcb8tz19363Pmd4frgSZSpu14+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7Sc5697JKchQstKTURf9Wo5Pq2FC/xAt+iwXxRBIrxKdC9LX2+sITEC7gb8b1Oqy06NcM/cxz7tM1rhNPVnPn64ux1GH0NQrm0zswxFiOkgqT413I3ZlV5oIh6TQU3TxBEK0nBvP+wPF26wyWhC+T1fj7MjOZuTXrMInJvrVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgaybzOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2786C4CEC6;
	Fri,  4 Oct 2024 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066513;
	bh=C16IEkzhseK1MgeBXcb8tz19363Pmd4frgSZSpu14+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgaybzOK93BIVdcXnEj3N4j0Ohzf487O4w6tAqz7DqyImtKdyG8j3P3qL0wvp2pIN
	 +HW63RHXLzg3V4meMZqFFdugvH4QC6hNwGUbmgPmtIrg6W4UqW3JcYuj7xYZByDNRv
	 bwM7YVCWmyIkrxiNgggP0fkRxtuB+2nOXyJtxmx4h5JrJIEOoCmVWw8gEujxcoCLUZ
	 LdArtE5nKWilCHaUjPAmnhksTX1uJPUZ9DvakCehWwCMuZjeKfXh5UEr3caEGzznJP
	 DerU8o5xG8QQ7IhwoRVst88MsbiwCioIndmYX2VmnX2/WIj2F3jZPASpQ6oyMblL5A
	 QrkSYw72yWV7g==
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
	nicholas.kazlauskas@amd.com,
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	chiawen.huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 40/42] drm/amd/display: Check null pointer before dereferencing se
Date: Fri,  4 Oct 2024 14:26:51 -0400
Message-ID: <20241004182718.3673735-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index d7bca680805d3..ce31a2f460932 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1659,7 +1659,7 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
 			return false;
 
-		if (!se->funcs->dp_get_pixel_format)
+		if (!se || !se->funcs->dp_get_pixel_format)
 			return false;
 
 		if (!se->funcs->dp_get_pixel_format(
-- 
2.43.0


