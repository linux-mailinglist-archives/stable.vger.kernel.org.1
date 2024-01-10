Return-Path: <stable+bounces-10465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD25B82A3B9
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 22:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3472DB2611A
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 21:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C013C4EB5C;
	Wed, 10 Jan 2024 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u8wzVcDY"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01304482E4
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd3ToU1SrfkF1G0tK/AzhW9zy09chTaFEtjkfKgWs4TGT0hAIDmdrVGws3CrlltCUN01y5XSWbWzbIxl9JB/J6dO4s5SJa87RLOX7ldm6GJonQFBxX88KOMk+GXYI8XFtN2tY3gW0TiJ/zuzu+WZ56b+0OTsv1vOs+1dfwcSz3bSq9F/KIp9+DziUjEIe/sxMDOfasWj+GWEwo3JHSLKH8NHGW5MMmyKI8UpyMTQKyTyFmItydbweQIISjRETXvZ7Z2uSQZEm25IMJt0W1ngrYI1UpLRDCnCJRYh6TkdeTD2483To7Y/K7OKvCVch3owptW6U3zMyHMbas9+KmEpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSPzSC/o/YBsLsOZUF11ZeOT4zThvQAtTXJR9wwdn9E=;
 b=mIAJGQECujp/3eChYDLDuvyQlVOGUrn1Ef1PTL2wTqMpwbpTiFc1JX6noPA/d/4lRU8hSU0lvVfIkWqqvygrqH2/hZ2lXEK7BGplVSmC5+d4AlPbUtCiYaqh50e15mVGe/00z21eGKONqZU9XM7sYtWRaNqlJ94VlS+x7vZZZOzOYyo2601fOvsRq0w+zb5WTW9UH3vj2ue6TG6lmEc6C8vxQbre/ZgK3iQWnvBmf6j8PT8yRL1j9HMaoY5PW+CbaDsHsYGytJhmmTLYoltpV2paNF4DdXTor70DSse5l3oz0aFtgZwR6XyVBH4M3jVXzAqI9UbOT8sRnGGTzMaCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSPzSC/o/YBsLsOZUF11ZeOT4zThvQAtTXJR9wwdn9E=;
 b=u8wzVcDYHFG6/QEqOGAM2x8+Hb4uX04smrLjrGXfbD0yIaNWjfvGvBcgD7eiSdu0cSjZyF44yiPxUZwpSt0dxFD05C3eX4tmWG0E50vRWhhYXP75+mcKJnxhk7AOTn6ujV0inxbDDzqZD9XLn+dCRYstWDK4zWk+GbAS85fWjUg=
Received: from DM6PR02CA0123.namprd02.prod.outlook.com (2603:10b6:5:1b4::25)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 21:58:12 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::97) by DM6PR02CA0123.outlook.office365.com
 (2603:10b6:5:1b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:58:11 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:58:09 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <stylon.wang@amd.com>, <agustin.gutierrez@amd.com>,
	<chiahsuan.chung@amd.com>, <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, "Wayne
 Lin" <Wayne.Lin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Alex Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex
 Hung <alex.hung@amd.com>
Subject: [PATCH 18/19] drm/amd/display: Align the returned error code with legacy DP
Date: Wed, 10 Jan 2024 14:53:01 -0700
Message-ID: <20240110215302.2116049-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bd68b3-de77-4673-3827-08dc12273d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SvoKZIzEMmfYLlEX7jLT1bHKyygR0G2tczZuFda/ahdr3lVE30aDVDyqXnAD9rxaTN6NgrGIIHVDk4/6Qu93WFn+hNm+QFHZuWkqWEL3tR7rgCXFHSS7njKvU4oK+1Yv+MmJzQpiucj+wQrFICj63eE6iRri/s0xfDPp+ioM/8o0tQbQwgXsxogSEoo5Aq2XMCM3sYbp2yFf4kfFrLhF6POLDz4SQcetrp9H/Njd0rU/L6d7jf2cdRtjAK2hC05xMOYvIMA+XS8xsWZi+4Xzxd/Mw96GGwNysgTQ253nK/E8+rUpRNUtAF2e3eW0+XH2sk6csN3BUSzO0KpIf1Cwe2/Lbt24mLPYEq8UOMDO2D4YaiR5sgxyCdAAB4S4lx9q6rVXQMiFfhKrG40uMKE4CXrRukDmYxfXcIiac2a/uZaBgbvXTtMcjgjw4hoZKk1C62kC7AhknbNkgBHg8N7kVLr/9PePyTNWgG1IVX8B0S32rFR4KqADT5ZKn2E0GRg8P6qM2k/1XxiCs55WEPW5i3pWZQ1waTDvHvuochbfIKMV6TfoIEExOiNMFCWIZtTNX+A1kTgNKXe2wDFkJhHvR6hkfZPE/JW62+cdG/7I7YTyJ6Jvj9CZ6WKRx9jGNwx8foVFqlvLtavZ+YHud2VeUvxaweGBWt/9Pl+0O01+QG8zTuGMsU/g0OXnkpq/6YNOc4GuQflkRSWhRvh+VL1t+OCDc5IpzoStN6nDojNN7p2XB0bt8KtZhHiJSTqb6FS6FBnvV4Q9es1lZbjkvjphFA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(478600001)(54906003)(8936002)(6666004)(7696005)(316002)(6916009)(8676002)(70586007)(70206006)(47076005)(2616005)(26005)(1076003)(336012)(83380400001)(426003)(16526019)(36860700001)(44832011)(4326008)(5660300002)(2906002)(41300700001)(36756003)(82740400003)(81166007)(356005)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:58:11.9302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bd68b3-de77-4673-3827-08dc12273d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
For usb4 connector, AUX transaction is handled by dmub utilizing a differnt
code path comparing to legacy DP connector. If the usb4 DP connector is
disconnected, AUX access will report EBUSY and cause igt@kms_dp_aux_dev
fail.

[How]
Align the error code with the one reported by legacy DP as EIO.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d3966ce3dc91..e3915c4f8566 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -978,6 +978,11 @@ int dm_helper_dmub_aux_transfer_sync(
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
+	if (!link->hpd_status) {
+		*operation_result = AUX_RET_ERROR_HPD_DISCON;
+		return -1;
+	}
+
 	return amdgpu_dm_process_dmub_aux_transfer_sync(ctx, link->link_index, payload,
 			operation_result);
 }
-- 
2.34.1


