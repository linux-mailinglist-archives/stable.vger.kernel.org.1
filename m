Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05C7ED449
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344577AbjKOU5i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjKOU50 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B3DD57
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BD8C433BA;
        Wed, 15 Nov 2023 20:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081251;
        bh=UR179jnsBRLa0qm9pWrfBWm9wp6ZkHL+dsK/8HTRuTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptu+qOW8Q8010oTb/z+ubN49mv12XFzl0pJ+OQprU7hIaVErddAp1RHB8Ysv2+q0n
         qLhA36eZTYH87lJlIbm/zHusgegaKzwtPHQw11HftOW+GhknmSBUBcWvg7PjCcYjf6
         19ldLggQt7JIVrSmdUNy4XXMo/cgAT7IWR83uf7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 041/244] chtls: fix tp->rcv_tstamp initialization
Date:   Wed, 15 Nov 2023 15:33:53 -0500
Message-ID: <20231115203550.834176497@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 225d9ddbacb102621af6d28ff7bf5a0b4ce249d8 ]

tp->rcv_tstamp should be set to tcp_jiffies, not tcp_time_stamp().

Fixes: cc35c88ae4db ("crypto : chtls - CPL handler definition")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index ddfe9208529a5..65d4a39634be4 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -2260,7 +2260,7 @@ static void chtls_rx_ack(struct sock *sk, struct sk_buff *skb)
 
 		if (tp->snd_una != snd_una) {
 			tp->snd_una = snd_una;
-			tp->rcv_tstamp = tcp_time_stamp(tp);
+			tp->rcv_tstamp = tcp_jiffies32;
 			if (tp->snd_una == tp->snd_nxt &&
 			    !csk_flag_nochk(csk, CSK_TX_FAILOVER))
 				csk_reset_flag(csk, CSK_TX_WAIT_IDLE);
-- 
2.42.0



