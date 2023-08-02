Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510ED76C5C5
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjHBGxR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 02:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHBGxH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 02:53:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F22D72
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 23:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6oyVDQyhaf13+up0pukl2MJ0hyV3jKPXNIzTHNcooMoew5ncfhlOIp0FbdMC5GU63+UkfnPHDkf99SBFdQiAY4A52Ehl/DzN39s3axtImhNUG4v7W5alnjnk+15wh59+zzuW4INblzXzg2pmwa3+k8EVp45hD21/WedRT7QMoun9FdZvI7F+XXDchO+GoNKP7uE43e4ZYMWmK5k+nv+OtThd01P3RvCQpaUWp5x9QjRDX81tJEqo3I0jjcfNWw+6XT8iIaAD73AgUeLMqX6IF4pZ/oFIgy+FPewDrk/QLJeukTGEclZKWaDWgSNHtubgi/HtjPvSiwFXyod32OMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AKs1hx5WS72Cheto71Jusrlya89yysqcWB5XGUPGF4=;
 b=Z5skxtkesbsnnD++Wzex7fzF3vgNgT0JHxHScKD7Z3e1da36Y/rFxBdvFjSJr9romBylP1M1sTl5ZJj6A0YYSjycdhwV+p2fJAXgfDCeEL2TSvxvNRJmQGRJDxCHb6nNoXPu1+pS5QWpcnVe/S/RqXzgiYpcAOLXHtzm8iRJ9Nggbk1sch+lax/LeLS6oLUaeAmwermekFOBD8LFMnvSXj4Yl3ZNCBaUedKwoyCXBVeWbTyeYcaEtaKOK6eejtRjbZ8/6+sz1zdA5u8rH8Mv9XoDnfLaSK4PFl2baQiDzjEv6Zgm1wNG3Ax0SVnzNcwq4vxqOnYC3bJGc2kyg0B1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AKs1hx5WS72Cheto71Jusrlya89yysqcWB5XGUPGF4=;
 b=qE75oP5X9pk7bnXnIpUqY8CQS3d1zWpxAMRxk5LMRE3coa7BB/gIWvlfMSPs4+Pkja+ptrz687AdTOIN6ZF8BiFZPNtbqgHPlHlQo9b0Aq48cmU2Pu5WenWILfeacDDJ/BjwbkVZqqBLvTIxZRH2QgcwQYnq2huTZJcHR8fpflE=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:52:19 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::27) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:17 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:13 -0500
From:   Tom Chung <chiahsuan.chung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>,
        Wesley Chalmers <wesley.chalmers@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Jun Lei <jun.lei@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH 04/22] drm/amd/display: Fix a bug when searching for insert_above_mpcc
Date:   Wed, 2 Aug 2023 14:51:14 +0800
Message-ID: <20230802065132.3129932-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3cb77a-9809-445f-f713-08db932503a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5UbH5l+Abz+TT+UwX0cwldU80V4j7C4VGIr6xTmW1WLwfRsLp9sPpLYI+alpewrWBoL+IYqQeJkbK8CCBC7xHqGfqthgAsaCZS7230JvvnpofEXYOTrxjMn0cPYbbR4E/AfGeX2dRStwCdBZ/KXsjSxtMxDwvHxste2F5pQHlYJwjLNnvzO5HEjgXAKMsitLDgRYxhejqFtdaKl9bTdNchPeCYobyv48BMMz4usvR6mrpZeg9c7AudRFjZvlRRmR8oUk0krDkpoyMXFe08exaSSxVKQWSqm77S+q8SP01I6UFvC9VsICeKcXN33Xbu864jb+WnWNu69T05rJz18/Ujsu2y6G4lrgONIhuPhxzcy9nWHmcfevPb+uArJ1Gbhs1Jyfmmn0/ydw2QuavUGQuqVyD/qKOjucY8yNF8DlDYgfpsIKjdcngPEU6J4JHqldly6E0fk/8WuqXI5IXM5TidcPBodhswH+5UNsAzcBMJ6iKMW1s9ZmAo/UPku8sZ3A35lr4EToJAaEiC4cll2HrVOfj3uaoev9nDb/i4rOpkBB2kaMOFwzVnoqFsfObGxltm6to4tHPbPLMefzpI9dufgwd+0YU7307CSEKSaECiumH16QsXey6wKDKeNQzVBqY6aRffzRQ8OgzHIE2+NqrmSO+/FesjVNxqTwulAct8dY55EBMtyUvmSnmaVuv1xUlEJXUyFWhVKE9Z8DP4spSvuVcUzFfWp1/h1lmnNf+qMYfeHTBv+wZEqND9+bCqyL4CDlMvWToPVFetFjNomE/6PNrsC7KvbsSCH1ey1YjI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(40460700003)(70586007)(70206006)(2906002)(426003)(2616005)(81166007)(82740400003)(356005)(336012)(186003)(1076003)(26005)(83380400001)(47076005)(36860700001)(54906003)(40480700001)(86362001)(36756003)(478600001)(7696005)(41300700001)(8936002)(8676002)(5660300002)(316002)(51383001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:18.6179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3cb77a-9809-445f-f713-08db932503a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wesley Chalmers <wesley.chalmers@amd.com>

[WHY]
Currently, when insert_plane is called with insert_above_mpcc
parameter that is equal to tree->opp_list, the function returns NULL.

[HOW]
Instead, the function should insert the plane at the top of the tree.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wesley Chalmers <wesley.chalmers@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 8e9384094f6d..f2f55565e98a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -212,8 +212,9 @@ struct mpcc *mpc1_insert_plane(
 		/* check insert_above_mpcc exist in tree->opp_list */
 		struct mpcc *temp_mpcc = tree->opp_list;
 
-		while (temp_mpcc && temp_mpcc->mpcc_bot != insert_above_mpcc)
-			temp_mpcc = temp_mpcc->mpcc_bot;
+		if (temp_mpcc != insert_above_mpcc)
+			while (temp_mpcc && temp_mpcc->mpcc_bot != insert_above_mpcc)
+				temp_mpcc = temp_mpcc->mpcc_bot;
 		if (temp_mpcc == NULL)
 			return NULL;
 	}
-- 
2.25.1

