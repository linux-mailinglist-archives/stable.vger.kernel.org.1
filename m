Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9557C7ECD89
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjKOThE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjKOThD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3D49E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A81C433CD;
        Wed, 15 Nov 2023 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077020;
        bh=wCHBeoBoUWQNpbKP0opNLw3LR1797lRHy9sCa9cV4mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8G0bs2iP0M2hpXrxeQEBJZr+4LYywPCfP7hQs+V7xrkY6NHAfyqpZjhZ5O0Uf/B1
         o4kJ20aU51WzlGhWHrl+BeboVlPjCkGxI/wOEFAlcQFeyetYgrOXU7DkKESpE6Kp7A
         n2G7OcpOxWq2NKk7GGNCJjamnDD5UaPuFpV6VfcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Neal Cardwell <ncardwell@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 100/603] tcp_metrics: do not create an entry from tcp_init_metrics()
Date:   Wed, 15 Nov 2023 14:10:45 -0500
Message-ID: <20231115191620.103753747@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a135798e6e200ecb2f864cecca6d257ba278370c ]

tcp_init_metrics() only wants to get metrics if they were
previously stored in the cache. Creating an entry is adding
useless costs, especially when tcp_no_metrics_save is set.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_metrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 0c03f564878ff..7aca12c59c184 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -478,7 +478,7 @@ void tcp_init_metrics(struct sock *sk)
 		goto reset;
 
 	rcu_read_lock();
-	tm = tcp_get_metrics(sk, dst, true);
+	tm = tcp_get_metrics(sk, dst, false);
 	if (!tm) {
 		rcu_read_unlock();
 		goto reset;
-- 
2.42.0



