Return-Path: <stable+bounces-54747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C29910BFB
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B84B24507
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03F1B29A9;
	Thu, 20 Jun 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TmmVQBYL"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C81AB91B
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900329; cv=fail; b=KsEGTaH7x2AR7qp20i+EzBhFECA1AqFGZnYqMrVQcXwcFLCNBLj9wiv0d2gFAibMoZdd1J3vn/adOogjSio47xeu0j+iPaQMnlwGAtIZZl4LKTZfUSsl0r3Zw88FMpCo/EnR2TFFomNhUTt5P9iKUWShG5WFxKpEOhzzJlR+WSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900329; c=relaxed/simple;
	bh=W5U2miDTPK9zuaeZF+2MCCnci1gNfO2178qUxMDCuMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8Z3uZ711nAHyPwWLpCGRf1N3OKsEKCntp2wR2HX2Z+7HQfvFvGY9KyxQkeWf/u0+ApqGjMhQIVpMN0i8UjeENDRd2zFmUqZehbEizlqiMQDwlqZzXtWqbcsoQbRXCp7/bRs2YYfejm5dcZ6q2jnxEN5x/7XZRMUQG4Mb9mA1V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TmmVQBYL; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nztoaPjPUkOAgXaY27vbes7QRFcGS5rFmM2/o7xbNMcADzrJt4ciSjwHfIHNfy9dkYp7JN8LAuoRhQQqLSzcWUhoAc9cph8XUqU/aM+1OjjWTFCfA43NRiaxBUZtJFQYCEJvjJibEWimC8uQj/4GykckAxlEeSXGADAtHD2vkk64E7rmHNkNdYr6W+s+jLhsEgnKbZddW3ARKXYW+sZf7Xdi4xRzgywx677DX4xT2p+GyL1yWEDdgs1kr8O4ckDq8dlX9MFXUSzw2Yxgk2TIuXzBjUKAEtQnLv9U4tuGgW0AZ5HDj5/SnslsEJgbaz4I/wblKkqRvCFc0SnJzzi0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHK3cGMiD96PO8c6FXxfUJLByttcAFQprwHdajxPxVk=;
 b=cTBkPJd9IC2+sVoyju7rc8nub4/A77WiA9SRnq3YujrezAOsWuFMKcp5on45morJg6Eem+jw4/d86hWzt4IKabpCrej+VxAoS1L9l60Gs4oW5ZehjNZtYm5xrIWsl3aGRt8QUY388V4kw2aoTeX9mg6mdegVPwWbdQGaMljDCKjchOy76NJvVLp8F3Ak63hp8/TMXy8O+hCsJMmpEve2wnvEeE5qVjpEiKEIzWfTZPRP5e3NH2OMK2N8Qn5AtkpdtTBJ4V+O5YkmGSKYV8OlcYi9oiipzUMO6ljYCxzCmqjwccIVjuOAwUW9aj2sivkBPK7YNNOZ+2JSO4Uq4RB0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHK3cGMiD96PO8c6FXxfUJLByttcAFQprwHdajxPxVk=;
 b=TmmVQBYLNCv3E0hwUeOgKZHf8R6LZyooFC+/zRgGJxiIVxLJBFrAtAbs4jbLXoCySACsFJPe9+HNn07buwbH6/UB70rj47mM7guPBNKftec/hXgvchZ0EpP3Oc2m0ndEQrj05Gq62dV1lhGm2FdBzooTxYQao9258z6aUKZ15f4=
Received: from CH2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:610:51::36)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:18:42 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::9) by CH2PR15CA0026.outlook.office365.com
 (2603:10b6:610:51::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:18:42 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:18:32 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, "Sridevi
 Arvindekar" <sridevi.arvindekar@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 27/39] drm/amd/display: Fix cursor issues with ODMs and magnification
Date: Thu, 20 Jun 2024 10:11:33 -0600
Message-ID: <20240620161145.2489774-28-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cdd9e80-cda4-454a-e842-08dc9144a6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fhUHmYWk8MqOAUSpWFtPnbAAiVO7qt5G9vKM3eQjQb33fw/urFCCBZfKOHwJ?=
 =?us-ascii?Q?dGm9maxdH8uhCqt4MGnBiMy0YSxod7GzXcIUkMzQY22oW2RoKkp2JVyUz2uZ?=
 =?us-ascii?Q?Tf4/PLi5pMhAXkPbJXhnnAtY2stRSavb0Gwiqb17cr98pz7T1o5pkNKO9xjp?=
 =?us-ascii?Q?0rAY2dtjIzig3/Lg7RFPP5iCkTalnY0Cw6xSKwJO7we3WZyEZ08Cwv7TSRmV?=
 =?us-ascii?Q?20PATo0Yw+ekodAwO6AiqcW3pih6dlQbDaPWvGzXpu3u1e1T/9EzPTpgYG3r?=
 =?us-ascii?Q?HMgu2v92ytKQb+WL+fo5dPSyYGyfILFyzn3B7zMOCJGHbvnIderQys+1/ah4?=
 =?us-ascii?Q?E8ZD2XjrGBWNWMn5NL9X4bmLicEjhu63uV/3eftZEmuHi1sllayccmHCbnVm?=
 =?us-ascii?Q?xUUFhy7TcLjnnWsEk//Eom5EdZZNJP0PCoddM4Ee/uKgb6FkOXK6FV69/QxC?=
 =?us-ascii?Q?fGY7DcZNJrPwI6W3kAzfDSlbO77HO9uBaa6vZVJj51e61gQoEFlOoU6eVSdk?=
 =?us-ascii?Q?B5cDPhLxc7AX6W46E4039U5CEpgwld1ssHm2YhFpUHx4qpzD9eBGwjmodIAG?=
 =?us-ascii?Q?Me06u0Vd8pU8W7DGnkvBahgSQC8HyaHs8XvCpghlbiGD6OVwOW5zHapyo5uM?=
 =?us-ascii?Q?JDAgX9yuMiyUDP+s8KAqwmCJmGWPudkeWcyzzDVGpb6ZYsnCAKSiXcs7BfsU?=
 =?us-ascii?Q?JNjBF0tAQT7e5GKwbtN7wme8jl4Ywu31OQtaRsVYUc67I8jlAzkuGszldQUE?=
 =?us-ascii?Q?ILUMb7r30HfD/ykpX7mrMjpS/UquhuHNcIqjHZh1pZtYu1qsd4puc18KMZZ5?=
 =?us-ascii?Q?IRTmpCTl/LYHXTI4uSVB+bOG5Uig8y9IAIinv8gnr7+/foXHJ3tb8TNBVbqZ?=
 =?us-ascii?Q?FVa+oRk0yQYpP9JoXgPsVPWaufmdiIoj5U1U9kxtGrjDAOdsJG5BC8ybPeZs?=
 =?us-ascii?Q?sDVrE6SmjEFNk5ivco+fnqMH/ID8bb/X8qk5W+6Xmo0E1mY54GDJL30t+MXR?=
 =?us-ascii?Q?rauWcTmBWJjPf3MKd5W5cbjvkrETCy5mT8/UyZyuW5Hk62uk5Hk5KFcKMU+p?=
 =?us-ascii?Q?x2z68JFnqWXKni+wbYJqxaUZGR6DVtNFtuzQnEMjF7WBMxvYao2sFRfHYBz0?=
 =?us-ascii?Q?BeRKm05dcnRs28cWey6Hx1fsymO6JG39CwIse5CCg9OMjNxnm2Pe/df24Fgb?=
 =?us-ascii?Q?po6rY80rMkGXmBaRFGbPAWXXcIGfozlH48MIE6rK6QRNZ69LilwoR7Xn432V?=
 =?us-ascii?Q?3Yo6psvj3WJjlglPbYG3+J94IW7cNzIXccawOBJ2RDnCgpFTkSEMr/G1vtP+?=
 =?us-ascii?Q?Dn5Epsn26iqi52xO5COhIglrMLaipACmQj1XwsvfxDXoRPI0d6lwFDToMOAo?=
 =?us-ascii?Q?V397TgmuAXlqcz3OmHulbQrdKEiBPIf4V5FfQP4mSzwRTWjKjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:18:42.2522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdd9e80-cda4-454a-e842-08dc9144a6e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189

From: Nevenko Stupar <nevenko.stupar@amd.com>

[WHY & HOW]
Adjust hot spot positions between ODM slices when cursor
magnification is used.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 79a911e1a09a..5306c8c170c5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1177,6 +1177,15 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 
 	if (x_pos < 0) {
 		pos_cpy.x_hotspot -= x_pos;
+		if ((odm_combine_on) && (hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION)) {
+			if (hubp->curs_attr.width <= 128) {
+				pos_cpy.x_hotspot /= 2;
+				pos_cpy.x_hotspot += 1;
+			} else {
+				pos_cpy.x_hotspot /= 2;
+				pos_cpy.x_hotspot += 2;
+			}
+		}
 		x_pos = 0;
 	}
 
-- 
2.34.1


