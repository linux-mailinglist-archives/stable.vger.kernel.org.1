Return-Path: <stable+bounces-128117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552EFA7AF6C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF52D3B9BB0
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF725F794;
	Thu,  3 Apr 2025 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joHM7v9T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8525F78E;
	Thu,  3 Apr 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708013; cv=none; b=N8uzbDxg9v2UiEFdHolljr/EXiU+Y052+5RapMG7/MiSMF3DLiYtaxhwgaw64+7v5/+lQWFcE/rzrcH7tDOhInwqsbaM4eLjqwsFOXUthiTrOOD3aMAwZA3APWUtvWfs8MztNSKKk3EDoZ3BHyv7v7CTGpGPdvV5Fx03Z+emyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708013; c=relaxed/simple;
	bh=II+x6mrmAM9y9kllTPt8t+WSMECNLUZKJyi88SaC90Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1uOZu0E5ZljilJbnhGDxIIZwtz0RDQsAruMabMUxnSU7w573BlKMzWoFx+rEhskY3hDjvRH68Tm+84y4qvveL4LjjDRcGjPYDxZrTwcx9uCZZer7unzvnnMae6of7u+41BiQjRLEu+6o4p2aKY2fXmivcC/IdMUfylaKr8yyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joHM7v9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C9DC4CEE3;
	Thu,  3 Apr 2025 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708013;
	bh=II+x6mrmAM9y9kllTPt8t+WSMECNLUZKJyi88SaC90Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joHM7v9ThpSSA6u2msDHEn4llylkhdcGE3OL6ZlMeor/VcPry4c6+hUXkV0569ZLF
	 lPcNWlIJrTOJON+EMXhOLOHQ875cG2WDZu6Wp2Ai8gfaItwW/G6hCehzsQDJ+YLUMy
	 0hXF73giHREzxV8iPfGDETD3s6ON0gLVekK5Ou/MyrSbpfvRzKag3F/aCYVowdu1fK
	 cQx3+iHFcyET1xT7LZwpOEA7nHd2c5LzsuxHLJuyCylJ4FYqumcuVgzTohFAD2J7hs
	 M9qYicc96M3D0xPUmcv1LmxtpBodCFBMlamQfmWMHV3JSt0i4/94Uq5zS+s2EFYSIE
	 KM1rzVAocaIlQ==
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
Subject: [PATCH AUTOSEL 5.15 03/12] drm: panel-orientation-quirks: Add support for AYANEO 2S
Date: Thu,  3 Apr 2025 15:19:52 -0400
Message-Id: <20250403192001.2682149-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192001.2682149-1-sashal@kernel.org>
References: <20250403192001.2682149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

[ Upstream commit eb8f1e3e8ee10cff591d4a47437dfd34d850d454 ]

AYANEO 2S uses the same panel and orientation as the AYANEO 2.

Update the AYANEO 2 DMI match to also match AYANEO 2S.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: John Edwards <uejji@uejji.net>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213222455.93533-2-uejji@uejji.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index bf90a5be956fe..6bb8d4502ca8e 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -166,10 +166,10 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* AYA NEO AYANEO 2 */
+	}, {	/* AYA NEO AYANEO 2/2S */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
-- 
2.39.5


