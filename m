Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119FB775AAB
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjHILKa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjHILK3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFED1FEB
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FB0161FA9
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E719C433C8;
        Wed,  9 Aug 2023 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579428;
        bh=bsEcnBtGTD0EsNNFytNWfDdbsIUNU3KIKefudLL13Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5hrHHmNXWtJ8cSL2UsJG8B4rNcTXm+kcvGgXm2dxup/JEQ5lwyuneODz1cICnyMk
         oOqe6Q1adCxAqlussHVxkv99+kg+8wvOtCi+LCJBai4VnT6JotgCN/VbZfPn71ZrkE
         a3Ceo9jOBPcKIOW0aEAQW8x9fUdEHbVWOi/yierM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 192/204] tcp_metrics: annotate data-races around tm->tcpm_lock
Date:   Wed,  9 Aug 2023 12:42:10 +0200
Message-ID: <20230809103648.900270037@linuxfoundation.org>
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

[ Upstream commit 285ce119a3c6c4502585936650143e54c8692788 ]

tm->tcpm_lock can be read or written locklessly.

Add needed READ_ONCE()/WRITE_ONCE() to document this.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230802131500.1478140-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_metrics.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index a283b0710a7e2..2f0e7c38e634c 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -61,7 +61,8 @@ static inline struct net *tm_net(struct tcp_metrics_block *tm)
 static bool tcp_metric_locked(struct tcp_metrics_block *tm,
 			      enum tcp_metric_index idx)
 {
-	return tm->tcpm_lock & (1 << idx);
+	/* Paired with WRITE_ONCE() in tcpm_suck_dst() */
+	return READ_ONCE(tm->tcpm_lock) & (1 << idx);
 }
 
 static u32 tcp_metric_get(struct tcp_metrics_block *tm,
@@ -112,7 +113,8 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 		val |= 1 << TCP_METRIC_CWND;
 	if (dst_metric_locked(dst, RTAX_REORDERING))
 		val |= 1 << TCP_METRIC_REORDERING;
-	tm->tcpm_lock = val;
+	/* Paired with READ_ONCE() in tcp_metric_locked() */
+	WRITE_ONCE(tm->tcpm_lock, val);
 
 	msval = dst_metric_raw(dst, RTAX_RTT);
 	tm->tcpm_vals[TCP_METRIC_RTT] = msval * USEC_PER_MSEC;
-- 
2.40.1



