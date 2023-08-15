Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A491977CDA2
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 15:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjHON5R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 09:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbjHON4o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 09:56:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A70EE;
        Tue, 15 Aug 2023 06:56:42 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQCQW2jjkzNm9h;
        Tue, 15 Aug 2023 21:53:07 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 21:56:37 +0800
From:   Dong Chenchen <dongchenchen2@huawei.com>
To:     <kernel@openeuler.org>
CC:     <duanzi@zju.edu.cn>, <yuehaibing@huawei.com>,
        <weiyongjun1@huawei.com>, <liujian56@huawei.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH OLK-5.10 v2 1/2] net: tun_chr_open(): set sk_uid from current_fsuid()
Date:   Tue, 15 Aug 2023 21:56:01 +0800
Message-ID: <20230815135602.1014881-2-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815135602.1014881-1-dongchenchen2@huawei.com>
References: <20230815135602.1014881-1-dongchenchen2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Laszlo Ersek <lersek@redhat.com>

stable inclusion
from stable-v5.10.189
commit 5ea23f1cb67e4468db7ff651627892c9217fec24
category: bugfix
bugzilla: 189104, https://gitee.com/src-openeuler/kernel/issues/I7QXHX
CVE: CVE-2023-4194

Reference: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=5ea23f1cb67e4468db7ff651627892c9217fec24

---------------------------

commit 9bc3047374d5bec163e83e743709e23753376f0c upstream.

Commit a096ccca6e50 initializes the "sk_uid" field in the protocol socket
(struct sock) from the "/dev/net/tun" device node's owner UID. Per
original commit 86741ec25462 ("net: core: Add a UID field to struct
sock.", 2016-11-04), that's wrong: the idea is to cache the UID of the
userspace process that creates the socket. Commit 86741ec25462 mentions
socket() and accept(); with "tun", the action that creates the socket is
open("/dev/net/tun").

Therefore the device node's owner UID is irrelevant. In most cases,
"/dev/net/tun" will be owned by root, so in practice, commit a096ccca6e50
has no observable effect:

- before, "sk_uid" would be zero, due to undefined behavior
  (CVE-2023-1076),

- after, "sk_uid" would be zero, due to "/dev/net/tun" being owned by root.

What matters is the (fs)UID of the process performing the open(), so cache
that in "sk_uid".

Cc: Eric Dumazet <edumazet@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Pietro Borrello <borrello@diag.uniroma1.it>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: a096ccca6e50 ("tun: tun_chr_open(): correctly initialize socket uid")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2173435
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f8feec522b32..50c2ce392cd1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3456,7 +3456,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 	tfile->socket.file = file;
 	tfile->socket.ops = &tun_socket_ops;
 
-	sock_init_data_uid(&tfile->socket, &tfile->sk, inode->i_uid);
+	sock_init_data_uid(&tfile->socket, &tfile->sk, current_fsuid());
 
 	tfile->sk.sk_write_space = tun_sock_write_space;
 	tfile->sk.sk_sndbuf = INT_MAX;
-- 
2.25.1

