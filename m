Return-Path: <stable+bounces-92839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050AA9C61FC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 20:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1C41F25672
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB152194BD;
	Tue, 12 Nov 2024 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oGGe4eUj"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4F21894F
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441513; cv=fail; b=NkqRMOAbcuwJ31VPoHxzcDIVOnPRI6uU7RBbmyewZ1kjZ4PCJk/uPwPvBAhSwntIbBJ8tq1pBOilqBU71uu6+WBg8rz8W94j7ar735Vvth3UNUYijCXc9mifasliz3nsjRTGpfMFDbPlbH0OwzdYEUnUfnxydfU7YY6yF2L/Keo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441513; c=relaxed/simple;
	bh=GJDHcO86hkxzo3XPeEisBdVfcgs1uOFCFQnzCD1DQ9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4hKQDD7SbKlhEeLMDIzt0BiHiTkrH7UcQh4Vndil3M902WjG8xFYy9ht1IG878nWbKNjRz025rrapzP/hH+0w8EfCXkceYHI2iVb/6+BKNlLJaBExNjYdE9oA1DH8ki/G9W3ioGQxvtOfsX7PecqNRZ3fgh1gQKDj6xdMbs03Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oGGe4eUj; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJC/GWG8FGy149FNbAP/W+tfcfIKyU7urAw8Kh6AuN/EUUWPtY1BQnLnVNuR/rxqiLK+2pE3g5OYhhzwPbpoQCugS8CkLcnJNfhTiZjHBQFJY2IV5eJwGUHqVd6DGDeElTV9qUP1HBOBpDvG6E2FtrADjrTbAvfgGAafeA4ZA/G3HHLfG2KBh6/WZtGEK/D5F3Z3K03ObAvx5nH8qW+/Yd143rhscyC0CXmOkc/xbbX6d5I0df5RMljGWVQQffUUq8UmD/TpoD6HyUKDxbnNTVYGhEhdEM6trATQSQuUIsPGVMZGIkJMsPYl1/EP5IaKTpB/diaSVOdBqJW8XSzMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zMF16et07oC6MFd3i8t6/C+wAd7jb78K5qGKKf3cKs=;
 b=koJ+SHCdfi4p5OBE5DjI/iZq7XRoDPxgKdhGovxqsbDDlQZKLlQf9PyiKi8l2ype4tybAk0bH0+UeSp1U6DSH2g6QOIhIQsCL5/iYhHdoxZ8qQ9Csgs/ILZ80n6u6kYn787BULm5CR4Lo903nmZnMY+3FXIVVidZ+4oY5BEQXF3JZFtelWgfu8KUlLQnGUz/YEqyWdgEk1+zVbfYNZJLJmEWbkwHXkAeAKEda1fJHIdkhI2+PdkyHg7+ODb7lEcHkNrqvIboLDSc3DHmfjNgCGfG748WIfy5CSuQDlFGFoVa5Ha3ts+HdYqjJxF8UzSxU/EZ5BQRr3qPWVsV8PaMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zMF16et07oC6MFd3i8t6/C+wAd7jb78K5qGKKf3cKs=;
 b=oGGe4eUjwWpBvTW8HV55og6wj6liwdA49ZM/g8b9etRue4355bLQUAtyRFBGACPEXOmsBApXau7bzuButV+HSuNEboR6w948VvaKPOa78db5f1LmRD7dCmV/lf7pUWFb8uoJzvRIjvE0PDzELRUtVW6vYl6pc7lMK0WuhloqCEg=
Received: from MW4PR03CA0274.namprd03.prod.outlook.com (2603:10b6:303:b5::9)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 19:58:26 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::6c) by MW4PR03CA0274.outlook.office365.com
 (2603:10b6:303:b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:25 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:21 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>,
	<stable@vger.kernel.org>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 6/9] drm/amd/display: Populate Power Profile In Case of Early Return
Date: Tue, 12 Nov 2024 14:56:01 -0500
Message-ID: <20241112195752.127546-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 397c4b66-56b6-4997-8d05-08dd03545e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wLIK/qNXDFwpk/gUsl1ifqKDpAoOa4dqxHjbXGIu4izORcqIbKCnEOH8exbt?=
 =?us-ascii?Q?rwZT9hnNFmwEd3eQ0hStl+/JDEOiKff78tIfz1MqIksWdBiKA8Lx0rAEobC5?=
 =?us-ascii?Q?sLEpt2Kxzy7v0FpHtTv2XUQcTpWl/cwuZ0dFwBQkVrkGjQrJVpwCgt+h5C+d?=
 =?us-ascii?Q?GLmWRB+ACeiyRIkVlYeDhBDCk0oarMUBI3AwBG2w/ymAM8Ohn93lTI6VHdOg?=
 =?us-ascii?Q?SBsVM6jTQ9geFrinAL8vxu31Bm6BA1K+t2myQwDsRTz5s4rZO625QSupcECN?=
 =?us-ascii?Q?13yKprXFsVlpVqzEUone7VCm8tEUyU0cudPGXdVxLgjtneEjwRqkcoZBdmaZ?=
 =?us-ascii?Q?zs0/dp+llczsiMY6sPEL6eAdzOj4fULhPa4ZcruyyzTPJ2ooMdZMSV29YVwS?=
 =?us-ascii?Q?MvpYl8iKAaljmQ0ezQtCYATxnaMkFdlhVtROfoI+MMKqEi5NqDuD30dweK6Z?=
 =?us-ascii?Q?drd9/5mNMPlBw36BW7t0NBd7shfueKgHIlfxdX/6zFxVFePvk/tJhS5GPAbU?=
 =?us-ascii?Q?AX3Jf8hOwy8RM87grl4QqAMStUyu422xFaqRrk7xGYbKCSjVjcH1UfImSa24?=
 =?us-ascii?Q?vQQaEdL4FSWCvNcNIa3OiJjmg2lw6IpUIAMwcLlaOYFWUPZKaQzwbX8cjggs?=
 =?us-ascii?Q?6ZwNwdIs7TtZ6CJOTOjFT+VAITZnW+KdZK7wGfnHu8blVRSM/a1F9SDzQepx?=
 =?us-ascii?Q?733tPzSqWpBjKbRZ1m63GixkAzPfF8E1kS3JKak7IWB5Ai1ZJ3yuzpudHh3R?=
 =?us-ascii?Q?bFKCxMrz3GxSTvqi9vqtaQf59afNBnyymfwGTUBDJ9uNufE7YD/A7K6L4UUS?=
 =?us-ascii?Q?ALcjTLLzhqn4BD8356ScKprIUY+21oDQmsRk1y2nVgtPFcZjVB2fjn2rVuD/?=
 =?us-ascii?Q?pI8Z4txOital7RDdaTFibF1v7gcJRpjVIXCffeA0nHMFA4xSS3TSTFKnDAHD?=
 =?us-ascii?Q?QlEJu53nCAmE2Lvk8iR/1MAhjhLKo5RJW1rm1iBxj3ywRtcBuYELUUKD5uCX?=
 =?us-ascii?Q?kvm0YjyU4G13NSsUPkTcXJl4H2jSwtCFx2lBqTj2te4DIL6vz0ylDld5T4e0?=
 =?us-ascii?Q?ParvTO70ghvEJCbzlX0kr0GgfZmGMXUuFd3D58yuFoNJOW8Kzk5v68FGBqfC?=
 =?us-ascii?Q?DcrHsYS2/HEP/BHsEbnIf/rWc0FIQrvXWA197rdCd42BfyHEoZ/z+ra+9kbm?=
 =?us-ascii?Q?FHt9eE5pLHsfGz5/4NzJV9K3vlnmSl1aDs5/C29BRGaoMhEbEhwbvm6MPUUD?=
 =?us-ascii?Q?aMzS8oo9c4tyKmNYBuyIVMlCvS6BnA1GqbDXX3AKc9H7w63/L5AKTPn9X8iy?=
 =?us-ascii?Q?Fd/BlKBrYqf0ppMM004VpDlsL5pekuSLOC8BlswaGsgLY7+0IQS0Kt8nDTtP?=
 =?us-ascii?Q?fIXmNijb6H8W3iGmz4V1HZAaxQc3p41ietYzWTMpO/gXpG7kPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:25.2131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397c4b66-56b6-4997-8d05-08dd03545e81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

From: Austin Zheng <Austin.Zheng@amd.com>

Early return possible if context has no clk_mgr.
This will lead to an invalid power profile being returned
which looks identical to a profile with the lowest power level.
Add back logic that populated the power profile and overwrite
the value if needed.

Cc: stable@vger.kernel.org
Fixes: fc8c959496fa ("drm/amd/display: Update Interface to Check UCLK DPM")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0c1875d35a95..1dd26d5df6b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6100,11 +6100,11 @@ struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state
 {
 	struct dc_power_profile profile = { 0 };
 
-	if (!context || !context->clk_mgr || !context->clk_mgr->ctx || !context->clk_mgr->ctx->dc)
+	profile.power_level = !context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	if (!context->clk_mgr || !context->clk_mgr->ctx || !context->clk_mgr->ctx->dc)
 		return profile;
 	struct dc *dc = context->clk_mgr->ctx->dc;
 
-
 	if (dc->res_pool->funcs->get_power_profile)
 		profile.power_level = dc->res_pool->funcs->get_power_profile(context);
 	return profile;
-- 
2.46.1


