Return-Path: <stable+bounces-128078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83090A7AEC8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F847A7056
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69822A800;
	Thu,  3 Apr 2025 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpe5c2Tc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66422A7FE;
	Thu,  3 Apr 2025 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707921; cv=none; b=pNZUhnwah3QFKk/s+drtrEyn16xsHZHcD/vo/PDl2wnn5pzC3a1/y9RVhM68uOi0L0FIQKW8HvwfaBwZm5wEakOuRHvDfDB7VqL+P0pub/uwUzRv+zIzxcLdC9olVSHO7mQUS/NvNjGGPUlcl5C4u971cYApK/mYBSACP6YkeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707921; c=relaxed/simple;
	bh=7/BuOQX3ObVXa+wHVmsd/9C4LWOM3RTqepGHgYc8dVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDH1McVCscfGuSkG1Fx/Q7XkIq25gqVi4FCS3wvmkBgaH2S0jyhUPachMhFgDrrao9ry+/es1WOiKIH4lfYzVtKFyDj8NxVfgFftyTkpdA3Wxtiq6eVLywCwUxbUK5nWgDLklBDtmGGMR5fHxg9rwROv854As/jwt/jRefZ0uFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpe5c2Tc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6867C4CEEA;
	Thu,  3 Apr 2025 19:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707920;
	bh=7/BuOQX3ObVXa+wHVmsd/9C4LWOM3RTqepGHgYc8dVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vpe5c2TcR10Jq4quaqN+9Nirbnodp206kK5PN2K1t3V8V/dYesY47+YeWpLNMnLUI
	 nLN0MB1rkRpZn2h3UtVJyJXKIwVngXmjp0SawvWcN0973OsRFj21l2jSyeBz+0z4k2
	 3QHXDMVxnXO4Ykwy+HZCI4BGhbkkwbkPi/V9OuYim4f0mqZ/LM28uquFJHZ691X0J+
	 FVL4j4HKD0NPe1LitVES1k1H67lq/H5j4ZLdz1lq8UVx0IX0VtThZxV74tYeobYyOG
	 Vv/161zyv7sSavDpRXp2PC6mvCqDaCfx/ziqSQtA1gceHMjcPm0n1X80JnF7xX0TJ+
	 xqEzU3rOLTFRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Wyatt <fewtarius@steamfork.org>,
	John Edwards <uejji@uejji.net>,
	Paco Avelar <pacoavelar@hotmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 07/23] drm: panel-orientation-quirks: Add new quirk for GPD Win 2
Date: Thu,  3 Apr 2025 15:18:00 -0400
Message-Id: <20250403191816.2681439-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191816.2681439-1-sashal@kernel.org>
References: <20250403191816.2681439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

[ Upstream commit a860eb9c6ba6cdbf32e3e01a606556e5a90a2931 ]

Some GPD Win 2 units shipped with the correct DMI strings.

Add a DMI match to correctly rotate the panel on these units.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: Paco Avelar <pacoavelar@hotmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213222455.93533-5-uejji@uejji.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 702246ee7ced2..12d547f093bd2 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -339,6 +339,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_win2,
+	}, {	/* GPD Win 2 (correct DMI strings) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "WIN2")
+		},
+		.driver_data = (void *)&lcd720x1280_rightside_up,
 	}, {	/* GPD Win 3 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
-- 
2.39.5


