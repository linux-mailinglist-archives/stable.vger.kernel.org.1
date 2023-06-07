Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1B725E86
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbjFGMRL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbjFGMRG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:17:06 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6C1BD6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKpo/wT4SuJpp+OHSQN4wfSEhsYInB938jvF3twNUC09xm6LPJZKnbDJuzib6ZojS923FiuKOEaycWdEJ/d6AW5/Z2O36kahRFW62sF33b1l3Q4MbYdisSODtavOJoGqM4uVuG6HvIblfEEpf/Cn89iCYyvcmSZgRizll38Q8hwqeZKeLyYywWCxuAVnhNAUF0ul5jWH0ocvTk5YBh8I1vpqjQaynCejNAdMBcwr11W748YQiVbOyNEPwVEydG5HZOwuplsmC/779GogmYS2xmyAHcxlGc3E5l7yzmdIsk+i559KB33hxhd2jfidGm51F6lvjNUCk4TBUWQuIuT+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK7NZgpd/B4vtC8uanOWeSC08Yr1GNVLdejgP3c9+qs=;
 b=mI97/olgM4HS/Bdpop+UZtaxWV+CUp7jW6ECvSzmdJhWNQGWLi/2kc0WXTk/zzeKO4ahnEY9AcD7EJ2eqXzWkGV72GC4McQqhfpKTjbBG05EZ+oYWNfWcXXxqQqJVB7MecA/xYnEc52yXCxIgt4k8LJxHwyCcq9rqejC6Qy9KLgw3YZ1tlyWRf5EMKWNj7nNBp6t9BWDe5nURo4utioP7etbFxzTv1/SDDLzErfHJlKz5sjtnppI2I0koeDL69+CuvRwMFYV+p/ujS9j7DIj7PyQsO5Xn5r5wa3dYuKsVBCWTYXnUq7LMEsdGwHgb90EPcOz5+xD05sHrLUlUfFXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK7NZgpd/B4vtC8uanOWeSC08Yr1GNVLdejgP3c9+qs=;
 b=fImMWQCy2QzA7b5Zes078zjYsRlCrbBsRCquLSbWi7Rp+jep6tisQrlex3HVlhfoiu8r6OIe4oJBaLKVBYAH1mZfMZ29trdlky4u0oTMA5H6zsMqLLtKSiRziAJs42FpD0zMJjJ22FHGwSRCK8PlpFlgKnlx/pV9niiYgMECc6g=
Received: from CY5PR13CA0021.namprd13.prod.outlook.com (2603:10b6:930::21) by
 IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 12:16:59 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::c6) by CY5PR13CA0021.outlook.office365.com
 (2603:10b6:930::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:58 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:51 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Saaem Rizvi <syedsaaem.rizvi@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Alvin Lee <Alvin.Lee2@amd.com>
Subject: [PATCH 11/20] drm/amd/display: Do not disable phantom pipes in driver
Date:   Wed, 7 Jun 2023 20:15:39 +0800
Message-ID: <20230607121548.1479290-12-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 136726b9-ec6a-4468-4b96-08db67511759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3tp/MEJ8c6IcVWRvq/yoJyZTbTkcpnNe9InGlx10Gak1OyuJn87ca+aIUebU7Im/qv43NLDK7u9XhVRb3Uvh7DMqXEDjZYaJ1TdGGEjrn/mwLQfamVGPv9xyh/xXMrHDV1sala7/BGLKdJQgjb9BquwNxJqsmVag8sX/x9z0eXSRiHmj8LGGhDTCIUCkTNx40ZhysdHP7Cyno8IDAzx19BGVK83HvHLrz9E004CmvV4n2YCjef6+qqDzt7ZXMUtaYQHF1lEoauT7qEV2wZzgjauBjt5/8DEcS2vUSBnTHnnCzYenkn3R1PiEaumW7gxvnV/4Snrkk2pQCH3LNIjrHXFeUpe4A2YCJGm1gpvRuYSSeA3or7UI9GCoD9uLcKxFpUFw039smE7lVTTRfNaNTFHv1bHJcG0tkRfIxRWRDtSmIzCccjj5tmk5R7fQOm5n5Oz6hzHVRry2N53OjI0gBnPF2wmQmNQvcvmjuoEqP03Jvk6jVumD1Mqa4fdmpaPb8GZd0bRjx8rQx+FCqvKRlC1ZUIIhuJqgxGJ1mMPQBx/z7rVSBmkR09C0z+rzejeQsF2c827tfu7FLZr3AHCLsgELgRKLG2QZ/cnL61Uf9hd82dZaB6DCo46/kjO0zEHosPbAOT4JBIEHRlBEqBu6EmEOk4fI4aeT4s6JU3WvbedgErgqDO6o7nNmWcr1SV+yZHieuOuH7816KPv7IrHlRltkWfPj27RPjPFBaa5ESDexQlZwQZwkICawKDzagLFqrN8DeCtkOznPgMGoMN35w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(40480700001)(40460700003)(6916009)(36756003)(81166007)(70206006)(82740400003)(356005)(54906003)(4326008)(2906002)(44832011)(5660300002)(70586007)(86362001)(82310400005)(41300700001)(316002)(8936002)(8676002)(478600001)(186003)(16526019)(426003)(336012)(36860700001)(83380400001)(2616005)(47076005)(6666004)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:58.3703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136726b9-ec6a-4468-4b96-08db67511759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Saaem Rizvi <syedsaaem.rizvi@amd.com>

[Why and How]
We should not disable phantom pipes in this sequence, as this should be
controlled by FW. Furthermore, the previous programming sequence would
have enabled the phantom pipe in driver as well, causing corruption.
This change should avoid this from occuring.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Saaem Rizvi <syedsaaem.rizvi@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 00f32ffe0079..e5bd76c6b1d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1211,7 +1211,8 @@ void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))
+			&& pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
 			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
 			reset_sync_context_for_pipe(dc, context, i);
 			otg_disabled[i] = true;
-- 
2.40.1

