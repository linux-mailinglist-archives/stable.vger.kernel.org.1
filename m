Return-Path: <stable+bounces-8167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1F381A55A
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74D01F26AA7
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022341763;
	Wed, 20 Dec 2023 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Zr64vZo"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78635208BB
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+z247Woyhw844/4MgwS4Dm9ehpHUga2oP4mlCSCH+HF7DlQ302NOseM0+sOtD8sO/fGV5J7t+V2X+ULlPkPpJdqJxZPXfUUbHKt9K4XZf5j2mMGGXngNo9bNzO4YlgMX+EYtUpo9VhRb1z3QsjEpeHw/XkZlucUDZStmb7Q1wvukB8PYgRjqf3W2rk6Xc91twNURHKCnXXferGLvEz2B89Ou3yxcrLSL+hmM5VnwIU5+lMFyWF1x6iPqG3wxIuR1GwhJGSdIIbTL8XWlO6BFD6NQOmipx9/AjLS3pf0bQAPi4YMrpImrwnYGiAmpmFcAYxqsuxNvYTC5OtkEMg6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9OZgaqbUBJXGNKkkDFI3Ds0HFcf6vCU2EPbCKmCHZs=;
 b=n8Bkj+ju1aoNq4wFOuMf6QfoIMsvedR5mNQkYoIHvv36QuR98HG0H8PxVqapWX4KwpX3ZXf0g9MtbIY+l3THobeUj8UqMGJJX5pr21ug736rJ5A2nS4bArcfkwEmZIeqZxz/IQvKsU5o0qdG9VDCbtx9DclIHuxdx76vs4vHjfZRi9dtgPOLGPtxJuLI+4yHZu2rse+eY/TSET+OmFwE5Og4MJp9e8iysmy3OHZYyRnzAFjdDt995FgJiaOml1UmSSckyIbX+NzcsTZ+UQ0GjJ9qSSiyVuh41gP+XoQWC2IzxlwaNFfxvuzKZ0qpeoDbcLtMQl9/bwP4L6y7DJsI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9OZgaqbUBJXGNKkkDFI3Ds0HFcf6vCU2EPbCKmCHZs=;
 b=5Zr64vZoXJ582h8KscUM1VR0xxuaqaFqfiUzxl+RjE9fzMk3R2LVMGxqmlhwi4tt5NA6xl9QfujaYyg+ErqwSQQkMedXUim6MEoNlwWskQ9RvseqRN3r7SveNgIpwPeAW1vUM/hYGy/4p3fgSh3UyYQ1z1mJxrY+GHYcmJ/QZ2U=
Received: from MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 16:36:55 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::3) by MN2PR07CA0021.outlook.office365.com
 (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:36:55 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:53 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <stylon.wang@amd.com>, <agustin.gutierrez@amd.com>,
	<chiahsuan.chung@amd.com>, <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
	<stable@vger.kernel.org>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Wade
 Wang" <wade.wang@hp.com>
Subject: [PATCH 08/20] drm/amd/display: pbn_div need be updated for hotplug event
Date: Wed, 20 Dec 2023 09:33:40 -0700
Message-ID: <20231220163538.1742834-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e42176-2336-4f11-5512-08dc0179e115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NGURg4OrC6VjVkAW6hYHsMiSfx3UBXO0GNDZZOaAaxWENg7CLtPjK5XpivNdZwl7r6azVyvpnn73gHxEyw/ZwnO9UoeeoBWncgCkkcspY4Hkmqs2T2n1YhZoy9WeD6Gu9x4fF2SJPGfwL2ZMDYnEIAlJLh+6FcjQxqrOpco1zK8LcTZbW+WiW85Dnd6uj9zv3bYwsyRz+l+ZxYHPZp28YGcROHJEomWb5TneAkOAuDDft73GI6rLPEtVyHzb258pbu7IRgZUOTLp7rF46y2DzT/FiaJ22aE8x/jgH+7sP7AsL6VYb0wGUp4jQdwBGxLsQVwo/c4k5CpugMQVucvhlcf7pbxeRmZ2ZbrXzhQPas2mStbSmoTn1RYGRx6eE4TPYCSydPhbYM8uaVhU7ULFGfu9/HuRJtQcHKS+37nuWuthIY5aTTy4oL8o1C1VhChttmZP4bO2riC5/v4UrSj+XHErEVqM7trdw9CH+UFmIFWwOyvNGuOTOY5f4n2NAMIQuoV2XTAsR2El5dMGJxwk0280ecJ4xqkk0/wsWnhomPJJ4LSdpMHrdEjIKy3I0eGc1vqus8zybJzzo0p/kqTAV3HdogTjckmkVzBUVwbjYAfBQ9JAPiB4peIaXwctI1wVHzsTg0RwfpSIooGv7MTaUDf4sCC6l3AMGxV+VYV3KfZq08BvgWBghDE6FIxp+kvCBZttofvmOX+OM37F9h+VUT5wTeuxJm9UxdLcoXjU02bfCAkbzaE1YcFqFymgRQMaJ+7TcWXrYHub6Iy22EhfN5WlcsJaw6nUMZohqUHhaR2QxP4OYI7CXfmPapq7tLzO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(36840700001)(46966006)(40470700004)(6666004)(2616005)(336012)(426003)(2906002)(1076003)(16526019)(26005)(83380400001)(47076005)(5660300002)(4326008)(36860700001)(478600001)(8676002)(8936002)(70206006)(54906003)(6916009)(15650500001)(70586007)(316002)(41300700001)(81166007)(356005)(82740400003)(86362001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:55.8241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e42176-2336-4f11-5512-08dc0179e115
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

From: Wayne Lin <wayne.lin@amd.com>

link_rate sometime will be changed when DP MST connector hotplug, so
pbn_div also need be updated; otherwise, it will mismatch with
link_rate, causes no output in external monitor.

Cc: stable@vger.kernel.org
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Wade Wang <wade.wang@hp.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2845c884398e..9ff87cee4c61 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6980,8 +6980,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	if (IS_ERR(mst_state))
 		return PTR_ERR(mst_state);
 
-	if (!mst_state->pbn_div)
-		mst_state->pbn_div = dm_mst_get_pbn_divider(aconnector->mst_root->dc_link);
+	mst_state->pbn_div = dm_mst_get_pbn_divider(aconnector->mst_root->dc_link);
 
 	if (!state->duplicated) {
 		int max_bpc = conn_state->max_requested_bpc;
-- 
2.42.0


