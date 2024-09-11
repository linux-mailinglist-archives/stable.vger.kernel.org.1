Return-Path: <stable+bounces-75859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4537975838
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8B61F22EB9
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C07E1AC440;
	Wed, 11 Sep 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iCT8xWw4"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA396224CC
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071789; cv=fail; b=H1q44sdNjziWrwfiXoNfDS3Ak512GlOkt3JeTIcmKbn/vS0KOQ29mcD3+vUoRGEwuCK4I/MDjeGnQPf3mNdRmAXxUh/JDgXqtzDDIUnee3SleWFoaEgxRcEAovImaX67CqpIARHhsFr99NNQao/ddECw/So0u64+nkSfJiV55/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071789; c=relaxed/simple;
	bh=XJhOtgSfGbfCRlDyDg4WCnMx3cHdFWh8z18q3/4pPG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sX74CXH0XQweeORh/GQNzvHD09uBLMh0m+LDDxSjIxPXH1QZurpufGokA/C45AXMTorzDlPf4uRm/SWq9ToZ/z7ENAAPjPLhrAIiMIWAzUlI7JoQ/A2lPe7320d5qgnAwG5fyFJtH20NlH3cvi5n6UotqT5ScpxiSuW7Np31+8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iCT8xWw4; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrhD1cFSa9Flh4J4yMtEIDHLDJISn204SUcPjT1L3mLk/QH37i4xRj1KhWn6tG6D+3PNftceTeADjDvfqWBKU01BlxpQPoyAFoNcndWSSKBCmpu09XeU7zYPhgcAzCoUW9Ik9+tB7RDz16CfaH6NOzS/xrNCtR5fubrxGxymD8UQ9Hb04e6OeUZV1LsXC9Cod3hOf/RmiPl2o+tD2MYP4oX4c3MKZq03njHmZ/ZOanYGE40fNAOrKOQ2OE2lTSj7JaY6X/3e1TM0SD81M0r9w33GxdjUSxbvsqnwLQXS9g4SFGczrrrWPdSLz5OADDFJmA3vINqK1TaU2sXJTlxGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkkS/uel3ELtSfbTtOm6DNwnWEIvaXmzpzUoWbRXMkA=;
 b=o4eAHRfNKG7EonjJIzmKlq6jaPOprIIR9A64FTZ9gTQ8GTF+4AUkJFmtlkT+0BoYBlpPh+IN2fQchxO1I7LLz/6Qr8DDcYqwk/vK5VCkh5OO/y9Jo653kubvrqraTo3D8gI+iAk6GndeHL+6E+//QoS8co8r5qQcZpz5cmuG4UzSIYCaAl9bwAe63lPX1DEw+g1AGRlFKlDthrNCx403Rw6VzI9qm8hBWl1+bN7g1t3gh/e280tN8A7KHcSIkZvSQz78iDkYfIMyOD4VOm+I/K9lpOIHErPPrOHzRf0JYrQgCPAd84uej2VrIA4FD7I/4iQNp+kAQIW+dQYD1t688w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkkS/uel3ELtSfbTtOm6DNwnWEIvaXmzpzUoWbRXMkA=;
 b=iCT8xWw4xCHJ/IarBnVGHKYLt+AIReadjQ6iEktsy2wUXCZzbvQ5l4gS7wv925pZIBYtyL4vAnZo8ScoF/WaXQPQkU9bPQA13K6d5SY7VQudr2R8WBSZJZXfwT1/0e1yTXW6FT3k0RmZ2X/ByWbmLmMxHKpDIRQq2F9Z+cSFj1E=
Received: from BN9PR03CA0904.namprd03.prod.outlook.com (2603:10b6:408:107::9)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 11 Sep
 2024 16:23:01 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::43) by BN9PR03CA0904.outlook.office365.com
 (2603:10b6:408:107::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:23:01 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:22:58 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Yihan Zhu <Yihan.Zhu@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Alex Hung <alex.hung@amd.com>
Subject: [PATCH 06/23] drm/amd/display: Enable DML2 override_det_buffer_size_kbytes
Date: Wed, 11 Sep 2024 10:20:48 -0600
Message-ID: <20240911162105.3567133-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ecd088-3722-4989-56b4-08dcd27e0188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pghBMdxzuI8aiK4W2tVZ3S5NPUcgkv7J907vk88sqqNPdiFD1OBJEtm0LSCt?=
 =?us-ascii?Q?vB6fSMUBZSPgPc/6dUuXUaaIpYDmfKW73zL9TlYdaPNYbMep24OLJYaIeOMh?=
 =?us-ascii?Q?qnt8/VNaDn8ec2hERXtL+yn79bkORU1qEr9jt9WCRUlonDWgn0H9Mrw3Lqyu?=
 =?us-ascii?Q?RCqw+R/XmpC9+cx1PRfU6KAJjpYuYYnniaGmqWXI78pLo0zB1sDSpKPIrNv7?=
 =?us-ascii?Q?tFuWNijOPOpJDp8JVBy6U9hBXB45YjCfy8lAsLJlZa5yAd7+3VTqpMASsmcO?=
 =?us-ascii?Q?pqI0Iy0RHRCHI/DOjruBKPi3jXM7lbaaYLXZoheaSe3A6y1hd5Bk5oWZl4oe?=
 =?us-ascii?Q?z0f2KC0TeWB68RzMjGLPQxePuWRXX2//8GumMivFApMDAE+olefmjnFEz2vo?=
 =?us-ascii?Q?yN0U9ZhiVJ8RngO+j2dUhFfKuU7VlvlA5QRZsosjAXUzSsl2cgpAEoDoWjM5?=
 =?us-ascii?Q?aSnsHWXPhUJALNaV7MRc7c0getOUi1IhjImXRimM7MOZ6MwUWA0+r/JfIecI?=
 =?us-ascii?Q?2ubqV3s+hngbEK4uG0zk85Sl99iwgKbuduVKMi+yUlIpdT+80nl4RtGcjgnD?=
 =?us-ascii?Q?EbGS4qskYx1hM81fzoBIsKCoLD5JL4jZLlfLqNffGOjJaG/qJaVKHvz0Q0c5?=
 =?us-ascii?Q?SL+BCUSYY4jbfu7yib60O9VIz52FEG0NA9LJAubkFAJOWD/zdnsw3F82urXY?=
 =?us-ascii?Q?NSDeMQSdMi5A70iSvLYu+JToVZ33atFGZrT6Rzqyrvw5KFYtXaDBxvqBvJR+?=
 =?us-ascii?Q?qrkSBhqPslWCkEmssIKJWxg8G42Tf4z99+lguiZxzURWoeH8cu2YQKclpfaf?=
 =?us-ascii?Q?J6BhODyjJHrBA72rXrfAD2SJJZStrjBQJPIYSZtiUa11hpbU/6C7yqSHnIeR?=
 =?us-ascii?Q?tpNJL8iiMClRcGoR4hQOhnAEMOCKPFhQjfH8ubK7KqgePztGrBErZjtZ1/C0?=
 =?us-ascii?Q?l4CEAzOT7xSwl5m9zWlMACUr3Ac+id6+n42nV5WYQ/C5AIdDOl+rTKl1iRz6?=
 =?us-ascii?Q?z/+D8Bzk+eX2KFGlB2RV61N4fgcr0bMaR+bwTDMohDniWfs+iHk1KTofl/ND?=
 =?us-ascii?Q?ov+LD9OvpF8Yf2IKzKwvm95ZLbABtHfUOWL00IuC+D1RKa7f7Wij/nxYfO38?=
 =?us-ascii?Q?VcxUpeo8Gfl03L0j8KBv53ZEB1dCvB8c/FtLD8/93bNa09qv0PO+koYPBFVU?=
 =?us-ascii?Q?458jyqvLX+g7Rd/eavV+qyAGSnBNUJ+TNy/tD63zF0TbrAw57C8APYriR5q+?=
 =?us-ascii?Q?EHnSJJtkLo8ymfLriu59y96wFQW5pGvamRIet3x4xtWfLdINvDaTzMzKUpJD?=
 =?us-ascii?Q?ipGPt7M7WCJdT4Uagc7A8u0xNnkv5NTm33TrfZzKqzVDoLBArxG6zZH679LX?=
 =?us-ascii?Q?BQhyvQI5TWLCJnb3ziAd3K6O9LhrTcGkQK4KWVC+XlJt7+GFi35SKH6N6aEb?=
 =?us-ascii?Q?LbJLwPNBaHUiaRJtG5Phhu4+xImF03sZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:23:01.2411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ecd088-3722-4989-56b4-08dcd27e0188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY]
Corrupted screen will be observed when 4k144 DP/HDMI display and
4k144 eDP are connected, changing eDP refresh rate from 60Hz to 144Hz.

[HOW]
override_det_buffer_size_kbytes should be true for DCN35/DCN351.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 46ad684fe192..893a9d9ee870 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -2155,6 +2155,7 @@ static bool dcn35_resource_construct(
 
 	dc->dml2_options.max_segments_per_hubp = 24;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
+	dc->dml2_options.override_det_buffer_size_kbytes = true;
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
 		dc->config.sdpif_request_limit_words_per_umc = 16;/*todo*/
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 4c5e722baa3a..514c6d56925d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -2133,6 +2133,7 @@ static bool dcn351_resource_construct(
 
 	dc->dml2_options.max_segments_per_hubp = 24;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
+	dc->dml2_options.override_det_buffer_size_kbytes = true;
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
 		dc->config.sdpif_request_limit_words_per_umc = 16;/*todo*/
-- 
2.34.1


