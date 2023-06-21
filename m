Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947B17391E2
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 23:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFUV5h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 17:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFUV5g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 17:57:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A066B1AC
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 14:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adPZLNcSgn5gICZcoH4tI5l2q1xxW8KoMROmfLFATheoBey1q0iosHhAKRNKr+D8jCvtVJ3E22cpk22V/9toKYTxVlG//+hqFM4KaPIJr9WHNU28LIan9WMqBHbPzAIpmNF5xvDFbbfwlJBhlbq/GMaCdCHYQUQdZQkUd0K8zIEg/79S/HxPHFQ++3MWl6D2qlWGHBBYhpKzDYOLvliJr7lh6YmiYf0/h77aWrlGIGlgJapPjKSPtIAqlF2rhblh4qQQBflXs0g3Ayv2Rg6rEJJ+fFSg1WQDNcMIZh3tVNlHdQMqSl85ADd4twZw6XVYds5NV0KNZj4H3mRPj59mqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2I5ZISunKKE+EF8Op3cRsBRiPLUtbCO1zF3H82JHUms=;
 b=QY3plLhOYEfEUSWV2BdeE4aizWiAzTZuD3k2FJV9HfzoXHLMErVJdpnaUqAjYg1TSk/ZS8Sxf5HuvaToSIWp6X/AW8mVjIsB7mqBVOLoSRnZ9MUes6Nn7x9UYcZUGYfXKtnrKinEIDwwUnluynWTn5xwWOcX0NgxOwjESQFNMI6sRQ0ZHGU5oot9rNe3cK2e4LQ7ywX0XzJ+bEUocr2WalQHEMSBuiOCXa5dJLohuJiGIX0ozFCj5wB58DxPxZ4b5OBmwnMuxjaYo6VjpM2UbjYdFbxGeautBGrMxOL1d7iiw3s/7D7IMqGNWy7Lque2KHI/ZWVamA8RgjmvviUiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I5ZISunKKE+EF8Op3cRsBRiPLUtbCO1zF3H82JHUms=;
 b=tu4fNjkc2QkkXJoMmwDj7SlZaPMkP4NqLa16z/uvuha1TyZVo/7vHrArItC0vHhVaj92MWuXegvI1FIeKKVY4QWAnIxVcbgCMq4ZufXx4IUJvfNQbNk8FRIZqPK2IPU94ZOYnl8QiIuJ9oRZJN9uZ997oKLLpfJ/Lo41X7Xd9ok=
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by CH0PR12MB5090.namprd12.prod.outlook.com (2603:10b6:610:bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 21:57:31 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::3d) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 21:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.38 via Frontend Transport; Wed, 21 Jun 2023 21:57:30 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 16:57:30 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: perform a bounds check before filling dirty rectangles
Date:   Wed, 21 Jun 2023 17:57:11 -0400
Message-ID: <20230621215711.133803-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|CH0PR12MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: f564801c-4fa8-4cc4-35cf-08db72a282e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5p+7JjkYQaEWXQ/6Ptn9MxL0G0T5mPJpL/GBD60gAHcVRih2DSZeE7GmYq1MyOJhirVoLiKgR4kmicNAU7iSXIqCHgOT4yJDPBFjnQ6qAIliKtAU9d6xjuSDQ7wXpUslR9matZtDjvq6aX4JduE6AXIWwrJBcjE7iyf1Rtnh2DzBADZ74rL1Zq3En0P1BcQPG01qwBstU/TeKHh3STp9LIdpRX3NdsHUdWgHQS2yBHA1Wwyp8yxQzJ0ITrBnzp3kY/Y4J2BhAakfo58HYV6xpwfh2qdF5oL+YgrPWmbIXlZMQ0KP5+NC0IvafJX4BqQcqasQOVMYo6J967sxqtnTwAN6RwUTe9sDRSiz/thAVMMQXbNBjXY8KX9AvsNXfMIQzC07zFuDOMUGZj29pN7NQFK3cQpxuPIsVBc3EF2BP2fXM1Rc4Ffhcb6SGgaN/zrXLRqYOzr+mfI92YPt+7iHu08pC2fSJ8Cj9qkKr83uSOB4GIyGj/0tivoq8wg8cRVVxRKlwgllhPp/Me7wUfigCW4anyjBLcCONjmh6RdUfg070O4ttU3kBaWETOe49MNteXbdOH7rdyWGmEX6mhZMdnC6vBxXXE9UR73wBOMC09+XHf2/rQXmPlNxY0iXEGG/tj2EwwSDbQoDrB3krW4ZQe4SXE6uMPCazap958JCWHbz2M+ePSI5JaruooGqIQeGBsjcughsmHCGSUtQ6yR61Hckvk/grMa8YYpztWp+vB+/QJliUTJa+3549v4w3OmM//3shXCOR8GdQbdV+y8NXHP20N7cJ4ww/brmKB5p93rRuEPZy1oWkueUiYBsWheQLslMujDCGoCZnrMuKsCtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(478600001)(6666004)(70206006)(70586007)(26005)(1076003)(16526019)(186003)(2906002)(82310400005)(8676002)(316002)(6916009)(4326008)(41300700001)(44832011)(5660300002)(8936002)(82740400003)(356005)(81166007)(86362001)(36756003)(40460700003)(47076005)(336012)(83380400001)(2616005)(36860700001)(40480700001)(426003)(14143004)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 21:57:30.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f564801c-4fa8-4cc4-35cf-08db72a282e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5090
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

Currently, it is possible for us to access memory that we shouldn't.
Since, we acquire (possibly dangling) pointers to dirty rectangles
before doing a bounds check to make sure we can actually accommodate the
number of dirty rectangles userspace has requested to fill. This issue
is especially evident if a compositor requests both MPO and damage clips
at the same time, in which case I have observed a soft-hang. So, to
avoid this issue, perform the bounds check before filling a single dirty
rectangle and WARN() about it, if it is ever attempted in
fill_dc_dirty_rect().

Cc: stable@vger.kernel.org # 6.1+
Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 64b8dcf8dbda..66bb03d503ea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5065,11 +5065,7 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
 				      s32 y, s32 width, s32 height,
 				      int *i, bool ffu)
 {
-	if (*i > DC_MAX_DIRTY_RECTS)
-		return;
-
-	if (*i == DC_MAX_DIRTY_RECTS)
-		goto out;
+	WARN_ON(*i >= DC_MAX_DIRTY_RECTS);
 
 	dirty_rect->x = x;
 	dirty_rect->y = y;
@@ -5085,7 +5081,6 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
 			"[PLANE:%d] PSR SU dirty rect at (%d, %d) size (%d, %d)",
 			plane->base.id, x, y, width, height);
 
-out:
 	(*i)++;
 }
 
@@ -5172,6 +5167,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 
 	*dirty_regions_changed = bb_changed;
 
+	if ((num_clips + (bb_changed ? 2 : 0)) > DC_MAX_DIRTY_RECTS)
+		goto ffu;
+
 	if (bb_changed) {
 		fill_dc_dirty_rect(new_plane_state->plane, &dirty_rects[i],
 				   new_plane_state->crtc_x,
@@ -5201,9 +5199,6 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 				   new_plane_state->crtc_h, &i, false);
 	}
 
-	if (i > DC_MAX_DIRTY_RECTS)
-		goto ffu;
-
 	flip_addrs->dirty_rect_count = i;
 	return;
 
-- 
2.40.1

