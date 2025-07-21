Return-Path: <stable+bounces-163585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D4EB0C570
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BACA17EAE5
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBCA21B9F5;
	Mon, 21 Jul 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exvffVbL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D22576
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105434; cv=none; b=dQLdQpWqxAcQKGiRZdxpSnO1JQaJVL9QwIxqi8UG7PLQGRplc/36Fq989e0O3hdcYaHWvQYaUy4jsIgst8RAANHACF1tvrhaOH7Pr/JQZbPaPxSeROHLeZ6+Z4Rj0LLpKknRRUT6HZjcUfenydOYWVM4SBXvePlfdkaZxSwrVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105434; c=relaxed/simple;
	bh=pro29KEPMRLoagSJ/fdxTVhSrn2ZnvtGDUaZZ6K9JMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTIteb6guay6RldAviLxEWdQbtD3fYSjX/iHjrBN0cVFcac7pAwxTSSazsx2l7PAHoMmghRrdok4511MZQwTnhbr7MTfyw8DuTnIXpa9J/rcd42TljZ7A80wyR2oamTZOFrwhP4sWBAKgwrQhNkT3c8+egf2O73JjiWlYMsKR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exvffVbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E5BC4CEED;
	Mon, 21 Jul 2025 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753105434;
	bh=pro29KEPMRLoagSJ/fdxTVhSrn2ZnvtGDUaZZ6K9JMc=;
	h=From:To:Cc:Subject:Date:From;
	b=exvffVbLvOn/icKonyzlBO2iwXtKH6tcejjmx7keI7badUZ46ozVpvUZPnPMFMr4i
	 2JS3uFQa78sYPlDGjfI87sbF4Sm9DBZAubuv3Ty37vO9NP5rTpH0BO5JFCPxy2TnTd
	 h4+Nxn6ew3a08316GQIK+N9up06f/BnWtAk6Bj/CRRQZlcpFP8Zeon1HMJLiqkeUaS
	 TnpBMIcRgJp+z2H0Ou7v4Sa6tlYHRLoAWrKTvP1m4E0t5tZM4Ns4ff90/yu+02kG6U
	 ng+cXz0PmGaQbhS2I7lZUq8p9wMcOAm2LUpbxBk58gaz1WVM2BEl5m/qbP9CixHww9
	 Fh/7eZaCIw/7A==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value"
Date: Mon, 21 Jul 2025 08:43:50 -0500
Message-ID: <20250721134350.4074047-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

This reverts commit 66abb996999de0d440a02583a6e70c2c24deab45.
This broke custom brightness curves but it wasn't obvious because
of other related changes. Custom brightness curves are always
from a 0-255 input signal. The correct fix was to fix the default
value which was done by [1].

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4412
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/amd-gfx/0f094c4b-d2a3-42cd-824c-dc2858a5618d@kernel.org/T/#m69f875a7e69aa22df3370b3e3a9e69f4a61fdaf2
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e1405e9025ba..f3e407f31de11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4740,16 +4740,16 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..MAX_BACKLIGHT_LEVEL] */
+/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
 static inline u32 scale_input_to_fw(int min, int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * MAX_BACKLIGHT_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
 }
 
-/* Rescale from [0..MAX_BACKLIGHT_LEVEL] to [min..max] */
+/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
 static inline u32 scale_fw_to_input(int min, int max, u64 input)
 {
-	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), MAX_BACKLIGHT_LEVEL);
+	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
 }
 
 static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
@@ -4977,7 +4977,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
 			caps->ac_level, caps->dc_level);
 	} else
-		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
+		props.brightness = props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 
 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
 		drm_info(drm, "Using custom brightness curve\n");
-- 
2.43.0


