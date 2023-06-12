Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3472C10C
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbjFLK4M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbjFLKzz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC38C0A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43368612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FBCC433EF;
        Mon, 12 Jun 2023 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566584;
        bh=Tj5pIUHrwKbgZKMQUQA49EpM6LyQZLQbHXh/SbjZEW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6h6WLM7AgihR+RjXXxyMYs7HgN1LNqCq3ZoneZnsqOldQwrH3TWuvZpXT5iy8e3e
         89MlyHLFEx39Gb5/8qjZ7pmhd2fUyIgkK+iwJQf9YDA6/GBbtIbnMZK2mO+fh+y1UO
         TS1OJbCUFaauIK/sXCGd3OKD5tbR7Lc2UnaHGQAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 087/132] s390/dasd: Use correct lock while counting channel queue length
Date:   Mon, 12 Jun 2023 12:27:01 +0200
Message-ID: <20230612101714.230735749@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Jan Höppner <hoeppner@linux.ibm.com>

commit ccc45cb4e7271c74dbb27776ae8f73d84557f5c6 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_ioctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -552,10 +552,10 @@ static int __dasd_ioctl_information(stru
 
 	memcpy(dasd_info->type, base->discipline->name, 4);
 
-	spin_lock_irqsave(&block->queue_lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
-	spin_unlock_irqrestore(&block->queue_lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 	return 0;
 }
 


