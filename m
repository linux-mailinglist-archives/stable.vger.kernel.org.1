Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24AC7BE103
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377515AbjJINqW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377520AbjJINqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:46:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6240C192
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:45:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FBAC433C9;
        Mon,  9 Oct 2023 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859156;
        bh=dd3V4HKw+cQSM/qGFBnvSonKOXGD+UnCwJgo/4amwMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNwqwavd10qX59Gzk3Y1A2A6ffN9y6QSBMyPedIFhA37zibwXbrgAfjzvNnYlwQdQ
         a5eq+PcifYJW1LVR7GnRvMKvih5LQp6Pr6JMiVNvOE22Cli+bu4vBXPalHgBq/0i03
         421zTJ5i5D9MADnPT5JDhW+0eQvY4QaIG96N9Sg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Xin Guo <guoxin0309@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 209/226] tcp: fix delayed ACKs for MSS boundary condition
Date:   Mon,  9 Oct 2023 15:02:50 +0200
Message-ID: <20231009130132.020384903@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neal Cardwell <ncardwell@google.com>

[ Upstream commit 4720852ed9afb1c5ab84e96135cb5b73d5afde6f ]

This commit fixes poor delayed ACK behavior that can cause poor TCP
latency in a particular boundary condition: when an application makes
a TCP socket write that is an exact multiple of the MSS size.

The problem is that there is painful boundary discontinuity in the
current delayed ACK behavior. With the current delayed ACK behavior,
we have:

(1) If an app reads data when > 1*MSS is unacknowledged, then
    tcp_cleanup_rbuf() ACKs immediately because of:

     tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||

(2) If an app reads all received data, and the packets were < 1*MSS,
    and either (a) the app is not ping-pong or (b) we received two
    packets < 1*MSS, then tcp_cleanup_rbuf() ACKs immediately beecause
    of:

     ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED2) ||
      ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED) &&
       !inet_csk_in_pingpong_mode(sk))) &&

(3) *However*: if an app reads exactly 1*MSS of data,
    tcp_cleanup_rbuf() does not send an immediate ACK. This is true
    even if the app is not ping-pong and the 1*MSS of data had the PSH
    bit set, suggesting the sending application completed an
    application write.

Thus if the app is not ping-pong, we have this painful case where
>1*MSS gets an immediate ACK, and <1*MSS gets an immediate ACK, but a
write whose last skb is an exact multiple of 1*MSS can get a 40ms
delayed ACK. This means that any app that transfers data in one
direction and takes care to align write size or packet size with MSS
can suffer this problem. With receive zero copy making 4KB MSS values
more common, it is becoming more common to have application writes
naturally align with MSS, and more applications are likely to
encounter this delayed ACK problem.

The fix in this commit is to refine the delayed ACK heuristics with a
simple check: immediately ACK a received 1*MSS skb with PSH bit set if
the app reads all data. Why? If an skb has a len of exactly 1*MSS and
has the PSH bit set then it is likely the end of an application
write. So more data may not be arriving soon, and yet the data sender
may be waiting for an ACK if cwnd-bound or using TX zero copy. Thus we
set ICSK_ACK_PUSHED in this case so that tcp_cleanup_rbuf() will send
an ACK immediately if the app reads all of the data and is not
ping-pong. Note that this logic is also executed for the case where
len > MSS, but in that case this logic does not matter (and does not
hurt) because tcp_cleanup_rbuf() will always ACK immediately if the
app reads data and there is more than an MSS of unACKed data.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Guo <guoxin0309@gmail.com>
Link: https://lore.kernel.org/r/20231001151239.1866845-2-ncardwell.sw@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b8d2c45edbe02..3f2b6a3adf6a9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -242,6 +242,19 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		if (unlikely(len > icsk->icsk_ack.rcv_mss +
 				   MAX_TCP_OPTION_SPACE))
 			tcp_gro_dev_warn(sk, skb, len);
+		/* If the skb has a len of exactly 1*MSS and has the PSH bit
+		 * set then it is likely the end of an application write. So
+		 * more data may not be arriving soon, and yet the data sender
+		 * may be waiting for an ACK if cwnd-bound or using TX zero
+		 * copy. So we set ICSK_ACK_PUSHED here so that
+		 * tcp_cleanup_rbuf() will send an ACK immediately if the app
+		 * reads all of the data and is not ping-pong. If len > MSS
+		 * then this logic does not matter (and does not hurt) because
+		 * tcp_cleanup_rbuf() will always ACK immediately if the app
+		 * reads data and there is more than an MSS of unACKed data.
+		 */
+		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_PSH)
+			icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
 	} else {
 		/* Otherwise, we make more careful check taking into account,
 		 * that SACKs block is variable.
-- 
2.40.1



