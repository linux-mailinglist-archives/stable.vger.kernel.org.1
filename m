Return-Path: <stable+bounces-105519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A51B9F9C72
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 22:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2BF188F9DB
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C38198845;
	Fri, 20 Dec 2024 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lbHmj3ON"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20F1A0B0E
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731497; cv=fail; b=AcCFawEjT/Y8gR17ucHKRNgSvDu2zG836xLtHWeipVIjIRd+oieBaKcHFhGDSLGAvjPT7DW+IW89lWv4jx+/7vnaKMCNGTAZBgh2QWllT+te3iWJgcpViZ3nNIzcuVccJXZgz0/FozZayhdbo7RqZtDoDCL4lNPrwK7u3bc/3lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731497; c=relaxed/simple;
	bh=DVd4Ebwtvx945hWZHX68gEKBCLxy+LuXJgGCJvZBxJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InIyWYafSAuYwjLytMVlx58moRijd/nJc3ZBJyyT3ONDV5Y2goCxOlwRvhVuYmvI+z7EcRqYqsnr698eZA30yd5Fjw56aJHQGZhQYhZRn30b+SC9ZYTtAAkm7cB2qtzvmpr7hyDlb0cqov2MnyXjiYAMpvd1WFln1p0J4KJ1mY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lbHmj3ON; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAlGcncqrkT2fxvucVn1MHsD2UweRGenggD2MJ2zKFS+eCOMPHSO9PWsQcOXBp3zrcVF5QJtrpZW+NiMpdT94ZWVcZZ64tjAr7odTB0NhBq4AezuvEcRjJE9nG+BBmRn3X8jqJhd73OZ+JqNlQDqxXHafJJvjVykw+/PCTbRIj5ow7KDwz7Z9DzMH5K4wENJS7epGqonaaQbapOsP+dwKAboQiPbQ+NGwW4O0RiTXhTPV66hxNeG1Lb7oA1ZwkNbCRkwMN0kPHZoXiq/7XLtQfxYnuvQnH7wVrMrhGZwAb7E77tMLt8w+bQVPpv5XfKrTlDnlgQGhFIQJ3V9z/NU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr1pGatZNgxHcsC6g+ZnwAYGxaLWP6PM9vO4iQOoxLI=;
 b=cIZOEQ/aaMB8eAoMj9DLiL7Dp+7tTa/cqD0eKh2643NVVDQBLAMBSPDOo1oMyTDWV2RHWGXlbxm1L7mtAasYm4YuBPt+JxluqoO1Hd6UZXpCIyEv0nF9asR4ZL9YfCvxEUZH8hi1aANgkEbWBKZRS7TOODM6Ju6RkymCaA9ml5NOu1N2fyqYn+7CilSdqTzD31Ht6pPQU1tmHNR1pNpismMRs/JP7X4jG7uUrgkbeO4kO1fmsuWNHlWmT8gFiwkyj84tkW2p1HjhXS2iE7PjMNIs2TM/I9XApRb7KxXFuLCPJepe5cXxI6JG1aBrJk3dgr/D/DC2SXHuYcimhzTHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr1pGatZNgxHcsC6g+ZnwAYGxaLWP6PM9vO4iQOoxLI=;
 b=lbHmj3ONeQnN75XWTnkgRYMve8fktBVFc3kaK0Tl+coUVc1p8WMoxp/it/t0ArrDc2hBMGhKMR7tKnJ5lKA8t63lse68yifiP9QZE96k51gtB8hwr8UynrQMj2YJ87/w7sKcpOqReuEIs2C7doFRK8zgD3RIXdt+P6ORHAXBjtY=
Received: from BY5PR20CA0031.namprd20.prod.outlook.com (2603:10b6:a03:1f4::44)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 21:51:28 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::43) by BY5PR20CA0031.outlook.office365.com
 (2603:10b6:a03:1f4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Fri,
 20 Dec 2024 21:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:27 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:22 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
	<jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Roman Li
	<Roman.Li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	<stable@vger.kernel.org>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 24/28] drm/amd/display: Add check for granularity in dml ceil/floor helpers
Date: Fri, 20 Dec 2024 16:48:51 -0500
Message-ID: <20241220214855.2608618-25-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: f96741b5-98d8-4be1-bfdd-08dd2140755f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SkIizLGIXG3TDwzjCojt7dR8FqE64UIGethggdrIHLREzjfLWVrdqELMMNVf?=
 =?us-ascii?Q?25joPl0LxROCAEGOwd9KZgtfD3Z5WsEWdjTCV1HXp3h41V+9aPowoubd0urN?=
 =?us-ascii?Q?3awGJxMH2EB5OqIM4FhqCoqWNcRTxalvKLkMDVQbnR4WKtgJ09KR+w/OjwBE?=
 =?us-ascii?Q?ZA76kpcHgEUhWcPWXbEfsQwG3UhQvVZkuHBIjqJWvOppH1y2eAlQcE3XT0NP?=
 =?us-ascii?Q?5aRyFC6IEiPgg4EBLSQl29Tga2FRmIyoZ1ijK1qZEyiQKIS3U3zZnliZi+6e?=
 =?us-ascii?Q?QJnlz4wykdAJYw1Y3zPwf8IhHXUDMq/Zrtroop6u7JstmLwHPPVPv2EbSgFH?=
 =?us-ascii?Q?ODQfD7Hy51SoLh/kiKF6ZBMWvSV5pGvptGQMkXW7zNcqpG14klFz0KnCfvzO?=
 =?us-ascii?Q?o76ufkPYNtr/iFUWjyYc1cWBLfJ4CTvF5qxAj+GBWRzhE53aCi9sVDq0nLcI?=
 =?us-ascii?Q?nxmpfqYSgRq1o9CbQz9FwHNe+eLx+rTgv3xtp5+0FcxFZhPB8MH+VqPXBag8?=
 =?us-ascii?Q?zyEcwVAjnWEUj4V17+X3QqVZqGbjdhE57DwBSKEAbxkU5yfaDcWMtyHUFx13?=
 =?us-ascii?Q?4e9E3GZv9XyUNVUwuRBnc7MDckzX8F9nOO2VCubpDFM/uYeVOx/d9C8zDiyu?=
 =?us-ascii?Q?8aXOBkb7Rb7v6xQNKE2s8+9FKRbgZCXyNuW+QYBoqtEKC+0lzIIIfUZKPTPT?=
 =?us-ascii?Q?sOblbr1pgkzZ3jBRZyswjSMyRJAmioaORD3OR0nIojaY9bJbIhVMw4v6MP1U?=
 =?us-ascii?Q?uTEjzRfW7v6f0CG0ktnUxS50CE0bFzL5np9c6/qs1ArA2gECawE1GcwNQOR9?=
 =?us-ascii?Q?ZMeMUIBSfNPzhLkhakLXB/qIpqfoinbCtrLTTsYSFpRXymDbOH9ALOEOVo0m?=
 =?us-ascii?Q?WELMGEiQsB9orjX8x5XgJ0lvHs6Yy61d/qDPJsJaLmrIFcP/2+UvyzWZDNpN?=
 =?us-ascii?Q?FhLWQCKC4K/oj6r21JBXv9WcHDcE7NxPq1Ipcs7URcauneSn65+LnHLOYm/L?=
 =?us-ascii?Q?8YA0MZCqiZzYGyhCIdjQVk2TM6yj7GkCt7vRkcXKnQRLl0By0mm8ofPiDK41?=
 =?us-ascii?Q?eddnFuRuVWCqBkZRq5qUIzPiK+nzDDMiotWGRKhL2uh5PhZtxtrbPPvzezYV?=
 =?us-ascii?Q?eIbr/8qihi3BxlaolF8SoubRnEAaxysIzQYot2PH1BcgCzndRVApJkU2UVFM?=
 =?us-ascii?Q?4aONoGLoXADhTPkAI9jlVuWSieXIOXqRCaFnkF+uKEqooAS5pNQd9ERmheJX?=
 =?us-ascii?Q?GXy3nG7A1n8bpRhEzhSJeYhe9xvCtq1O9YCXsZRzMHIOYIudpPtM05RPXIjN?=
 =?us-ascii?Q?mbpj9bIXB+U5lTdywiQy/FzVM8Ijg7CuwO2FPe7ni99KpN82nw9OaB8hxK8E?=
 =?us-ascii?Q?vQntwEOiqgQEoTHHOZkrQtzB2n1VmS9scxztBtZGIACN5SdHBTYYwaqf+2di?=
 =?us-ascii?Q?SrlN7YCBtoaTvtXYJHgHMwAAVpT3skY7PTw0VhYDPuqkIyuItdi+VkFo4i5w?=
 =?us-ascii?Q?yOq79CSu4hwYRoA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:28.5748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96741b5-98d8-4be1-bfdd-08dd2140755f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284

From: Roman Li <Roman.Li@amd.com>

[Why]
Wrapper functions for dcn_bw_ceil2() and dcn_bw_floor2()
should check for granularity is non zero to avoid assert and
divide-by-zero error in dcn_bw_ functions.

[How]
Add check for granularity 0.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index 072bd0539605..6b2ab4ec2b5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -66,11 +66,15 @@ static inline double dml_max5(double a, double b, double c, double d, double e)
 
 static inline double dml_ceil(double a, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_ceil2(a, granularity);
 }
 
 static inline double dml_floor(double a, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_floor2(a, granularity);
 }
 
@@ -114,11 +118,15 @@ static inline double dml_ceil_2(double f)
 
 static inline double dml_ceil_ex(double x, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_ceil2(x, granularity);
 }
 
 static inline double dml_floor_ex(double x, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_floor2(x, granularity);
 }
 
-- 
2.34.1


