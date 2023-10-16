Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF87CAC8F
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjJPO4C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjJPO4B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:56:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34013E8
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:55:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A15AC433C7;
        Mon, 16 Oct 2023 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468158;
        bh=I9FXzntxaUcwkQl4Q2EEVTBdbmv0HCDiprEhLi/6VWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2TcC9mO2Af8e3k/DpSiLohM3zOkj4wkhOpfzGQ9B3MIk3EYtuLTPmrZDHICexSjp
         4R4IfejmKPkY8fr0eBXCT5S7DkCkmUJKHKlcX2kp8Sq0Rk1T/pNaf7uMUpL6vCTcLR
         mFYGHkhRIF0Ey/9YDU1201AZVhQhGuhNrYBsMM3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linu Cherian <lcherian@marvell.com>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 6.5 170/191] coresight: Fix run time warnings while reusing ETR buffer
Date:   Mon, 16 Oct 2023 10:42:35 +0200
Message-ID: <20231016084019.344130796@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linu Cherian <lcherian@marvell.com>

commit bd2767ec3df2775bc336f441f9068a989ccb919d upstream.

Fix the below warning by avoding calls to tmc_etr_enable_hw,
if we are reusing the ETR buffer for multiple sources in sysfs mode.

echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
echo 1 > /sys/bus/coresight/devices/ete1/enable_source
echo 1 > /sys/bus/coresight/devices/ete2/enable_source
[  166.918290] ------------[ cut here ]------------
[  166.922905] WARNING: CPU: 4 PID: 2288 at
drivers/hwtracing/coresight/coresight-tmc-etr.c:1037
tmc_etr_enable_hw+0xb0/0xc8
[  166.933862] Modules linked in:
[  166.936911] CPU: 4 PID: 2288 Comm: bash Not tainted 6.5.0-rc7 #132
[  166.943084] Hardware name: Marvell CN106XX board (DT)
[  166.948127] pstate: 834000c9 (Nzcv daIF +PAN -UAO +TCO +DIT -SSBS
BTYPE=--)
[  166.955083] pc : tmc_etr_enable_hw+0xb0/0xc8
[  166.959345] lr : tmc_enable_etr_sink+0x134/0x210
snip..
  167.038545] Call trace:
[  167.040982]  tmc_etr_enable_hw+0xb0/0xc8
[  167.044897]  tmc_enable_etr_sink+0x134/0x210
[  167.049160]  coresight_enable_path+0x160/0x278
[  167.053596]  coresight_enable+0xd4/0x298
[  167.057510]  enable_source_store+0x54/0xa0
[  167.061598]  dev_attr_store+0x20/0x40
[  167.065254]  sysfs_kf_write+0x4c/0x68
[  167.068909]  kernfs_fop_write_iter+0x128/0x200
[  167.073345]  vfs_write+0x1ac/0x2f8
[  167.076739]  ksys_write+0x74/0x110
[  167.080132]  __arm64_sys_write+0x24/0x38
[  167.084045]  invoke_syscall.constprop.0+0x58/0xf8
[  167.088744]  do_el0_svc+0x60/0x160
[  167.092137]  el0_svc+0x40/0x170
[  167.095273]  el0t_64_sync_handler+0x100/0x130
[  167.099621]  el0t_64_sync+0x190/0x198
[  167.103277] ---[ end trace 0000000000000000 ]---
-bash: echo: write error: Device or resource busy

Fixes: 296b01fd106e ("coresight: Refactor out buffer allocation function for ETR")
Signed-off-by: Linu Cherian <lcherian@marvell.com>
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20230823042948.12879-1-lcherian@marvell.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 66dc5f97a009..6132c5b3db9c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1173,16 +1173,6 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 		goto out;
 	}
 
-	/*
-	 * In sysFS mode we can have multiple writers per sink.  Since this
-	 * sink is already enabled no memory is needed and the HW need not be
-	 * touched, even if the buffer size has changed.
-	 */
-	if (drvdata->mode == CS_MODE_SYSFS) {
-		atomic_inc(&csdev->refcnt);
-		goto out;
-	}
-
 	/*
 	 * If we don't have a buffer or it doesn't match the requested size,
 	 * use the buffer allocated above. Otherwise reuse the existing buffer.
@@ -1204,7 +1194,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 
 static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 {
-	int ret;
+	int ret = 0;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etr_buf *sysfs_buf = tmc_etr_get_sysfs_buffer(csdev);
@@ -1213,12 +1203,24 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		return PTR_ERR(sysfs_buf);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/*
+	 * In sysFS mode we can have multiple writers per sink.  Since this
+	 * sink is already enabled no memory is needed and the HW need not be
+	 * touched, even if the buffer size has changed.
+	 */
+	if (drvdata->mode == CS_MODE_SYSFS) {
+		atomic_inc(&csdev->refcnt);
+		goto out;
+	}
+
 	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
 	if (!ret) {
 		drvdata->mode = CS_MODE_SYSFS;
 		atomic_inc(&csdev->refcnt);
 	}
 
+out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (!ret)
-- 
2.42.0



