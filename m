Return-Path: <stable+bounces-128010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB522A7AE28
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68795188D5EF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F401F875D;
	Thu,  3 Apr 2025 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQNDt18Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92731F8755;
	Thu,  3 Apr 2025 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707752; cv=none; b=fIch1YfR6/dFT0lAW6fthk4QU7mnVLDBgRNGTg+o/osUrOv9joKNa84Q8/TeBZySAHzxneeNM4FnQuPNTmfKCtHoUEvDBSvOANV4+9sVV/F3MrkFNy9lkedGZZ6pMzfYQ6Mb51zMnmNK7qkF8Kt50GMedFUkqS1g7OKRkG5y6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707752; c=relaxed/simple;
	bh=9vLA05UqALd9HAN6zu0mr5Jdmu90GO+dK/JXjUDyrN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cj8w5Z6ACtD0SHEZLRoWfTeln9g1rMcA+CCj5JiB3dI2/Ke6+umq2+97E2HB1qxvJcQG0VDw/FlxiO8hwYlDrVCN11jIH4QoS9vqjDoR8uPo4LWDnOrqIciikbVoz6AQlASaHhZxagDsHvBDsYx+Kq11FnIa+FuNwQmsMYW+eqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQNDt18Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D99C4CEE8;
	Thu,  3 Apr 2025 19:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707752;
	bh=9vLA05UqALd9HAN6zu0mr5Jdmu90GO+dK/JXjUDyrN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQNDt18QTyyQRjItlA7Ce/E3PCJgW/gcMvxugFj67zaobeFsK1u9iJH58bdChCsLh
	 6YyBqAzOUqzyqIKwznut33lF8w9dJBhoFQF0tBSZkSb8yV2Xk8iQo7bcIJ/V7yoy/g
	 rmGKZdlShAB7104FiSm5DGOfC58fowmCiUG6Wwg/t3wcD5AwuO/lkb45fefaEiVumF
	 aTSRw1bCJYdUWIqdWihzXhNOkhzgFkBwDXn0r2CmaP021m4eV/J9HvLatWcn2+4SPP
	 Mv7ufRx8ts4Gc4OrzuzvHSQZkkQTBWqv1T18z1CtFiYgHpj6X7V6hxD0UCwtxwkPAI
	 /r4b8x7t8fFpw==
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
Subject: [PATCH AUTOSEL 6.13 11/37] drm: panel-orientation-quirks: Add new quirk for GPD Win 2
Date: Thu,  3 Apr 2025 15:14:47 -0400
Message-Id: <20250403191513.2680235-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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


