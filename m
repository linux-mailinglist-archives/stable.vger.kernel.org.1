Return-Path: <stable+bounces-54743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD02910BDD
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F39A1F211EC
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CC219EEBC;
	Thu, 20 Jun 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a0+arEFf"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A51AC76D
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900250; cv=fail; b=lH72WU/cCwLa3eOsJb7PLPhLhcgsHsZEqv4qyrsg/L4x5u3EHUDaEgwywTZZDkKyxqnjFfRs1u/AlIBO/tPXCkJ7zRl4c3OJt8hGqII536RgNnxfNv20E79K2epRtCgfP2TV0iDS6AgsI2yU6X+AvNrLSps3emgchscie0uAHJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900250; c=relaxed/simple;
	bh=vOY8tesR5WjZzVHUCCCidC5h5MKI2vMr47qw8yySnIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbPh0xD2qM5YSr1h7YzvXeOY7+j57VthkkK6w2e+p8CSkurW16Mu1Hg8L832EBI1rejtqjuNWu/nj5kLJb+iQmlS37RIcGDpVxGiWz0uvlnRqnY+/sq+bXhi7156ZdvQdyZKf3uUt9VmVgwLDLeT0MPIckfnJ0808FdttSd0CW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a0+arEFf; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQcQQ6oddgbow/ydFQpCY0OqwL/663K26aSl5BtP6jjVlaVosT3p+ubdoMW99nbulWgRKN4SXJ2GALl9IwYc2U8oSk5KTEkZWPhLRkl9tDDlJCA1ILiAhcnBWa3Nv6ncMKwMPZ2/bS8ERlHk+SJlgHhj6B9tFiEA4jjo7AJIXBwytdTAKhfQIDebs23WqUEimsclb1l5AP04S/FI69y0KQcyOZop9ZcPGg+NNl0k/idoteDbqFK2//aZbVmiRDYo0Jq1uhEg0+S12maj4FMrQJarSIYLX3CHdBuy64JSH1jOeghWYKrwa52JhTT39muFjt/a2nEqC9l8/A0vaPIt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRyXEo/c6b6R0ftMjpLXfve6jlfTTnQTxHjNBCgIjpY=;
 b=dWbWoyVv5Epo/bhMwOcZaB656Pz/bjvU1CsL9oUNRzdbOmdV3vE91fdbJn/lBwlBWEU4FGuLwOsLZpYjMf+5SSqgMS9SyaMtFGpu5hr+a/Huk0XJfM+KXeaH2hoJB0vtAou3B+ysEgtx2UnNGJd4WAhrm7vDNzHE/5kHjUmk4+Flqr1oL1k0QOVao91GroAERzcJ7MCbxVV4TWG1RR+ATheqEd5bJraUOSNZ3XeExRYHhjMwbOQDVFdOlKoxHhB1S2pOrdS+nq4I0kxxbVRwbxNYXShPeYJR05tq8uSzJZvJ4OHkd0cjvCOARwXo2ObeykGnhpgmQVE3AznGJweatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRyXEo/c6b6R0ftMjpLXfve6jlfTTnQTxHjNBCgIjpY=;
 b=a0+arEFfYV84SVc2Ki4yf5CJ/wsYffm+R6R3+gii7IptapYFhY2ti45C6QUQg407gevEHeu+YzvaLrlXHkIuz6+YG8W1jhS2gwAjPZPMy5IWVyP/uj/Ci07+F0usWu8WzrLJ0zdcqvm8UdeJG/yHBC8YKyUhjT5yvj/wlEe+hhM=
Received: from CH0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:610:33::18)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:17:24 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::96) by CH0PR08CA0013.outlook.office365.com
 (2603:10b6:610:33::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:17:23 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:17:19 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Daniel Sa <daniel.sa@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 22/39] drm/amd/display: Fix reduced resolution and refresh rate
Date: Thu, 20 Jun 2024 10:11:28 -0600
Message-ID: <20240620161145.2489774-23-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 93143d4b-f81b-413f-2f0a-08dc9144780d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DqAD4vCKljp0CirjVKNGt6egN2PNSMe+z7kbTaZsVODwcgJfTNa98YHAnUJd?=
 =?us-ascii?Q?OIdMwquth7ddTCgCV4o9htQFna7avCXbU+cQ8sQC3f1lD2tDbjJo4tqPmFsa?=
 =?us-ascii?Q?nmSkiDfowtuvBOrTYaJluHdjDtAcO3QRfarapDA87vg/Z5HlKFvhWqPfSH0G?=
 =?us-ascii?Q?WlrhMSzsRrqxokVzSEKp5uzdSNNoMRvvwNMoWQFKnjGP0DJ2SjZegYVaGUDr?=
 =?us-ascii?Q?Bxrs+qNNPrBXzxGwku4SeDFNQgYa6qO+kIhShkOBgvHOofuBYqkjZ9BAhGxJ?=
 =?us-ascii?Q?pwBO1FzKl+SalapoMJVjzYLl0D0tK1j0LqOKxIjvdCssmYNNjuGfpNkBZiCn?=
 =?us-ascii?Q?QvGFNt1S4joTr5hpbKDRBUL9osRk8YjEuQ+xm5SmKBk//5zkkwmkZa/2k6yt?=
 =?us-ascii?Q?dHTyDC1N8zh9KFmqOa6U0eu/DcdYptvofJKNUMwFP7VEOkhGm3bnZme/xrOH?=
 =?us-ascii?Q?4/d/vUatprXSjILg5HEgnfDS6z8z8MAcysg+H5ylWbTxElNNk37O0QZY+war?=
 =?us-ascii?Q?y/ZFpnetrMIEw6WzhcNqKcG8Kkqd9bQR/l3FgqXyLYjCQ/3Q4IAwi3kOYzk+?=
 =?us-ascii?Q?X+lfWJ9QazuXEj1If8UUUFbEOJkDyr8ihgTTnri6ZXZbwxh4wltP5NjrnnC8?=
 =?us-ascii?Q?O4/wTZNZ/pMchKF9HrFnS8B4Fp2dedVQff2WoO9g6ncxjgyVLlVjtaCu54Q3?=
 =?us-ascii?Q?IPUFIV+mrKa/jVD6iI20j8uVQ+6XyYq574JAR6zBxkyTuLtYPr5d+HCn1XU5?=
 =?us-ascii?Q?YoohabH6hkgtxNaN7C3kUo5Dma8HDE3HejEOrfUyDFCbVhW5QiFb0cn4nmse?=
 =?us-ascii?Q?SwK8sSwJWdJnv2hAwzQrk6YKhE9uA7H7UHmps8d0gKkFeh2nKmYsDqsEOPdX?=
 =?us-ascii?Q?PGIWKlYtzF7PpfRIJtgTkAdmjkH6lbZlqjUQiMAaib5o72dBOboRGGaFk+h7?=
 =?us-ascii?Q?Zkya3HqPWj+HtMU0BGXKYH/LH9+fR977JKgQrORJQX9xl5m7zy1wY6PIjpnl?=
 =?us-ascii?Q?qYKAr3sxD/a2+DOYnZYQ05QqPnNwviyhx2qfK9ygneDsZOE06eKtJHLsdG/x?=
 =?us-ascii?Q?iJCTDPNqQC3rNH8Z7Hv/YpUjXBTHelQfhz+2pQr4uH7Mw2T0V3ChMI1aOTn2?=
 =?us-ascii?Q?N22C+8/H/i4GGBkOjE70mFZ3QAFsg3eNZHLr5bs6KZmV2RYg/jxj9dBVR+Ha?=
 =?us-ascii?Q?nfGKsWY4EcSBjcZI3+mhxmKVJFP267c98SPzjhc8021xERk2jjhy31G5vJtN?=
 =?us-ascii?Q?grW7HdLt2YILDaSBpVPIWLQC7FiKxp/Xog65gF505Fu2DRMfzpNAhlp5OXTr?=
 =?us-ascii?Q?fkleyIfI2eGpk7xv0vQfGzfORUix1neMdIJyAcLfnCW3N3e+9vQwVUWiFOFt?=
 =?us-ascii?Q?SSHw1UJqc+CpdidqtKWztGHwucVly2krUpNSW5nkTlPQa6D6wA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:17:23.6763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93143d4b-f81b-413f-2f0a-08dc9144780d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204

From: Daniel Sa <daniel.sa@amd.com>

[WHY]
Some monitors are forced to a lower resolution and refresh rate after
system restarts.

[HOW]
Some monitors may give invalid LTTPR information when queried such as
indicating they have one DP lane instead of 4. If given an invalid DPCD
version, skip over getting lttpr link rate and lane counts.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Daniel Sa <daniel.sa@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index f1cac74dd7f7..46bb7a855bc2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -409,9 +409,6 @@ static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
 	case LINK_RATE_HIGH3:
 		lttpr_max_link_rate = link->dpcd_caps.lttpr_caps.max_link_rate;
 		break;
-	default:
-		// Assume all LTTPRs support up to HBR3 to improve misbehaving sink interop
-		lttpr_max_link_rate = LINK_RATE_HIGH3;
 	}
 
 	if (link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR20)
@@ -2137,15 +2134,19 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
 	 */
 	if (dp_is_lttpr_present(link)) {
-		if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
-			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
-		lttpr_max_link_rate = get_lttpr_max_link_rate(link);
 
-		if (lttpr_max_link_rate < max_link_cap.link_rate)
-			max_link_cap.link_rate = lttpr_max_link_rate;
+		/* Some LTTPR devices do not report valid DPCD revisions, if so, do not take it's link cap into consideration. */
+		if (link->dpcd_caps.lttpr_caps.revision.raw >= DPCD_REV_14) {
+			if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
+				max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
+			lttpr_max_link_rate = get_lttpr_max_link_rate(link);
 
-		if (!link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR13_5)
-			is_uhbr13_5_supported = false;
+			if (lttpr_max_link_rate < max_link_cap.link_rate)
+				max_link_cap.link_rate = lttpr_max_link_rate;
+
+			if (!link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR13_5)
+				is_uhbr13_5_supported = false;
+		}
 
 		DC_LOG_HW_LINK_TRAINING("%s\n Training with LTTPR,  max_lane count %d max_link rate %d \n",
 						__func__,
-- 
2.34.1


