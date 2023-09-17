Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7AE7A3D73
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjIQUnN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbjIQUmq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:42:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A413CCE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:42:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79FDC433CA;
        Sun, 17 Sep 2023 20:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983345;
        bh=Z9hQ0kNV8gqHtWt64eiBng++M2iBISmwSDZ0hmf2oyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEyiUJVZ4EwpH7Wtf7CJcwM4RNa8DkEG9vQBMKvbf8f/wY30YAt2RcZ0Qbfzc0yLP
         d+tU3/qqBTrP4Yt7/m0vZ1sLi6ZC1mFu+Dn5D/v2UV06M8oBqvQFtei5vuGY09Tqna
         v8c+7WaRXB9GSjyLGiCnn90HtV6nkud89BK2HhqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 509/511] kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().
Date:   Sun, 17 Sep 2023 21:15:36 +0200
Message-ID: <20230917191126.008215161@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit a22730b1b4bf437c6bbfdeff5feddf54be4aeada ]

syzkaller found a memory leak in kcm_sendmsg(), and commit c821a88bd720
("kcm: Fix memory leak in error path of kcm_sendmsg()") suppressed it by
updating kcm_tx_msg(head)->last_skb if partial data is copied so that the
following sendmsg() will resume from the skb.

However, we cannot know how many bytes were copied when we get the error.
Thus, we could mess up the MSG_MORE queue.

When kcm_sendmsg() fails for SOCK_DGRAM, we should purge the queue as we
do so for UDP by udp_flush_pending_frames().

Even without this change, when the error occurred, the following sendmsg()
resumed from a wrong skb and the queue was messed up.  However, we have
yet to get such a report, and only syzkaller stumbled on it.  So, this
can be changed safely.

Note this does not change SOCK_SEQPACKET behaviour.

Fixes: c821a88bd720 ("kcm: Fix memory leak in error path of kcm_sendmsg()")
Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230912022753.33327-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 2d06617e89891..0d1ab4149553c 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1064,17 +1064,18 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 out_error:
 	kcm_push(kcm);
 
-	if (copied && sock->type == SOCK_SEQPACKET) {
+	if (sock->type == SOCK_SEQPACKET) {
 		/* Wrote some bytes before encountering an
 		 * error, return partial success.
 		 */
-		goto partial_message;
-	}
-
-	if (head != kcm->seq_skb)
+		if (copied)
+			goto partial_message;
+		if (head != kcm->seq_skb)
+			kfree_skb(head);
+	} else {
 		kfree_skb(head);
-	else if (copied)
-		kcm_tx_msg(head)->last_skb = skb;
+		kcm->seq_skb = NULL;
+	}
 
 	err = sk_stream_error(sk, msg->msg_flags, err);
 
-- 
2.40.1



