Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F237F7A7D14
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjITMG0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjITMGZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:06:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4CFE0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:06:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1828C433CB;
        Wed, 20 Sep 2023 12:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211577;
        bh=bJ5Dp4qZAzy0+MCahqhzjrPGvQc7ycSCvAVdbcDXdrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rp5Aujp/axSahVPILgGy6j1CMDpaAzw5oeZ+T4u3SSp5sLYtHlJ+7Rj04eeE1Tbgp
         7eVrQ/l4V1/OtlvN+JZ0nTFbfOPjvOe2s1JE4CBr0okbr800JQ9B37qaAEpYa7nS78
         Sm6fJ5lFlMh3KMfufNFPZQjUHlYa+mxDNjjswuvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shigeru Yoshida <syoshida@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
Subject: [PATCH 4.14 145/186] kcm: Fix memory leak in error path of kcm_sendmsg()
Date:   Wed, 20 Sep 2023 13:30:48 +0200
Message-ID: <20230920112842.214863015@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit c821a88bd720b0046433173185fd841a100d44ad ]

syzbot reported a memory leak like below:

BUG: memory leak
unreferenced object 0xffff88810b088c00 (size 240):
  comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
  hex dump (first 32 bytes):
    00 89 08 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5d5ff>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:634
    [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
    [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
    [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
    [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
    [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
    [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
    [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

In kcm_sendmsg(), kcm_tx_msg(head)->last_skb is used as a cursor to append
newly allocated skbs to 'head'. If some bytes are copied, an error occurred,
and jumped to out_error label, 'last_skb' is left unmodified. A later
kcm_sendmsg() will use an obsoleted 'last_skb' reference, corrupting the
'head' frag_list and causing the leak.

This patch fixes this issue by properly updating the last allocated skb in
'last_skb'.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Reported-and-tested-by: syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6f98de741f7dbbfc4ccb
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 0589b6b560eca..96b5fbe919b67 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1074,6 +1074,8 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 	if (head != kcm->seq_skb)
 		kfree_skb(head);
+	else if (copied)
+		kcm_tx_msg(head)->last_skb = skb;
 
 	err = sk_stream_error(sk, msg->msg_flags, err);
 
-- 
2.40.1



