Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B1A74FCBB
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 03:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGLBfh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 21:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGLBfg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 21:35:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D3E69
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 18:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdnvec3ZhDENQHbZB+KjWvfKGftRJyAepJ/zvhGd5F5ZwxBbMfDTuDjrtTFBHaTD+pkNFciMB6of3FV/WTVPE2ynYxOAVfXmDk4LCOHxC02UE2EusRlFN0Z5Wm13wOw5GBmtLUcnJD7xb6/EfRDSsvJIDkgD6ALfrkfaMAsX7ftW+6SyKXL9u6xOSImnVguUEzJurvNDb/0Pg/mUeSFmdO703rA+052BqmlyB2OlQPIAIrA0PUHETqrL6nmI9feTvdzrvQpQG4MC2FFxBji2dXyNqxOlR6ocqszPoZEIM2T9fXCVdOXlqqYQ32VPpS4/GTpBHmILItc3Q62o26Dk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saIoSUefM/vAQdFW8mK1xcTWkCzm82q5R2oLPgL7Vvw=;
 b=TUCthsEA2NuwUw1X0risKeLWcbM4wDU9K0l3p2+ssXpT7kRNc3/v47DhKqJ4cxzn+uegJAFWXeYGojdv4MieYJRwqVvJL8fVdhqHosZ2zgTocUbwR6c/NYQhebBYifhMIoBni0kdGZbfD+4x0To+5J8AmijbTTf92QHrr1ftN9FDEaJ5aFt+emEHiyN6L5M2dEHvnSTq+Fm6lWiFQ+3HiCkAL231rWOJeq8Cz6VfqaiMLp8ZEwS/0QJgRlnVJIUduk2upmg9wYoL6pCy/72FJRvp/syYe5N4nLjtuG9knxvaCqJAGpxEgYoHNRiSAsV5bKC5+IoBi2w4lFdPmSbCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saIoSUefM/vAQdFW8mK1xcTWkCzm82q5R2oLPgL7Vvw=;
 b=xtc1ufStmFuawLO1dyUknP7jPDsi3mqJ8NJA//ryEjdOL7NGtxN3DNCMXHt01eYHon1x58nUQ75W1GQGc8PunDBIsgn6iPIyZz5V4du7ovT4EjkDz7dHYyFPd5PdUmkcbwcFCYmTEP5L2sIYf6cJ0SGQUENOmyX1x6hswOwjjS4=
Received: from DM6PR06CA0022.namprd06.prod.outlook.com (2603:10b6:5:120::35)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 01:35:24 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::ff) by DM6PR06CA0022.outlook.office365.com
 (2603:10b6:5:120::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 12 Jul 2023 01:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 01:35:23 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Jul 2023 20:35:18 -0500
From:   Guchun Chen <guchun.chen@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
        <hawking.zhang@amd.com>, <christian.koenig@amd.com>,
        <dusica.milinkovic@amd.com>, <nikola.prica@amd.com>,
        <flora.cui@amd.com>
CC:     Guchun Chen <guchun.chen@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v4] drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel
Date:   Wed, 12 Jul 2023 09:34:55 +0800
Message-ID: <20230712013455.2766365-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7133a72c-5786-42f1-0cc3-08db82784320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hpJMgZanyYygPqoozuvZbsGgURBOg9rotQsylOh6E6EgmOPdCKTjL1vpn0mqmZ06WdAXxSq3ZFb6OxMVviKYWdNKlzwsefM8KdZyTVRm+rRIk6f9JdoQ39VXp6HtZcIXGWa8Uk00Gs0tFGFLNTiF/dA7kWeAxliO/DcGfNSaRytl0FkyzWxsFS2KvXw+hqo7mSaJWiYSGzt+smf4xW8foHcvsG528HVc7BUWkNREfWs8PGPK5sbfOE883VKy+dJQSESI0F719ogxA3OSd9KZDTKq00ux8PIrHFo9HWR1bpHpuzsKuwrsSRcv5HuePNd6Tu74ejnho8FHKb1QnqFOGXMgCe0HoQrY+K4v5GrwCUzNLWvYME+nHQtU01PELgO4Xd7YMcyTdw8wK0fZCvSODEBbMBtKVXgwqJ1KDtu9Hh/ZQK0xxPqZFj2ZbzWqJnZAvpkaIRHr7I7J3GBlbZmlmGO5xfK7EH/uhMDM9ydfW/9UkQNd5KW2MgpfM7YHdUy+qzZ/g7BVjc3A5TAGC0SxaOIlbgLynMLk0/MDPW+11MdFzGhMc9YiQv5/TdZ+3eEYv+FoElI0A4ePORqMyFvnSXkT+OS1Jt5vrQhAtMBpjkZOoMEgTRLOlIX2wxJ3OcI39IV5V38+1yQJWN59T4b3zqghKH7ieLjyFQU4/IosfKFxgwbCH/mfR7I2IcVhZ9eZSh8ok5BBONeF8JSypGbemT961vfu9VbF8fhglITPwlrW9LdZAf1nz2Fj+EhnJ3VmXLkx+GsjPy1YR1DDdoxuwbwGBz2u1bxJfEv54TsI4U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(66574015)(2616005)(426003)(26005)(186003)(336012)(1076003)(16526019)(36860700001)(83380400001)(70206006)(70586007)(316002)(6636002)(4326008)(44832011)(8676002)(8936002)(5660300002)(41300700001)(7696005)(6666004)(2906002)(478600001)(54906003)(110136005)(40480700001)(356005)(81166007)(82310400005)(86362001)(36756003)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 01:35:23.6136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7133a72c-5786-42f1-0cc3-08db82784320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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

In below thousands of screen rotation loop tests with virtual display
enabled, a CPU hard lockup issue may happen, leading system to unresponsive
and crash.

do {
	xrandr --output Virtual --rotate inverted
	xrandr --output Virtual --rotate right
	xrandr --output Virtual --rotate left
	xrandr --output Virtual --rotate normal
} while (1);

NMI watchdog: Watchdog detected hard LOCKUP on cpu 1

? hrtimer_run_softirq+0x140/0x140
? store_vblank+0xe0/0xe0 [drm]
hrtimer_cancel+0x15/0x30
amdgpu_vkms_disable_vblank+0x15/0x30 [amdgpu]
drm_vblank_disable_and_save+0x185/0x1f0 [drm]
drm_crtc_vblank_off+0x159/0x4c0 [drm]
? record_print_text.cold+0x11/0x11
? wait_for_completion_timeout+0x232/0x280
? drm_crtc_wait_one_vblank+0x40/0x40 [drm]
? bit_wait_io_timeout+0xe0/0xe0
? wait_for_completion_interruptible+0x1d7/0x320
? mutex_unlock+0x81/0xd0
amdgpu_vkms_crtc_atomic_disable

It's caused by a stuck in lock dependency in such scenario on different
CPUs.

CPU1                                             CPU2
drm_crtc_vblank_off                              hrtimer_interrupt
    grab event_lock (irq disabled)                   __hrtimer_run_queues
        grab vbl_lock/vblank_time_block                  amdgpu_vkms_vblank_simulate
            amdgpu_vkms_disable_vblank                       drm_handle_vblank
                hrtimer_cancel                                         grab dev->event_lock

So CPU1 stucks in hrtimer_cancel as timer callback is running endless on
current clock base, as that timer queue on CPU2 has no chance to finish it
because of failing to hold the lock. So NMI watchdog will throw the errors
after its threshold, and all later CPUs are impacted/blocked.

So use hrtimer_try_to_cancel to fix this, as disable_vblank callback
does not need to wait the handler to finish. And also it's not necessary
to check the return value of hrtimer_try_to_cancel, because even if it's
-1 which means current timer callback is running, it will be reprogrammed
in hrtimer_start with calling enable_vblank to make it works.

v2: only re-arm timer when vblank is enabled (Christian) and add a Fixes
tag as well

v3: drop warn printing (Christian)

v4: drop superfluous check of blank->enabled in timer function, as it's
guaranteed in drm_handle_vblank (Christian)

Fixes: 84ec374bd580("drm/amdgpu: create amdgpu_vkms (v4)")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 53ff91fc6cf6..d0748bcfad16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -55,8 +55,9 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 		DRM_WARN("%s: vblank timer overrun\n", __func__);
 
 	ret = drm_crtc_handle_vblank(crtc);
+	/* Don't queue timer again when vblank is disabled. */
 	if (!ret)
-		DRM_ERROR("amdgpu_vkms failure on handling vblank");
+		return HRTIMER_NORESTART;
 
 	return HRTIMER_RESTART;
 }
@@ -81,7 +82,7 @@ static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
+	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
-- 
2.25.1

