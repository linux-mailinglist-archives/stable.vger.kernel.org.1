Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A8779938
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjHKVIz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjHKVIz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:55 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10278AC
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB28cPs3H/B+1T/8+mgp50X57teHmmeiUPFPbvIZigD1QhPjkWbFAQ5EohbKAwsqk4xOH7YYiT3I3Pk8/MONw4uRdYLG94gsQk9Yp+hnuTaq2gUB11Z2RFfvs9PYn3sZPum0svt9HGpSknoogHVzsDMYS7FxBqV+5OTaCUAM+dr1lkW5Vm9d8zve9ng0ONnObWrhcxb0f1PXC6N6CfIk4zUvK2eUE5MxcwfJDwoaH2JRFFfGN9+/D7j2oQPm/R16qyLUjNB3kL50NWQunnhmebnAH9VRkkxjlQwSzjCFX+6AxCacs9bBgwo+JEcvwU20RtpvjT6hKSZrYuR1huvV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNTSKljk7CSxNNHwHAnJF6mbolCUGpd4SnLkHPryNCA=;
 b=SKnAhzp/AGQ7sVHpsuktce5wQ1wTZ7TWAVXtGawFBgx+D4ZfEcq7+PA6VIp9v7IM4aD5XCnmr1Zl+Tm2tys4EwRgjR1ntA0rpBKvQwvhytW8W5vAQhpf2yRXyS/B3ioAcTWJDIUrasI+NBj5deduBamspTD7XJrl+qMWRVEVnWIXb9VsG/+MZ67jZq9tT0WEUex6BiZ4VOpkm/eNVwN0Oiif8e7xStofC2ukUJNog8ld7OP4Lh8PaGlWOMp5s5iDqJBRLN0PhXxsl5rDtgMlXUGoexQI+8MebKGU/hho+P53xU5I+wjnGQqMTDu2TvLM74+Y47FmWK/c+8QYKkIiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNTSKljk7CSxNNHwHAnJF6mbolCUGpd4SnLkHPryNCA=;
 b=VZcYFduBB3LFSeyv3u69Cm8fW6Jezi8s7j3j0R2dj3sWuzZgkfx9cKbP+j2caBUK5e8zzqHdxXYK/Pkh9COdSSnHF/8JZ7rYMh0mlLy4q8jzBXqRU6BW2vvW1RrpLtvL3lPCYTvXSf6GJru1MOo+OFk6XPMytWG4oOZdp5vuMhA=
Received: from MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::21)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 21:08:47 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::7b) by MW4P222CA0016.outlook.office365.com
 (2603:10b6:303:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 04/10] drm/amd/display: Update OTG instance in the commit stream
Date:   Fri, 11 Aug 2023 16:07:02 -0500
Message-ID: <20230811210708.14512-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: c2eae992-5ead-4113-01e4-08db9aaf26f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fjk6uz+7l6FiLlyazytociSMSxXGQRsPgq3mMq13ys4wb1E6OwPmg+UayoqKfR7bXZ5tzJHijqOXiCbbH6ZSZo2RIAnCH11KhlfisqxGkDZNwPD0TrZ2TAPU+npbaqTk9cafmPlQQw9Ca0kKr9MclcHYW6wEiBQTwLpoJW+w8iXfQ0WwSu8EqLKFy9Etwl02bUR8rdjHHM4V5YDR8tjJAi7Cyx4IpuXJAymgB73xe8q2XfqnimlSQtammPaA8YU3UN7imIOEsbaDmwC78yF3HCMtVTescTWdu1VBZrNoQrM8G84d23R2cE4XfF2wvMKDPgmAONl6Jjre94qBGA/TlLWAEpLg7Fmu/AV+6lmrYHMbEu+jTX04gOnLzv3x6i8JgS8qOjHzed0FlPAMqO5VKqpMZVEPpYpJ2fc6cYrFXcY3/sC18fVBpdN9bR2Ag3kKxsVavLzUS0ffEKBpzn9GOEmEU1xBOKDqd1jj6vm5k1F2GCv9Wbt2B9Pqv6SKOdTwCb1Tggx4qfMC7isonGoPk7BwKHKE+Qt4bWLOmPoVafhDUY9SIiRgv7StpNf1z2sf3BkaHkCZ6QmpBBtKT3bjwGqd+atN6GVQSv09uXQWu4rlZDrX1eNt3yHWssQwohuzUvzO68zy9fi3yXiltfhsnUc1zNmyWdswGK9+Z4EihHXeWZNGqdtOLhTn7NcREgYzREVmPC4QFDxfvBDnhd4dRMbWmmzi+difuuYzU0J7nVuUDE/jqWJXTUtrgRqLDkQdFjFQyRZTET4NpbaZcv91MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799006)(82310400008)(186006)(451199021)(40470700004)(46966006)(36840700001)(4326008)(6916009)(70206006)(70586007)(41300700001)(316002)(36860700001)(54906003)(2616005)(26005)(426003)(336012)(1076003)(16526019)(86362001)(40480700001)(47076005)(81166007)(356005)(40460700003)(6666004)(7696005)(82740400003)(83380400001)(36756003)(478600001)(2906002)(15650500001)(8676002)(8936002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:46.5014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2eae992-5ead-4113-01e4-08db9aaf26f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

OTG instance is not updated in dc_commit_state_no_check for newly
committed streams because mode_change is not set. Notice that OTG update
is part of the software state, and after hardware programming, it must
be updated; for this reason, this commit updates the OTG offset right
after hardware programming.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit eef019eabc3cd0fddcffefbf67806a4d8cca29bb)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 753c07ab54ed..5d0a44e2ef90 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1995,6 +1995,12 @@ enum dc_status dc_commit_streams(struct dc *dc,
 
 	res = dc_commit_state_no_check(dc, context);
 
+	for (i = 0; i < stream_count; i++) {
+		for (j = 0; j < context->stream_count; j++)
+			if (streams[i]->stream_id == context->streams[j]->stream_id)
+				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+	}
+
 fail:
 	dc_release_state(context);
 
-- 
2.34.1

