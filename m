Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A3F775AAC
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjHILKc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjHILKc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0938ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D5A6245A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE1AC433C7;
        Wed,  9 Aug 2023 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579430;
        bh=7MmJOywD/N+7zgR03Puape8lsRvdhUnxPAYm8oN2iUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKcnNKVwAbD2h3+gaJ7SZulMIQO57kYJQ5U6HorwSgpR6dnXZU8JB/siaL+68kB1t
         wE7pHIUzoOQXNPjq23sJr+07BNQY7xVML0gPZHwDIhI1DJUy4c01eP5+82CFSWlfMM
         opqWkx6zW3uyiAazW6Li5Dss5ryXhmG8ELZ4RS64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 193/204] tcp_metrics: annotate data-races around tm->tcpm_vals[]
Date:   Wed,  9 Aug 2023 12:42:11 +0200
Message-ID: <20230809103648.944629000@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8c4d04f6b443869d25e59822f7cec88d647028a9 ]

tm->tcpm_vals[] values can be read or written locklessly.

Add needed READ_ONCE()/WRITE_ONCE() to document this,
and force use of tcp_metric_get() and tcp_metric_set()

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_metrics.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 2f0e7c38e634c..13b92573aadd3 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -65,17 +65,19 @@ static bool tcp_metric_locked(struct tcp_metrics_block *tm,
 	return READ_ONCE(tm->tcpm_lock) & (1 << idx);
 }
 
-static u32 tcp_metric_get(struct tcp_metrics_block *tm,
+static u32 tcp_metric_get(const struct tcp_metrics_block *tm,
 			  enum tcp_metric_index idx)
 {
-	return tm->tcpm_vals[idx];
+	/* Paired with WRITE_ONCE() in tcp_metric_set() */
+	return READ_ONCE(tm->tcpm_vals[idx]);
 }
 
 static void tcp_metric_set(struct tcp_metrics_block *tm,
 			   enum tcp_metric_index idx,
 			   u32 val)
 {
-	tm->tcpm_vals[idx] = val;
+	/* Paired with READ_ONCE() in tcp_metric_get() */
+	WRITE_ONCE(tm->tcpm_vals[idx], val);
 }
 
 static bool addr_same(const struct inetpeer_addr *a,
@@ -117,13 +119,16 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 	WRITE_ONCE(tm->tcpm_lock, val);
 
 	msval = dst_metric_raw(dst, RTAX_RTT);
-	tm->tcpm_vals[TCP_METRIC_RTT] = msval * USEC_PER_MSEC;
+	tcp_metric_set(tm, TCP_METRIC_RTT, msval * USEC_PER_MSEC);
 
 	msval = dst_metric_raw(dst, RTAX_RTTVAR);
-	tm->tcpm_vals[TCP_METRIC_RTTVAR] = msval * USEC_PER_MSEC;
-	tm->tcpm_vals[TCP_METRIC_SSTHRESH] = dst_metric_raw(dst, RTAX_SSTHRESH);
-	tm->tcpm_vals[TCP_METRIC_CWND] = dst_metric_raw(dst, RTAX_CWND);
-	tm->tcpm_vals[TCP_METRIC_REORDERING] = dst_metric_raw(dst, RTAX_REORDERING);
+	tcp_metric_set(tm, TCP_METRIC_RTTVAR, msval * USEC_PER_MSEC);
+	tcp_metric_set(tm, TCP_METRIC_SSTHRESH,
+		       dst_metric_raw(dst, RTAX_SSTHRESH));
+	tcp_metric_set(tm, TCP_METRIC_CWND,
+		       dst_metric_raw(dst, RTAX_CWND));
+	tcp_metric_set(tm, TCP_METRIC_REORDERING,
+		       dst_metric_raw(dst, RTAX_REORDERING));
 	if (fastopen_clear) {
 		tm->tcpm_fastopen.mss = 0;
 		tm->tcpm_fastopen.syn_loss = 0;
@@ -678,7 +683,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 		if (!nest)
 			goto nla_put_failure;
 		for (i = 0; i < TCP_METRIC_MAX_KERNEL + 1; i++) {
-			u32 val = tm->tcpm_vals[i];
+			u32 val = tcp_metric_get(tm, i);
 
 			if (!val)
 				continue;
-- 
2.40.1



