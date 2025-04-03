Return-Path: <stable+bounces-128099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3508A7AF32
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132333A8F43
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF110236458;
	Thu,  3 Apr 2025 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRWqhDjO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F3236433;
	Thu,  3 Apr 2025 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707969; cv=none; b=Uunj3nnMOtHXYNzJfFKMablRDqs5uy+pz6vjmSa6MqPExXt4EshovMWuIcaAzJ/jROV+1TAjZlioHrbd0mGXGzJ789nHTM4P3hHBQ85PWi3XXU64ZWdYhW7k4IqGH+/3bKe0VIQHoljbCN3FIMtEois3KMtAG1MpRyaFoGXHlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707969; c=relaxed/simple;
	bh=0iAd2EYKbPx39L+TMiaVJqEG2r3RP09Wm71HD5ezxMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0337KkZp3NOnNqwDWFceFoynW9s5Rf8GgI07c/TIo3Lz6K+rbGLqnyRmtdd+vyQoGVBSMGY0WrH1zJOYsWDCzSzU03ZKSV2Z5R9HVU/gHz+HkiTwjWRBS5MUCSO1mGuRrbKA1YPbpwYqiUNVBN2Ux+Gk7HOnzWW4n6OtCa2kE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRWqhDjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322C4C4CEE3;
	Thu,  3 Apr 2025 19:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707969;
	bh=0iAd2EYKbPx39L+TMiaVJqEG2r3RP09Wm71HD5ezxMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRWqhDjOKAQGfoIvKw9RqB/jtESxbxCS6CY0q+KVhegvI7m2w4mCU6pAk5abOzxNt
	 EdufM6Ucb6LwcIYk/wuSXzYhGINbIuZ0SpP/nWE6lPHKuMg0U3YlvnIfwHjm/4CSkL
	 3BmpgN3NxQU+ToH9fht/f+2UpZOwbxIp5rB9PaZeQcYdz0uXbIWC7TKcD+7cjmgLbD
	 xMOlFZIBoP3XC3Ct5eLDNPiu2fVsC+NqAHfNl4NKd/TrlLf0LiKcDcJH++OmY1m3qX
	 /lGH3GVlJwefLsZy/Mn0z8CR876iL7aCr8f8QcCg03tdJs8ECCkPoM/CgKZrWWfRLs
	 ptw0DXbMVhchg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Wyatt <fewtarius@steamfork.org>,
	John Edwards <uejji@uejji.net>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 05/20] drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
Date: Thu,  3 Apr 2025 15:18:58 -0400
Message-Id: <20250403191913.2681831-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191913.2681831-1-sashal@kernel.org>
References: <20250403191913.2681831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

[ Upstream commit 132c89ef8872e602cfb909377815111d121fe8d7 ]

The AYANEO Slide uses a 1080x1920 portrait LCD panel.  This is the same
panel used on the AYANEO Air Plus, but the DMI data is too different to
match both with one entry.

Add a DMI match to correctly rotate the panel on the AYANEO Slide.

This also covers the Antec Core HS, which is a rebranded AYANEO Slide with
the exact same hardware and DMI strings.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: John Edwards <uejji@uejji.net>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213222455.93533-4-uejji@uejji.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d9ed6214cf28b..702246ee7ced2 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -244,6 +244,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {	/* AYA NEO SLIDE */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "SLIDE"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {    /* AYN Loki Max */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
-- 
2.39.5


