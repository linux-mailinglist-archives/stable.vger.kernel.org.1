Return-Path: <stable+bounces-128097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B4A7AF2A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C683F168402
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD01233734;
	Thu,  3 Apr 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOatOh6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD923371F;
	Thu,  3 Apr 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707966; cv=none; b=aID3FiKbyXG35khGc3bbheXpBiZCNyRw4RwdRAW9sSsJsGcDVS/XyZdODo2T+YsFd2nFQ3DywlhxiPmIR0vdXLAJVTZ9WW3y3EC3byLOYo/gqvj8Znlz+dctnFeRaTH3oxSIQQKyq3iNl5OuRfCw9J1GPTctyM4Pa3fVExTnqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707966; c=relaxed/simple;
	bh=7ZnN5TqzjbGxkYavaKZmc9g7jeBRN0VAk+pBaM4agIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUJ5lIuHpvCGNWUonow7K5AiSLqkBHnMedQnuZ2BiwC4ejWWEE6xrgtS3df7tKb/IHP+YuFIWD3nPYggTyzIwNZdKmPAgTLaFH7kuzMZFoCT1nWA5B3KtTFtD6NCHTOj7FEogRvQ9vrNcD4YihKrS3kIcurbG2aRHxwDLr441Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOatOh6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994F9C4CEEA;
	Thu,  3 Apr 2025 19:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707965;
	bh=7ZnN5TqzjbGxkYavaKZmc9g7jeBRN0VAk+pBaM4agIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOatOh6dpwwbA9zCDfh6tphUby+pw2IZ2JP+Tnqk8W+aios+ZK2THDeBpvytkYP2P
	 U64rOCAPd9mPu/CNn079SCrDQ4Zj+1cTa47rdtMJHu5LMftHBECpmiSCCRMlg2PFBR
	 HTY+xth4AIpYWMcP7kZt3hixHYiqpz2TWtMxQ2WeH+PpYc5S2xbnfnZC1nKwNwUMS/
	 rtNRvWZ+ZRVCCdABzUxbRtjuc6DUuBkrokCdqoEkv3JJ5h3PP7O8PIizfyd3K2kPWZ
	 x1tYvw4+T/tOplGmBYt3GmeDZxvUVDEYP4dm/yve5PaGIzZ9sFFXrN6nrpLsq2yDXy
	 KarXcCOM2+Eqw==
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
Subject: [PATCH AUTOSEL 6.1 03/20] drm: panel-orientation-quirks: Add support for AYANEO 2S
Date: Thu,  3 Apr 2025 15:18:56 -0400
Message-Id: <20250403191913.2681831-3-sashal@kernel.org>
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
index c00f6f16244c0..7bf096ddeb06d 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -184,10 +184,10 @@ static const struct dmi_system_id orientation_data[] = {
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


