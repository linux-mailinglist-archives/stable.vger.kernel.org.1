Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3EB755492
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjGPUb7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjGPUbz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46241E54
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D693360EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E617CC433C7;
        Sun, 16 Jul 2023 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539509;
        bh=UZVPbcctiy2oDrd4lBLw5oQMC+sGPLOxg7nNDYe3BLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRFuWI3c8XCVU/TFesklp28DcNeQtdrKZseL50LmufrNLzK/Rrk0iGW+UdLtJMI/p
         jLa80uckhPgxZ3l/KejdO+11QK9FUPXkNI4D4rZSaAZdZmCZ8rqUjOtiH8hJ+NVygq
         2sqLMrSux9RiZ+c1DEaqR2nKPvIVrWt4dFct14Y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 032/591] block: fix blktrace debugfs entries leakage
Date:   Sun, 16 Jul 2023 21:42:51 +0200
Message-ID: <20230716194924.713463921@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit dd7de3704af9989b780693d51eaea49a665bd9c2 ]

Commit 99d055b4fd4b ("block: remove per-disk debugfs files in
blk_unregister_queue") moves blk_trace_shutdown() from
blk_release_queue() to blk_unregister_queue(), this is safe if blktrace
is created through sysfs, however, there is a regression in corner
case.

blktrace can still be enabled after del_gendisk() through ioctl if
the disk is opened before del_gendisk(), and if blktrace is not shutdown
through ioctl before closing the disk, debugfs entries will be leaked.

Fix this problem by shutdown blktrace in disk_release(), this is safe
because blk_trace_remove() is reentrant.

Fixes: 99d055b4fd4b ("block: remove per-disk debugfs files in blk_unregister_queue")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230610022003.2557284-4-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 62a61388e752d..afab646d12c85 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -25,8 +25,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/badblocks.h>
 #include <linux/part_stat.h>
-#include "blk-throttle.h"
+#include <linux/blktrace_api.h>
 
+#include "blk-throttle.h"
 #include "blk.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
@@ -1181,6 +1182,8 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
+	blk_trace_remove(disk->queue);
+
 	/*
 	 * To undo the all initialization from blk_mq_init_allocated_queue in
 	 * case of a probe failure where add_disk is never called we have to
-- 
2.39.2



