Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F9E79BC63
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjIKUur (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbjIKPHy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:07:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39DFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:07:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6045C433CA;
        Mon, 11 Sep 2023 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444870;
        bh=7CyeIJq9a94SVp/rE3FrHt9gzqPjpQL/OKfz0YtskxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+YdGU0P82SYWPjcxl3qjEoDPALGnlD74yjvDrkeVNwYct+ksl8isgEeQn7Z2U4rL
         lAD50vNOb4onWolFTQkhCoD76uch8F7MvmFjjkfBFzYeIj1IXm5vwklMOfB/haFRKd
         +QIJgble4N2NacZ6bLCFdmQbqZFFw/cxjaHVIiOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 145/600] tcp: tcp_enter_quickack_mode() should be static
Date:   Mon, 11 Sep 2023 15:42:58 +0200
Message-ID: <20230911134637.887791526@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 03b123debcbc8db987bda17ed8412cc011064c22 ]

After commit d2ccd7bc8acd ("tcp: avoid resetting ACK timer in DCTCP"),
tcp_enter_quickack_mode() is only used from net/ipv4/tcp_input.c.

Fixes: d2ccd7bc8acd ("tcp: avoid resetting ACK timer in DCTCP")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Link: https://lore.kernel.org/r/20230718162049.1444938-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h    | 1 -
 net/ipv4/tcp_input.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9c8f88f47696..5fd69f2342a44 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -355,7 +355,6 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, int size, gfp_t gfp,
 				     bool force_schedule);
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks);
 static inline void tcp_dec_quickack_mode(struct sock *sk,
 					 const unsigned int pkts)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e2d3ea2e34561..c697836f2b5b4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -287,7 +287,7 @@ static void tcp_incr_quickack(struct sock *sk, unsigned int max_quickacks)
 		icsk->icsk_ack.quick = quickacks;
 }
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
+static void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -295,7 +295,6 @@ void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 	inet_csk_exit_pingpong_mode(sk);
 	icsk->icsk_ack.ato = TCP_ATO_MIN;
 }
-EXPORT_SYMBOL(tcp_enter_quickack_mode);
 
 /* Send ACKs quickly, if "quick" count is not exhausted
  * and the session is not interactive.
-- 
2.40.1



