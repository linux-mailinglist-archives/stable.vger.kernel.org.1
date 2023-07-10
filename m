Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F73A74CD32
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 08:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjGJGim (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 02:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGJGik (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 02:38:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C98E
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 23:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhfEfLHPC6cN1vBO0WC0pXUDfRea2sX9nfJ292JTdxpoSeCI/ehzcx1SOrAIpHqnafkhArHcYMd9qc3AKAD0n5u0zhwP2GamTLye/Q4H2pLG75gb2xlOL818RYHZGaGZ/IjJTUiVw0CQQAFVSbijfRth2EjJx1ZhcDaiqKlIApXjrQqt0ttPpDX9sO2IRDWLZZdn4xZJu/2aew2e0DWvDKXt5m33USBOPPYpae8aDTc4gW+85dy/GnOOXWkgZdJdkSw6ItQ/9XC/j393ceSZeAmf1Msv4FWIh1rEcymHQ1X6OH03Ros1OWI/TMstwfjKv7D4dUNLt9jPWcHjAwZHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtQ4XJlvVaQS3fFVF1U9pjZfL4OZFttDqZTzTqO6nRA=;
 b=gd9LR8u54iKm+4MMsx2d7inhxPn2arWoskYeZqZeFz+nlXfIKHdMjwrO8G/4zP1ledGRmD1uPlBflADlVQR0mnGpqwmAaa+MjPtDwJywucBj8knjxWtujF4iGZ5XfHY1Q+KnqgFuJOWkKMnSnuWp82QxBwQ2VV7S36KeYYENvJas6f8kYzbqR2vknoimUGBswJ5ktDtB78CKMw8HVTAUfN6zh44gYGZoL5Zq2COOsHlzO8lvsb9tXg7votJeggd4H6A4eT7N5hT2Yu9JYawwUaAn41TQ2nC+cmue/KlPsqUV+cGUOyAP0YIbH0wVVaIYRXLRXt9bTwY2X/Qy4b/Ifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtQ4XJlvVaQS3fFVF1U9pjZfL4OZFttDqZTzTqO6nRA=;
 b=LZHEVAJnPpvVVl9zYihbbfuhAwiAskkW21VN6PqW2eq50VtxyY0QpyRXPo6RfKFznP00vC5BfQueszcUGR2v62i64ebV2dg3iLx+SmObE4kQN4BhSiAQpnhZc+RjnILpa+IKkxh+8yU/4bLF/D4DIbXW6KFbeGNHuziLSpYXgPs=
Received: from BN9PR03CA0903.namprd03.prod.outlook.com (2603:10b6:408:107::8)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 06:38:31 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::6c) by BN9PR03CA0903.outlook.office365.com
 (2603:10b6:408:107::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 06:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 06:38:31 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Jul 2023 01:38:28 -0500
From:   Guchun Chen <guchun.chen@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
        <hawking.zhang@amd.com>, <christian.koenig@amd.com>,
        <dusica.milinkovic@amd.com>, <nikola.prica@amd.com>,
        <flora.cui@amd.com>
CC:     Guchun Chen <guchun.chen@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel
Date:   Mon, 10 Jul 2023 14:38:08 +0800
Message-ID: <20230710063808.1684914-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: c84af51e-c900-4aea-67d7-08db81104708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Kd+sJzbW88I/kF9mxhglpnR5VozB5wvL0VqKSUoQVn3fvXWiqtnpyTUyBOQ1RPItgalpjG37D93Gt14YwTPgPJnohrPjtheeLBa4dxnDdpiM1aLmVyaCCO0vE8xXtCtU5Y3onnxifZoyzHPgzmsVq+jME/ncJiQOlIIBW2hYbJP1X4Eesq2mDXjiGTVat5FLR8Xyv4+nZq51vWPRz30+D3B//c80FMF5M+HteFXBqvoMVArk4XadgDNuE4+QVCI7LNcICMRpOEIn5wntLmQhyh81JacV7XKJnLr4LmU7Gt1cYeCHsuWGwl1TM3ncOdFhWrYtbURIbITk+G/hIRxNzc83NlWfHwah6FWcI0vlAbSNqWTzC3TEyFlcoH/VUStH8yKn6SxlHdd26OsKfqXBp8Zo7XMFpekOK6RYd3G5bqZYXn+TTsdUO7Pwb93xrQh97n6OauVe0CTcyGeu6POG+wOkmhNqBbfpXwCNfoTnSqUfMjUvQ20luJwMOXlkbYFIwdJoCt/jmA7cJKOkbpZiYZDawJKECAVbpVKWiMPq1GQ1U3EfupI9QM9EMI8/aPiQ4fL6m/Ki0hjeTCgs2Bed3AVSuZTInNCFEg32dH2MMYG99jGIH8tBL+bLwYrCwTPxQXbU8GIdWYq1TaouSvyulUUfJcLq5nxcFMrkEtmQNagFldTr5gaFxT+A8Okl5ZKzNsKjSvZ+zu6W9qIlnd0gboHzjWCxVwtxXsdw+hm5G9Abxi9HaIZzDG4Ozt9GAP5av0X47oU/ABlipeneJx74Njt0zFqsQsBFFpMqqINg0M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(478600001)(6666004)(110136005)(54906003)(36860700001)(47076005)(66574015)(426003)(2616005)(83380400001)(36756003)(40460700003)(86362001)(40480700001)(2906002)(70206006)(82310400005)(186003)(70586007)(1076003)(26005)(16526019)(336012)(81166007)(356005)(82740400003)(6636002)(4326008)(41300700001)(316002)(8936002)(8676002)(5660300002)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 06:38:31.3781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84af51e-c900-4aea-67d7-08db81104708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
                hrtimer_cancel                                       grab dev->event_lock

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

Fixes: 84ec374bd580("drm/amdgpu: create amdgpu_vkms (v4)")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 53ff91fc6cf6..44d704306f44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -46,7 +46,10 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 	struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct amdgpu_crtc, vblank_timer);
 	struct drm_crtc *crtc = &amdgpu_crtc->base;
 	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct drm_vblank_crtc *vblank;
+	struct drm_device *dev;
 	u64 ret_overrun;
+	unsigned int pipe;
 	bool ret;
 
 	ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
@@ -54,9 +57,15 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 	if (ret_overrun != 1)
 		DRM_WARN("%s: vblank timer overrun\n", __func__);
 
+	dev = crtc->dev;
+	pipe = drm_crtc_index(crtc);
+	vblank = &dev->vblank[pipe];
 	ret = drm_crtc_handle_vblank(crtc);
-	if (!ret)
-		DRM_ERROR("amdgpu_vkms failure on handling vblank");
+	if (!ret && !READ_ONCE(vblank->enabled)) {
+		/* Don't queue timer again when vblank is disabled. */
+		DRM_WARN("amdgpu_vkms failure on handling vblank\n");
+		return HRTIMER_NORESTART;
+	}
 
 	return HRTIMER_RESTART;
 }
@@ -81,7 +90,7 @@ static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
+	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
-- 
2.25.1

