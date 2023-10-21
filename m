Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA87D1BF4
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjJUJJP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 05:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjJUJJN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 05:09:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C00A10EC
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 02:08:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CD4C433C8;
        Sat, 21 Oct 2023 09:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697879326;
        bh=CWqg6U/NUEe5AGR87+VP4gxXz1q8POeXNt46q/Q2W/s=;
        h=Subject:To:Cc:From:Date:From;
        b=L49GBrBnLUXiDrSwC/EKrDnyarg9BB5Rh0i6bnjHtkhTTYLdZQwn8Dp3TDCgo7gdA
         ASlgo+y+fg4olCUOQsQyLPFeDGgpt9gjxpYrcRStBwKrcsfgx3veOV0ohuLfQR/P9U
         ieMzIRnLb5cy01RUoUJC/RKeF1SrwfpMdg2s4QR8=
Subject: FAILED: patch "[PATCH] nvme: sanitize metadata bounce buffer for reads" failed to apply to 5.15-stable tree
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
        joshi.k@samsung.com, kch@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 11:08:43 +0200
Message-ID: <2023102143-task-roundness-da6d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2b32c76e2b0154b98b9322ae7546b8156cd703e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102143-task-roundness-da6d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b32c76e2b0154b98b9322ae7546b8156cd703e6 Mon Sep 17 00:00:00 2001
From: Keith Busch <kbusch@kernel.org>
Date: Mon, 16 Oct 2023 13:12:47 -0700
Subject: [PATCH] nvme: sanitize metadata bounce buffer for reads

User can request more metadata bytes than the device will write. Ensure
kernel buffer is initialized so we're not leaking unsanitized memory on
the copy-out.

Fixes: 0b7f1f26f95a51a ("nvme: use the block layer for userspace passthrough metadata")
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f2..747c879e8982 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -108,9 +108,13 @@ static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 	if (!buf)
 		goto out;
 
-	ret = -EFAULT;
-	if ((req_op(req) == REQ_OP_DRV_OUT) && copy_from_user(buf, ubuf, len))
-		goto out_free_meta;
+	if (req_op(req) == REQ_OP_DRV_OUT) {
+		ret = -EFAULT;
+		if (copy_from_user(buf, ubuf, len))
+			goto out_free_meta;
+	} else {
+		memset(buf, 0, len);
+	}
 
 	bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
 	if (IS_ERR(bip)) {

