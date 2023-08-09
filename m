Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F20B775959
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjHIK7n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjHIK7m (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005BF1FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B5BE63118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7F2C433C7;
        Wed,  9 Aug 2023 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578781;
        bh=K9FJGd2o2pRrOrC4J1YUUQvn977VUmI6A+uS9mCHx70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqPTtN+uhtKnT07GPRRNxOUccV2PS2hQ+9+DgX1NRYHu8hLnjFsYXiQd/khIs463H
         TiqyF83DP89/qeUu7NdF+Sw4OdAG7T8RBzBq3VJzCtlZwWnWh9DeDu7axhcbm2KaQ2
         EFa7OftP+7ZAYOOd6KWm5l/P8XpdoG5vbPZHBwJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 26/92] net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
Date:   Wed,  9 Aug 2023 12:41:02 +0200
Message-ID: <20230809103634.523780700@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
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

[ Upstream commit e6d12bdb435d23ff6c1890c852d85408a2f496ee ]

In a prior commit, I forgot to change sk_getsockopt()
when reading sk->sk_rcvlowat locklessly.

Fixes: eac66402d1c3 ("net: annotate sk->sk_rcvlowat lockless reads")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index d392efa0d9551..ffd566d52eec3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1549,7 +1549,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVLOWAT:
-		v.val = sk->sk_rcvlowat;
+		v.val = READ_ONCE(sk->sk_rcvlowat);
 		break;
 
 	case SO_SNDLOWAT:
-- 
2.40.1



