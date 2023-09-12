Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830EC79B783
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjIKUvw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbjIKPJK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:09:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E83FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:09:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D2FC433C7;
        Mon, 11 Sep 2023 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444945;
        bh=SdiobAsLAjlJ9JIu65yYeLUQSrchlBJ4+p3f2f0Sdic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEchn39Fc8rVXuBTKMJG3RqemeW4ujA5KdTn480G3P5Prv2tPRkkGnEwi1FjAMmSi
         tbV0IcTi/52cMGI//aT3ToZ7VQ1OR+peEDZnqbl93R7YWjfx5gM+MEgXDSpMjnZvoM
         p1oZakku76ADfOo7D1ht1DTPa0MMHACCvJQMdiCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Menglong Dong <imagedong@tencent.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 173/600] net: tcp: fix unexcepted socket die when snd_wnd is 0
Date:   Mon, 11 Sep 2023 15:43:26 +0200
Message-ID: <20230911134638.713115949@linuxfoundation.org>
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
index cf354c29ec123..44b49f7d1a9e6 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -441,6 +441,22 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 			  req->timeout << req->num_timeout, TCP_RTO_MAX);
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
@@ -506,7 +522,7 @@ void tcp_retransmit_timer(struct sock *sk)
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



