Return-Path: <stable+bounces-69979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F183095CEC4
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302101C23A8B
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD018E043;
	Fri, 23 Aug 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7T2oCyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4518E035;
	Fri, 23 Aug 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421721; cv=none; b=Z7T4Njus5mqUfv/JTc8dIlosChwi0D5XB9MpGuUBAHGPSYb8g3BvxkuH4g/9fUK8sMgsBM7WitbnwqhfbApaV4EKknAekopV6DPQGxUjlF4fPAh7sbfu4+aaOwPaXHDfZS004NkeCtei38UVH/4c+FbOa49qVll9jXojgK3/4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421721; c=relaxed/simple;
	bh=u9dPYlpCBGOxC499+p4J2pinMIffVbfU6kw7JI3tWG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSIzqF2u7Vc/I5KfvL7iga986/+jidSCDbUaeVDjsUPAq6HFmoz5b7DehYzUZOziM9QJgyMoKAahBN0M1a7lssdfbntdxNkSQD20I2cRyQ9Ii5bZ2Pl7ivuwRyTjktx5BfiSg9JhDLHY8VQKVs5cP1sTMmKq+OzEqnIbBMoH7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7T2oCyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A68C32786;
	Fri, 23 Aug 2024 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421721;
	bh=u9dPYlpCBGOxC499+p4J2pinMIffVbfU6kw7JI3tWG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7T2oCyhIgxbjFt+uwvBrpNzDRF6CbyZREfq/UDpNujwM80p/Qegg//Yw3hlbZVBl
	 IhmWt2zQNxZSuaZk5L8Mtio+tr09Jz+v8cxnrkkltGpn+kkY5Uxvc19jMBW1cfX9p9
	 cWDRP7mVZgPq30yEEDckw7QGyR/DSwtzqq+RGXwJlM1p2OPMBDHdpeiMDgIhxLGVpw
	 XBBNKADHPWInIKI6iIAxo2vFMVRzuSZTtpxJyB3GGig4qQT0o2bNQcc17xQdVuOVie
	 Qk73eky0DHcX3gP/5cY5QKPdk7LR6M/2tIue+pZXb22Inu+On9mxyLfRB23l4LFUqq
	 99fP4doipzfUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 12/24] drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
Date: Fri, 23 Aug 2024 10:00:34 -0400
Message-ID: <20240823140121.1974012-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>

[ Upstream commit b86aa4140f6a8f01f35bfb05af60e01a55b48803 ]

Add quirk orientation for the Ayn Loki Zero.

This also has been tested/used by the JELOS team.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240728124731.168452-2-boukehaarsma23@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3860a8ce1e2d4..96551fd156abb 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {	/* AYN Loki Zero */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Zero"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.43.0


