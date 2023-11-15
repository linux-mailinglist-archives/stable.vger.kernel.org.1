Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288707ECECE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjKOTot (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjKOTop (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:45 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A030B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUOKbC4pFJ/BCpfGnsa8eeUlLfqovhzXQLUv03hDvogkmoNq5siBME7MGChFr4lbUKzhjTzFS8sQYXWgMha6dj7TmyAJRCSingXPFmHqReoWIIiWOEToxRsC/pyZTTSKoeLuObIhZcHwNKg7orVBVjs0uNGefb51/qT07s3H0LdOJ05PiRU581For+ovcj6aPqCG/vuGoGLylulnXry3DyClZkvZ1rEqkBdjRmpjsqdPvf/TOdscvPdF6IsInqIJfN1+k2H5Qg5uM1uswBBZ+VhSC95KVEtMHfJPksxbtiwCKXSwUT5SSskvtor7nvdqV9Rs/753wkyifWgu8Bfs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK7BlGZxMCGCNfY6PqaimD3j0iGGZoFqs7fz/MFyY9U=;
 b=Ex/Ul+D3if7iYNQGb4MyVQfX6pwM3GS14pJeDM8g4E10WD/IBqnoJh/zvSKcmvWXQnrRlWMdaSfVMlUFjeFDPVrWiZkTxVgcXQvBS+YEWaQQ7BSRqcf/WHZPBnoRP6Eh6o5niQnYZyB2ioO/kHkyrbeI+fCEn1JFyYknfOl7f8M+UIfOeH4BPvuIoAlMeu1/6q+2TTJkU28b1v08RLak39Xdsc1wNDBvElP9zU1XDkPngc0oBH/Kn5NblznbODDpt6LxD7QZlBdtoYDSYz3DGT5zjkuCXvlOUAQbXPBS/+URM2NNHb4rEWW8Y+NTZvBJxSxGu7wsMUd7XEizsuXFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK7BlGZxMCGCNfY6PqaimD3j0iGGZoFqs7fz/MFyY9U=;
 b=IAy/FoA//RK+1uDHH1lok6JYOMsyxXWaKDDb28NRIlHwUQhK+hMDY3HqBuTUgE+6trtcJW4qqbXLcU6YruGpBh1us17PtpkWe5ZbI63HnHVlbRjdK1XKYnU2EjMfovz04ulrL6/IPzCnS8eFsYgggVrdZJTPHC5HROdfzoo6u+M=
Received: from MN2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:208:23e::9)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 19:44:38 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::13) by MN2PR14CA0004.outlook.office365.com
 (2603:10b6:208:23e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 19:44:38 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:35 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        <stable@vger.kernel.org>, Syed Hassan <syed.hassan@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 24/35] drm/amd/display: Update min Z8 residency time to 2100 for DCN314
Date:   Wed, 15 Nov 2023 14:40:37 -0500
Message-ID: <20231115194332.39469-25-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: af8aeba8-1739-49a6-49ab-08dbe6134dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2HFTdBnoiRbD8FxWaqxwAw/qu5/cnCJLeL1A8PEhpUEIhetL5vIlZJ/ynTa8y/6I4bhTPVBhbZ8XBMq2AQ9/xr3FqLvC44UK56Khx4ZB+dOVzIYK3MMnYxQDXrbSyEI1sN9Cq8Je010UV0fVrCG3EF0XU6t+/mkkmfCoEBidPQ/rZ/7oEHt+ICcjjpbGBZMgYp54XrrGxIJZaE/uZ49I19+wW/FILATjOMyJe9JHe/iLOWGdLIX5YMU8OulhjyatCdGCqsCPZAbYRrr8kLdPZNV+3yK/PxQcA7nxLSTDpNMOE5OPruzJwredk8h+I9Kvz92rr9v9Rr+WTWTpFG9fKPynE7Uyzmn8JKASN0CibJSX+4AbtCdU1KXcpd9zN7YOdhxrihixQjWEyXt2qKl1LHdH46iDTeQAhP2BLBeLcJ5iP1vt3eFeCKrUlGvpddJNksq2rFo5NvAFjuzQwRxGbd5XaP06LQugHLDl1k+NPznWHpJrZBLovmo/rMVVJZGyNEKYLcjPDeb+evpLFS3x1Pzh6+ptF6KeNMZ2HMrnhx0r7W9ZFVdDn+3PoVBZSW4izyzBWgeAjtnIzbkN4LhZVxKv3YoPOjzTIcedXdmvGboKOcx85nr2AuShjZ5CFSadHMLz3UUegxW3aere4HkZyImZssoHu3bCNCIXKNA8AFwH5z06ywjezCDgQn53T/7Sbew30/esanN3tcnwJCOsU1/EaP0o2kbhKwSffM8Ez0jhWBHENxSRe0NF3j4KqRCp/DAZejTPVhHLeKU2ljZDAOFjtB2uYDBYKF8G3w4UcyixAGxjfiB7wu6gu/PjeTF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(83380400001)(2906002)(26005)(2616005)(16526019)(478600001)(5660300002)(1076003)(426003)(336012)(47076005)(8676002)(8936002)(4326008)(44832011)(316002)(36860700001)(41300700001)(40460700003)(356005)(82740400003)(81166007)(6916009)(36756003)(70206006)(54906003)(70586007)(86362001)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:38.6196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af8aeba8-1739-49a6-49ab-08dbe6134dc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Some panels with residency period of 2054 exhibit flickering with
Z8 at the end of the frame.

[How]
As a workaround, increase the limit to block these panels.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 677361d74a4e..c97391edb5ff 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -871,7 +871,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
-	.minimum_z8_residency_time = 2000,
+	.minimum_z8_residency_time = 2100,
 	.psr_skip_crtc_disable = true,
 	.replay_skip_crtc_disabled = true,
 	.disable_dmcu = true,
-- 
2.42.0

