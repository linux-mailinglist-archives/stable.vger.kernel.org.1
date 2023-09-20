Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEF07A7CB5
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjITMDg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjITMDe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:03:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B94132
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:03:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272B0C433C7;
        Wed, 20 Sep 2023 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211401;
        bh=Ti6+EH9JGeFXX696tUhdb5s952IKLAwe1yNVV0xQYlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=az6WLJOCm3Ew5RdZXB5bKwEkRtr3R2fZhOm5EzZzxPdq0t5js8U8bbiYleJh6n4dW
         11+68vYVDcZkLUq8H+6l0/lsAeYqPvHd2DzwfPBPd41h1BPk+rEVmOzglXWTiYGeDV
         7LOWGIooK2XGGNhxJ3XMnV5O5zX5sgciQIqPB+8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Menglong Dong <imagedong@tencent.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 043/186] net: tcp: fix unexcepted socket die when snd_wnd is 0
Date:   Wed, 20 Sep 2023 13:29:06 +0200
Message-ID: <20230920112838.497421545@linuxfoundation.org>
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

From: Menglong Dong <imagedong@tencent.com>

[ Upstream commit e89688e3e97868451a5d05b38a9d2633d6785cd4 ]

In tcp_retransmit_timer(), a window shrunk connection will be regarded
as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is not
right all the time.

The retransmits will become zero-window probes in tcp_retransmit_timer()
if the 'snd_wnd==0'. Therefore, the icsk->icsk_rto will come up to
TCP_RTO_MAX sooner or later.

However, the timer can be delayed and be triggered after 122877ms, not
TCP_RTO_MAX, as I tested.

Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
once the RTO come up to TCP_RTO_MAX, and the socket will die.

Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
which is exact the timestamp of the timeout.

However, "tp->rcv_tstamp" can restart from idle, then tp->rcv_tstamp
could already be a long time (minutes or hours) in the past even on the
first RTO. So we double check the timeout with the duration of the
retransmission.

Meanwhile, making "2 * TCP_RTO_MAX" as the timeout to avoid the socket
dying too soon.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gSD2XT8pyAMM096pg@mail.gmail.com/
Signed-off-by: Menglong Dong <imagedong@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_timer.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d708094952056..3d51a7edb3117 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -396,6 +396,22 @@ static void tcp_fastopen_synack_timer(struct sock *sk)
 			  TCP_TIMEOUT_INIT << req->num_timeout, TCP_RTO_MAX);
 }
 
+static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
+				     const struct sk_buff *skb)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+	const int timeout = TCP_RTO_MAX * 2;
+	u32 rcv_delta, rtx_delta;
+
+	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
+	if (rcv_delta <= timeout)
+		return false;
+
+	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
+			(tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
+
+	return rtx_delta > timeout;
+}
 
 /**
  *  tcp_retransmit_timer() - The TCP retransmit timeout handler
@@ -458,7 +474,7 @@ void tcp_retransmit_timer(struct sock *sk)
 					    tp->snd_una, tp->snd_nxt);
 		}
 #endif
-		if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
+		if (tcp_rtx_probe0_timed_out(sk, skb)) {
 			tcp_write_err(sk);
 			goto out;
 		}
-- 
2.40.1



