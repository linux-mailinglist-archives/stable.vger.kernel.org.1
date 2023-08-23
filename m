Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4B7862B6
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 23:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjHWVp3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 17:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbjHWVpM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 17:45:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFEDB
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 14:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXn6kxE6blQdWxbK/VW94oMxgm8R4nz7kB4mH465YfcgjFHUC/5gXQxWaCkSzk3/CtGN+M5UoXWUWNQzbiypAk/SI7gwfF9wdl3ae/XeFpPGmhy2DamN8R2Px43mqY2DWughRndifWrpv9kJdIX+lE0iw2UiInbUxJf6zDTGwRPjfrmR90IF34BlaFVYLW5XVZq725iGuliqhsijswI1txKH2J7J22CFt6cnUG5H/+5soE2eqxwIEc0fwzOP8q53VRMuxHiXe4m/iclw0rch28tEL5Mkn4uODAFCskSM7pByw0hZM0I+QX/W9kx4leLeQOPSMiWo4y+QLgKf9LOOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaEL+SPmWXtXVIPhtze0q+R6sB9BMs5U9VbafoKy0vQ=;
 b=UixGMVH23LKbJN2ELe/XJEMvNSTy6sc+gVYZQbtxB/4JLj2OZ97Sa5YJda9ZBMza9I4EcQBO9WH1RMeSWXzz19MSTC1F1giIrCxeHPETEIpdpgY7600p32QOMSsxnxDoPfh3Havb179ZnzrvAP5XLSdU1wjf6DX28AqQXM/j0Q0WQb/v5KWBZNAH0dXYX6a9R15t/nAESW7qZAEO651M2DJuZGAddrtWj6tSnzTvPk8WyAFYSny50sBA2Fk6LuXyMkjnROc6K+EEuqwBMu4Bew+AQBnGdv1xMLJy3mbHkGnWBDq42M8mEsw9JxZBEXXrmgF16XNotGBLVpDAh+x/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaEL+SPmWXtXVIPhtze0q+R6sB9BMs5U9VbafoKy0vQ=;
 b=Sy16o1nByB0B7b6vcWAuGIo3g3mXFgiThlHKX1SRAtFMEebt+C0dc1lKRH5YKndqERUh7uDkGCxEowgvV4RPBFRytHjkbIAnO0d/NHOsYySo07tkHELOklpxgl4Iw23Hs8jb1uERY100lLA2AmhWLwVg4/CSxvvxEhydZdl0vEE=
Received: from CY5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:930:10::34)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 21:45:07 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::2c) by CY5PR16CA0022.outlook.office365.com
 (2603:10b6:930:10::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 21:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 21:45:05 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 16:45:04 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        "Aurabindo Pillai" <aurabindo.pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v3] drm/amdgpu: register a dirty framebuffer callback for fbcon
Date:   Wed, 23 Aug 2023 17:44:50 -0400
Message-ID: <20230823214450.345994-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 0817d043-eb2d-4b1c-f2e8-08dba42236b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3dfjo+aohaNzlNqR3q4mLothveHD7E+4rtKOxqeozvY5mfJOjRB2EcatoTzAfQPxDBEhSTR4l0bfEQ3NsywjtyFmwMESyjX2taMrJlZnQ0t9P5P5mL3AmJMrr6mNa5Vl5mV9HEIBAnPqPhu9/NmsgWJDC2FnBlhFvZybDpCAzy4K2vena0DX+hq8ZdjBBGNK7w5Ghl5ezg0zRCt0AH4SrmP6UD6Hs4XAsd5U5nGhfrSGRN5YpT+3C+Kg5U8cMt98zJnDhYRLqb3rWjutK1JisRGOTe16dQ022MnRbeQL6E2OsVKJDuwhUCNfYYyr3bmEbCBPkwaytQXzPhqudwPo/biHO/y0BwjimyivYZGDcuGoCvYDEgSDSrw3TOSOk9u0c78z3ER0rb7IFI299hjZc3e5/eNPVzrl585L43hikCCKgoEXd89IwBPxhvyxDDjb90XoW9LxzlinVjU4BxApq6qWNBsKGeKTIxquCjppo6kWHbNnLuyA/OzLq+uydah5qi9FgP9/3Dxqa1bTicINxFAXPUaGg7n9nduVOQ6xteDc7d9g9aazZwOdSU0uuUt8RcSpDm8O1rWi/sz7zZxPSUpa0MQmBzjp5d04B58JcUqGrFca1vcf1oSmKUPLXh3/5AYQ3/a9JjvLVw40au5++7rrUV/WR66iZwgJ0lbLPmBSIKXfKKWfUSVPJz/pecw3+MDiQBacYa2ltQz4CaC7vG9tr55f4fiS8+hbXqaHcjrll0dibhV9m2F7+Wi5KYlI38N3Cg4pJf5bEM1tcfZjQzxASvyTIWzwOKevu2n4rFnoIiw6Axop+qGnhjaXSTG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(966005)(6666004)(478600001)(36860700001)(81166007)(82740400003)(356005)(83380400001)(26005)(2906002)(70586007)(336012)(1076003)(16526019)(2616005)(47076005)(426003)(8936002)(316002)(70206006)(6916009)(86362001)(36756003)(5660300002)(8676002)(54906003)(41300700001)(44832011)(4326008)(14143004)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 21:45:05.5766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0817d043-eb2d-4b1c-f2e8-08dba42236b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

fbcon requires that we implement &drm_framebuffer_funcs.dirty.
Otherwise, the framebuffer might take a while to flush (which would
manifest as noticeable lag). However, we can't enable this callback for
non-fbcon cases since it may cause too many atomic commits to be made at
once. So, implement amdgpu_dirtyfb() and only enable it for fbcon
framebuffers (we can use the "struct drm_file file" parameter in the
callback to check for this since it is only NULL when called by fbcon,
at least in the mainline kernel) on devices that support atomic KMS.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org # 6.1+
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2519
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
--
v3: check if file is NULL instead of doing a strcmp() and make note of
    it in the commit message
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 26 ++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index d20dd3f852fc..363e6a2cad8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -38,6 +38,8 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -532,11 +534,29 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 	return true;
 }
 
+static int amdgpu_dirtyfb(struct drm_framebuffer *fb, struct drm_file *file,
+			  unsigned int flags, unsigned int color,
+			  struct drm_clip_rect *clips, unsigned int num_clips)
+{
+
+	if (file)
+		return -ENOSYS;
+
+	return drm_atomic_helper_dirtyfb(fb, file, flags, color, clips,
+					 num_clips);
+}
+
 static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
 	.destroy = drm_gem_fb_destroy,
 	.create_handle = drm_gem_fb_create_handle,
 };
 
+static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
+	.destroy = drm_gem_fb_destroy,
+	.create_handle = drm_gem_fb_create_handle,
+	.dirty = amdgpu_dirtyfb
+};
+
 uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 					  uint64_t bo_flags)
 {
@@ -1139,7 +1159,11 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
 	if (ret)
 		goto err;
 
-	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
+	if (drm_drv_uses_atomic_modeset(dev))
+		ret = drm_framebuffer_init(dev, &rfb->base,
+					   &amdgpu_fb_funcs_atomic);
+	else
+		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
 
 	if (ret)
 		goto err;
-- 
2.41.0

