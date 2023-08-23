Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0B785CDC
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 18:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjHWQE1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjHWQE1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 12:04:27 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1C184
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 09:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioo+QQgIlN0zXaewSJcrUFks1aBJXP28XvcRhmDiv7y+lLQ4vI8u5ISeStckbmhxkaHy2tEWFkbcD1DSzaDkJlfPxJcc4De7BtfK+th0K7K2U5WFOIvJRD8Wwzkk+JnEi9Kg6phB4r9+4a71zBAL0plF3Xql9UzuC6COYfTZBBViL3KKrGh4eI8Jz17IHIteBvSqzAiDi0+3GCo6BwXKps2CqPH1DHGREt0j/WHM4nlzp2aRcvJwQIxvVsnmUrF8neQSSOtzU8ac7hrhJ6WwwAhoHQzINTaADceVGBh7NKshKlCF4yV5knJRx3Mfs/3wjwnJi6HAi5+JfAon31Bu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bok+eFEV6NEvIvKG1/UudSfP2rClssP8V7zIjxaB9Fw=;
 b=UYSwg+6mDhMSChQdpvZ31ckYgM2TZC2Uk/RVlCthZnsapyZo4OOu3+5hd7WKIIzARts1+Hd3QYR/tmikPjPSpxDtGgHhEQll6O44iHA6lmeQj6x7UDC6YtJn/L5qqNtu2eOcipOlb+HJmIw2zjtHp0M0LI9Kx7WQyS8uNMVWmTS8uslV1g9scMXuzC50tMD+OdSWC0SXX4weRgu2MBue2iwY2pE03OggsnMQpG48mCDPmCF1Si2fjbYogSZLsxUg/Ayft6dWfOzXnwIExwHZQXa5wdSU4apZj7pfTakQEqc8n9aYE1OB+D7rzVzjoz5yDgbYbkIY/D5DNzQroidIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bok+eFEV6NEvIvKG1/UudSfP2rClssP8V7zIjxaB9Fw=;
 b=kJhmXg5F835jPnU54kKt4ejK1zu+G/8F7TGWkhVTMjX6cUgdR/g+x6QE6JnTcadWcqJO81g5LkVO/zkkTRrR0tmobdsDnc+OHMM5vjYCiodILsCeNy9lHl8oiP5/iucEymqVkDZlpY4XvTJyRMxr+SHehtDlPCH9HqJVYcD0C7o=
Received: from SA0PR11CA0135.namprd11.prod.outlook.com (2603:10b6:806:131::20)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:04:22 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::5d) by SA0PR11CA0135.outlook.office365.com
 (2603:10b6:806:131::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:21 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:20 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
        <hamza.mahfooz@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>, <stable@vger.kernel.org>,
        Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 05/21] drm/amd/display: always switch off ODM before committing more streams
Date:   Wed, 23 Aug 2023 11:58:07 -0400
Message-ID: <20230823160347.176991-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dca6ee-efba-4da0-ca4f-08dba3f29d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vBwKtxQm0p4XVQEmeMp07+5lYwjB4D9JqOas1DF8hBq5Wt6b2gO1rN34w/a/ZSAPx0qGlh+K8vAONUygJAoqrqWgTbQg5TJ/wl3s/RiL2N3s94KxlmGPEfN7Rq2biM4+ktGWJ8X2NsgIJXHnVlNQN33nH6XDfXPo7dHvYEpxUyRKppNqOYwq381AG6G+Te1+7wvHsjhI/Kh53DpZ7sEG1iKpdJWkjBVdCqjGesPltYHI1lwrKx0u7dG8xYNnz/mg2Vfymfy2r+BMuxwzGGT0pmlReJ7/l6Mt0PPK23TU/YFKIq0F4dOFlzSiNQCNmF0p/uRI/tL3h21kFu1UW3I9nZRv64kwUOQfo5CIVzt77G8mQK3KiCEyhDFR7ZMFYyizLs5oV5Uhx8rJtlKYccvkBJDy7PGc6g23qSGdvvMf4/9QbqaefcAh2udh/eB+JcPB7Ch8zcOqbEHLuxRPht43NE622pfF4NSFPmMY6Y9D2UMK5pOEbmzMOfJbHdIAjZBtk+pYfG2jTnZO7K1cnC3cgzULQDJgBrDEp9svfJlQdYBI/4J/cplD3p40M/esxcIrGGuAHlnbcqZnNM1ni58I9/xj8+vz/cZLKaZXTl3+G/raF8B7hMLb5901Zy3OrJ0UtIhfPHYZBOiySo/RIg49YjE7OFz1JOVZwtzLmf+MnP7hTGJkgFYBpHuBboInCq4DSoGBJDSHXGm58zbjTbG2AWUup3Pynm9QZlIElW43IO6EGpXTIjeHHYKvU06HPkrJ4rzSdrlrNg++KtbpDulvZQkECB05EWnQQu7ewzvcIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(47076005)(36860700001)(86362001)(426003)(336012)(44832011)(5660300002)(26005)(16526019)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:21.7786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dca6ee-efba-4da0-ca4f-08dba3f29d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wenjing Liu <wenjing.liu@amd.com>

ODM power optimization is only supported with single stream. When ODM
power optimization is enabled, we might not have enough free pipes for
enabling other stream. So when we are committing more than 1 stream we
should first switch off ODM power optimization to make room for new
stream and then allocating pipe resource for the new stream.

Cc: stable@vger.kernel.org
Fixes: 4fbcb04a2ff5 ("drm/amd/display: add ODM case when looking for first split pipe")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 025e0fdf486d..c6f6dc972c2a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2073,12 +2073,12 @@ enum dc_status dc_commit_streams(struct dc *dc,
 		}
 	}
 
-	/* Check for case where we are going from odm 2:1 to max
-	 *  pipe scenario.  For these cases, we will call
-	 *  commit_minimal_transition_state() to exit out of odm 2:1
-	 *  first before processing new streams
+	/* ODM Combine 2:1 power optimization is only applied for single stream
+	 * scenario, it uses extra pipes than needed to reduce power consumption
+	 * We need to switch off this feature to make room for new streams.
 	 */
-	if (stream_count == dc->res_pool->pipe_count) {
+	if (stream_count > dc->current_state->stream_count &&
+			dc->current_state->stream_count == 1) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 			if (pipe->next_odm_pipe)
-- 
2.41.0

