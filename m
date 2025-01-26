Return-Path: <stable+bounces-110540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4437FA1C9F1
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549213A82D8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E41F8AEF;
	Sun, 26 Jan 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZngCTLa3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE61F8691;
	Sun, 26 Jan 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903298; cv=none; b=uwkD0TeYPtiuK/8wPyoV7nYFklbUyqiNvFSrSYZrJWanwar2X5YRvtJalaJ1LLD6us24gM2joMEmaUeT1mGem6IFHtefne1udikOP0NAP/F4dyir/7+FQsGCsrC3W3KdK9pAG0KkKnruKifEUP3Rwz1PXIqq/GkHoDS6ELqT7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903298; c=relaxed/simple;
	bh=RsBfB9XUELwfxmqC+WNzDubIQj4UpFq3UOCVQC2ocao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSpkhGXBGjAUKzO/Ctd/RD91SCuqhU3UQbHLIXptfFCsCL1zEtrSt+FRRa5tyLTk4iSEPb6KIIqRjezGsjCjagaL8ba9H0nt2T+Pe+hWo1bJEKB2UC/KI/pQYsWndzdSae16y84kAy1cSSK+DKeTJnTeZMGV5XcVqSFnF14exUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZngCTLa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6962AC4CEE3;
	Sun, 26 Jan 2025 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903297;
	bh=RsBfB9XUELwfxmqC+WNzDubIQj4UpFq3UOCVQC2ocao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZngCTLa3tI+QKL0+0OiK7cWVc70hOZ6VINhHhh7TaIyVVSW1/Ob+cTDJNrpZTqPQj
	 X88++CvzeYrG8lbK2wX7K5prRoV1Eu7SNfbg7L/qzWWmNZlfmnJehuPsjNNcCCPKLL
	 60C2eECMnWxckKU5NEq67gTeHbtJVzWOlBg+Ts63ffPsh3BPd3B/uFrPYzaQ8Ht5US
	 YmZ2jC0ooHPyM8SQQLOE59mU2kPJeyxqa5kM0/FIXDxcVYo5zTtGK/DMC2lKQcayPv
	 PjbYPJHGEswUtF4w6k8S7r80Wft5ThsrGlTGN6wqIB4XWWGfBB7SizJaDeFqRApP7z
	 gM+xQ7hUJExvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Dustin L. Howett" <dustin@howett.net>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 04/31] drm: panel-backlight-quirks: Add Framework 13 glossy and 2.8k panels
Date: Sun, 26 Jan 2025 09:54:20 -0500
Message-Id: <20250126145448.930220-4-sashal@kernel.org>
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

From: "Dustin L. Howett" <dustin@howett.net>

[ Upstream commit d80b5c5b9be6b2e1cdeaaeaa8259523b63cae292 ]

I have tested these panels on the Framework Laptop 13 AMD with firmware
revision 3.05 (latest at time of submission).

Signed-off-by: Dustin L. Howett <dustin@howett.net>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241111-amdgpu-min-backlight-quirk-v7-4-f662851fda69@weissschuh.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index f2aefff618ddb..c477d98ade2b4 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -25,6 +25,22 @@ static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks
 		.ident.name = "NE135FBM-N41",
 		.min_brightness = 0,
 	},
+	/* 13 inch glossy panel */
+	{
+		.dmi_match.field = DMI_BOARD_VENDOR,
+		.dmi_match.value = "Framework",
+		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x095f),
+		.ident.name = "NE135FBM-N41",
+		.min_brightness = 0,
+	},
+	/* 13 inch 2.8k panel */
+	{
+		.dmi_match.field = DMI_BOARD_VENDOR,
+		.dmi_match.value = "Framework",
+		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0cb4),
+		.ident.name = "NE135A1M-NY1",
+		.min_brightness = 0,
+	},
 };
 
 static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,
-- 
2.39.5


