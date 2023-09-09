Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADA0799B6F
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 23:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjIIVdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIIVdH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 17:33:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDDF195
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 14:33:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD79EC433C8;
        Sat,  9 Sep 2023 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694295183;
        bh=LL5ONTF+7WzWA1nvX5bXq+KIFxa2b6iymWwYKEuCWQg=;
        h=Subject:To:Cc:From:Date:From;
        b=Eh0Y1LNcZW9ScAC5seW+PO/ohRyjwOcQcpi0ciYw7FEdbKkmMcfr8WcPF9BYq8qwe
         XnCJLeoQhPXMUX+QlVlpCETX12dw0h62s8nWloeMZZDNBBkiL5tDorkwanb+crwQov
         wczchq0onRvRa9Mk8BIJWubtiyS4j4zJcdlJZ5A4=
Subject: FAILED: patch "[PATCH] block: don't add or resize partition on the disk with" failed to apply to 5.15-stable tree
To:     lilingfeng3@huawei.com, axboe@kernel.dk, hch@lst.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 22:32:47 +0100
Message-ID: <2023090947-apprehend-immobile-0fb5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 1a721de8489fa559ff4471f73c58bb74ac5580d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090947-apprehend-immobile-0fb5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

1a721de8489f ("block: don't add or resize partition on the disk with GENHD_FL_NO_PART")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1a721de8489fa559ff4471f73c58bb74ac5580d3 Mon Sep 17 00:00:00 2001
From: Li Lingfeng <lilingfeng3@huawei.com>
Date: Thu, 31 Aug 2023 15:59:00 +0800
Subject: [PATCH] block: don't add or resize partition on the disk with
 GENHD_FL_NO_PART

Commit a33df75c6328 ("block: use an xarray for disk->part_tbl") remove
disk_expand_part_tbl() in add_partition(), which means all kinds of
devices will support extended dynamic `dev_t`.
However, some devices with GENHD_FL_NO_PART are not expected to add or
resize partition.
Fix this by adding check of GENHD_FL_NO_PART before add or resize
partition.

Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230831075900.1725842-1-lilingfeng@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/ioctl.c b/block/ioctl.c
index 648670ddb164..d5f5cd61efd7 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -20,6 +20,8 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	struct blkpg_partition p;
 	long long start, length;
 
+	if (disk->flags & GENHD_FL_NO_PART)
+		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))

