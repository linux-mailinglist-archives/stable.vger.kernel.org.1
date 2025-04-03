Return-Path: <stable+bounces-128128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5FA7AF69
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512C01899349
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A32561C0;
	Thu,  3 Apr 2025 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu+JMoVx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006B262813;
	Thu,  3 Apr 2025 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708038; cv=none; b=M99/y5k9bk/GB2e/p0t7vKlZJyxLG8DE4LOJrxCTUmxE/tUpSVFAC34N3PndR/Hu5wJ8+dePWTZwO8pJoWVhlJk1Epm/Rq5SW9M1e0loY8cX/TkbuMQwBducsWWsIKthS1YZqgcnMUVxvKUXHnYfO1uHREy7s2J1cxxJLTvxcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708038; c=relaxed/simple;
	bh=II+x6mrmAM9y9kllTPt8t+WSMECNLUZKJyi88SaC90Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1RHQfb8ZUa7tsMv5547n7hBLSBNOOLzTMmJE65LOYnkMHFfLBW6GExzXbDeWJ+uK4OogMWqYILJF/Jlsutv7KIOJtd0g4riyZ5lH4ECnJ2l8B536Ra397cybxqc3RLVEQocKDa3cHaQyJXzeFRjOPwoT+XFNtXW6gXRYAljF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu+JMoVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6A4C4CEE8;
	Thu,  3 Apr 2025 19:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708037;
	bh=II+x6mrmAM9y9kllTPt8t+WSMECNLUZKJyi88SaC90Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hu+JMoVxyzkQeVkKpUX5ssOUmPpeLfUSFlc3EdcT5YiRKvIs8B3rFLiQ1l75XXfr/
	 nfl1wERrZ+ClSX4GILBm4V1eIvB/nW59oR3Mpicnt4nLNP997OmKUJ21lObS0gLpnK
	 atTgfKTZkq1sAy44e6bmR21/UzL94m+dOvpqHu5Tt/wkJrG5PHEJ18VYvVhxHsxr/J
	 nJih3Z5LJ+hVx7+ByTGHIp1juX5uoBWO+0aDDHJ4G9dFt+1MlnpL45auqIsWpw6LEj
	 +GAgnTQDwuoyTdwV1z6tSEdBhLRDvNVtrbspdRig+pfxYvPLW3x4jGzxpMfnFH1uNB
	 mo9GH+ENJ8iuw==
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
Subject: [PATCH AUTOSEL 5.10 2/8] drm: panel-orientation-quirks: Add support for AYANEO 2S
Date: Thu,  3 Apr 2025 15:20:24 -0400
Message-Id: <20250403192031.2682315-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192031.2682315-1-sashal@kernel.org>
References: <20250403192031.2682315-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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


