Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A23B726D1F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjFGUje (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbjFGUjO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70EC273D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56F2A645C8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66483C433EF;
        Wed,  7 Jun 2023 20:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170325;
        bh=zlS7jTFaits1XcQkhlJmSDn45yZbN/98Lx2XUZc82hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifXDJUS8wVcLj74s0L0aUmFs8e8J+zYoE9+yNuYdTDh37wzKW9dd3VtgMU80w8Cy0
         mDmexKb3HvPRpQJ7OnKjYvL3olDP5Rj5TXACc1wLJD5XmCtc2tCmzkXCG/gVaLAiXp
         /pzN80JFt83gKkRpL4kcQzFaoHd9S2+uf5l13yfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladislav Efanov <VEfanov@ispras.ru>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 041/225] udp6: Fix race condition in udp6_sendmsg & connect
Date:   Wed,  7 Jun 2023 22:13:54 +0200
Message-ID: <20230607200915.690959860@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vladislav Efanov <VEfanov@ispras.ru>

[ Upstream commit 448a5ce1120c5bdbce1f1ccdabcd31c7d029f328 ]

Syzkaller got the following report:
BUG: KASAN: use-after-free in sk_setup_caps+0x621/0x690 net/core/sock.c:2018
Read of size 8 at addr ffff888027f82780 by task syz-executor276/3255

The function sk_setup_caps (called by ip6_sk_dst_store_flow->
ip6_dst_store) referenced already freed memory as this memory was
freed by parallel task in udpv6_sendmsg->ip6_sk_dst_lookup_flow->
sk_dst_check.

          task1 (connect)              task2 (udp6_sendmsg)
        sk_setup_caps->sk_dst_set |
                                  |  sk_dst_check->
                                  |      sk_dst_set
                                  |      dst_release
        sk_setup_caps references  |
        to already freed dst_entry|

The reason for this race condition is: sk_setup_caps() keeps using
the dst after transferring the ownership to the dst cache.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index eb0b76acd9df1..83f590d8d0850 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2370,7 +2370,6 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
 	u32 max_segs = 1;
 
-	sk_dst_set(sk, dst);
 	sk->sk_route_caps = dst->dev->features;
 	if (sk_is_tcp(sk))
 		sk->sk_route_caps |= NETIF_F_GSO;
@@ -2392,6 +2391,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
+	sk_dst_set(sk, dst);
 }
 EXPORT_SYMBOL_GPL(sk_setup_caps);
 
-- 
2.39.2



