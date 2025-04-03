Return-Path: <stable+bounces-127970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84BA7ADBF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D2517E0A3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387E291A03;
	Thu,  3 Apr 2025 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIx6AnmX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8D2919FD;
	Thu,  3 Apr 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707644; cv=none; b=C0/ghpI8BsLyDO+B1vYUgJcaJdZqdOV9joy8CpNPUK+QidGKMPlEwp8YJnvurtBiggrwg4uNDCqm4ypDW0S9pGE/ygx5bqy1oqp/NOheoD1Jfo8DhR5YGHo3wRknqd74c/MdZAwovhstx2vyIa/YOPh1R9H66OAt7IgWsrAmGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707644; c=relaxed/simple;
	bh=9vLA05UqALd9HAN6zu0mr5Jdmu90GO+dK/JXjUDyrN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5ZxElYPhRR4Ba6dQib3On+VbHpIGkpvkyKoUedIXyJifGc2DtKD9vhAWUJozoDFO73FrKG4CYkM8JJUEU+Ld9oDbSkypJ4gP38Meh8yJRCv7kesj6qzss4dS51VSjWo3lsIvUThsvesN7YJ57fjJMZbkmvOXFiZTPZQr2d8CWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIx6AnmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A4EC4CEEB;
	Thu,  3 Apr 2025 19:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707643;
	bh=9vLA05UqALd9HAN6zu0mr5Jdmu90GO+dK/JXjUDyrN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIx6AnmXw/f4kXehb8wOT/LPtu97VodnGAxDtfz9hxg/NXeHO/iUx5JyIU0HzlWg0
	 KulpkeQUBpEZ8hL8l9mo7w0pfQO8pT6liswiC1LNMGPan+QuM9YvHtFCqvKhX0QUXt
	 OS5/pKhz9hlQOdyS14EZlmvT6H6RtFhuVfKilZXR+qWp84tlpRG1f6ZUg/zkW8FXvj
	 no//YYksjVD/4MP8bT1kusIas8OgIOEV04ah9nOcOayXwjpR9cFHhEVZNPLlYJEP30
	 mp4j4tZSQLumE5PrFUQL/KXF3XdYmO7J7q9zVbBERc6GWxUSI/IAcjyPqmzlTkeNHL
	 Uc89RP0kZVBvQ==
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
Subject: [PATCH AUTOSEL 6.14 15/44] drm: panel-orientation-quirks: Add new quirk for GPD Win 2
Date: Thu,  3 Apr 2025 15:12:44 -0400
Message-Id: <20250403191313.2679091-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index b57078cfdd80f..384a8dcf454fb 100644
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


