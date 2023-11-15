Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C657D7ED690
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjKOWCR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbjKOWCQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:02:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C46818B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:02:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06387C433C8;
        Wed, 15 Nov 2023 22:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085733;
        bh=4iHDDRjvHrKTOU2pu7ICCRA1+ox8MImQGdpb3CL2WkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=veG33ag0Qh1tbCaIzU6SCw9qMtavD7Y040YZF8nGmljvF8eo5G8yVZuAZFOaZ5Vw6
         oxf7w/WKnZgxOphFNnF8ukPGIU0CyTGz/8bHjER+Q/lSKapgwTy1hqlA70jpv0eO9S
         jLjq1Cs1YISIJujn8SqutA9hpzyc6tiCL7A933qA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 018/119] tcp: fix cookie_init_timestamp() overflows
Date:   Wed, 15 Nov 2023 17:00:08 -0500
Message-ID: <20231115220133.176840983@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 73ed8e03388d16c12fc577e5c700b58a29045a15 ]

cookie_init_timestamp() is supposed to return a 64bit timestamp
suitable for both TSval determination and setting of skb->tstamp.

Unfortunately it uses 32bit fields and overflows after
2^32 * 10^6 nsec (~49 days) of uptime.

Generated TSval are still correct, but skb->tstamp might be set
far away in the past, potentially confusing other layers.

tcp_ns_to_ts() is changed to return a full 64bit value,
ts and ts_now variables are changed to u64 type,
and TSMASK is removed in favor of shifts operations.

While we are at it, change this sequence:
		ts >>= TSBITS;
		ts--;
		ts <<= TSBITS;
		ts |= options;
to:
		ts -= (1UL << TSBITS);

Fixes: 9a568de4818d ("tcp: switch TCP TS option (RFC 7323) to 1ms clock")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h     |  2 +-
 net/ipv4/syncookies.c | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2be7d26434180..af67e19eba392 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -776,7 +776,7 @@ static inline u32 tcp_time_stamp(const struct tcp_sock *tp)
 }
 
 /* Convert a nsec timestamp into TCP TSval timestamp (ms based currently) */
-static inline u32 tcp_ns_to_ts(u64 ns)
+static inline u64 tcp_ns_to_ts(u64 ns)
 {
 	return div_u64(ns, NSEC_PER_SEC / TCP_TS_HZ);
 }
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 88d53d37fbe96..3cc22f776a313 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -43,7 +43,6 @@ static siphash_key_t syncookie_secret[2] __read_mostly;
  * requested/supported by the syn/synack exchange.
  */
 #define TSBITS	6
-#define TSMASK	(((__u32)1 << TSBITS) - 1)
 
 static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
 		       u32 count, int c)
@@ -64,27 +63,22 @@ static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
  */
 u64 cookie_init_timestamp(struct request_sock *req, u64 now)
 {
-	struct inet_request_sock *ireq;
-	u32 ts, ts_now = tcp_ns_to_ts(now);
+	const struct inet_request_sock *ireq = inet_rsk(req);
+	u64 ts, ts_now = tcp_ns_to_ts(now);
 	u32 options = 0;
 
-	ireq = inet_rsk(req);
-
 	options = ireq->wscale_ok ? ireq->snd_wscale : TS_OPT_WSCALE_MASK;
 	if (ireq->sack_ok)
 		options |= TS_OPT_SACK;
 	if (ireq->ecn_ok)
 		options |= TS_OPT_ECN;
 
-	ts = ts_now & ~TSMASK;
+	ts = (ts_now >> TSBITS) << TSBITS;
 	ts |= options;
-	if (ts > ts_now) {
-		ts >>= TSBITS;
-		ts--;
-		ts <<= TSBITS;
-		ts |= options;
-	}
-	return (u64)ts * (NSEC_PER_SEC / TCP_TS_HZ);
+	if (ts > ts_now)
+		ts -= (1UL << TSBITS);
+
+	return ts * (NSEC_PER_SEC / TCP_TS_HZ);
 }
 
 
-- 
2.42.0



