Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9B72C1E0
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbjFLLBJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbjFLLAy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E35B8D
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C3C462499
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC2EC433D2;
        Mon, 12 Jun 2023 10:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566867;
        bh=eP7D0Ja1R9WBcVi31o8KcCPt6SpBY5UAIB20QHyZuy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6FBi5EYOs0e7GoKmCOunSVZYTo0oSWwFNEX37oMWpkRix904gbbw8HYMBel2y2zB
         ynH0jFI1g2c6xqhyawO1vF2pywOXtNJgZAwwSdLXUD6+oSPlNO2yKRzT60fBXknLeV
         RLg3Bou6kLAzJJ43QW5nJmv5eB2YhHvr3xHmVZ3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 062/160] accel/ivpu: Do not use mutex_lock_interruptible
Date:   Mon, 12 Jun 2023 12:26:34 +0200
Message-ID: <20230612101717.843699029@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

[ Upstream commit b563e47957af4ff71736c5cc4120a59b055ab583 ]

If we get signal when waiting for the mmu->lock we do not invalidate
current MMU configuration that might result in undefined behavior.

Additionally there is little or no benefit on break waiting for
ipc->lock. In current code base, we keep this lock for short periods.

Fixes: 263b2ba5fc93 ("accel/ivpu: Add Intel VPU MMU support")
Reviewed-by: Krystian Pradzynski <krystian.pradzynski@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230525103818.877590-2-stanislaw.gruszka@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_ipc.c |  4 +---
 drivers/accel/ivpu/ivpu_mmu.c | 22 ++++++----------------
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 3adcfa80fc0e5..fa0af59e39ab6 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -183,9 +183,7 @@ ivpu_ipc_send(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons, struct v
 	struct ivpu_ipc_info *ipc = vdev->ipc;
 	int ret;
 
-	ret = mutex_lock_interruptible(&ipc->lock);
-	if (ret)
-		return ret;
+	mutex_lock(&ipc->lock);
 
 	if (!ipc->on) {
 		ret = -EAGAIN;
diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index 694e978aba663..b8b259b3aa635 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -587,16 +587,11 @@ static int ivpu_mmu_strtab_init(struct ivpu_device *vdev)
 int ivpu_mmu_invalidate_tlb(struct ivpu_device *vdev, u16 ssid)
 {
 	struct ivpu_mmu_info *mmu = vdev->mmu;
-	int ret;
-
-	ret = mutex_lock_interruptible(&mmu->lock);
-	if (ret)
-		return ret;
+	int ret = 0;
 
-	if (!mmu->on) {
-		ret = 0;
+	mutex_lock(&mmu->lock);
+	if (!mmu->on)
 		goto unlock;
-	}
 
 	ret = ivpu_mmu_cmdq_write_tlbi_nh_asid(vdev, ssid);
 	if (ret)
@@ -614,7 +609,7 @@ static int ivpu_mmu_cd_add(struct ivpu_device *vdev, u32 ssid, u64 cd_dma)
 	struct ivpu_mmu_cdtab *cdtab = &mmu->cdtab;
 	u64 *entry;
 	u64 cd[4];
-	int ret;
+	int ret = 0;
 
 	if (ssid > IVPU_MMU_CDTAB_ENT_COUNT)
 		return -EINVAL;
@@ -655,14 +650,9 @@ static int ivpu_mmu_cd_add(struct ivpu_device *vdev, u32 ssid, u64 cd_dma)
 	ivpu_dbg(vdev, MMU, "CDTAB %s entry (SSID=%u, dma=%pad): 0x%llx, 0x%llx, 0x%llx, 0x%llx\n",
 		 cd_dma ? "write" : "clear", ssid, &cd_dma, cd[0], cd[1], cd[2], cd[3]);
 
-	ret = mutex_lock_interruptible(&mmu->lock);
-	if (ret)
-		return ret;
-
-	if (!mmu->on) {
-		ret = 0;
+	mutex_lock(&mmu->lock);
+	if (!mmu->on)
 		goto unlock;
-	}
 
 	ret = ivpu_mmu_cmdq_write_cfgi_all(vdev);
 	if (ret)
-- 
2.39.2



