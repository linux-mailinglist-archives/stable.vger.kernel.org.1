Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5036470C624
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjEVTPc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjEVTPY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281421A4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30BB662755
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494C6C433EF;
        Mon, 22 May 2023 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782916;
        bh=Sjcfn1r0ahXPgKMDb045L/vCMqWCxC7V8Hoxetw5THw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHKdgo9eNEtYzMqbGfq0dJxrNd92EUfTEHRANr0CiNrMVrLHmtS7hQXn5t9miCyI7
         YWGIhRksGTADucIp4pSCBmuOj0kgypkKcXtVBX/sZS2Ec+rJ+hEVhxjeg+gWNYQUP1
         OAeR/Kpe5Y5TSu3GpYfeKTGEeBLjkbg6rP6dnQic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhong Jinghua <zhongjinghua@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 073/203] nbd: fix incomplete validation of ioctl arg
Date:   Mon, 22 May 2023 20:08:17 +0100
Message-Id: <20230522190357.009055654@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Zhong Jinghua <zhongjinghua@huawei.com>

[ Upstream commit 55793ea54d77719a071b1ccc05a05056e3b5e009 ]

We tested and found an alarm caused by nbd_ioctl arg without verification.
The UBSAN warning calltrace like below:

UBSAN: Undefined behaviour in fs/buffer.c:1709:35
signed integer overflow:
-9223372036854775808 - 1 cannot be represented in type 'long long int'
CPU: 3 PID: 2523 Comm: syz-executor.0 Not tainted 4.19.90 #1
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x3f0 arch/arm64/kernel/time.c:78
 show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x170/0x1dc lib/dump_stack.c:118
 ubsan_epilogue+0x18/0xb4 lib/ubsan.c:161
 handle_overflow+0x188/0x1dc lib/ubsan.c:192
 __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:206
 __block_write_full_page+0x94c/0xa20 fs/buffer.c:1709
 block_write_full_page+0x1f0/0x280 fs/buffer.c:2934
 blkdev_writepage+0x34/0x40 fs/block_dev.c:607
 __writepage+0x68/0xe8 mm/page-writeback.c:2305
 write_cache_pages+0x44c/0xc70 mm/page-writeback.c:2240
 generic_writepages+0xdc/0x148 mm/page-writeback.c:2329
 blkdev_writepages+0x2c/0x38 fs/block_dev.c:2114
 do_writepages+0xd4/0x250 mm/page-writeback.c:2344

The reason for triggering this warning is __block_write_full_page()
-> i_size_read(inode) - 1 overflow.
inode->i_size is assigned in __nbd_ioctl() -> nbd_set_size() -> bytesize.
We think it is necessary to limit the size of arg to prevent errors.

Moreover, __nbd_ioctl() -> nbd_add_socket(), arg will be cast to int.
Assuming the value of arg is 0x80000000000000001) (on a 64-bit machine),
it will become 1 after the coercion, which will return unexpected results.

Fix it by adding checks to prevent passing in too large numbers.

Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20230206145805.2645671-1-zhongjinghua@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ade8b839e4458..394355f12d4e0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -326,6 +326,9 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
 		return -EINVAL;
 
+	if (bytesize < 0)
+		return -EINVAL;
+
 	nbd->config->bytesize = bytesize;
 	nbd->config->blksize_bits = __ffs(blksize);
 
@@ -1048,6 +1051,9 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct nbd_sock *nsock;
 	int err;
 
+	/* Arg will be cast to int, check it to avoid overflow */
+	if (arg > INT_MAX)
+		return -EINVAL;
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
-- 
2.39.2



