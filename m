Return-Path: <stable+bounces-64961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DE4943D07
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961791F2331C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407AB153810;
	Thu,  1 Aug 2024 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBxMNsHz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F109E13D8B2;
	Thu,  1 Aug 2024 00:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471748; cv=none; b=h4Dcg/EiicwvUReOV5j9xdRyn+S2rBEslIhWktjmWgq8Q36E6ST9Wj3RS5qH3HmUut5ILuyNKArUjs8DJkPzWAtt19fFkGvdx3hK0+bM3XTSNIBOCm8GgKnq/pgw1iTNFWZkQyuYvCWYndN2zQG788KtPP41BUnJe3QtjQgfhVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471748; c=relaxed/simple;
	bh=n6G4/s2vu+UI7B7Vk5JFAkc+wuBp7+gbufQIhDUGLd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOIRIoK6TZqyTvzBi1XPjUOKChmvigwtTJIZFIeyEKTnGA8kg81DqjetAdQykIjkzPxvnmz8YzWZoHl3sX+6Sd8f7jdYGyC/aDKG807xuc6hwXoi7PoIFXPOsekukeJDHdaeVSQWLbhLXTJ8Fpi7dow5WsNUvBFWH4seucqURpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBxMNsHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A921C116B1;
	Thu,  1 Aug 2024 00:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471747;
	bh=n6G4/s2vu+UI7B7Vk5JFAkc+wuBp7+gbufQIhDUGLd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBxMNsHzeodEz7Ka3kMa9xn2ZsmHBVhapx6g9B+cvxGpfLv3fmcbV9es7XIJ3jQjy
	 FInDB0FHFVgmWs09drsJDignBH2OLdHXq4Rxg/X/tKv7IKEIWivVaw9CYkFKkVk+Ze
	 uai7WsL3BfFkUovwwGktdqONlVPEDbipYW85kdHlFEPahmrUOGI52aHBC0pFZalOW6
	 1xVBXerXdlyljKzNibngLvCgrARro74yrmb/c1fF+WIimQxNrbcYpSIxl8VkXbBsbs
	 SMX9I+uojtQm+w93KSQ5xqEep5UPTIB7wydWZzE9h8Oxv+NJuW+mOZc3KGjdfZWoeg
	 szKbQEraFbwSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hamza.mahfooz@amd.com,
	dillon.varone@amd.com,
	ruanjinjie@huawei.com,
	aurabindo.pillai@amd.com,
	wayne.lin@amd.com,
	samson.tam@amd.com,
	alvin.lee2@amd.com,
	sohaib.nadeem@amd.com,
	charlene.liu@amd.com,
	gabe.teeger@amd.com,
	sunran001@208suo.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 15/83] drm/amd/display: Fix Coverity INTERGER_OVERFLOW within construct_integrated_info
Date: Wed, 31 Jul 2024 20:17:30 -0400
Message-ID: <20240801002107.3934037-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 176abbcc71952e23009a6ed194fd203b99646884 ]

[Why]
For substrcation, coverity reports integer overflow
warning message when variable type is uint32_t.

[How]
Change varaible type to int32_t.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 6b31904475815..19cd1bd844df9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2552,8 +2552,8 @@ static enum bp_result construct_integrated_info(
 
 	/* Sort voltage table from low to high*/
 	if (result == BP_RESULT_OK) {
-		uint32_t i;
-		uint32_t j;
+		int32_t i;
+		int32_t j;
 
 		for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
 			for (j = i; j > 0; --j) {
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 93720cf069d7c..384ddb28e6f6d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2935,8 +2935,11 @@ static enum bp_result construct_integrated_info(
 	struct atom_common_table_header *header;
 	struct atom_data_revision revision;
 
-	uint32_t i;
-	uint32_t j;
+	int32_t i;
+	int32_t j;
+
+	if (!info)
+		return result;
 
 	if (info && DATA_TABLES(integratedsysteminfo)) {
 		header = GET_IMAGE(struct atom_common_table_header,
-- 
2.43.0


