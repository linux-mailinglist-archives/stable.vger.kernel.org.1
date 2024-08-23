Return-Path: <stable+bounces-70002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9795CF0E
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48AE1F285E5
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408901990B3;
	Fri, 23 Aug 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlwwjuGD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D31990A8;
	Fri, 23 Aug 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421820; cv=none; b=NXt3IuKhuTzmFUhM+/QCgbWjK1eP7xwzpsk1xbpB1+GeA0C82Km645n7WPZl2cvgdFRm+lNyauKBYKWOYAUMIvkLFdAabUJHw7G/irO37gmZWHglytEmHsrq7FTd+hAcdnZw+glLNzTJ+5z7FgLjDnM8SJJebdC/qBpjVk2PZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421820; c=relaxed/simple;
	bh=gSSvy2dAew+hub5xIOIxQ3J5yTcYbohKu8RqJPZlqHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm8BoJkBP5+C/M8GqLMFwSWGCO4Ytm7ollzJlEBzwZ/Pjvl8uKKsySkexgeGUA2PWm2Kmrdg1tmMD6pPF6P1Lvck+29nesh6nShhaFSUxkRizPSzYmsrheCm7t0luoCATYUGDhJHAaTN+xyjgHFyUkKYHzj1TDD/ruJA1dUpO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlwwjuGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922BCC4AF09;
	Fri, 23 Aug 2024 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421819;
	bh=gSSvy2dAew+hub5xIOIxQ3J5yTcYbohKu8RqJPZlqHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlwwjuGDhgjv5H8+QIJrKv8EK5vlmBZjpdaB15TOlQexJLkEcM8mlpiVLlesN9qHz
	 wy4WUQVy9RE9xjdfU7HufrTa2aLl7ukcXaTdqos/3GkNk1A4jFPkPDa1AEYN/hRGpB
	 h5S7DEYpi42f/8MTZMJmo7VTqY+QRwm9I15YA8L1NMF+c5mBQB4bbTkcIZfdqQ7S6K
	 Fv41O3p/vLiv+rbCMJ64U3KlUFFXIlRzuYh8tx9tQoIl0p9yOY9wVqd8LP6ftlFh4f
	 u97Oo0G+dTVEigjQHbV/9AeUODgAgdV5YmI7I7B1CdBbiLouNT7uUDVrPxpb3bDooo
	 BHfgUFGzApnsg==
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
Subject: [PATCH AUTOSEL 6.6 11/20] drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
Date: Fri, 23 Aug 2024 10:02:25 -0400
Message-ID: <20240823140309.1974696-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
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
index 5db52d6c5c35c..21f2f3abf90f0 100644
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


