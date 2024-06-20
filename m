Return-Path: <stable+bounces-54744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4B910BE0
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76611C23CD4
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623581B14E9;
	Thu, 20 Jun 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZuKOWy1P"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C61B1420
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900278; cv=fail; b=Yxp6gn3njRhwWsJayaYZnOlJmgbHNjdXc+o+yukyzuQjMmRFU1+T/hs4TBSByOp0xOzQtQC5ZU1T4LBG+4Hu+aMGmqfrFyt4E84k42mMHq7+6C0nnK41sYd9rm+s7bECijI3kOBbFYKYxg+C/7B4LTqgMi3wZZTfm3cpE08LOMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900278; c=relaxed/simple;
	bh=VGMjk11WYmkSW9pPl5VqSjsCGXUUSLpOiQu0IL4f6Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYv8fkLYtwxKxYHrxF65aXFdjvBFC2PD5IRM6TdOJ4M1g92xVx9WblpgkYC5mgC/yaKHlmKbFHm3Ufw/xX6rALhml9CDnfsYJkvdxtwGJvPvpIPDZ/5KmpZ8OV/F5pC6krpXUDeQFFYEEEJfQCqzWYEtj6LW3DUxm/Jn1mKasC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZuKOWy1P; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f45b576Z2+kJToU/HHlDOpT2dYqLNKnYD4U6aDdpA4gtXxUlztjavzOaAXluyeo0KciOn7Bafz5IKVyjFTSZrVb9rWMJP3r/AQO9jfOqDS3tynhQwTbxCGDeNYFWHxNS0ujdDmg4LmPykQkcfu2Reu75Qy9tEitJv4VX3+HoN7sKh79UFhmcnzZl+4ybhr93LXd1MGNF886fepuOBlBDS1ubIZCanMisv2OSGyp4qbex3+Ls0CQWjcDeFX+PvrgWF42sf+FqO/ay7OXFPZsxWccD2A9eIiCPoXQ8c6s536iGCITZ/SwnR/v54O6bgMfvytct7NDM8nGi7aHm+j70yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JQ/3zv+jG7PN+CbBG4/SLSx0I74OLcJn0T/BHD5Vh8=;
 b=Y/jNMDQDxlXNslFy82Gl7htnBbFJY2X9Yaam6SYaRi3ydjRniUYmdrB0MWd9Ir176ctmfK1VkCGoI+RLakUeM8EHm7cFMJ+wYCo8N1pKDJYzNZa2ApphwnHp9i3SbsESFaDgPFdswyoFBLJP5XGO51VqwY+lVdfDLWrZlwa66ZW5EHjOm33CGZe2/c8DSVQclORb1oC70t3XxlfrfGgXG+/8hqRhd3nYiBnVNt0nUa1X06ZfxAPnYiA4vVc3cBuoi6vY9mB9wmHF0+bBBRWlFzLFtIigpEKlOtIZ3nmLy9trlBFFKQILv4pjSJIyqOv4+hADws7wrw/1vQfHNhPvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JQ/3zv+jG7PN+CbBG4/SLSx0I74OLcJn0T/BHD5Vh8=;
 b=ZuKOWy1PeOtGUw2Apm3b4Eo67YC7BhN6hl4fqjeTLq8bqqAOMVccwfjld4PSj+B9or4xy5ZTJX92tW/Gph82/trM756P1xbdJrsMIdHnnp0RC+FRgPviVL/wo4qeUddEReqxuy61ugXqq0hgGEZ57pPTdqiQcc2NMG82nSCgKpU=
Received: from CH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:610:32::17)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:17:51 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::e4) by CH0PR07CA0012.outlook.office365.com
 (2603:10b6:610:32::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:17:49 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:17:47 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Nevenko Stupar
	<nevenko.stupar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Alex Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex
 Hung <alex.hung@amd.com>
Subject: [PATCH 24/39] drm/amd/display: Program CURSOR_DST_X_OFFSET in viewport space
Date: Thu, 20 Jun 2024 10:11:30 -0600
Message-ID: <20240620161145.2489774-25-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3ddcf5-cef0-474e-95eb-08dc914487b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|376011|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jvg33CEzIZAP3iY7aKjk5+ftn0fHRvVQTfo5yOu3zBB1EO+JAUUse8xRIk6s?=
 =?us-ascii?Q?LR5VEZyDiGOqLSaMLn/krfnswFbEU40Nualw0pdBGSrd/9B2ZigH/1dbpucr?=
 =?us-ascii?Q?ruZe/0aVeoNJcBjeJ6KEqh2ysJOB0iBK2jhMlz1V5ntqpZKjSXKJNrGBnFZZ?=
 =?us-ascii?Q?Lnda8BqG+ESdQh1Zge/3mbyKYiiXXjs2pweDGymF0xO5+GV1Kp5VfPzvCDV3?=
 =?us-ascii?Q?o4AaOomJIqNREXGBeNCb6PKEFEUu42hdFufNLp9ipwE6u6vGkkvYQPzScxZ2?=
 =?us-ascii?Q?2hQxkMJe7ETEBZ9zv34RY1Ewe34zr7+1c8eZD0xj4kX6GFGz7XaW4IhbXaoX?=
 =?us-ascii?Q?hyBRG2liNdXnfL/uYql5we1sXFI8dycpXSG9ESrZ8SOjzRqlxcOklHBE2SDE?=
 =?us-ascii?Q?NICQGqWe2Wlv73kq4MZFwgeYDioZcbZnSK8SbU+Yw5n7R27zEzF+xZGjOCD6?=
 =?us-ascii?Q?PAjrYL4R2qrQOqucNFHbT+5WG8S2BvtkDmB2SGIFk2WyNSHYaWgZuFawPqsE?=
 =?us-ascii?Q?sqjxt/eevOIWzxBGV1qeVCP01cA2THj8PPUBMfA6aYGPbQdaaQP6YJSNHw5p?=
 =?us-ascii?Q?4F1x8LB9yLvsi5jtEwFLQVeTZss5YuPRsCi4Hdl/Qih/Y3EXuYIwulRVjM9I?=
 =?us-ascii?Q?70PVmP8/PNJd/tJWfCGj3fvLVolSrz/S+s7VajMsMgkotYP2dJEcZBKE2pf1?=
 =?us-ascii?Q?tLJk8GY4NqCSPQiupQ2hXEbNU/W3sZR6RTOv5aJONtqyeZrIbU4Ct9+qeSvL?=
 =?us-ascii?Q?qnL3r9HnJ6ldfa2NiXsrHdoXwdazMI9HtiYOHCRYwExVnOM30nKR7Z2Pw7cl?=
 =?us-ascii?Q?BcmCN5Yyq+Fq+L4ZLqjXTRL7/4aNgSktzSQ0SVfHhnrMWpnSPdat+BWWQDuM?=
 =?us-ascii?Q?kx+32xCe7j4JnQW/n2oS/Jot32fdrHgg44ElsZ08+MQ01MCQs2qfQQiL0BXY?=
 =?us-ascii?Q?BdumHj53Oh4chN//o6LxGcfN7OwlgsutSYEMRP+0xPciYPYFGpLncC9zZF3G?=
 =?us-ascii?Q?lmUKMtc9SYaaJM9WMrnFQZ3an0lGvTFuO5jrbWCICwv0Q8srIAx/yDSqp0ra?=
 =?us-ascii?Q?sFZmkV9YZsPkecZUMNHA/rs3odD8EfD0oLeogBh3/tMzs1/lT7Y7lHifsh35?=
 =?us-ascii?Q?hoCj4BU4Q0flNb9R54fzMpOYV7+X50qAvlZnLJw7wRNYslGowE4948VNpbvA?=
 =?us-ascii?Q?7mTlNk/c4DogOggWhA0zCw7biVrZ/mshz5HMZ0oB0io8NrPaTR/CaS0upHKa?=
 =?us-ascii?Q?vJ5Bt34w/KroI5hUfci7VQj6F0cuxDng9fQ7FwWx4NFZ7BISJENLkxoSar9G?=
 =?us-ascii?Q?YZnWCvYIdI0cS9CWftNDrtNj1Hga2xdv3cZWVx3I16tykjqPwkNfBKn8W8GS?=
 =?us-ascii?Q?MYWNMPCHHa93t0M3fxSXWTE9MplfOvMGuUCz2mOj3gFQQmMTbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(376011)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:17:49.9146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3ddcf5-cef0-474e-95eb-08dc914487b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240

From: Alvin Lee <alvin.lee2@amd.com>

[WHAT & HOW]
According to register specifications, the CURSOR_DST_X_OFFSET
is relative to the start of the data viewport, not RECOUT space.
In this case we must transform the cursor coordinates passed to
hubp401_cursor_set_position into viewport space to program this
register. This fixes an underflow issue that occurs in scaled
mode with low refresh rate.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index a893160ae775..3f9ca9b40949 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -656,7 +656,9 @@ void hubp401_cursor_set_position(
 	int y_pos = pos->y - param->recout.y;
 	int rec_x_offset = x_pos - pos->x_hotspot;
 	int rec_y_offset = y_pos - pos->y_hotspot;
-	uint32_t dst_x_offset;
+	int dst_x_offset;
+	int x_pos_viewport = x_pos * param->viewport.width / param->recout.width;
+	int x_hot_viewport = pos->x_hotspot * param->viewport.width / param->recout.width;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
 	hubp->curs_pos = *pos;
@@ -668,7 +670,13 @@ void hubp401_cursor_set_position(
 	if (hubp->curs_attr.address.quad_part == 0)
 		return;
 
-	dst_x_offset = (rec_x_offset >= 0) ? rec_x_offset : 0;
+	/* Translate the x position of the cursor from rect
+	 * space into viewport space. CURSOR_DST_X_OFFSET
+	 * is the offset relative to viewport start position.
+	 */
+	dst_x_offset = x_pos_viewport - x_hot_viewport *
+			(1 + hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION);
+	dst_x_offset = (dst_x_offset >= 0) ? dst_x_offset : 0;
 	dst_x_offset *= param->ref_clk_khz;
 	dst_x_offset /= param->pixel_clk_khz;
 
-- 
2.34.1


