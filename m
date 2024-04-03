Return-Path: <stable+bounces-35870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4096E89793C
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 21:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A78B23AF9
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFD4152DF5;
	Wed,  3 Apr 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4btw5P4v"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81582155394
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173900; cv=fail; b=qHSdwBC8M7j0vcTdtWI1x4VP9y1AHNZEy7pYJN2/kpr/6EOiCY/km/faq29zJuZ6k1qqAn8KQasbDLR6HNYxoxyzv+co8+NTTusmKwKTUwoPXqJ8YmtSJVhuy+MTG+XeHSk+7TEAniQrUhLDmW6VARuOiqJcp325xqun5tVrQO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173900; c=relaxed/simple;
	bh=PpXiRcVVznLNwOMAAod3vjkt075u0oIhjVeJASXImq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXW5LVaN/E4JmGSkdVCDtX5BnMc8U+AR/jLr7UQmNm74IJ4NFj+pdDvTnxYUcq79gWrTwy0cjD4uwEEV5tcgoItpy/0uwcb2kB5/2gNeXJ7YDgrzR652JUM0GVtMWC7QJMx2/OOs1eMlH8ZESkQAC4eNZZfwXvh89zvt8jpxSNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4btw5P4v; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJHKGEw3aN5n0wJSH3aA4iHduVI4aguQ1ansJR/60ySy/bqN4KrBDWJRrzl/qS8X02pocR+/mu7wPw/oQtuXKQQodwBO0Z0dC7d2DhtKfB7kxnrLf2FnGGKpUbWLjROzMs14AeUf6X6WEY0C9wBibW8rwvV2kcJQWxtiAEur2uGtzP+znverDyx9wwPx5tT/kxZ/3PVurkwMtY0SCR+hgEzxQOcCxqvINnDlI7+w5sJOUWwW0qru1hzkLSQN5c84M1uKikKBFipEptxP8YtILqnlclXcwkIq/LxZ2KGYFynhhhB7l+aDA1Zw2mXbxjWADaGweBAQqD9namlaF5lXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bob/Y63bRKnf6cH0Rki/7qcEfQcHSItR7F8C02D0Zdk=;
 b=FBEQUBFDzDMz4c0Jow7VlrhTV40RWEcrL36k2blBKV5HdvMErZpInnQCeUeFQXcxW+wKNO8YkNi8irjGWSlCxc8OXO7NEBS60Fhye4e3caXWl2cGxjr4ePLs3xg8GHl0r5OgbU/QEQ0e2Bc92+vkFK7DkvDBa/mrKnK3lALhOb5v+505Rs7tUzqmUm67Huv3sWF2Yy36kMMS4y4za+YHcH1uHT1OGLIT2+tglNFt/CSDFbmBrRjmGxDbR3FILsglvwkNPjh0qIhI6qJh9q6TR0rlNvybzYltzEvwqdjiHWleqm4w6vm7pi34GpCIaeRVLFFdjBtp5jVFh5N+JfcyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bob/Y63bRKnf6cH0Rki/7qcEfQcHSItR7F8C02D0Zdk=;
 b=4btw5P4vA5dvcMQbmpCsooTldKIhgoViQNcdjJbdKSmdoaOxhoUpOHa/lJjIURzIHJ9c7Ly8TXAZ2XjIU2eqlI2KSSX6wd1zdiE9q7lWCRR3H14edf2TJk6EIRMMAg3ZqhXuJ5fxC/h5XPWKjrPLud+NhHiVJoGG0TRapYS/MfM=
Received: from CH0PR04CA0080.namprd04.prod.outlook.com (2603:10b6:610:74::25)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:35 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::76) by CH0PR04CA0080.outlook.office365.com
 (2603:10b6:610:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:35 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:33 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, <stable@vger.kernel.org>, Alvin Lee
	<alvin.lee2@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 04/28] drm/amd/display: fix an incorrect ODM policy assigned for subvp
Date: Wed, 3 Apr 2024 15:48:54 -0400
Message-ID: <20240403195116.25221-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 44346ffb-93a6-4bba-85b5-08dc541777f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/4/tmByjM0CNA4EPDa/Edrzla8FhxiE4KSJ0tZhR/cHWVOBJfnr1YfqoSsZ3sr8foZHywM1x7qIRcH3UNigGDkv463FNsz+qYXtCGePMU6zQ32jJ1KMfaed3OaCifQQHGKHL2fSozBXAQWZd/0BUeIMfRXQ8q4ktlyyW0LkPPRhT/+lcK1gYJvNfD5xo3UCY3Kdoujjh/mGh/6rKqlZYNE8/twTmuv650s02bK1OcrXU49k/zh+dFk1A632wjDHDbS3/ZL9oFjMI2xZ1umPkwAvGejppgESmkHDcUXezmP45SQZXc1Rcj515fiaU6MTm77CvjF5/zCqek2o9xmRozvFt87QCQzpeLgY88oleDvIjRREy3spE57tScujhtOe8iuLdWXB9wEsowdZ/GkcFJBSSmmpa63wnKung5krMWaY6euRsVEs8jntgswwxZU9aIqP6RdxnGi6hqRHcoJXa8+boH97SOP7vDzQZTkA2St85ht8ymYymsYyjScAqYzK2ZmlXSyRMHHQYuIip95Mi2b6miDUDTyoBgcEsWGjUHUy8Jk8gM7r9gzUa8bFSBuSSzOZc0sw/lpWpNrEBZuNzfITXUftXfErJ8RDM+tdfcVJyc7S69LQeeW/iQ5MJBLregAUj+b93TPTHldz0rK4H0o8i9f8SEjTdx73yzPIBd2SttT+2bKcoxjnRasQy1t/6ovEJTfZSiNCR81XjBsv6rKZW4vOuRqVKbGoGM0+1K8nOTm7eGSS+Q6rrn/49OP9G
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:35.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44346ffb-93a6-4bba-85b5-08dc541777f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When Subvp pipe's index is smaller than main pipe's index, the main
pipe's ODM policy is not yet assigned. If we assign subvp pipe's ODM
policy based on main pipe, we will assign uninitialized ODM policy.

[how]
Instead of copying main pipe's policy we copy the main pipe ODM policy
logic. So it doesn't matter whether if main pipe's ODM policy is set,
phantom pipe will always have the same policy because it running the
same calcualtion to derive ODM policy.

Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../dc/resource/dcn32/dcn32_resource.c        | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index e2bff9b9d55a..9aa39bd25be9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1824,6 +1824,7 @@ int dcn32_populate_dml_pipes_from_context(
 	int num_subvp_main = 0;
 	int num_subvp_phantom = 0;
 	int num_subvp_none = 0;
+	int odm_slice_count;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
@@ -1852,7 +1853,7 @@ int dcn32_populate_dml_pipes_from_context(
 			mall_type = dc_state_get_pipe_subvp_type(context, pipe);
 			if (mall_type == SUBVP_MAIN) {
 				if (resource_is_pipe_type(pipe, OTG_MASTER))
-					subvp_main_pipe_index = pipe_cnt;
+					subvp_main_pipe_index = i;
 			}
 			pipe_cnt++;
 		}
@@ -1878,22 +1879,23 @@ int dcn32_populate_dml_pipes_from_context(
 			mall_type = dc_state_get_pipe_subvp_type(context, pipe);
 			if (single_display_subvp && (mall_type == SUBVP_PHANTOM)) {
 				if (subvp_main_pipe_index < 0) {
+					odm_slice_count = -1;
 					ASSERT(0);
 				} else {
-					pipes[pipe_cnt].pipe.dest.odm_combine_policy =
-						pipes[subvp_main_pipe_index].pipe.dest.odm_combine_policy;
+					odm_slice_count = resource_get_odm_slice_count(&res_ctx->pipe_ctx[subvp_main_pipe_index]);
 				}
 			} else {
-				switch (resource_get_odm_slice_count(pipe)) {
-				case 2:
-					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
-					break;
-				case 4:
-					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_4to1;
-					break;
-				default:
-					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-				}
+				odm_slice_count = resource_get_odm_slice_count(pipe);
+			}
+			switch (odm_slice_count) {
+			case 2:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+				break;
+			case 4:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_4to1;
+				break;
+			default:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
 			}
 		} else {
 			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-- 
2.44.0


