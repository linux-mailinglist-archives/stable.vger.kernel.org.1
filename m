Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E29B771845
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjHGCVu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHGCVs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE001722
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehFdd5BMK95GEn66DaiyyLrjIAv+Tjsehgy0zRW+8cWtIOTOzcd4sQr6eKeIEDV48IMAqpCJ3bvYrJMEoKQlbPwEYI1UrjBudJjT7OBgj3X+exuuk99Esa5GmuF/1HoLW+p9XOgmXrnwdnd5VRe2RnceroH9/VSQ191hlmMCro+jnWaHNQhRnveKQ3DkjNoJx5OQX8ofWT6wPRUWIwUC0uLwAFcRSttpQKNAWGWoBAelKDfQVzpR4mTrRR+APQCBop2VoPd3NG5vtz+S7XfUuweBEm+uP3qsusSKvci/NkUgwT2/ruxiipZUJmsqSKAbYLgqBbdMArTV9QEgd8W4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR315Js18redSpIS8RLZgfEoELAmYcmvwnUs/b7AQPs=;
 b=OqcBlXZ3V+196Aat7AlvfUq+9dAEyqc1jMk7MqFJwz98OOnAkUwcFsBG7mGQnybidcSN1CJIzplyxXFV+SfjW8m42869Omb6V7XTzwqLlzHgNVQzXMlcXe2zgCTAD/TBrg47gg0E48WeQAJd+MVoJnzLD/ZnJoS4iIdvY0foc5L7s1P8GY+QT8Lfd9yWAdBoxADIyrxfrtJqAiUtaOhFDuyKpCTqTd3rJz3qjlj41MdduLMf/y9ccj/YIKcn/BLf9elBQQqmGKXKmIOfvMJxYOJ/6WF3q9qcqfR6LhfXmk0zccK6J4y2Q0l2xKggdcWLPS2tu/XI2AJMFTSsTBQkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR315Js18redSpIS8RLZgfEoELAmYcmvwnUs/b7AQPs=;
 b=lvdH77q6H9L6zvEanomR6iY6UFeQ1Og4pcVpTc/XGW+yVrKC5p+YZMA6SbKoR/AsglOv7tAht8sTacaOGbkrQ7Zg0qR0DPwiIgJSCLrsrdFnduOIgdvCztL0xrNaIcSBC8dG1D8pQmtwQvswvcLCkejquMRnW33Y4w4oihG6GpM=
Received: from SJ0PR03CA0390.namprd03.prod.outlook.com (2603:10b6:a03:3a1::35)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:21:43 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::36) by SJ0PR03CA0390.outlook.office365.com
 (2603:10b6:a03:3a1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 02:21:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:38 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:37 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>
Subject: [PATCH 6.1.y 07/10] Revert "Revert "drm/amdgpu: use dirty framebuffer helper""
Date:   Mon, 7 Aug 2023 10:20:52 +0800
Message-ID: <20230807022055.2798020-7-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaab867-d55d-4b54-01bf-08db96ed0a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aswtOAgydtinvJufo9GIWmAAQ1rp9Y080Vab/QudPV+3b0SEMZvyLeruBIg+/cigdSoc+/259MINiWikc8auFE7OaDeGsZ7JEGAyBclCe6AFtbOZCOwapOJVKZ7UHAcltJg4AMwTWx0ChWQHboOdFR96K1xID0zWoWN02q/lOI06LTTXhtbtIH329g9FfIxF4MyilYlUL9clAlXOQ4jtdxWjSXx4poRJk66tcg5AF8mPRGJuvoUB8AFDTSTl1AGwIQGE3/8kE9YtOIPI4hmfVibmrRtMUQhAhljhi5HwnpyzrpuRfOuGnKJGWFhFXpHp1tWoH2tAgodaDzjgR+xOp8g+l9LBnvNfbgqHVmTD781Wq41lJiqmFoO6HYDAWYI+MWmJ+Ds5mtPNCBSsAHTrdcbzT5hAdqRkGNy+A7OYAEqtHesCcnwgnolu2xPN3s+tD4TTYmw+CjugVZaZ3ARY07zmFssTihqLC99ERSFZNOVi4aYF4r6VSjZ9LJOGrE4cFD0p4HbU+tyVDEZvc8xhNBd7+FMQyrQDOIGIVepw7y9as4x/lBcmBatx6NaaN25sFTGWI7lvzY0+ClkNQ1yBOrzVZHlvtlPZ2Smy/B6bm3KqdEA7RVbMMKGYPaSEoWjuWJI1LHzOEJVEbzTuMrZZPJssFO9Whawo8G26ACOvP6GfbetFG3lrLiAZIJCjpX97bf2GLfgHvhmF4i0r1flUvPLFzOsn6XKW3U2wI8vs0Y2ZBxyVXlJ+slO0gYTjscYqvgv5+la6X6LYetZ/0LX1aVQPd+CPxpLw/RT4Qwv4wqADZ5CHdmiML/bXoFTdQOm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(82310400008)(186006)(1800799003)(40470700004)(46966006)(36840700001)(40480700001)(336012)(40460700003)(2616005)(36756003)(4326008)(316002)(6916009)(86362001)(478600001)(81166007)(356005)(70206006)(6666004)(70586007)(7696005)(82740400003)(41300700001)(1076003)(26005)(426003)(8936002)(8676002)(47076005)(36860700001)(2906002)(83380400001)(5660300002)(43062005)(14143004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:42.8834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaab867-d55d-4b54-01bf-08db96ed0a7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This reverts commit 17d819e2828cacca2e4c909044eb9798ed379cd2.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index dd6f9ae6fbe9..fb7186c5ade2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -38,6 +38,8 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
@@ -498,6 +500,12 @@ static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
 	.create_handle = drm_gem_fb_create_handle,
 };
 
+static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
+	.destroy = drm_gem_fb_destroy,
+	.create_handle = drm_gem_fb_create_handle,
+	.dirty = drm_atomic_helper_dirtyfb,
+};
+
 uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 					  uint64_t bo_flags)
 {
@@ -1100,8 +1108,10 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
 	if (ret)
 		goto err;
 
-	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
-
+	if (drm_drv_uses_atomic_modeset(dev))
+		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs_atomic);
+	else
+		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
 	if (ret)
 		goto err;
 
-- 
2.34.1

