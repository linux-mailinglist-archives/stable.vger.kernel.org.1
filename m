Return-Path: <stable+bounces-110539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFEBA1C9BB
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65D47A33CC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D411F8931;
	Sun, 26 Jan 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLgrtjpS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A71F8929;
	Sun, 26 Jan 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903296; cv=none; b=UlxKAbonw4EPUihUMdvLSR+pKGRSkzoezeGd1wCjMfaLEQaZyHbHWPBknQ370UgVl2/+h7JkO6tGHlktDb305eMAp/yitlbnRuvGQ1ooHBrR/omtj0/8cbbmjzd1Ok+QnCvfpatyQpxAqN1B25RJ4tMIgrh6TZcMvBSUt0cwv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903296; c=relaxed/simple;
	bh=A80N/vwzgNu2zPt3sRpDXRCaasm06f5duZKz0cFftVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXw7bd8ti6ColvM9RZCkD6c3p5N8nqqR4uxSDArxfNag6fhyHos+AQNp8kcZrKImbTLGlCL7O3E1eg46DbYOJ0+Fctc0EyEWBuUoyyGukZ4qWaduh+UgeueilZ66KEBXTFgAFNgpnhKiv2wzeuadbvtpqfpBkRSDAH5Z/9Opza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLgrtjpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3C4C4CED3;
	Sun, 26 Jan 2025 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903296;
	bh=A80N/vwzgNu2zPt3sRpDXRCaasm06f5duZKz0cFftVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLgrtjpSmKtrKJy790cVssAliuzIFz8wT4RM7A6M8451kMm2h7MJKnAqtCLavFJTi
	 DjSu9XIaw6g4bacCJhvNQTAppYbPupaIVSc3nGI7E9mBeAqTaPFZY4nfzhyJlUjuQ2
	 8/eiT46CLngrER1BJhHB05UIt7nYCVykUm/F22Phh87xRY62UOj71quIDp0rzW5W7K
	 Dl3aUoDFvk/RqWvqwmXRmrOq0ptzXrQjseP25wVI3knjucS9N9VWu9EPt9JC3ZEsg5
	 LVadY08q3G2P9Wpr5SfaXn3msm4IOrEuogEByE96X9YxQUECAIH5+hZspxK7J+KfD2
	 vpclfik+nVhFw==
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
Subject: [PATCH AUTOSEL 6.12 03/31] drm: panel-backlight-quirks: Add Framework 13 matte panel
Date: Sun, 26 Jan 2025 09:54:19 -0500
Message-Id: <20250126145448.930220-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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


