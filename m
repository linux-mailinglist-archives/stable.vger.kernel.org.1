Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B10674978E
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjGFIgH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 6 Jul 2023 04:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFIgG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 6 Jul 2023 04:36:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D6170F
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 01:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EivVddYOeU+ZoTp8BEtWmVa9niA768Y0ZGkkSHdt8ltrNZz4GGXziM+idm0aEelPYq2e5ujtmgwPNSbg7b9CZeJVZK0sA1+yzzCn9IR6GeMnLFzMu64q+2vKx8Qujoj50t7xP2WSDT9bG/hQr/MZxfOHKutCjmyJsJ8HvD7WqUiOB/Svk4Dks75VbOg43Ng8FUW+s/Ih5ZiJk0+5GTqJo6vHWae9Q9YqkSd7zSXUg+GVCtU9B2rNf57IqSyyjEMtSs38ocIZl1I6VZtSTQVc16ohqpHmscC0JkSHp4PCOyZl49FRPRdqIuetkv+QrVS5ll63z+4eamI4uVpBD75dYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+4ZP4C+N1dvOPtAMhapEDwkc12qUGadWwH51ifjzjw=;
 b=cWLMRkmJgBmYvHU524exht1lYM2MxPJGrV4cVSYjoGWGi6eq9NwVfUjU6QuQ4xHYOv4qEc0yYha40hmg+wYpyIgVv2pdl5SkICriGENBxMUXA738PIv3e997H1QF9eDsyzNjC3TYTwTU9KFlxa6d2gb/5duws7bSUNnmN/2WPYwIPAYgYt0rMMQISkB2SWOWWHSQ9riKOlfXlE9Cq8ShTWQqqDri/JVecyCPVvcrXIjrf9hbTkVboBjRoYiQYVfzEZhO8IpdTmTirqqRIIO7/4cedZxgoKe+z/1UGBL2ahBRlLHtdh5/ih3tQ8L5B/yHQVQTU1S3Wfl4MhT0HYLB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+4ZP4C+N1dvOPtAMhapEDwkc12qUGadWwH51ifjzjw=;
 b=sn+PVlzgWePhpNHacTutFSnFzdtLlY7OxL4KMRq02lIN8DAwzT9t+Y3zYvp/HJ7fdtTmxG1+ZNM61Rc5Qr78eYx1W+IiHkOYkEKtJk8Y2KteRGP2/YAHcmP0Cq/aDISppY4rpyvtikKDFRdlpfldR06RCvcnidGacrdaQMQgb/w=
Received: from BN9PR03CA0848.namprd03.prod.outlook.com (2603:10b6:408:13d::13)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 08:35:58 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::9) by BN9PR03CA0848.outlook.office365.com
 (2603:10b6:408:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Thu, 6 Jul 2023 08:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Thu, 6 Jul 2023 08:35:57 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 03:35:55 -0500
From:   Guchun Chen <guchun.chen@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
        <hawking.zhang@amd.com>, <christian.koenig@amd.com>,
        <dusica.milinkovic@amd.com>, <nikola.prica@amd.com>,
        <flora.cui@amd.com>
CC:     Guchun Chen <guchun.chen@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel
Date:   Thu, 6 Jul 2023 16:35:23 +0800
Message-ID: <20230706083523.561741-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: b543f075-adb7-484f-e94a-08db7dfc0566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsppSpMKOq7THP8qL18OUZwvK+GxSTlF6tw6gC5jvxjcuGe1bUCrzhle/Ikmfj4PVqgJzXD/huWjoF2dJbvol6gvUZFUw56sD1D702oFLj6Y3uxbbijgAw9xRLmsfOj8I76aFdcpQSLx1KN7enlWWqOpdgIu9U/zMNjaYdg5zLmiTkrh7BOqW48rKzN+7kILpkoOI1UiFtFc/+lrIbONrnwmpPKMiKyWyBHjm/gjKd+oa/4pCpxgthEVraktXk79AqkMkAubHk2I+wK/uSIE9U/gAF93SSLKAwe4d67EfL2ZIoBY4agKi/bFDt0/5bPBytzLYhWSYafCDsVPiUqsDeQqocKY6wT/D/4XD3EWFMlo5Bg7IqdIrqTBYNpS4TNYC2Fz+DsIQdG2leJWDOp64Ia5YsX/Ct0M/9AuXEIqOUApbUBBdhKxoMrmLfH1YupHs1LVUNzBg56QZaiEkkZ2yDnUfDU8cwoMd5/skZ6mk0i5jsO4TbZqiiITirMNhwjA8kuveSkbG4Josnv54I9rkS9uzDkVE1kIvRqBFdKRr+Yj/JW1iGQo9iGleR6CxerBL3SpoGX4gdCKoBGjlJTWfxAV65lhOgS4ByB+0wzep29DE3BEBgGdJCdFfyZIovpNfrKLWR3m6OlZDWgdlZAgBOljUrW1jqTBaHNTfe13+U0XysNDO9bsVnDDmi2cxiyd+/wYnhUyXXjFc5z3M0uvf0/6kM7J/YD5FOU/UMebcdfrTNoYXlcbRvlNrkS4up0tL9fl180pnwUPfSByTwdPn9L0R9fr6OeWCHbCDbN5pls=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(44832011)(478600001)(5660300002)(8936002)(8676002)(70586007)(316002)(4326008)(70206006)(6636002)(2906002)(41300700001)(54906003)(110136005)(7696005)(6666004)(2616005)(26005)(1076003)(186003)(16526019)(36860700001)(356005)(82740400003)(83380400001)(66574015)(47076005)(336012)(426003)(81166007)(82310400005)(40460700003)(36756003)(86362001)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:35:57.8449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b543f075-adb7-484f-e94a-08db7dfc0566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

NMI watchdog: Watchdog detected hard LOCKUP on cpu 4

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
                hrtimer_cancel                                   grab dev->event_lock

So CPU1 stucks in hrtimer_cancel as timer callback is running endless on
current clock base, as that timer queue on CPU2 has no chance to finish it
because of failing to hold the lock. So NMI watchdog will throw the errors
after its threshold, and all later CPUs are impacted/blocked.

So use hrtimer_try_to_cancel to fix this, as disable_vblank callback
does not need to wait the handler to finish. And also it's not necessary
to check the return value of hrtimer_try_to_cancel, because even if it's
-1 which means current timer callback is running, it will be reprogrammed
in hrtimer_start with calling enable_vblank to make it works.

Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 53ff91fc6cf6..70fb0df039e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -81,7 +81,7 @@ static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
+	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
-- 
2.25.1

