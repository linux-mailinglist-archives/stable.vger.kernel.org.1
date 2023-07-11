Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CE474E392
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 03:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGKBjg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 21:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGKBje (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 21:39:34 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3B10EA
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 18:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvhLh9VJvDqFxmGrzbNBvKB3ac+PiKAy/k0aq4z33a6ZutduO/Fo9yerQ7+q5D2BxBVNQXrWOPEe0L6clnYtB5ywONd2hqHsZkwrXv9sIyPDXpRaDWNZIogBaJ+FGt33xhBxbfABCS+RrVaeMbtChXlSqyTas0pvMWp0bUhvYqyaIQftaBShu9KGcOzoKsXDx4MdflyT3gB2HOi0QoenoK2Nqq2Zo5yHluYUdcMpbXauapbqrI/GXWzgb5h4OKOL39DYHeDwEBTex338AsQgMcBGHxBrr4qtEgJFrjEhGNDrWhUaaahPMlBa9H4EahNBbb06l+lym5XJxx9fNBUnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y2AtvptGAzJGTa2W8PTrqQ/yYlcKuRcUM1aHa+6G1M=;
 b=P3+iqDIGNof78lkIHPn1F1Rev7hD1QBHa0bK9nWXZxe01tTOEH15bj/mr4zFyhQHnKy2EJYWl44UOncM0sRkR77onksVMnunQMri+u35+N7o51Nzf85ZFkw7f5BFDh+337GOZIS528MKqfdL/3gOc+e8rK/zvy0sO9zhIEFlxRcdC385w46HJrEOpgHpVqyucPVwaKnrisQ0BBL+LQg4dUE20En9qwlQjlPV+BimuQd6pIJrnLv9YtQ5JTn4Lo27N2LREbmctHJV5H4mQM6sPuMjggDRu7CzKYT+cPJ9L6FAkMDA95XmRywKaFlhLY/k2H+rKXm2gGY7pqAHS17QAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y2AtvptGAzJGTa2W8PTrqQ/yYlcKuRcUM1aHa+6G1M=;
 b=P+0ZgLlKRTE26Emoz4RJBHOfSQThG6a81CDhnPOIaRpezBEr1eckhqbEWRpEciJRS5/ytZ4IqTJrlClML8oP8X957LYPpxiFL3wXhklM45t6J7lq6uZyGlvT9T4zuI07QkAf5TiIA9dh84dyraMuZzsx1QWJzQHLKwUrs6ypMPQ=
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 01:38:56 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::48) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 01:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Tue, 11 Jul 2023 01:38:55 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Jul 2023 20:38:52 -0500
From:   Guchun Chen <guchun.chen@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
        <hawking.zhang@amd.com>, <christian.koenig@amd.com>,
        <dusica.milinkovic@amd.com>, <nikola.prica@amd.com>,
        <flora.cui@amd.com>
CC:     Guchun Chen <guchun.chen@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel
Date:   Tue, 11 Jul 2023 09:38:31 +0800
Message-ID: <20230711013831.2181718-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: eddca09d-0d21-4694-332c-08db81af9733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBtjOPGKEBe8Lqaa9h9f0pQF9LhTzv4O2fcWU3vtD+m3qSA9SxKUkATGJAAKgjmdQ1dlTH/DDXEfxSHrLBT8vnzBCdxFnVYyUsb0SXJ9Ln7UObSzxGsdLAqQOTy9pjEjwScJy/2nts/Z/6pZUHjJn2grFlDMp1HRQBUkqL2ossqLJojHnJBobscXKy/2WgOUARZ1WAtmy0nTgHbyv8A+IXm7mb4oK/U65U8ciG+JNWJMjnvX+e84CeOFLroQj6nOcL3KHGcMQj23TlmapK9fK+r7W7VOis+ubG9PmiNk+V3nPNzZ1Bbqh2xbMhCDmPcKtwVeYnrfLv5N4jNnESFy4Qsd+1+DCV1Ox0l/SnDTb7MTbCIcN4a6H8ZxHWmC6WB9ewK/A2pVdIrpjWiG4AgYvYDwtNnycq2Xyq0X6Azgh3ZfXI6rAT9jUdnXL12O4pu/GKRF6zKtkpkaiPF80MI4BsXjwsbI35R+SKJpyUKngBqzfNC7w/atgLJRIMPo0JEZ/+zd/jc3XndQhOWqMuBRX3stJoaTUsXEgF88Xf4uJjH5P0WpKHqliFOzsEIzaXYm361Is9IZ/n2qr0PSXlLUmOdLsxoSPGV9MYZxmf1RIiRZHDyAG/Mxz7NIcI7xNkWVBQhvpxFNsO/zqoCFJvVi6mwSp3d20gfzuOuDnbuzJLo6rUt0c8mxkxjpVxPFp73Cu5jPi5ic7xVE2nC1PJ8NDFI8fpJ2ffth+Rj0ZLjgT88yqTqKSbv9t3YvWJ82PUnWo6eLs/TnFj+okvDFTguiVbBaT5xsK1IcAUMaye6EOtg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(86362001)(82740400003)(40460700003)(40480700001)(36756003)(6666004)(7696005)(110136005)(54906003)(70586007)(70206006)(356005)(81166007)(478600001)(36860700001)(26005)(1076003)(186003)(2616005)(16526019)(44832011)(316002)(2906002)(5660300002)(8936002)(8676002)(426003)(66574015)(336012)(83380400001)(4326008)(6636002)(41300700001)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 01:38:55.7313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddca09d-0d21-4694-332c-08db81af9733
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
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

Fixes: 84ec374bd580("drm/amdgpu: create amdgpu_vkms (v4)")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 53ff91fc6cf6..b870c827cbaa 100644
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
@@ -54,9 +57,13 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 	if (ret_overrun != 1)
 		DRM_WARN("%s: vblank timer overrun\n", __func__);
 
+	dev = crtc->dev;
+	pipe = drm_crtc_index(crtc);
+	vblank = &dev->vblank[pipe];
 	ret = drm_crtc_handle_vblank(crtc);
-	if (!ret)
-		DRM_ERROR("amdgpu_vkms failure on handling vblank");
+	/* Don't queue timer again when vblank is disabled. */
+	if (!ret && !READ_ONCE(vblank->enabled))
+		return HRTIMER_NORESTART;
 
 	return HRTIMER_RESTART;
 }
@@ -81,7 +88,7 @@ static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
+	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
-- 
2.25.1

