Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB372B1F3
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 15:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFKNJR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKNJQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 09:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C210DA
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 06:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 310F361141
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 13:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37187C4339B;
        Sun, 11 Jun 2023 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686488954;
        bh=OXn/Y+mOvpno1nm03aS6qwmS1X2ARCNhG/NPqQHL7rI=;
        h=Subject:To:Cc:From:Date:From;
        b=Pcvgil8xLJKkUIx92q62BuuL6Mni7Zu87/YrkeXR9DmTIR2GNYTI8AdMEcHkxUBJK
         8AzAzBavqTN6NHy5/72DBDerV4A+mke6aKczYxm6P+qp48deTtySDSyRl7LbC45WYV
         mHvmpm40LkB4R37dMf+ty13dJqnjO4c81TYPi5JM=
Subject: FAILED: patch "[PATCH] s390/dasd: Use correct lock while counting channel queue" failed to apply to 5.4-stable tree
To:     hoeppner@linux.ibm.com, axboe@kernel.dk, sth@linux.ibm.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 11 Jun 2023 15:09:11 +0200
Message-ID: <2023061111-tracing-shakiness-9054@gregkh>
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ccc45cb4e7271c74dbb27776ae8f73d84557f5c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061111-tracing-shakiness-9054@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ccc45cb4e7271c74dbb27776ae8f73d84557f5c6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>
Date: Fri, 9 Jun 2023 17:37:50 +0200
Subject: [PATCH] s390/dasd: Use correct lock while counting channel queue
 length
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The lock around counting the channel queue length in the BIODASDINFO
ioctl was incorrectly changed to the dasd_block->queue_lock with commit
583d6535cb9d ("dasd: remove dead code"). This can lead to endless list
iterations and a subsequent crash.

The queue_lock is supposed to be used only for queue lists belonging to
dasd_block. For dasd_device related queue lists the ccwdev lock must be
used.

Fix the mentioned issues by correctly using the ccwdev lock instead of
the queue lock.

Fixes: 583d6535cb9d ("dasd: remove dead code")
Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20230609153750.1258763-2-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9327dcdd6e5e..8fca725b3dae 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -552,10 +552,10 @@ static int __dasd_ioctl_information(struct dasd_block *block,
 
 	memcpy(dasd_info->type, base->discipline->name, 4);
 
-	spin_lock_irqsave(&block->queue_lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
-	spin_unlock_irqrestore(&block->queue_lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 	return 0;
 }
 

