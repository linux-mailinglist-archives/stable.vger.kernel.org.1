Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084197DD5E9
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 19:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjJaSP6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjJaRuG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:50:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D29A6
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:50:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83486C433C7;
        Tue, 31 Oct 2023 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774603;
        bh=LVNkCHjscX8lKQzVu0vV+2YSArwT29hUqO3rnSUfHl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkOr4OlbfrsK3Ysjl0GwcFwwm46NvUBfC7HMdfCKZw/VLu677ha+vatpilWlDst6x
         riuL2e2e0uIWS7/BVrsAtylOih0fAO7qpOif5VySq2+aESkkfskJDHlFoAwti/5PbP
         9PoGVCMVfPDQmP4Fwi7RnShSlF8+gCXuGQNUS0YE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fred Chen <fred.chenchen03@gmail.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 066/112] tcp: fix wrong RTO timeout when received SACK reneging
Date:   Tue, 31 Oct 2023 18:01:07 +0100
Message-ID: <20231031165903.403516824@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fred Chen <fred.chenchen03@gmail.com>

[ Upstream commit d2a0fc372aca561556e765d0a9ec365c7c12f0ad ]

This commit fix wrong RTO timeout when received SACK reneging.

When an ACK arrived pointing to a SACK reneging, tcp_check_sack_reneging()
will rearm the RTO timer for min(1/2*srtt, 10ms) into to the future.

But since the commit 62d9f1a6945b ("tcp: fix TLP timer not set when
CA_STATE changes from DISORDER to OPEN") merged, the tcp_set_xmit_timer()
is moved after tcp_fastretrans_alert()(which do the SACK reneging check),
so the RTO timeout will be overwrited by tcp_set_xmit_timer() with
icsk_rto instead of 1/2*srtt.

Here is a packetdrill script to check this bug:
0     socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0    bind(3, ..., ...) = 0
+0    listen(3, 1) = 0

// simulate srtt to 100ms
+0    < S 0:0(0) win 32792 <mss 1000, sackOK,nop,nop,nop,wscale 7>
+0    > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 7>
+.1    < . 1:1(0) ack 1 win 1024

+0    accept(3, ..., ...) = 4

+0    write(4, ..., 10000) = 10000
+0    > P. 1:10001(10000) ack 1

// inject sack
+.1    < . 1:1(0) ack 1 win 257 <sack 1001:10001,nop,nop>
+0    > . 1:1001(1000) ack 1

// inject sack reneging
+.1    < . 1:1(0) ack 1001 win 257 <sack 9001:10001,nop,nop>

// we expect rto fired in 1/2*srtt (50ms)
+.05    > . 1001:2001(1000) ack 1

This fix remove the FLAG_SET_XMIT_TIMER from ack_flag when
tcp_check_sack_reneging() set RTO timer with 1/2*srtt to avoid
being overwrited later.

Fixes: 62d9f1a6945b ("tcp: fix TLP timer not set when CA_STATE changes from DISORDER to OPEN")
Signed-off-by: Fred Chen <fred.chenchen03@gmail.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a5781f86ac375..7d544f965b264 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2202,16 +2202,17 @@ void tcp_enter_loss(struct sock *sk)
  * restore sanity to the SACK scoreboard. If the apparent reneging
  * persists until this RTO then we'll clear the SACK scoreboard.
  */
-static bool tcp_check_sack_reneging(struct sock *sk, int flag)
+static bool tcp_check_sack_reneging(struct sock *sk, int *ack_flag)
 {
-	if (flag & FLAG_SACK_RENEGING &&
-	    flag & FLAG_SND_UNA_ADVANCED) {
+	if (*ack_flag & FLAG_SACK_RENEGING &&
+	    *ack_flag & FLAG_SND_UNA_ADVANCED) {
 		struct tcp_sock *tp = tcp_sk(sk);
 		unsigned long delay = max(usecs_to_jiffies(tp->srtt_us >> 4),
 					  msecs_to_jiffies(10));
 
 		inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
 					  delay, TCP_RTO_MAX);
+		*ack_flag &= ~FLAG_SET_XMIT_TIMER;
 		return true;
 	}
 	return false;
@@ -2981,7 +2982,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 		tp->prior_ssthresh = 0;
 
 	/* B. In all the states check for reneging SACKs. */
-	if (tcp_check_sack_reneging(sk, flag))
+	if (tcp_check_sack_reneging(sk, ack_flag))
 		return;
 
 	/* C. Check consistency of the current state. */
-- 
2.42.0



