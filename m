Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5836D703923
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbjEORj3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbjEORjO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587AC8685
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:36:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3868E62DD3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F61C433D2;
        Mon, 15 May 2023 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172188;
        bh=W7gRnmZIVovH5DyqTn3YHGKXrTqlv0v62JNDlzxjSaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EofUbhdL7xwIOj/A+3OlqwUpMn6Qbv3AGQBGTErXhKOIapmYbRhKoF4Y3AD5sIEDb
         d5388hK9hbhFVRXKzzwjCZaEtLI3gGZR9H++McB9Er2udF0Px9Nsiyr6lwO8blE46n
         UM6oxH7PAPlXCmFezpv1i4vA45HA0Bv6m7/U5ihQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Zhengming <zhang.zhengming@h3c.com>,
        Zhao Lei <zhao_lei1@hoperun.com>,
        Zhou Kete <zhou.kete@h3c.com>,
        Pengcheng Yang <yangpc@wangsu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 043/381] relayfs: fix out-of-bounds access in relay_file_read
Date:   Mon, 15 May 2023 18:24:54 +0200
Message-Id: <20230515161738.790959552@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhang Zhengming <zhang.zhengming@h3c.com>

commit 43ec16f1450f4936025a9bdf1a273affdb9732c1 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/relay.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1077,7 +1077,8 @@ static size_t relay_file_read_start_pos(
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
 	size_t consumed = buf->subbufs_consumed % n_subbufs;
-	size_t read_pos = consumed * subbuf_size + buf->bytes_consumed;
+	size_t read_pos = (consumed * subbuf_size + buf->bytes_consumed)
+			% (n_subbufs * subbuf_size);
 
 	read_subbuf = read_pos / subbuf_size;
 	padding = buf->padding[read_subbuf];


