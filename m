Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F047713DD6
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjE1T3h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjE1T3h (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:29:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE2D189
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617F261D1F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664A9C433EF;
        Sun, 28 May 2023 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302158;
        bh=GAKfk2bBnUNVJAUxBeYig4Vy3Gwi6jdpGt9a25Sn8gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkJyKz7o2acQQXkIstAuUQWRvbW/IerfG35830Exlz+YA7UDPMngm2PXNfIBjwtL0
         8toprD31VDFY2R20ymzyxY6KgHA6oVopwUgvr9pku9AaiiFQA4I/1BuHpGoHy4N5FA
         gp9caddD+VQBfpYoELth7xAxc4Ry07NzskjOc+0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Loehle <cloehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.3 022/127] mmc: block: ensure error propagation for non-blk
Date:   Sun, 28 May 2023 20:09:58 +0100
Message-Id: <20230528190836.971380604@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian Loehle <CLoehle@hyperstone.com>

commit 003fb0a51162d940f25fc35e70b0996a12c9e08a upstream.

Requests to the mmc layer usually come through a block device IO.
The exceptions are the ioctl interface, RPMB chardev ioctl
and debugfs, which issue their own blk_mq requests through
blk_execute_rq and do not query the BLK_STS error but the
mmcblk-internal drv_op_result. This patch ensures that drv_op_result
defaults to an error and has to be overwritten by the operation
to be considered successful.

The behavior leads to a bug where the request never propagates
the error, e.g. by directly erroring out at mmc_blk_mq_issue_rq if
mmc_blk_part_switch fails. The ioctl caller of the rpmb chardev then
can never see an error (BLK_STS_IOERR, but drv_op_result is unchanged)
and thus may assume that their call executed successfully when it did not.

While always checking the blk_execute_rq return value would be
advised, let's eliminate the error by always setting
drv_op_result as -EIO to be overwritten on success (or other error)

Fixes: 614f0388f580 ("mmc: block: move single ioctl() commands to block requests")
Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/59c17ada35664b818b7bd83752119b2d@hyperstone.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/block.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -266,6 +266,7 @@ static ssize_t power_ro_lock_store(struc
 		goto out_put;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_mq_free_request(req);
@@ -653,6 +654,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_
 	idatas[0] = idata;
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(req, false);
@@ -724,6 +726,7 @@ static int mmc_blk_ioctl_multi_cmd(struc
 	}
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = n;
 	blk_execute_rq(req, false);
@@ -2808,6 +2811,7 @@ static int mmc_dbg_card_status_get(void
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	if (ret >= 0) {
@@ -2846,6 +2850,7 @@ static int mmc_ext_csd_open(struct inode
 		goto out_free;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
 	blk_execute_rq(req, false);
 	err = req_to_mmc_queue_req(req)->drv_op_result;


