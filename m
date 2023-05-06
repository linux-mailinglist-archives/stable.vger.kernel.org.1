Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807CB6F8F61
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjEFGmC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 02:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjEFGlu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 02:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D24C1D
        for <stable@vger.kernel.org>; Fri,  5 May 2023 23:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1856261777
        for <stable@vger.kernel.org>; Sat,  6 May 2023 06:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D309C433D2;
        Sat,  6 May 2023 06:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683355305;
        bh=0TH7GMZ9OJ7D3bowhtgxXN36mrdTjBnIRtVZQIbSv9A=;
        h=Subject:To:Cc:From:Date:From;
        b=Hyxb18e7h7h0T4yLZlXMy9iMX/GgnoYtcRCkavB7bpcX5gJob9c1fekzQEhCb6J44
         n2vbfy8DxdZ3QxrrUC8YciIrYYjFzOZg9ih5Wh8LwPFMwdRTXVZqVFlk7lMTFsJbmL
         zpACUFLr4/ayCAlPIlxXRkIVzijWOiygKy4quQoU=
Subject: FAILED: patch "[PATCH] relayfs: fix out-of-bounds access in relay_file_read" failed to apply to 5.4-stable tree
To:     zhang.zhengming@h3c.com, akpm@linux-foundation.org,
        axboe@kernel.dk, stable@vger.kernel.org, yangpc@wangsu.com,
        zhao_lei1@hoperun.com, zhou.kete@h3c.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:33:27 +0900
Message-ID: <2023050627-squirt-reproach-95be@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 43ec16f1450f4936025a9bdf1a273affdb9732c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050627-squirt-reproach-95be@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 43ec16f1450f4936025a9bdf1a273affdb9732c1 Mon Sep 17 00:00:00 2001
From: Zhang Zhengming <zhang.zhengming@h3c.com>
Date: Wed, 19 Apr 2023 12:02:03 +0800
Subject: [PATCH] relayfs: fix out-of-bounds access in relay_file_read

There is a crash in relay_file_read, as the var from
point to the end of last subbuf.

The oops looks something like:
pc : __arch_copy_to_user+0x180/0x310
lr : relay_file_read+0x20c/0x2c8
Call trace:
 __arch_copy_to_user+0x180/0x310
 full_proxy_read+0x68/0x98
 vfs_read+0xb0/0x1d0
 ksys_read+0x6c/0xf0
 __arm64_sys_read+0x20/0x28
 el0_svc_common.constprop.3+0x84/0x108
 do_el0_svc+0x74/0x90
 el0_svc+0x1c/0x28
 el0_sync_handler+0x88/0xb0
 el0_sync+0x148/0x180

We get the condition by analyzing the vmcore:

1). The last produced byte and last consumed byte
    both at the end of the last subbuf

2). A softirq calls function(e.g __blk_add_trace)
    to write relay buffer occurs when an program is calling
    relay_file_read_avail().

        relay_file_read
                relay_file_read_avail
                        relay_file_read_consume(buf, 0, 0);
                        //interrupted by softirq who will write subbuf
                        ....
                        return 1;
                //read_start point to the end of the last subbuf
                read_start = relay_file_read_start_pos
                //avail is equal to subsize
                avail = relay_file_read_subbuf_avail
                //from  points to an invalid memory address
                from = buf->start + read_start
                //system is crashed
                copy_to_user(buffer, from, avail)

Link: https://lkml.kernel.org/r/20230419040203.37676-1-zhang.zhengming@h3c.com
Fixes: 8d62fdebdaf9 ("relay file read: start-pos fix")
Signed-off-by: Zhang Zhengming <zhang.zhengming@h3c.com>
Reviewed-by: Zhao Lei <zhao_lei1@hoperun.com>
Reviewed-by: Zhou Kete <zhou.kete@h3c.com>
Reviewed-by: Pengcheng Yang <yangpc@wangsu.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/kernel/relay.c b/kernel/relay.c
index 9aa70ae53d24..a80fa01042e9 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -989,7 +989,8 @@ static size_t relay_file_read_start_pos(struct rchan_buf *buf)
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
 	size_t consumed = buf->subbufs_consumed % n_subbufs;
-	size_t read_pos = consumed * subbuf_size + buf->bytes_consumed;
+	size_t read_pos = (consumed * subbuf_size + buf->bytes_consumed)
+			% (n_subbufs * subbuf_size);
 
 	read_subbuf = read_pos / subbuf_size;
 	padding = buf->padding[read_subbuf];

