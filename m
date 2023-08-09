Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F989775D96
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjHILjN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjHILjM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D81D1FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E76635E1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00FEC433C7;
        Wed,  9 Aug 2023 11:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581151;
        bh=hH0Whs3Ohcf/xs+zaJ3EQvnuYMHzb722yr/TdbiXMYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4hfU+ndFW6SpsCNSWKc1aGpkMFSQ3ePPHBj4DhPtRp7+u/a5ibrAnYhg5wFxfuhw
         wKh86korgaHuMpnParhWgPWLYcLHgWxeEEWAKii0E5hnZgjr63TQcPvCxDOqjShHlu
         cPwglT5EshoEzMo8asKY6MPBbDVX4y/CT7sSuJew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 124/201] loop: Select I/O scheduler none from inside add_disk()
Date:   Wed,  9 Aug 2023 12:42:06 +0200
Message-ID: <20230809103647.895397540@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 2112f5c1330a671fa852051d85cb9eadc05d7eb7 upstream.

We noticed that the user interface of Android devices becomes very slow
under memory pressure. This is because Android uses the zram driver on top
of the loop driver for swapping, because under memory pressure the swap
code alternates reads and writes quickly, because mq-deadline is the
default scheduler for loop devices and because mq-deadline delays writes by
five seconds for such a workload with default settings. Fix this by making
the kernel select I/O scheduler 'none' from inside add_disk() for loop
devices. This default can be overridden at any time from user space,
e.g. via a udev rule. This approach has an advantage compared to changing
the I/O scheduler from userspace from 'mq-deadline' into 'none', namely
that synchronize_rcu() does not get called.

This patch changes the default I/O scheduler for loop devices from
'mq-deadline' into 'none'.

Additionally, this patch reduces the Android boot time on my test setup
with 0.5 seconds compared to configuring the loop I/O scheduler from user
space.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Martijn Coenen <maco@android.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20210805174200.3250718-3-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2109,7 +2109,8 @@ static int loop_add(struct loop_device *
 	lo->tag_set.queue_depth = 128;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
+	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
+		BLK_MQ_F_NO_SCHED;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);


