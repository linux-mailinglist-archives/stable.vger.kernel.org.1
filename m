Return-Path: <stable+bounces-177768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE888B44634
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 21:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572CC3B5A8D
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D1A267733;
	Thu,  4 Sep 2025 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ECTWwvYp"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F54D599
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013265; cv=fail; b=MY1BOydLvuZxhKobmXpfV+fAEAMG+gSBl1o6SxncBAy3+jq+Q5V0vsTyYe7e7Sf4e6iHoGCi54bJAdTorcwtdeSQXqFpRugCKA/C/NwEviTaVfM7a/FBwJKdN7zDd9e9PtuxQJ5Jo3H+wq1p9mK47uPJc+l2NZBkZN99unL8APw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013265; c=relaxed/simple;
	bh=GuwM1uy2BqfkmZCO+qxHxGMx2pBck1zx/EqMvRR9LxA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E22MM1cj6XaA12qOegr7kw2CzLiH9V1m90+eA4wvykgAfFVkIbsWxpSaPc0n87qz9WoXcjoR5LiQzwapmpaGFNAT4R7FfhdXsyKIq1JKqhokpI9CYtHeKR0tTW2gLhYzGiA+zhdaVuUnzzbM4U99TNyFVtmkKKzr+FWJk8B7tMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ECTWwvYp; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPSGBHqgCCJShPwziuJaoy1PsFk8eJxmBg74VL8U8u/RhGsOqYOA8ivYZ8eoA93IVYUtaF+UgldIWBegPDstZWqd1WTfe1nfcBickwGMtTZKXUq/BFkd44cGY/VffBBUfp+HtQSGQujQiupWkrWfdo9jCrVrq4vPrtY6esGspDPkjTzMg7GXK0HGeqw36eeDGo7R55CSAIpkM0LPICv0zLZbsqTbIFC8k+MvvmQFR6Jrdrok4C3MTsXLLhxTDbm7jb/YT2ozUYAY6aED0akYUVDryIV2F55baWwect1mXi/wbCkjEhi+nTpQqRR07k8MdXdhG9MGH2su5i5KxtnCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buw4N9CvC+iDIBCW/RdQL28PsMaZ8apu193wFu3O7UQ=;
 b=mFxYHuAG6Zdx88LAWMRVDOvkeiEB8LTqgxHrricTR4LZkD/BJXo9CQxfGxk1ZtaEpceC4LOiXVo8eFfOO7CqvpecAGJg6Bso8U49ZyFvxA6jCKkkzbtQMYNgxD/MVoIGtrxy6+Jpgr2vBFnG2x5j9Omsbe1wrE2pcL4svPesUmLieyneVj/yF0qa9f8AlES3whzJgcsp3H8e+Q0rWEI9cCaj6Cj9CjAkgMBYaOK/NGzsAnQ7OLM4en3hjNmexNs9xF8W4U+r7tz3pAlCOaNfKYeJG9ouTBBTJjsK/cmde3niZMNmHROvFhEN0wuRr3RZGjchiMvLvSD6yj+gNAY7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buw4N9CvC+iDIBCW/RdQL28PsMaZ8apu193wFu3O7UQ=;
 b=ECTWwvYp7lQP+YTm0No6xcWqG0T6eTKAf8OOl/qQT+Q/LkxzFepeAuNSrkD+kGz2AUgU3VoPlKn8137mLjvS9BtJA8amlfWC9SsOJcC0npAdqC/A/JExWkRgiEGlMJLeFVP8S6ZnOG2SiJHzDmt4Edp1u9/J4L6JRUYLDXFK6Lw=
Received: from BYAPR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:c0::45)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 19:14:10 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::cb) by BYAPR05CA0032.outlook.office365.com
 (2603:10b6:a03:c0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.7 via Frontend Transport; Thu, 4
 Sep 2025 19:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 19:14:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 14:14:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 14:14:04 -0500
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 4 Sep 2025 14:14:04 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mario.limonciello@amd.com>,
	<wayne.lin@amd.com>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>, <stable@vger.kernel.org>, Imre Deak
	<imre.deak@intel.com>
Subject: [PATCH] drm/amd/display: Disable DPCD Probe Quirk
Date: Thu, 4 Sep 2025 15:13:51 -0400
Message-ID: <20250904191351.746707-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9608e66f-4455-45c0-3c96-08ddebe739fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zJi3hYIDJrvd+1hhOzDFBN+GdJFHKVTJx+4g8ZMQQK/k6OhOjY9nmQHaYw0t?=
 =?us-ascii?Q?eAvHDXuGpmY+GTsBoYlWuQFDqmDZBskHrJZgKbi65EZcYlwtmmFKPWBrris1?=
 =?us-ascii?Q?plRTx6rM7ekhSLbJ9KWFx6VGZzUAjAOcisSvWNq2Xg0EYRN8noSkN01YHQV8?=
 =?us-ascii?Q?00VYxAkm9W1yF199pELvh1ZFvHnKqAl/jUUyVnXyTaUXVH9j9AI0WnZobXXC?=
 =?us-ascii?Q?YlSB4sertywil0Jcdn3fOZxBDfSplUSORW6SKFA/SVj0BOqyYuVVXsEFo+Ty?=
 =?us-ascii?Q?m742Yf3vGrBTuip2yTUpDm7zhjMKQQvzxxoXGtY+kMxykSEtB2PWsnPYmjW7?=
 =?us-ascii?Q?cDLoUPnc6Ib5JMnOPQoDOx9d2vUaDWmAWfoKv+djdHKsnmtTNeN7HiTso3vH?=
 =?us-ascii?Q?9kEaR/gzjzyQJLPfbTatMQA32WThPbzOe1TVW6AwwSvPfNuO7DFR4QXcdhAc?=
 =?us-ascii?Q?4sHhKOnpv+NvRN4fhNckbmzedm4Sufl6aseLa9T2bRgSeDSIU866zkBNAZ0o?=
 =?us-ascii?Q?VrHShnn7in/CVl9Aa/KDazU4duERJCbhgTefZKEj0DoeKemjZcAfVgIdMnsV?=
 =?us-ascii?Q?t6xqogFJZH8RpyyecpyiCoPpgOpgAWrBpPo4CmV0s9FBiJang+Z7/kcXQWz/?=
 =?us-ascii?Q?iR6TXGqETUTSxBZHnUigOCz79JakALNSbQ9esfWDm4jKNkazQI5Ljk9d6h1Y?=
 =?us-ascii?Q?eZqZKm0M/RPD+v/B08dzmU/jb6d2RrLD68m2S4O37JV3VRDyoYFP8SiVb4dP?=
 =?us-ascii?Q?IZlY/26isuVI0k3l0vocwIoTq8t9qh7ItVNeorXkY4FUluGnpKCQnzGS8SWm?=
 =?us-ascii?Q?lg2neKDqaZZrCtPoILP068MbiDaO7/8QJ/CYc2N5ro5n9DOqGqR4jTYGmmK9?=
 =?us-ascii?Q?WQAfBSVPHQh3hVnoZEeCMGBnwHU7seRE8ljoae8WFCqcVn8bhVW9xrb4mzEX?=
 =?us-ascii?Q?f4GBoe7wQkuwwuq7AVyMaUNsLLe1K4RRKcF+z52RQOzf+1g5UhuJd2OUc05t?=
 =?us-ascii?Q?utClO2dlCNAMMGotCrgVDFW3hrav38jg1oikr1tUacVHTMOOENDg728KuLn6?=
 =?us-ascii?Q?IwJyYapIGOgt4wh7N3oK8I0U3le87M8/S931nU71r91R5gjUifqIjlr6IAM5?=
 =?us-ascii?Q?nIVKNZz34NAFofuSX6WTP7Vsh07YoZJ26aJMEgXULeSJ1FrkrJOUWJIaBrS9?=
 =?us-ascii?Q?mz88MpR7sPT75ACGqOXATVzAltWkOVhAIczSTkSMlhTzeWR9CXmKWde0BFJF?=
 =?us-ascii?Q?7Tert0jYiAFno7AksKij4zj3QWr2NAoy5ksEX7IWgm+547UHxwRyOPQABKWn?=
 =?us-ascii?Q?PJwOYC+8IaADjeg0g+7hiLd1DwU23sSsHKd5rrtCWM4Lj+ah38e21LEms+/G?=
 =?us-ascii?Q?LQEW+MnlLIvlYknyi0KKImqPz/fKEtps82dh1zvY+cMizdr49Ztr65rLCrJF?=
 =?us-ascii?Q?ikG50TlkuoTFGmtr6+tHdpRMVWCVa+VIp3IBHrGADXetwrVgexrNphPMcoF8?=
 =?us-ascii?Q?p/RzjROSdA6LJYH5oUMkntltFWsWlEQtZt9C?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 19:14:09.7811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9608e66f-4455-45c0-3c96-08ddebe739fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864

Disable dpcd probe quirk to native aux.

Cc: <stable@vger.kernel.org> # 6.16.y: 5281cbe0b55a
Cc: <stable@vger.kernel.org> # 6.16.y: 0b4aa85e8981
Cc: <stable@vger.kernel.org> # 6.16.y: b87ed522b364
Cc: <stable@vger.kernel.org> # 6.16.y
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 25e8befbcc47..99fd064324ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -809,6 +809,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
 	drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
 				      &aconnector->base);
+	drm_dp_dpcd_set_probe(&aconnector->dm_dp_aux.aux, false);
 
 	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
 		return;
-- 
2.43.0


