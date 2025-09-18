Return-Path: <stable+bounces-178225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0546B47DC0
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCBC17CEFD
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1C14BFA2;
	Sun,  7 Sep 2025 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFShME0i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28215D5B6;
	Sun,  7 Sep 2025 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276163; cv=none; b=DhgkMEVdVov3G8HrBRVlXssMvnUyp8ESCBDFZA24PuieE5paOcEeXGsb8h6+lIs6PncuhJpPdK9hmdqZFDznYdqk6W5TrZOrUZoye+0xwisEiuBpAClWJHSed1IvP5mrs7qxgmpmrRDGfw4Tvyd3fX764f7XsHXx9NPfnMVkBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276163; c=relaxed/simple;
	bh=UYofmJvBHffT3FXGpsK4dcjlHIh7Ysy9oee8Oui5+rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsdKpCd1vzQ0RnLDhTmC1ANXoq7aiUBkOz2P2pMwn6Pdq4kjJC+oWicT+hCM3IO4jzjQrO78yi1Z0BF2+r+gcSej5OQ079nPfzCJh38n6JTS8xUVZLLOBaWVzN4s29Hbn7QoibiS/cY3XJhV+gfF6nWVi5/xgKdc/qhcZ2qWrgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFShME0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCD2C4CEF0;
	Sun,  7 Sep 2025 20:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276163;
	bh=UYofmJvBHffT3FXGpsK4dcjlHIh7Ysy9oee8Oui5+rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFShME0iUSbaSy46Iy+vHMduZ04anwcQA6W8GjjDfP+lYNwFdE26nSWE2VMyyA3+e
	 Z6DezvHe64IwzjX5cjR0aFIkOgZUvnCZ26Ro4FF6rWNc8bhiVX0Zws5M82hebbGHwm
	 2rTNI9s3p6QR8F7tcHQEUlWxCBRGR6HXHxFIM6AY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Hung <alex.hung@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 009/104] drm/amd/display: Dont warn when missing DCE encoder caps
Date: Sun,  7 Sep 2025 21:57:26 +0200
Message-ID: <20250907195607.914819220@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195607.664912704@linuxfoundation.org>
References: <20250907195607.664912704@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 8246147f1fbaed522b8bcc02ca34e4260747dcfb ]

On some GPUs the VBIOS just doesn't have encoder caps,
or maybe not for every encoder.

This isn't really a problem and it's handled well,
so let's not litter the logs with it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 33e0227ee96e62d034781e91f215e32fd0b1d512)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 09260c23c3bde..85926d2300444 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -897,13 +897,13 @@ void dce110_link_encoder_construct(
 						enc110->base.id, &bp_cap_info);
 
 	/* Override features with DCE-specific values */
-	if (BP_RESULT_OK == result) {
+	if (result == BP_RESULT_OK) {
 		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
 				bp_cap_info.DP_HBR2_EN;
 		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
-	} else {
+	} else if (result != BP_RESULT_NORECORD) {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
 				result);
@@ -1798,13 +1798,13 @@ void dce60_link_encoder_construct(
 						enc110->base.id, &bp_cap_info);
 
 	/* Override features with DCE-specific values */
-	if (BP_RESULT_OK == result) {
+	if (result == BP_RESULT_OK) {
 		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
 				bp_cap_info.DP_HBR2_EN;
 		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
-	} else {
+	} else if (result != BP_RESULT_NORECORD) {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
 				result);
-- 
2.50.1




