Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052A47A3BC4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbjIQUWZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbjIQUWB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:22:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F651BB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:21:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAD7C433C7;
        Sun, 17 Sep 2023 20:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982102;
        bh=Axfr5wl9unMLW34qsPFcHefWfh74iu7It2vzVKZwLH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAqDSdmsJ78niSb9tXkp5O2C+4Mz/FxtuZ/qicePADGAOLwn4DnYu55KBVYeH8lnP
         qqc2oS1Z22z1H73ZnNNsRnr/WZ06PyCH5ocTEYsbkq3Qbbsk5N3HTKGTcG/RXiVSZJ
         y9FiSQg6rKOcx+iVdKBF3fPGQ5Ono+Qq/4a7dWbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 217/219] kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().
Date:   Sun, 17 Sep 2023 21:15:44 +0200
Message-ID: <20230917191048.781225452@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index dd929a8350740..65845c59c0655 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1065,17 +1065,18 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
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



