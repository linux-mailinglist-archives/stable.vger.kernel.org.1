Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640E17ECDF3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjKOTj2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjKOTj2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1CE19F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B26C433CA;
        Wed, 15 Nov 2023 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077164;
        bh=RSrEjjNbzi7DgbNvKELP/Vbq1zZo+jIqEE9x6UuziIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMbVQeVzKlzaJmayYjrGqvHnH4PrFCo6G5NVGNSCEeUrF8NKr4SgmhWTZoqSYSIR0
         gjR0XBcu8t+AAB+7Ue1Jfl97ZvrYKhEb4sLnIe9L7bR8mq9+XmKhSettPldC4QIe8x
         QUi+v2JNDMuqFm7WycOMUAlKP7G31Ms1eahO1q1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Lingfeng <lilingfeng3@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 520/550] nbd: fix uaf in nbd_open
Date:   Wed, 15 Nov 2023 14:18:24 -0500
Message-ID: <20231115191636.986541393@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Lingfeng <lilingfeng3@huawei.com>

[ Upstream commit 327462725b0f759f093788dfbcb2f1fd132f956b ]

Commit 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and
blk_cleanup_disk") cleans up disk by blk_cleanup_disk() and it won't set
disk->private_data as NULL as before. UAF may be triggered in nbd_open()
if someone tries to open nbd device right after nbd_put() since nbd has
been free in nbd_dev_remove().

Fix this by implementing ->free_disk and free private data in it.

Fixes: 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and blk_cleanup_disk")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20231107103435.2074904-1-lilingfeng@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8576d696c7a22..f6a9eda9fbb20 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -250,7 +250,6 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	struct gendisk *disk = nbd->disk;
 
 	del_gendisk(disk);
-	put_disk(disk);
 	blk_mq_free_tag_set(&nbd->tag_set);
 
 	/*
@@ -261,7 +260,7 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	idr_remove(&nbd_index_idr, nbd->index);
 	mutex_unlock(&nbd_index_mutex);
 	destroy_workqueue(nbd->recv_workq);
-	kfree(nbd);
+	put_disk(disk);
 }
 
 static void nbd_dev_remove_work(struct work_struct *work)
@@ -1609,6 +1608,13 @@ static void nbd_release(struct gendisk *disk)
 	nbd_put(nbd);
 }
 
+static void nbd_free_disk(struct gendisk *disk)
+{
+	struct nbd_device *nbd = disk->private_data;
+
+	kfree(nbd);
+}
+
 static const struct block_device_operations nbd_fops =
 {
 	.owner =	THIS_MODULE,
@@ -1616,6 +1622,7 @@ static const struct block_device_operations nbd_fops =
 	.release =	nbd_release,
 	.ioctl =	nbd_ioctl,
 	.compat_ioctl =	nbd_ioctl,
+	.free_disk =	nbd_free_disk,
 };
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-- 
2.42.0



