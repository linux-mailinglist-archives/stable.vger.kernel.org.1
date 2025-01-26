Return-Path: <stable+bounces-110506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE6A1C996
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A2F3AA1F2
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E7199EAF;
	Sun, 26 Jan 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuJGr07t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB619992E;
	Sun, 26 Jan 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903205; cv=none; b=S0AkV1cR/uJzBL/xl5Qelid5oPZ2Lrp+vna/p9w5Ajh9hI/WD/QFWmM+v1MVTtZY4SrRKWDIvdYbwTefuoANr8MoV87x9pZLoXsG+9YxN79XfD5hEURpeAdP/73pTed0f6R7DhN5+gYhOEtI45DzrDB1TWSsRpsckrrGXIM1CVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903205; c=relaxed/simple;
	bh=A80N/vwzgNu2zPt3sRpDXRCaasm06f5duZKz0cFftVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrE6LE5r/QkcfKpZqpAtlLL7ztSKaswl4xDg0psu8NV93f9lxuD09hdBe2SBKTlw5Ecx7tkpukYNNJxX7huf4mHAp7qbV3NMm27ubZURa9tTM5oGPr/QwojOIegyiGerfprZIeUBl4tnw4V3HqopZHj5V0n/qz3jkjFCaFELXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuJGr07t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDD4C4CED3;
	Sun, 26 Jan 2025 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903204;
	bh=A80N/vwzgNu2zPt3sRpDXRCaasm06f5duZKz0cFftVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RuJGr07tzOzgKOwCvPrGaCbT69+G4XTzsUjd7H+mKtI5LGyAeB6TVSAx6YLSQ5PBZ
	 719AXowcJ3S1dLruN9wEx71j0e21HxZLnJjLzUAD0Qfs/3nro9bR5/QDrOKO8UCS33
	 S7PQ9M49H3Ynob8CEjDwdl3m4zy9MJwuiBOCQk1ntaT+acJruf/H3TtXrxt33XM3r4
	 FKLS6PMrB24gm4NE4f6F04DePwD2tot6WZzZzq21ruLTOp6A1kTE1imHP2PT5DCmev
	 OlhGIlSGzKHNeWIyCCTfbOkdKxhjf1uqB086yyAxJtR6M0+/FDVPoXvAoEa0vSY9yN
	 yYVJCuJaqUngw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Dustin L . Howett" <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 04/34] drm: panel-backlight-quirks: Add Framework 13 matte panel
Date: Sun, 26 Jan 2025 09:52:40 -0500
Message-Id: <20250126145310.926311-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 916ecc0db336768d80e14ef28a8c64a775274f95 ]

The value of "min_input_signal" returned from ATIF on a Framework AMD 13
is "12". This leads to a fairly bright minimum display backlight.

Add a quirk to override that the minimum backlight PWM to "0" which
leads to a much lower minimum brightness, which is still visible.

Tested on a Framework AMD 13 BIOS 3.05 with the matte panel.

Link: https://community.frame.work/t/25711/9
Link: https://community.frame.work/t/47036
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Dustin L. Howett <dustin@howett.net>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241111-amdgpu-min-backlight-quirk-v7-3-f662851fda69@weissschuh.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 6b8bbed77c7f1..f2aefff618ddb 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -17,6 +17,14 @@ struct drm_panel_min_backlight_quirk {
 };
 
 static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks[] = {
+	/* 13 inch matte panel */
+	{
+		.dmi_match.field = DMI_BOARD_VENDOR,
+		.dmi_match.value = "Framework",
+		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0bca),
+		.ident.name = "NE135FBM-N41",
+		.min_brightness = 0,
+	},
 };
 
 static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,
-- 
2.39.5


