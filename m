Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28E725E7E
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbjFGMQu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbjFGMQr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:16:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03561BFA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKqjvjh2rUPrGuC/oKZihtnSDLXyIg4RU94CWQUMd9U0mYiQ2Qyp2r46Tq8/h+9VmIc1aWnmdIJpVm40tNFbFaPfWeqZ8Ftvcon1G0cDBA2vlUWy7TVJCI92QOxekkK9OkuPAZZDJCEwX/fUHGkvGwIGqyNRTHyriEDwcp/Kj92+8yCiX+pvkFCTG3SRETSctyN5jdRAGdq44mKGVxe4GC4zshsyCelUDdwiB7JCBvTKk2Q8r4FnVy3wCHYWRJW0l94S74i9Xe5lUBiI0BJlf5cBRBxTo/0SF0Behv7yQChXhMpMHLj7SHY2MzUOlPka3ULkk2AV+HSmEOwlYdDDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiakA8SNFP8F5ev/8jQ00qKyrWQ52Ym0+TJpA4Ng3ac=;
 b=nuHjvClMe2s5sPlvRlrvOBOsTALVal0Ecmd2wXGpG/KiPtHteNHgZua6ZBbtHjDWFgLZoegCFi3U5J2YDsWVkff0bIxI8lc6TNflSuj9kYQnsWePsuMt9LgWoodXPmxqIspQOo670dX3zPQ3iM+f1rYWiH816vj8Hwk25FQwiEHumKqg84u5bmRTgFOT+AkUhTAXXIlVHjrzFUUx7hsF9tu0qKtzKkKv/tUzLu84dWknWW1vGOhMTZENbuXtk1+c9sSGw9cs4FqQdy3E/P05qg4wQLbTMdCuopVRJ1xCsr6xa1k8AGZHErqkFmC3xfSI2jm/RKRCkEArMhW5ybVIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiakA8SNFP8F5ev/8jQ00qKyrWQ52Ym0+TJpA4Ng3ac=;
 b=xqYBieU/j9lA9tzuLzdJORU6sDsErcx4Ufi6A4kiVUl3QZZMqhbpXurBVSgGFxn6MTaTVVa0bHJdDyDV8xEBnoZUs9zwE+H44x0MDeZ22vfpsySe6CnsSRfe2Xm1Nolu1ix6O6I6H0QVAX3+YXkb7pswJLaFPNCgswtvZHo1ZFs=
Received: from DM6PR02CA0131.namprd02.prod.outlook.com (2603:10b6:5:1b4::33)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:16:36 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::48) by DM6PR02CA0131.outlook.office365.com
 (2603:10b6:5:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:35 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:30 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 06/20] drm/amd/display: fix the system hang while disable PSR
Date:   Wed, 7 Jun 2023 20:15:34 +0800
Message-ID: <20230607121548.1479290-7-stylon.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: a9493748-0a38-41b0-ebc9-08db675109d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01Ko5GThvIkBBQpYBSoJppX366N2IKpO6DmAMo+78J7jQFzvYOavSMPrwAp3AklaLKqUJs0zH/Wkx35UY/n5LpQxK9gaaXpSxYK6aQZkV+1JTeyeWvabGqkmZyCMITvFcZSnoozVq6tJNbtiGvwTnf32XitT9lQo+HXVky0ZV05SOWCwrwkQiAoOF7rPu26Z+JrZoutqYnCGp4fU1R3l3zMV+MJIw147iGpapkc6JslG35O1dnGi+uOUo3OntoGS6e/Vuh6QfM3Kc+RS3txdRJ7ZRvLtngRCLIcXvgHFi6RSGebNhHj6yeHCbyLXZwWSnJ/odWqbudVtnudGetVQXWV4gO2QA81ToyZdpZRYElZN97Fmk3EPevr9kroyOQ2+HvlDAU+2v56NtYrypAxfU6vnR7WwpbRdTQaNQ1qEjUWxpvmjxQMcKzIBFGwe961IwpMXI4ioMjFlr5hBxoHFoGGCRwcxt0E5IZKIzl4XPbJrAoKGdGQpMkcZ86Rns5JAbtBvTmJIFDxzUfPzTyyW+hgN2d77/t0oPXG2i928UFa4CxhbAZPGq7hTENjjoK/d+e7EJ6QxaVnoWmrYeERIRaPKjgwsD/Skt6PlyMkT/b1S6XcsaWsZYfD9esKM23ZCUkQKXMYWL1mQTFkBW81w23Rcdab/Zux5lYdfQYnq3b6k6q4mnkX2I5O6dcWEF5lD0Axmp2JakmPZmBKNg9UQnI9JvxNMl87OmI8hOKRhM8U9O8DfmfUmBJ6n3WOvib62YqPdNOzvZmF+Nz240u4PIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(47076005)(336012)(426003)(2906002)(2616005)(36756003)(86362001)(82310400005)(356005)(81166007)(82740400003)(36860700001)(40480700001)(41300700001)(316002)(5660300002)(8936002)(8676002)(7696005)(478600001)(54906003)(6916009)(70586007)(70206006)(4326008)(26005)(1076003)(16526019)(186003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:35.7277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9493748-0a38-41b0-ebc9-08db675109d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
When the PSR enabled. If you try to adjust the timing parameters,
it may cause system hang. Because the timing mismatch with the
DMCUB settings.

[How]
Disable the PSR before adjusting timing parameters.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9279c1d474f2..cfd1a67cf7d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8244,6 +8244,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level)
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 
+		mutex_lock(&dm->dc_lock);
+		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
+				acrtc_state->stream->link->psr_settings.psr_allow_active)
+			amdgpu_dm_psr_disable(acrtc_state->stream);
+		mutex_unlock(&dm->dc_lock);
+
 		/*
 		 * If FreeSync state on the stream has changed then we need to
 		 * re-adjust the min/max bounds now that DC doesn't handle this
@@ -8257,10 +8263,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
 		mutex_lock(&dm->dc_lock);
-		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
-				acrtc_state->stream->link->psr_settings.psr_allow_active)
-			amdgpu_dm_psr_disable(acrtc_state->stream);
-
 		update_planes_and_stream_adapter(dm->dc,
 					 acrtc_state->update_type,
 					 planes_count,
-- 
2.40.1

