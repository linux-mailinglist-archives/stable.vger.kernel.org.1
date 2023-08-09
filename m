Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D84775797
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjHIKrv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjHIKru (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:47:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6810F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A445630D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972BBC433C8;
        Wed,  9 Aug 2023 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578069;
        bh=HqxHB1BkX3P7VovaGf2jiIVzQKWXw3rhyBzklKdPS1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfagOgX656cZyNuR9Ci1nwB2ktpiRIczj9rnncsi3zMR/SOXMBaWV7DZqoqZzz0Eu
         047eOMwQXfXGE++gdVWltJCCAbhQpnmTAqcLpw+1X43xs9LPpA/rroMk16ZpuFrgFB
         ExuAnyeFr00Y2stijEl+wZ+ZbY/pYqMRdKe3AjUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 093/165] tcp_metrics: annotate data-races around tm->tcpm_net
Date:   Wed,  9 Aug 2023 12:40:24 +0200
Message-ID: <20230809103645.833827227@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d5d986ce42c71a7562d32c4e21e026b0f87befec ]

tm->tcpm_net can be read or written locklessly.

Instead of changing write_pnet() and read_pnet() and potentially
hurt performance, add the needed READ_ONCE()/WRITE_ONCE()
in tm_net() and tcpm_new().

Fixes: 849e8a0ca8d5 ("tcp_metrics: Add a field tcpm_net and verify it matches on lookup")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230802131500.1478140-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_metrics.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index fd4ab7a51cef2..4fd274836a48f 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -40,7 +40,7 @@ struct tcp_fastopen_metrics {
 
 struct tcp_metrics_block {
 	struct tcp_metrics_block __rcu	*tcpm_next;
-	possible_net_t			tcpm_net;
+	struct net			*tcpm_net;
 	struct inetpeer_addr		tcpm_saddr;
 	struct inetpeer_addr		tcpm_daddr;
 	unsigned long			tcpm_stamp;
@@ -51,9 +51,10 @@ struct tcp_metrics_block {
 	struct rcu_head			rcu_head;
 };
 
-static inline struct net *tm_net(struct tcp_metrics_block *tm)
+static inline struct net *tm_net(const struct tcp_metrics_block *tm)
 {
-	return read_pnet(&tm->tcpm_net);
+	/* Paired with the WRITE_ONCE() in tcpm_new() */
+	return READ_ONCE(tm->tcpm_net);
 }
 
 static bool tcp_metric_locked(struct tcp_metrics_block *tm,
@@ -197,7 +198,9 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 		if (!tm)
 			goto out_unlock;
 	}
-	write_pnet(&tm->tcpm_net, net);
+	/* Paired with the READ_ONCE() in tm_net() */
+	WRITE_ONCE(tm->tcpm_net, net);
+
 	tm->tcpm_saddr = *saddr;
 	tm->tcpm_daddr = *daddr;
 
-- 
2.40.1



