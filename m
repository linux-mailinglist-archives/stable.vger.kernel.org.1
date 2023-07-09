Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F174C22C
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjGILRh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGILRh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:17:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D18B5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E768960BD6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0316CC433C8;
        Sun,  9 Jul 2023 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901455;
        bh=20RzdbbO837WvEkxJP/2eS3il2gcFcbaJw7CnWVqIt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGAbHJkKhE7XwNjhr+nLFqywxQ2F2K9SB7RtB0ekDI64YAIORplZ4GIx6S5F+GJmG
         5iNZPz4b6cW6QA028VHOcg55rUBMOhqSLRlwlFbBs7uL+c2kU6Wrn5uWYwSLVluq4D
         XCQEXuuWQwe0S1U6a7DC1s68IM8Zs0lXVmajJJuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 026/431] block: fix blktrace debugfs entries leakage
Date:   Sun,  9 Jul 2023 13:09:34 +0200
Message-ID: <20230709111451.714061297@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 7f874737af682..c5a35e1b462fa 100644
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
@@ -1183,6 +1184,8 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
+	blk_trace_remove(disk->queue);
+
 	/*
 	 * To undo the all initialization from blk_mq_init_allocated_queue in
 	 * case of a probe failure where add_disk is never called we have to
-- 
2.39.2



