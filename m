Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D574712CFE
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbjEZTDS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243746AbjEZTDR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 15:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF5319D
        for <stable@vger.kernel.org>; Fri, 26 May 2023 12:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E066965292
        for <stable@vger.kernel.org>; Fri, 26 May 2023 19:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8D8C433D2;
        Fri, 26 May 2023 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685127793;
        bh=hdPrxxTceRPRT9oR2DGbPwA943x4qnInom892vZcGvI=;
        h=Subject:To:Cc:From:Date:From;
        b=X/Y/7TMQlBVRPgN32ZJrVAjTsUmKMxflElXbyOgKPrHbToiPLu6PQEcvl45ta1Wmb
         OvbuTBMChtPDqwZUjG7u9A7vK/kkej3jwvPQ0gCdDb15POL1m4nuZ5Bk40CKip96o1
         Ozf5+UxqScDwpk6JZMszPFTk9KaepZnb67SAs37A=
Subject: FAILED: patch "[PATCH] mmc: block: ensure error propagation for non-blk" failed to apply to 5.10-stable tree
To:     CLoehle@hyperstone.com, adrian.hunter@intel.com,
        cloehle@hyperstone.com, ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 26 May 2023 20:03:08 +0100
Message-ID: <2023052608-hybrid-jugular-3bc2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 003fb0a51162d940f25fc35e70b0996a12c9e08a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052608-hybrid-jugular-3bc2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

003fb0a51162 ("mmc: block: ensure error propagation for non-blk")
b84ba30b6c7a ("block: remove the gendisk argument to blk_execute_rq")
4054cff92c35 ("block: remove blk-exec.c")
0bf6d96cb829 ("block: remove blk_{get,put}_request")
4abafdc4360d ("block: remove the initialize_rq_fn blk_mq_ops method")
68ec3b819a5d ("scsi: add a scsi_alloc_request helper")
5a72e899ceb4 ("block: add a struct io_comp_batch argument to fops->iopoll()")
013a7f954381 ("block: provide helpers for rq_list manipulation")
afd7de03c526 ("block: remove some blk_mq_hw_ctx debugfs entries")
3e08773c3841 ("block: switch polling to be bio based")
6ce913fe3eee ("block: rename REQ_HIPRI to REQ_POLLED")
d729cf9acb93 ("io_uring: don't sleep when polling for I/O")
ef99b2d37666 ("block: replace the spin argument to blk_iopoll with a flags argument")
28a1ae6b9dab ("blk-mq: remove blk_qc_t_valid")
efbabbe121f9 ("blk-mq: remove blk_qc_t_to_tag and blk_qc_t_is_internal")
c6699d6fe0ff ("blk-mq: factor out a "classic" poll helper")
f70299f0d58e ("blk-mq: factor out a blk_qc_to_hctx helper")
71fc3f5e2c00 ("block: don't try to poll multi-bio I/Os in __blkdev_direct_IO")
349302da8352 ("block: improve batched tag allocation")
0f38d7664615 ("blk-mq: cleanup blk_mq_submit_bio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 003fb0a51162d940f25fc35e70b0996a12c9e08a Mon Sep 17 00:00:00 2001
From: Christian Loehle <CLoehle@hyperstone.com>
Date: Wed, 26 Apr 2023 16:59:39 +0000
Subject: [PATCH] mmc: block: ensure error propagation for non-blk

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

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 00c33edb9fb9..d920c4178389 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -264,6 +264,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		goto out_put;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_mq_free_request(req);
@@ -651,6 +652,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 	idatas[0] = idata;
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(req, false);
@@ -722,6 +724,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 	}
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = n;
 	blk_execute_rq(req, false);
@@ -2806,6 +2809,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	if (ret >= 0) {
@@ -2844,6 +2848,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 		goto out_free;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
 	blk_execute_rq(req, false);
 	err = req_to_mmc_queue_req(req)->drv_op_result;

