Return-Path: <stable+bounces-73228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B696D3E1
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564D01C2103B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73652198E7E;
	Thu,  5 Sep 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zyb63qEc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158F196446;
	Thu,  5 Sep 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529552; cv=none; b=oL/fHrPN78HX7FuhlH3j2tIOgS5FTddfwLUsLukputMtnhrTgB6y+H2GNa4zSUS/3g8V6hoM/ZkFSg3+dcU1LK/gzwxKEBHQYAiSD5PlVM6uINS6yIOIVDmSsJ2H81AcH02EHqnO7wB1tztrMduAcZz65LjJ1uFDyLIh+IoY3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529552; c=relaxed/simple;
	bh=CxjxhklMFD0L+71IihOZRtHrih0EWkPN1LVrDYMHOC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCCHfRi6mFySfA5bSzU9UWV5A7Dz/GDplMFH3/Z3O1A+YHwcMaphrgt1oEFP7pE6aitT4pCW8CFkvRwrduzOWnBQ41FNyihVmTKwGS/PrDLWVCSVFy3BSG8i01d3hAirDU6jCFBj2vDBeNGeDA/oLsyzyAAtYg0v88/viE/5T0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zyb63qEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BB1C4CEC3;
	Thu,  5 Sep 2024 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529552;
	bh=CxjxhklMFD0L+71IihOZRtHrih0EWkPN1LVrDYMHOC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zyb63qEc6UEcUj0l4Jv8AAwwO9xx1Cs+adKtwCkQ/y8pYps2NA99ZTThCvgOzO8mq
	 6InC12qivFxXVJWeHdGlyZlzAo0Ip57XaARh+w6RqFJ91WnMQD1uV3O19l+969TEDf
	 zlbffGmcSyEbDi/8E0ENafGD9hp63U/OsRY+Uhg4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 070/184] drm/amd/display: Fix Coverity INTERGER_OVERFLOW within construct_integrated_info
Date: Thu,  5 Sep 2024 11:39:43 +0200
Message-ID: <20240905093734.978430011@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index bc16db69a663..25fe1a124029 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2551,8 +2551,8 @@ static enum bp_result construct_integrated_info(
 
 	/* Sort voltage table from low to high*/
 	if (result == BP_RESULT_OK) {
-		uint32_t i;
-		uint32_t j;
+		int32_t i;
+		int32_t j;
 
 		for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
 			for (j = i; j > 0; --j) {
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 9fe0020bcb9c..c8c8587a059d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2920,8 +2920,11 @@ static enum bp_result construct_integrated_info(
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




