Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED24377992F
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjHKVIt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjHKVIs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707D9E75
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5AT4D58yWGiZDvPjdoMTG1CqVkHTY3SXyDRDwjGlFdG8Yupgs8JkFVUmAE/CEJ6iQtstg8NEZD2mu5S7kcdAqOYhJlrf+1Ek+U4+o0J+1RRR6zXeANh3M9oyLYxmSfOMTDMGA+Cf9sBgckJQU1/ZEoYpPdYa4i02HZJSxMklLkr7ZbFB3SDnQZmKcv9Gbgc5XLFm5ifB8ZZ0YWrKgJC0B2m/kfsydhx0tRViRZD54V/6rbzvm2io39FcPFQcn1CtGSDtUlUANs8mYmCnuJlJsHHL3X/6jFoA49azEOk5RMaBRBfVh+fbOACPQcQ3lJzl6n3RaEjzyrPmgE7+uQbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA3u73nSzK5pgsuk4cL78tHjWeSSBogeur7JYSJznkY=;
 b=d+6iFIMj1tgsXqsK8Wd2hKA22znEVIffv8OMPjXiVoHiNOyI4D+eZPUDdKAGQIahbgUTzlU2KX3RSuEz6aPxtRFUZ+qI9KZlq4Ft4EDlKTO7Q+BdfX1Q+ODhzJhYCYuXunCwunhvMkYTupOaZCrhKm0KJ/hgsgfETlM/e3lZMKww3ObsSQHpCNDAIcntppmTyafeeIhXXHKzdoqSuRfDllrVegYsiaMUin7um11Tg9zaGeN4KtNvG4dSqmy2Gka5eDosvcLX21AUh5sm+G5/Fh9xDw4IQOd9Qkq6VCDpCkmTp/JAZtD57ughifZh67C91dW+a7r9qx8FgVGpwo1/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA3u73nSzK5pgsuk4cL78tHjWeSSBogeur7JYSJznkY=;
 b=UxAOkbRwU+emTTgjDmqtF0os94XHG9gbMy4LnitBJvUdfTSVlHHeH4BqTJxG5EBbWzr7d4Hl3zWfmDcnJyM4bcggIKlaalxbWeZ55D+bk4lq7cjtFmF4Dd6W7McSjm4ApZxA20K41dZWxQ+CmCmLJrkkumZRHPW+Mmo/Vr4Ej98=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by BL0PR12MB4993.namprd12.prod.outlook.com (2603:10b6:208:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 21:08:45 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::15) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:40 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 01/10] drm/amd/display: Handle virtual hardware detect
Date:   Fri, 11 Aug 2023 16:06:59 -0500
Message-ID: <20230811210708.14512-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811210708.14512-1-mario.limonciello@amd.com>
References: <20230811210708.14512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BL0PR12MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 420c41a8-1d96-492c-bc9b-08db9aaf262e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3VlER6/A2twbiJxU0osEgDpqmIcTmIJqaq+J0NC5KkrjSLM3thfU09+D93L1vfs8zXsPTftm889fEtI/ssz3kGDPw0sJ86fN338Dt3L0anpqHTWR6DDrtm2JawBddoyBMGO4kRm/yfnL0bQi5MXA4yfuaWc7U1X6kKI4sHtUL/gU1ddKyxvgGRAlPWky+zJyGGgf0y+nYVXRshciVmlpuPww91utZqofLl3rwyCIIDjU5NCoqBqLmmGQOra/iCsVSZzO/Oo59gcOXqP2vg9oDyGamBPdhHn71oHoX+bSFylJFNZronobOh/Ti8EpBWrum+OLBXQAL7iyQQa+nbqWnXZjLbzkJW4kCEec3XcYnAaRMpX7qJ9soIMTi+MSPW2+vyV/zmj86auWJQhaZ4mDfPFBFeeyTQufmCgGgHfn/1haLZVuaUGK8Tk/V3sqgrtX96/zwbtGDzxUEIZNVo04PuYVdEdhMBzHyryCrPcwYdYEOj1gVQAH5R9SGwJNyYwHzPhjdjORleH/lwrtPhAr5IrRJzoY7PqPlik1wq4pXRgv7MsH0PNjZCoHBYE9fhmz2n7zxm75qO3KCNRNnQCPaLYf5LnduNIo5McRfJwiy6t3+IQ32R5JLqySSXbq0d7vHnTmENHHRieZHRert2+jaA3HzjnnxtMhwoeMt8G24sZsJFQEKzV6Qgh1/cUHjO8V8dD1kPZxS1UOPqDX7XJLswGaW9KDRV5F+Qh2ZaBNOQtw7LjbxltvYpvJELsMaa+vt/MBcC8wfu+uOrJVr/6Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(82310400008)(1800799006)(186006)(46966006)(40470700004)(36840700001)(7696005)(478600001)(6666004)(426003)(54906003)(83380400001)(26005)(47076005)(336012)(2616005)(16526019)(2906002)(44832011)(70586007)(5660300002)(4326008)(70206006)(6916009)(1076003)(316002)(8936002)(8676002)(86362001)(40480700001)(40460700003)(36756003)(41300700001)(36860700001)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:45.2202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 420c41a8-1d96-492c-bc9b-08db9aaf262e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4993
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
(cherry picked from commit 987b96eb860036ab79051fb271f7fbdc01c9daf5)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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

