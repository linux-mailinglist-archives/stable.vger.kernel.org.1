Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6037CAC2E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJPOut (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJPOus (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:50:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C17095
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:50:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB662C433C8;
        Mon, 16 Oct 2023 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467846;
        bh=k9SMxqJPvzKSpmzpXvVLrqDoAu+f+jYjoT9FPPeTzAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBN1+WbUBgQRVhe8LHCFbONsBRuqmxpC3UJ7IwO/kfvsOPYqpIfE416ExGZwXhpzg
         nGLVb9XBaliTNHh/Hf49+MorcRodU1Wq7pCCIYxhK436TXeD9GA8HeM+ZQoIq6ttv7
         +ady0YYO8+Iye+5vCFWucCHAkxwtZ2wIpx0My2IU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergei Trofimovich <slyich@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 086/191] af_packet: Fix fortified memcpy() without flex array.
Date:   Mon, 16 Oct 2023 10:41:11 +0200
Message-ID: <20231016084017.406411246@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit e2bca4870fdaf855651ee80b083d892599c5d982 ]

Sergei Trofimovich reported a regression [0] caused by commit a0ade8404c3b
("af_packet: Fix warning of fortified memcpy() in packet_getname().").

It introduced a flex array sll_addr_flex in struct sockaddr_ll as a
union-ed member with sll_addr to work around the fortified memcpy() check.

However, a userspace program uses a struct that has struct sockaddr_ll in
the middle, where a flex array is illegal to exist.

  include/linux/if_packet.h:24:17: error: flexible array member 'sockaddr_ll::<unnamed union>::<unnamed struct>::sll_addr_flex' not at end of 'struct packet_info_t'
     24 |                 __DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
        |                 ^~~~~~~~~~~~~~~~~~~~

To fix the regression, let's go back to the first attempt [1] telling
memcpy() the actual size of the array.

Reported-by: Sergei Trofimovich <slyich@gmail.com>
Closes: https://github.com/NixOS/nixpkgs/pull/252587#issuecomment-1741733002 [0]
Link: https://lore.kernel.org/netdev/20230720004410.87588-3-kuniyu@amazon.com/ [1]
Fixes: a0ade8404c3b ("af_packet: Fix warning of fortified memcpy() in packet_getname().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20231009153151.75688-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/if_packet.h | 6 +-----
 net/packet/af_packet.c         | 7 ++++++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
index 4d0ad22f83b56..9efc42382fdb9 100644
--- a/include/uapi/linux/if_packet.h
+++ b/include/uapi/linux/if_packet.h
@@ -18,11 +18,7 @@ struct sockaddr_ll {
 	unsigned short	sll_hatype;
 	unsigned char	sll_pkttype;
 	unsigned char	sll_halen;
-	union {
-		unsigned char	sll_addr[8];
-		/* Actual length is in sll_halen. */
-		__DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
-	};
+	unsigned char	sll_addr[8];
 };
 
 /* Packet types */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a2935bd18ed98..a39b2a0dd5425 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3605,7 +3605,12 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
 	if (dev) {
 		sll->sll_hatype = dev->type;
 		sll->sll_halen = dev->addr_len;
-		memcpy(sll->sll_addr_flex, dev->dev_addr, dev->addr_len);
+
+		/* Let __fortify_memcpy_chk() know the actual buffer size. */
+		memcpy(((struct sockaddr_storage *)sll)->__data +
+		       offsetof(struct sockaddr_ll, sll_addr) -
+		       offsetofend(struct sockaddr_ll, sll_family),
+		       dev->dev_addr, dev->addr_len);
 	} else {
 		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
 		sll->sll_halen = 0;
-- 
2.40.1



