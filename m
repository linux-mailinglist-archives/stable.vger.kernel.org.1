Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688066FA55B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjEHKIh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjEHKIf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A219532927
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 348A862295
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E3EC433EF;
        Mon,  8 May 2023 10:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540513;
        bh=26UkX21mnHCir44Ml/AoGVmniXXgA7fy+N5MBZlbnao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rH1ERL7z6/Xf0UuxomaSfjbi+6OmHEJY3lW7S/smMlXoBqlkxzQJE21wWUSLvktC2
         d9p6iuUbPQ+8m7S1zYOWFxnL9x4b/3pbm7VtP8yglaJYSD229Lmp1XaQW8lhVvfIXD
         MXQwPUPswNMq78uQnK+WOXGFJsIhGmEMNtFylrFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brad Spencer <bspencer@blackberry.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 394/611] netlink: Use copy_to_user() for optval in netlink_getsockopt().
Date:   Mon,  8 May 2023 11:43:56 +0200
Message-Id: <20230508094435.087894624@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit d913d32cc2707e9cd24fe6fa6d7d470e9c728980 ]

Brad Spencer provided a detailed report [0] that when calling getsockopt()
for AF_NETLINK, some SOL_NETLINK options set only 1 byte even though such
options require at least sizeof(int) as length.

The options return a flag value that fits into 1 byte, but such behaviour
confuses users who do not initialise the variable before calling
getsockopt() and do not strictly check the returned value as char.

Currently, netlink_getsockopt() uses put_user() to copy data to optlen and
optval, but put_user() casts the data based on the pointer, char *optval.
As a result, only 1 byte is set to optval.

To avoid this behaviour, we need to use copy_to_user() or cast optval for
put_user().

Note that this changes the behaviour on big-endian systems, but we document
that the size of optval is int in the man page.

  $ man 7 netlink
  ...
  Socket options
       To set or get a netlink socket option, call getsockopt(2) to read
       or setsockopt(2) to write the option with the option level argument
       set to SOL_NETLINK.  Unless otherwise noted, optval is a pointer to
       an int.

Fixes: 9a4595bc7e67 ("[NETLINK]: Add set/getsockopt options to support more than 32 groups")
Fixes: be0c22a46cfb ("netlink: add NETLINK_BROADCAST_ERROR socket option")
Fixes: 38938bfe3489 ("netlink: add NETLINK_NO_ENOBUFS socket flag")
Fixes: 0a6a3a23ea6e ("netlink: add NETLINK_CAP_ACK socket option")
Fixes: 2d4bc93368f5 ("netlink: extended ACK reporting")
Fixes: 89d35528d17d ("netlink: Add new socket option to enable strict checking on dumps")
Reported-by: Brad Spencer <bspencer@blackberry.com>
Link: https://lore.kernel.org/netdev/ZD7VkNWFfp22kTDt@datsun.rim.net/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Link: https://lore.kernel.org/r/20230421185255.94606-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 75 ++++++++++++----------------------------
 1 file changed, 23 insertions(+), 52 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 99622c64081c4..b1dcc536521b6 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1731,7 +1731,8 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
-	int len, val, err;
+	unsigned int flag;
+	int len, val;
 
 	if (level != SOL_NETLINK)
 		return -ENOPROTOOPT;
@@ -1743,39 +1744,17 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case NETLINK_PKTINFO:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_RECV_PKTINFO ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_RECV_PKTINFO;
 		break;
 	case NETLINK_BROADCAST_ERROR:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_BROADCAST_SEND_ERROR;
 		break;
 	case NETLINK_NO_ENOBUFS:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_RECV_NO_ENOBUFS ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_RECV_NO_ENOBUFS;
 		break;
 	case NETLINK_LIST_MEMBERSHIPS: {
-		int pos, idx, shift;
+		int pos, idx, shift, err = 0;
 
-		err = 0;
 		netlink_lock_table();
 		for (pos = 0; pos * 8 < nlk->ngroups; pos += sizeof(u32)) {
 			if (len - pos < sizeof(u32))
@@ -1792,40 +1771,32 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		if (put_user(ALIGN(nlk->ngroups / 8, sizeof(u32)), optlen))
 			err = -EFAULT;
 		netlink_unlock_table();
-		break;
+		return err;
 	}
 	case NETLINK_CAP_ACK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_CAP_ACK ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_CAP_ACK;
 		break;
 	case NETLINK_EXT_ACK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_EXT_ACK ? 1 : 0;
-		if (put_user(len, optlen) || put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_EXT_ACK;
 		break;
 	case NETLINK_GET_STRICT_CHK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_STRICT_CHK ? 1 : 0;
-		if (put_user(len, optlen) || put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_STRICT_CHK;
 		break;
 	default:
-		err = -ENOPROTOOPT;
+		return -ENOPROTOOPT;
 	}
-	return err;
+
+	if (len < sizeof(int))
+		return -EINVAL;
+
+	len = sizeof(int);
+	val = nlk->flags & flag ? 1 : 0;
+
+	if (put_user(len, optlen) ||
+	    copy_to_user(optval, &val, len))
+		return -EFAULT;
+
+	return 0;
 }
 
 static void netlink_cmsg_recv_pktinfo(struct msghdr *msg, struct sk_buff *skb)
-- 
2.39.2



