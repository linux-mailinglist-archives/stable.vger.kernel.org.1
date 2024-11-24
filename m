Return-Path: <stable+bounces-95269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E49D74C1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EFD16794F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9A71B6CEA;
	Sun, 24 Nov 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObKwNAM2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761331FCFF2;
	Sun, 24 Nov 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456552; cv=none; b=qjz/06SV2YKrShnoxL3txv9vczVP7H8r8KOMC8jNgk1lJDPcmjkV6D9VxqiLz/dn2PR3jRAGR8ThOOING3J5hZdQfuA9FKoU/WZr3aL9pA2UilwEFm7X886ha3Hf3Smuwi7cLW/c134UavVvl/oXWpaoYeV3xWlIAeGUWbgqjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456552; c=relaxed/simple;
	bh=LMpOm/I9CTRAPSQrp8UIrztHi5OPGkRiKBjYLgDAuKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cWW2CF/Cd0NbJWsUhQFPxeLkpHCV3C5TiAZyeXtag60GolWN9moQCVbEogT4CIVwnzMMVP+eug+MGrNqEOnHEDPVnjcMupULGFzupmWkJHNdicrbjcuE+GwjrUAr6G8W7Ta8jqdWUCzNyN0RLRoD2oO8l2ls/1C2JX0sRw8rl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObKwNAM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920D1C4CECC;
	Sun, 24 Nov 2024 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456552;
	bh=LMpOm/I9CTRAPSQrp8UIrztHi5OPGkRiKBjYLgDAuKA=;
	h=From:To:Cc:Subject:Date:From;
	b=ObKwNAM2gpd2Up49705+jcCMu4FtHy6taUQPpUscv70l34/oHlODYjzLK8VP086JN
	 D/dWVoQH5Hi7qv2rx4KclToXLCcUWqXddTotnPRfl/MHMJGxYKLgduFOnDfLCx31GF
	 jcuCMG8IGKg6/ZhmgaPhH0kPMc6sXzb5T4QLNl4E+Ds/EvuAyjJKPgfbemoDK2SIPa
	 p1yIP3ogzFPQC5ZeXlK0GRwMfVR/oxn8UYufa3r/YGQ42VXfqO5AT7doPKSIaju6Za
	 nb6p9mkTZhDcj4peUuVP1JPcy31GEZe0PIPffkuiPBm7NRSAq8gO5Wc8NcxUvTgAFm
	 y/jnXbtSc6SpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 01/28] drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
Date: Sun, 24 Nov 2024 08:55:01 -0500
Message-ID: <20241124135549.3350700-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Joaquín Ignacio Aramendía <samsagax@gmail.com>

[ Upstream commit 361ebf5ef843b0aa1704c72eb26b91cf76c3c5b7 ]

Add quirk orientation for AYA NEO 2. The name appears without spaces in
DMI strings. That made it difficult to reuse the 2021 match. Also the
display is larger in resolution.

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/2b35545b77a9fd8c9699b751ca282226dcecb1dd.1726492131.git.tjakobi@math.uni-bielefeld.de
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index f1091cb87de0c..bf90a5be956fe 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -166,6 +166,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO AYANEO 2 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYADEVICE"),
-- 
2.43.0


