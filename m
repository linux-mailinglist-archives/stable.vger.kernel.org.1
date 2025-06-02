Return-Path: <stable+bounces-148719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77024ACA634
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6043189F253
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC294313E67;
	Sun,  1 Jun 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA3izv6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A349C313E5D;
	Sun,  1 Jun 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821177; cv=none; b=QuUWBjHY+a4/MDbxKpSazcKMcBQJPCEaGXPz9nc3fahleV/CMAnSirn+I2wCr/tPDq3YB7ayb2D6vE0tjGzB2NwCuxDxiDxEKcSORs8RHZObUAzR9z1+5XIMr7yVU7dNHSzIMbZzQSVRs1a1WZyDLZJsHLXJAkD7eCZfp12CIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821177; c=relaxed/simple;
	bh=AmK/CvXfdspt8eIn9gVvuyB7t+8XXD/KzlmZ+C5JEMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwDWSNLQud0rMeShDHp2Kw+2B7WhQ/nlZvszcqkuXGfGyz+vYLb4XCJxYo1jq/XA7B5P6ThzM6dRH3o1Kd/rqzhMVFlCPptH7MeMiOH2fyO70eKHC2g3sBJ7UmOf8j/DZ+h99HNNd+kHSFi747o3tkaAOfKluxmKxBo/i8aPjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA3izv6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD82C4CEE7;
	Sun,  1 Jun 2025 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821177;
	bh=AmK/CvXfdspt8eIn9gVvuyB7t+8XXD/KzlmZ+C5JEMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aA3izv6QPwypgYYmQzkg6YOVrpmbke9s3PezrGF61vVmzobu7sMhDcBvK3d+F2ITO
	 Nlc5yz1RB2jpQIXQ3CTiC4yqWPxpRrJuXfxJ/7W5dI3GuBpUhms306jHjuhUE/7bLL
	 DzYRcKtIglj0ihdJ3aja13DonC4R3/EM3QvFRO9U0oLYhPGBRnfCSm/JfQWWc9d9/4
	 bWBUoeZIoFIiHMKcYsCrkIEAYOXKB+WOsF6WywVlGibvQmnkVkNUj2+wjJ8lFo+ind
	 U828AGeY7Ya89EPuBeWoazmWc7hqzsLcTjE6EFEJeFJ5kXRsO8MF6+eMzhMjyYjGx2
	 n/S/WpFoHeVVQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Talhah Peerbhai <talhah.peerbhai@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 48/66] ASoC: amd: yc: Add quirk for Lenovo Yoga Pro 7 14ASP9
Date: Sun,  1 Jun 2025 19:37:25 -0400
Message-Id: <20250601233744.3514795-48-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233744.3514795-1-sashal@kernel.org>
References: <20250601233744.3514795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Transfer-Encoding: 8bit

From: Talhah Peerbhai <talhah.peerbhai@gmail.com>

[ Upstream commit a28206060dc5848a1a2a15b7f6ac6223d869084d ]

Similar to many other Lenovo models with AMD chips, the Lenovo
Yoga Pro 7 14ASP9 (product name 83HN) requires a specific quirk
to ensure internal mic detection. This patch adds a quirk fixing this.

Signed-off-by: Talhah Peerbhai <talhah.peerbhai@gmail.com>
Link: https://patch.msgid.link/20250515222741.144616-1-talhah.peerbhai@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and comparison with the similar
historical commits, here is my assessment: **YES** This commit should be
backported to stable kernel trees for the following reasons: ## Code
Analysis **1. Nature of the Change:** The commit adds a single quirk
entry for the Lenovo Yoga Pro 7 14ASP9 (product name "83HN") to the
`yc_acp_quirk_table[]` array in `sound/soc/amd/yc/acp6x-mach.c`. The
change is minimal and contained: ```c + { + .driver_data = &acp6x_card,
+ .matches = { + DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"), +
DMI_MATCH(DMI_PRODUCT_NAME, "83HN"), + } + }, ``` **2. Meets Stable Tree
Criteria:** - **Device ID Addition**: This is explicitly mentioned in
the stable kernel rules as acceptable - "It must either fix a real bug
that bothers people or just add a device ID" - **Under 100 lines**: The
change is only 7 lines with context - **Obviously correct**: The pattern
matches exactly what's used for dozens of other Lenovo models - **Fixes
real user issue**: Internal microphone non-functionality is a clear
hardware regression/bug that affects users **3. Historical Precedent:**
All 5 similar commits provided as examples received "Backport Status:
YES". They all follow the exact same pattern: - Similar commit subjects
mentioning specific Lenovo models - Identical code structure adding DMI
quirk entries - Same commit messages describing microphone functionality
fixes - Several explicitly included `Cc: stable@vger.kernel.org` tags
**4. Risk Assessment:** - **Minimal regression risk**: Adding a quirk
entry cannot break existing functionality - **Contained change**: Only
affects the specific Lenovo model 83HN - **Well-established pattern**:
This quirk mechanism is proven stable across dozens of similar entries
**5. User Impact:** The commit message clearly states this fixes
internal microphone detection on a specific laptop model. Non-functional
audio hardware represents a significant user-facing issue that stable
trees are meant to address. **6. Code Quality:** The change also
includes a minor whitespace fix (replacing spaces with tab for
consistency), showing attention to code quality without introducing
functional changes. This commit perfectly matches the stable tree
criteria: it's a small, safe device ID addition that fixes a real user-
affecting hardware issue with minimal risk of regression.

 sound/soc/amd/yc/acp6x-mach.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 622df58a96942..9fdee74c28df2 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -311,6 +311,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83AS"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83HN"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -360,7 +367,7 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
 		}
 	},
-        {
+	{
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
-- 
2.39.5


