Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD07771843
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjHGCVq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHGCVo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08FB170A
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euKpZ8wIXWXiikawdkkmg4FgEseH7817/nmm4Jf4n7tjvo136SYECrJqwHYZ87brS2UoLwbKc2+JnNGuvRC8nXPcwPhkDyTwVTP0lcua1mdvn0Qkzm5Cw7jIEZogcwguL1RrxQozd+ZHUBotIBJzwYVz7pGdO8ZJhBxhp+U0mo0FPtwW8DZRBhMD5+FZLrNVcdvF9Kc2g+FDclV+jjXPelgBfCG15c0fWUXYwKOUpskEdieLUKTwdd/5IXVubGZ23GkOdiKy3f/teRaJ38gnrbJHqNLSZjM7U5dfgKedLLQFT7okLLpaXgQ2nyaU6n+suyAJJJQhd+SqK7UXOfQpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko8cHHflhQ3acu2qiPIfFVW6nfFfK5IxreAVxzhQw2k=;
 b=I1lfCVJHLnkWEveh0U2qmmLTs+NtKCXa1Bf3a72TtcDSAUSfVKP4oFWCd96qMiaMvHQXoN4qSfyQ5J9N47kZ1zXXsaN4lsj/FYHrETf/RM5tRpj4CuQmGiDB2wS4Dd2xyynuIqFSGgQO9/YCOFOJBxHvuIcneZyuF0LWy5DXjT7dj+AxAKfGRLnqAYUmAdwujAyX70cguDl8+QX0ywJ82ixab4wc2QvJ2CukfhNlHYIcJ0BL5VGXojtb/K+h2flSzUna87LQl6c8maH8sQVNLqxLAiK4/EUT7AK7NTAvpEuTNzxrGygtS9gRhaJYUSIObkoCxuLa87DScHFkdqzoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko8cHHflhQ3acu2qiPIfFVW6nfFfK5IxreAVxzhQw2k=;
 b=vfHujdofnpGqg3ghwiEgqQ8OjoxNXwd1S323xDLrcYNVt2QWCWCOnwluf49VmsfWdyYyayfCZSx7hdBZQzmsvAcl7oiPzhH9jR3EGNACc6rdk9YW5INsS+9fBs0uBe1GJswnl3IT25KUWs6+UK8xaBC/uo2gPpvOTsM4HrSvkMc=
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 02:21:37 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::b8) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Mon, 7 Aug 2023 02:21:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 19:21:36 -0700
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:35 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y 06/10] drm/amd/display: Use update plane and stream routine for DCN32x
Date:   Mon, 7 Aug 2023 10:20:51 +0800
Message-ID: <20230807022055.2798020-6-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: c54e52dd-779d-428d-2afe-08db96ed080b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuoYnbcpNHvRayg29OEA8AeIzYSWoD39RT96tFdnHk/KhUvQjGUYFQrN5bKHi0ZHPm24/o0YexzEYIDv21doSAz7dujubusBqAyV5AhPE5ziI50TR5YFCwlz7U+CRtEqrXJW0k35Cvv2/Ub3dKYsY3eJlnbKUfHy3AfRNrjQcK4cPQhR2chF5vNQMolIjG7V6X3l7aV3FrIUQowaGWw/8/u0MzEeGYBq66jRCFbaHfvD0e12RBk0l44IqPEbFpu4gO5S0Qf5Ojc7K3oj0D6Kjm9D8KYZWj2ROlvAYwADx1+dfVdHwZ3Xd06lbE3/xYAxjsObixNXcxpUklxVAC/jBh1nvP1uNDli9eG80z3R4fpqFVCNm69Nzw/X5vBAqJiLvRt1kzBoNuVALqxoKlvdcX/ZUZWi3Yg1UJWDKI9SiTXMsBixHS0Y8kXQ2kyWLN+NR+ZR/WL+09o8WB7sRPiv//DRJaVyMfmFnjBiVDD1/4qGq+xgChUUo/ihJZdF+EsELBsLuONS041VCXM4jTryFQPeJksw8kdHOkF5CKW9RcFWVHi+L3UKF6C5L5WXQ5e5DJMAXDx2PsZOj+doTqk0gtC8j3TbcM1fLkdxmv/viB4+tDLvbLfV77a3dLqYsxIuIp/7hyqqMoPooM2LTpPrs6QzRIPso7dC57+aQuEIOLK0PxjEOVvF5+z8PxdJFRzLcalYluBid2Es1XxyjptTdXe+HQz35CbuKfziSi0/LMcl2yYK89HRi2X5KkadD/9Q9XWCA3b9vum9dmZK4uqRrFQGyiTXE+ty9M/dDkZgzz0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(186006)(1800799003)(82310400008)(40470700004)(46966006)(36840700001)(2906002)(47076005)(4326008)(6916009)(70206006)(70586007)(7696005)(336012)(6666004)(83380400001)(5660300002)(36860700001)(41300700001)(8936002)(316002)(8676002)(40480700001)(81166007)(356005)(2616005)(54906003)(426003)(478600001)(82740400003)(36756003)(26005)(1076003)(86362001)(40460700003)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:38.7703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54e52dd-779d-428d-2afe-08db96ed080b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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

Sub-viewport (Subvp) feature is used for changing MCLK without causing
any display artifact, requiring special treatment from the plane and
stream perspective since DC needs to read data from the cache when using
subvp. However, the function dc_commit_updates_for_stream does not
provide all the support needed by this feature which will make this
function legacy at some point. For this reason, this commit enables
dc_update_planes_and_stream for ASICs that support this feature but
preserves the old behavior for other ASICs. However,
dc_update_planes_and_stream should replace dc_commit_updates_for_stream
for all ASICs since it does most of the tasks executed by
dc_commit_updates_for_stream with other extra operations, but we need to
run tests before making this change.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8c9843009176..c9ed0346b88c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4002,6 +4002,18 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	struct dc_context *dc_ctx = dc->ctx;
 	int i, j;
 
+	/* TODO: Since change commit sequence can have a huge impact,
+	 * we decided to only enable it for DCN3x. However, as soon as
+	 * we get more confident about this change we'll need to enable
+	 * the new sequence for all ASICs.
+	 */
+	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+		dc_update_planes_and_stream(dc, srf_updates,
+					    surface_count, stream,
+					    stream_update);
+		return;
+	}
+
 	stream_status = dc_stream_get_status(stream);
 	context = dc->current_state;
 
-- 
2.34.1

