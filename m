Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB87ECB52
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjKOTVk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjKOTVa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:21:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6108D6D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:21:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB6BC433CB;
        Wed, 15 Nov 2023 19:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076085;
        bh=0PPe3RHY/B+XNnShMjtgSmFShBF+7m62+0p9gZ22yzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wuNVfqblun28RGAe0f/yGMluzsOBh5lMgL+KPMjis7sMBhKXbTFFBrx/rTtM/ZJJ8
         7LLb24BT67q02RnluYkFSRbLYuwrtw9MKnBTLkp0m9A22Ok+XweWNcSZysLA1yyH6z
         1pI4yaJTVFBpOcHinv5pAdlgcTm3rjUKESAEbThQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aananth V <aananthv@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 067/550] tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed
Date:   Wed, 15 Nov 2023 14:10:51 -0500
Message-ID: <20231115191605.335021022@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aananth V <aananthv@google.com>

[ Upstream commit e326578a21414738de45f77badd332fb00bd0f58 ]

For passive TCP Fast Open sockets that had SYN/ACK timeout and did not
send more data in SYN_RECV, upon receiving the final ACK in 3WHS, the
congestion state may awkwardly stay in CA_Loss mode unless the CA state
was undone due to TCP timestamp checks. However, if
tcp_rcv_synrecv_state_fastopen() decides not to undo, then we should
enter CA_Open, because at that point we have received an ACK covering
the retransmitted SYNACKs. Currently, the icsk_ca_state is only set to
CA_Open after we receive an ACK for a data-packet. This is because
tcp_ack does not call tcp_fastretrans_alert (and tcp_process_loss) if
!prior_packets

Note that tcp_process_loss() calls tcp_try_undo_recovery(), so having
tcp_rcv_synrecv_state_fastopen() decide that if we're in CA_Loss we
should call tcp_try_undo_recovery() is consistent with that, and
low risk.

Fixes: dad8cea7add9 ("tcp: fix TFO SYNACK undo to avoid double-timestamp-undo")
Signed-off-by: Aananth V <aananthv@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7d544f965b264..908db91f7b4cd 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6434,22 +6434,23 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct request_sock *req;
 
 	/* If we are still handling the SYNACK RTO, see if timestamp ECR allows
 	 * undo. If peer SACKs triggered fast recovery, we can't undo here.
 	 */
-	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss)
-		tcp_try_undo_loss(sk, false);
+	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss && !tp->packets_out)
+		tcp_try_undo_recovery(sk);
 
 	/* Reset rtx states to prevent spurious retransmits_timed_out() */
-	tcp_sk(sk)->retrans_stamp = 0;
+	tp->retrans_stamp = 0;
 	inet_csk(sk)->icsk_retransmits = 0;
 
 	/* Once we leave TCP_SYN_RECV or TCP_FIN_WAIT_1,
 	 * we no longer need req so release it.
 	 */
-	req = rcu_dereference_protected(tcp_sk(sk)->fastopen_rsk,
+	req = rcu_dereference_protected(tp->fastopen_rsk,
 					lockdep_sock_is_held(sk));
 	reqsk_fastopen_remove(sk, req, false);
 
-- 
2.42.0



