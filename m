Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167547A38F3
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbjIQTnC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbjIQTmk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:42:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC93188
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:42:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B10DC433C8;
        Sun, 17 Sep 2023 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979752;
        bh=Iy8Hpnu4l2JK/2QqLSAUsdVKerP/3M/4WH5HMg7lHXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZ7zeKZTR/VzJNEe5LI1ZXnAFYvZUdeL4LXyW8Kjug4UDNO7D53S2ELopJmX4X7Hm
         X7c9Cuj7wG5BzlO5rovdZrGfHFuOiqjRzvAOFmfjNFlwlr1KxSGwfBowNh6/M39wfL
         EEa5EUgQE8aE3F/Kq7dOpvdbh8Xuqlb3SHDRQ1l4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 404/406] kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().
Date:   Sun, 17 Sep 2023 21:14:18 +0200
Message-ID: <20230917191111.925191338@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index fb025406ea567..39b3c7fbf9f66 100644
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



