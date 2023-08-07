Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59F1771840
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjHGCVm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjHGCVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E701703
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERvT3BN3wsGCwBg/HnPM5rGGCjCTLQYFYghe9gOpgMW3C63tOz0QLiIJARRt4ipb4594FiHlaL3RvYfi29EowESzyOaR+N8/QWJC4yTjHvMQe7VIwJrBLEq5iOyzOKdfzZpbQf/R/mpf6VjzzBfdFCWjVBEKvaYO0SV30vnJsGU0UhFkVIpOpp6UZrP+kZ8bR41zPSqjdXTHUJQdtv2zVE50I1wqaKrtWfAxpzCUvRT0mohwpSjB+IiDeJlQITs+LYyk5B6rNBQUgnZRPDzaw9GCtgP5rm/QeJDj1+RtPNqO64+pJbMB5R1x+17AU+lwNN8FZ0lQHYEaPVseTX1IEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gjtn21YM05DwyP2DLeLw2h4McsLYeWiQIwJqityFlc=;
 b=YiLmiobJxs+ZH6t8oCpfjnHBJkWsfVygQZpMjTrIONsQhTK9WfMBJFhiqeGyumb5RYGmgbmWeoI5HfSbxaWIvY2RbDyHRhVY3r5Dly5mG8NFFdB4kEI7EYDiT9nnVyO+KqQmKA3IyJt9ITqp4JpRRztW4TluxtiidxLa3vqvNyN10BrUXCfxyAupP0fuSRn7uuUb+3DocIIdCZUnVo6UkEuLk84AQ6Wdrfiw2fT+CbxDr3JxoaAVCg5OqX5ItEDpoXLb6lkm263rDfpS+qj6VOtyOXnt02uQ+DWXE6KCybPzVlixOuZhNfgMQAwxriX+c/hEahLvhqNYGSIDqpqAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gjtn21YM05DwyP2DLeLw2h4McsLYeWiQIwJqityFlc=;
 b=p/VEiqmdp1udiBZWVKpY+fJ454Kg5xRhWTql+vJ7pHW/lSluLLyOrYzHjO1cK84WVfMMC6cBoCJ5s/JinylPgGpG5iRL6DY8mJ/OBrMlIKFA5G3DT1QUnaV83kjpCC/0VW4+KCZ/3tloFdpSkK8QMdvTIw1SxuHWInSumz3fE7M=
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:21:38 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::59) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:33 +0000
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
 2023 21:21:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 19:21:32 -0700
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:30 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y 04/10] drm/amd/display: Update OTG instance in the commit stream
Date:   Mon, 7 Aug 2023 10:20:49 +0800
Message-ID: <20230807022055.2798020-4-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d8e5f0-be4c-48f8-7edc-08db96ed079d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdv05gK3LLCap/HkoZvysUOqbu/HcXkaMytxmCZ8ppDoYPEPYYtrTGA69cXslqtf4uiNUt+rtPkQBq+/WSjsNszYTfuKUuXa+GpKMAhUsgyi8mmhp/ipgMl16kVsvnb9ROWQ+K6Us4muF4i24uZQYRDjDQrEnnlPhUcsdXurkoDPeMy90qH4OoiiNMUJ8HkafNTQt6vVTihEQvraUfMevOVskzjZsuTOYG/Z5BlP0G9sfUUOZWlEentwVG9oEM5ZCYw8XYmtlE+Fql7uXtcHZDikSSKzYfU6z0OD0//dE4TOCbI7aYWX5kaGOqi0+a0AgsMOOcHrqyseGkbiOkzm3IMOIl0HB8tnS3ARzHvVJfWKSPHfeEadSuQsC0ClARmNbdPCPkgcC1CqAND9EEvyDfGzTv5EHCJxTJFnnXD95uRdKrjiFWuc+B4d1CyC1YP9eMv6Lk/ziceV9EFMHu7/yr6+4xiQHxpeM/rkfOKQILav1Vy12+/UN1Y13twvl4UaUqBjudbxHn1Cz83rIvC+ueCx/XCkbaGMw0htfhO5JyYjJ1F77kezsesr58UtahGn/yJAJp44NMMj60b+p8nm2QFlAu6O713Wk0UdL+BrruPjHaOBXjGiJ8uDD+ucuBO1UwH0WxmFM98wJ/pnFcnF8clrH2CZN+lhs5pw7CMqLDVvBtOftWIxS0B9sS9W267U2Al+PEv9KxC9Wm8JSGWPzaAh0WZm73DjQ2H+Yx9oN6vggKWr5VJTF0sXuGcmQkWHmmHky47JI4s3yCe31AjBpLueaoVK8A7G/gKAEDekdso=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(82310400008)(186006)(1800799003)(40470700004)(46966006)(36840700001)(40480700001)(336012)(40460700003)(2616005)(36756003)(4326008)(316002)(6916009)(86362001)(81166007)(478600001)(54906003)(356005)(70206006)(6666004)(70586007)(7696005)(82740400003)(41300700001)(1076003)(26005)(426003)(15650500001)(8676002)(8936002)(47076005)(36860700001)(2906002)(83380400001)(5660300002)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:38.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d8e5f0-be4c-48f8-7edc-08db96ed079d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
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

