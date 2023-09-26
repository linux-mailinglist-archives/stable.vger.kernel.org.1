Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7482D7AF64C
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 00:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjIZWaJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 26 Sep 2023 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjIZW2H (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 26 Sep 2023 18:28:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C691DB49
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 14:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVAa8JIzy+gQqs6BdOTMCmVLsui+28HwaDkABe+cR9vIzZxieY13pG8F7RKAkeuhoa+HovssvWWuxtY5YR9rKVNuWFnw1Y9R2ga4+nWqFlxWVSV0z6s+f4XyDu8GsOUWxE6xWnc4ZwuxzqM8ywT+y+cM/z/A1nS3sfDQOMnyZlWzp2fi2KMWL4UX8i4yUVF/Id0bt3qQn7FkRgKE7Scohqq/4/bh8pCc9zVYVRrdk/y9cJZav70rZ1tc3b1A0EQRvD0Li0uLFUO+uhMmR3Ix6zPEk4oAfCztTnOorlsDGT8oj/i1X8boHRvlc9r5lkGfaUhNw9gF/PEYx3NzFrmnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqMSU5usQc6YWMrgFPYw6x72I0s5eDC3LC6kfrQNIrQ=;
 b=Gp2yX67OanaN+23NevBDvS7mHmbXBDhIbGw1nkcgLf27hDButTdtny0zGvwnUrvLv+74up3GJDdw5NDem3XYB1NUiCDjsvpq11fUua9ElvCMKr0TXt+xqxei+r9/AduWFV7O8IWUoGj4ImHUH1DsbAi3r7liAMGwuLgi2bV6A4+tRMi9Thv9l3/or8M0BamPV2TKNwnzWji9qlT/ij9XBfj6fBs08yBiDcpDNqX0HaRJzA17sKe5hgKDkWPKV3hBDcMvMfuzwRJjbw+P44H+U1SlRlIcJwZZUXyUNaO7QQ327I9gSqztANnhpXAyuYqCnZCzk/3JWZFWJ0GBLSv/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqMSU5usQc6YWMrgFPYw6x72I0s5eDC3LC6kfrQNIrQ=;
 b=IbRErVXYE3sG/4mAv/kP2rCRedOs7SXz9SfZBG7yxmT+rnkYYQ5MNJAxVgtyaCrXlObiLjhEIYrDqXqDv9vW8Ta1jozXQq2elnHcn4PL8h2IN1Q4Z3T0BaPon5a7Y13HTpLMAdtE41Hx7nN+bcRMEVQlhldoZl/P5UlkhiJHcc0=
Received: from DS7PR03CA0065.namprd03.prod.outlook.com (2603:10b6:5:3bb::10)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 21:53:45 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::5a) by DS7PR03CA0065.outlook.office365.com
 (2603:10b6:5:3bb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:44 -0500
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:43 -0500
From:   Aurabindo Pillai <aurabindo.pillai@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Martin Leung <martin.leung@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 02/14] drm/amd/display: Add Null check for DPP resource
Date:   Tue, 26 Sep 2023 17:46:53 -0400
Message-ID: <20230926215335.200765-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d65427e-4c75-44da-2273-08dbbedb0e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhU1ZiWPeCxAxFxhSk6RLroLWozyV6T6kxJ56PFSmyo+D+Rbv9qvaJJ9ZedfZqBFL10qeBLTpLnUhNHF+XVve6YtWj3O7CdVT9nop9EalbgZClU9L4BT/aufFKpm/ZnI/c1lD0vjQoaLVx2Dhe2O/JWqLdJE1I4l7wMsi5Z5VeiFz9gfH96iYQeDBuLmb6SA/7O+xrQAKlpjnaC+f5rVQB8lSs1edf34+U8nIwo+RXhSIbWOEWCHVY9b5pZOToNH4QogBeatts6QDvUPuMq/6VlKiXF9lC83BBB4cD2X27rEBOIIEswskgtWT4mrFwF8EcZU4ktRvLI4SQxC/BFwdDeST1i169+6AYh76o3eo5az/nDvrnwCjfXeNK7RiIcqZL3tioRBqeCdy7/6ohgnlcXqERNkw2wMlt00nIPFMYLSoaWa5jkRGtOCOOByzXQ0CEVyH+ePqxCwKXXj3nGWvoXqtDvMBnOX9W0jCaQtNuKuEHOyw7pyHUz/TI0XrFxJdFFBeXjluuElzQewKro/206TdisJ+4Z6qBR+kI5xFE/AJWpZtIWaYgYrfirn+j7o7uYa1gd7b1VQOHtJCV50JD0K9GqBHnYqUS7U5tJ7+aPKVJczm+I5uTCmLnowV4fLcXYJX+MjSlbH75KghHasvIqye39NaWGWa2p3ccbbeLA0NRum6LvJo9QIaZpYdOnGv/J26xqQXYfIINI+QCZ74JAwAUc9cfK7Dc3qvedFkWdug86Wx/HfdL2FzmShev3/Re6On5Ol1cx5xVhrCAB7DA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(8676002)(8936002)(4326008)(44832011)(5660300002)(40460700003)(36860700001)(7696005)(70586007)(1076003)(70206006)(54906003)(40480700001)(26005)(6916009)(316002)(83380400001)(336012)(82740400003)(6666004)(356005)(41300700001)(81166007)(2616005)(86362001)(426003)(47076005)(2906002)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:44.6090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d65427e-4c75-44da-2273-08dbbedb0e1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gabe Teeger <gabe.teeger@amd.com>

[what and why]
Check whether dpp resource pointer is null in advance and return early
if so.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 628b902a4cec..aa7b5db83644 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -945,7 +945,7 @@ static void adjust_recout_for_visual_confirm(struct rect *recout,
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	int dpp_offset, base_offset;
 
-	if (dc->debug.visual_confirm == VISUAL_CONFIRM_DISABLE)
+	if (dc->debug.visual_confirm == VISUAL_CONFIRM_DISABLE || !pipe_ctx->plane_res.dpp)
 		return;
 
 	dpp_offset = pipe_ctx->stream->timing.v_addressable / VISUAL_CONFIRM_DPP_OFFSET_DENO;
-- 
2.42.0

