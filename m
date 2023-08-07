Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EF477183A
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjHGCVM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHGCVL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444071709
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9shFKicx3f7tHHROcH+S622Jgg8kRwubAAQG8zQJoQQStA+RUlzXcSNMoGi1iO1ovm/psFMQV0dPz3aGKDxqiDj6S37ETt99nmIC5v223AUSb7xYuuWbyCYTvZKxtD2eh5lvQF1WFzEuw29Hl6KF+EBWK3Q5HcD03OOUVV5YWvC7d6T1O5qni6xysu4e0d773z53QQMr1r4v5CuqGc/ndrik0Ke0pkkhllSstYrILFYFZxtCHJbxlVYCF4lO3M5na6qblAZw8YfoJ/OW3lfV3wcnm+f/F3sZCZsFFb9sKvr2fEf6C6a2QSSE6WIWsZXHYD9IOTjGrBDq4mFr5MI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEZEg9nkC1iR1FQy0ln9tzl7hUgXJ8btSDblwRMxF0U=;
 b=ajIVJFymS949e8FMLngKAx9JSAPvg8YMAhSp0a64WTo8qjFrt81l4Mo5QwIKy7NjQh0jIgMN9soLLEEtqrabasHL8j19hEjkhYwbMtFqvHYhYYaF4rEgWgE08yWAUG0WV0v178a3cx5VbZIUm4HVQuSH0nG4+taqS0lCFimBOSzrh57jPCx3smajFQjLdTDF4P+bLK+LXcXWO7j1iYVuqOKOMnZxVd9s2A1v8ksxheIOixOMl7+tY6NfxBW5PvrXX+axXSNLYozMf6ELhQYPKjtx1rFHzmTAzIuyLrNSV9xJgLRmFGk/BVyNjlw9UC8XTuvCGaJMxKJ23CggqAzu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEZEg9nkC1iR1FQy0ln9tzl7hUgXJ8btSDblwRMxF0U=;
 b=L0AV2HSY4olvCe48Dzou2oYphR/IMfJ9zI0r2ObVJI8/GZdzaPQMod6nKlwxwc2wk0xZMV44R9foOFj3VSvMWM/AaQBs64al0llfkXhfXry+myvO7SZ9dYx/z1ajzMrJ74vPyZgLyi1Qz7UwTVL/5UvVyX6/qwNk9bY3NxU29RA=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:21:05 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::f9) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Mon, 7 Aug 2023 02:21:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:05 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:03 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y 01/10] drm/amd/display: Handle virtual hardware detect
Date:   Mon, 7 Aug 2023 10:20:46 +0800
Message-ID: <20230807022055.2798020-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|BN9PR12MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: b0794ea5-6430-4521-8f86-08db96ecf4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrVpjfWL6nfclngleUAcD6Y11rgWQsX5PqpI52cYlTK/VqC1Mj6hohDefIFtPe0A2zURTZ7vKYE4ilSmmzY12ekGPwudwKcgEj1Rcle5wvvuOWdycNr+GJLGXbtXfzGRkGgUBskkKcSNHVpcDVSOmtbgC3yP8R3s+e+NrhLvkcpwtGsDButqWpsxCFGeSAa8ARydSPX4b2SCCSE6BRpO1tFhyOscg3ZxJ0cifFcap319gtpXFDXaRBFUJbWSoK6VPTAbj7VHlUBFETNCkLle3+XF3lP2JD8KqGJxGxb9TZmvq2V8eAZ0qz7x0vytJt5HJRbBJpqmv5D0iw3VrgIxkZ8k8uGW5MlRLDrs7ZxYDzGgagVRtK1hQr7eEKCbTp0+hjN5mEicAuiWYzsUAnJTALOBRGpWcNeiv76yQpppkQxPoqNoumKKBigOxfMfDzMrvk/5ztlE2BogrcLQwZutlDVKb3d7CNEJxlfWcQIGp3ZGE6fdxSq7OKF/LqMri0652x/TiL3eOK00K3tEd54hMW4FO8xBhqvN06tRGYpBwztg6Hmq6/Z4eRvNTyv+axOnyQiRUU2IVCcVWb7pvss1Fy56pdpeDNQkGFtdlZnWWNlp1cfmyt5EI00q2Zu8dysI15Qu3CIiCl0H5ogOyzJlWNz2h6HV/vcvhAM/yvB2BIkveHfvyEtC+eXvDZ9n25ydr3KmDuwuE97z4VV4g8lt3+cmbVnonAZVb9tbNOfgvZhbvTkztaOhR+csQQ9so5HVtivb3X4CP0uN5g1RQn7jTmQjJMj7GfidGhgVsLrOR70=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(82310400008)(186006)(1800799003)(451199021)(40470700004)(46966006)(36840700001)(426003)(1076003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(36860700001)(47076005)(8936002)(8676002)(2616005)(40460700003)(40480700001)(336012)(81166007)(478600001)(6916009)(86362001)(316002)(82740400003)(7696005)(356005)(54906003)(70586007)(70206006)(6666004)(4326008)(36756003)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:06.3810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0794ea5-6430-4521-8f86-08db96ecf4ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

If virtual hardware is detected, there is no reason to run the full
dc_commit_streams process, and DC can return true immediately.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8f9c60ed6f8b..9b7ddd0e10a5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1942,6 +1942,9 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	struct pipe_ctx *pipe;
 	bool handle_exit_odm2to1 = false;
 
+	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
+		return res;
+
 	if (!streams_changed(dc, streams, stream_count))
 		return res;
 
-- 
2.34.1

