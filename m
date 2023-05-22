Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED270BCDE
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjEVMEq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 08:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjEVMEp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 08:04:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BEEA3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 05:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJfs3snWglsP2tKYlz26Y5emzXb6DeC21POfByh0JqoYQUZXuyzjwlk29SgTKFvet6Cf2lwOh9kAXjLiti99bxMwMfM7sjoe7wSxTaHhcDx84qpSV7+7PFnf2jYa8P5B7m0iX2aL5SPt1SZsSKYNf5ZyITcwF+0yNzVSvrJ8ltBLI8oBPSq3e15q5lYsKNL5x/TY4fHyiH4DWaMQKy5layNHs2MykKved5NPSxH5lUR2mFd7QVCu2ZL0+PzEus9m3ZGEVCmCJson0aO384uTLZGu5XD1KMvR0n/807CgHJWyzOsitxr19jpd4Z5heQWfmJxMRSIlMqyNhS1zNyfIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIxSANJ770p4UR0rWE6FN1uXTE9GPimdMbGh0adENKQ=;
 b=K1ANvkZDLQvxJkItB5t9jiljSADFUbFEh48TqdPa3vy8HqMtxOGGFiA021KUzWrJWZe/1W+xEx6Ife9F0JOhtm1DUfD/fkV1unY2KfFZupsM5wcaTcnBwmyYNOyoiDZsimORgmKSvKWd1LhZlb3X2DmU7pTJSO0VI13aYO3KwbjQ4BoQH5JHuvYy9T0LAps91HMeyZwN0RA9YBwIgEkPXb+z0vs9OBauGoOF36j+BGk4X6oZbY4nuFX1MIB8zdwmWcJHMt2pKeYBSiDbxylVKabSExhKfn98ioWfkuhB6neUw48LGjGeAs4gHD6leVt0ca88b/Eids73ZyruzHIIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIxSANJ770p4UR0rWE6FN1uXTE9GPimdMbGh0adENKQ=;
 b=S179e/mArZPabbpkjH4iRRQxwCAYxNvicP2OkCEENWolFTyAQ0ESYcyOmN8ytKdIgJuRu8ZvkbsIUOJbzS+ut0sTZwg6O1cj0ZcbQ+cRdDfdJ9BzRZMW6XOAidLyyaat1Csispevdztqovot9eTjMV9aoKIf3+sGn9TAnYkiT3k=
Received: from MW4PR04CA0257.namprd04.prod.outlook.com (2603:10b6:303:88::22)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 12:04:41 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::16) by MW4PR04CA0257.outlook.office365.com
 (2603:10b6:303:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 12:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 12:04:41 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 07:04:38 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <stable@vger.kernel.org>
CC:     <stylon.wang@amd.com>, <jude.shih@amd.com>,
        Yann Dirson <ydirson@free.fr>,
        Alex Deucher <alexander.deucher@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] amdgpu: fix some kernel-doc markup
Date:   Mon, 22 May 2023 20:04:13 +0800
Message-ID: <20230522120413.2931343-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7db66d-65dd-4900-d889-08db5abcb94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSo2eRdfsqUG4f5knjKk4kVyoLXmba1qtbxoMNgKJgUYyFClEDo8eTK4dqeoyLT5Of/V5Y1mu/2Ll8Pt8skRg3AMXGBxaTbbs/JsoPb0bXMcjeB8wl2UZgg3pumm3w93E+1qQoBZywULEN9B/4iy+VAMWWO804QKjlYWBJRR5xgiFLUpWpTcEFDQMcW/mcpOz4RiLjfJMUXAqczkJyHhSgJi3HJUx7xuTMeqJ+Qog4RnKrA9YmQ/EW2I0pjJVO6Unm68yGRzPPnt/J2qlMd++cIWe4j1iV4ECZFAt/p1ckrSPcupQVY0oP5SxOEbBSlMauehs2scinqE5Phj+FDQYHJiFThwG+3j0mlfTOFhPYKna915VeteVtyzg92eNbol+Nm6bE/P11um+T7rEbgH1lpao5wPwAuPz9WaV4yUyB2RLQ2eY+CdQ1gO23MZ4J7LNwuTV7ZyTHtzn64fA0Qh4KtSmh3mrLbFOsTaIVqm8OEGjUjgYFGZYjY6HWdVyQTyvAM7edZc6M2HdvmQWZ50lMhaVA36csu7AM8NSFstWOLFLTxgfrnXstwYyK0OpMV/Pkt1tpQZDwQzc90p7/db83WsOC8PTd9nwHVePssHVicxthBnUTIllIv5ID1lL8R25EiUjGkxUgcs6BTcpcOgSYUFQIKxOOrYHdSzf+bFc8JMPKp+zsjOpADW3BG3EU4S6/Ll7U2AH9soL3PVJRxZwFa284RZoeF29XgXmAmYYRA5PjP5t/pl4FtlnDdDXFk2OqYL8D3CAvUCNapnvHC8Rzt24XNrfywgc2sKZ//VXHVSWoH0jzIkcXvpG8inwmOfpNCpn290hSPA7ZMxbVV6Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(8676002)(356005)(5660300002)(8936002)(82740400003)(40460700003)(36756003)(336012)(426003)(40480700001)(26005)(1076003)(186003)(16526019)(2906002)(2616005)(82310400005)(86362001)(44832011)(47076005)(83380400001)(36860700001)(6916009)(4326008)(316002)(70206006)(70586007)(6666004)(54906003)(478600001)(41300700001)(966005)(7696005)(41080700001)(36900700001)(15866825006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 12:04:41.0692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7db66d-65dd-4900-d889-08db5abcb94a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yann Dirson <ydirson@free.fr>

commit 03f2abb07e54b3e0da54c52a656d9765b7e141c5 upstream.

Those are not today pulled by the sphinx doc, but better be ready.

Two lines of the cherry-picked patch is removed because they are being
refactored away from this file:
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h

Signed-off-by: Yann Dirson <ydirson@free.fr>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302281017.9qcgLAZi-lkp@intel.com/
Cc: <stable@vger.kernel.org> # 5.15.x
(cherry picked from commit 03f2abb07e54b3e0da54c52a656d9765b7e141c5)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 6 +++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b0d9c47cc381..a5cf672e79c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -557,11 +557,11 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
 }
 
-/*
+/**
  * amdgpu_mm_wreg_mmio_rlc -  write register either with mmio or with RLC path if in range
  *
  * this function is invoked only the debugfs register access
- * */
+ */
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 			     uint32_t reg, uint32_t v)
 {
@@ -1107,7 +1107,7 @@ static void amdgpu_device_wb_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_device_wb_init- Init Writeback driver info and allocate memory
+ * amdgpu_device_wb_init - Init Writeback driver info and allocate memory
  *
  * @adev: amdgpu_device pointer
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fa4f0a205127..81d033b99591 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -622,7 +622,7 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 #endif
 
 /**
- * dmub_aux_setconfig_reply_callback - Callback for AUX or SET_CONFIG command.
+ * dmub_aux_setconfig_callback - Callback for AUX or SET_CONFIG command.
  * @adev: amdgpu_device pointer
  * @notify: dmub notification structure
  *
-- 
2.40.0

