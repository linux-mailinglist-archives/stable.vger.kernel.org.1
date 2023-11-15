Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793347ED5B1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjKOVLe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjKOVLa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:11:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513DA1BD9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:02:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB2DC4E772;
        Wed, 15 Nov 2023 20:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081545;
        bh=U4ZGkTZOm04/v/dY01wwo+B3fUqGtUuMdZZCXBWhWBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFkddYgcJwmUxUUQ7H8LGa6f84AiUvi0VZewXU2xmb0WnW4z8Kdblzwv9yUal/ji4
         icqsOWf3m6dIDhVfNmiQ8hSeTIV8hsExan74DtEdqc+/wQDOJSxgzdQDAfVMeolJ+A
         zO537cCf3RIePdvLCbxILFOyLL/hG0c0h4Kmag0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Paul Moore <paul@paul-moore.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 219/244] dccp: Call security_inet_conn_request() after setting IPv4 addresses.
Date:   Wed, 15 Nov 2023 15:36:51 -0500
Message-ID: <20231115203601.484116456@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit fa2df45af13091f76b89adb84a28f13818d5d631 ]

Initially, commit 4237c75c0a35 ("[MLSXFRM]: Auto-labeling of child
sockets") introduced security_inet_conn_request() in some functions
where reqsk is allocated.  The hook is added just after the allocation,
so reqsk's IPv4 remote address was not initialised then.

However, SELinux/Smack started to read it in netlbl_req_setattr()
after the cited commits.

This bug was partially fixed by commit 284904aa7946 ("lsm: Relocate
the IPv4 security_inet_conn_request() hooks").

This patch fixes the last bug in DCCPv4.

Fixes: 389fb800ac8b ("netlabel: Label incoming TCP connections correctly in SELinux")
Fixes: 07feee8f812f ("netlabel: Cleanup the Smack/NetLabel code to fix incoming TCP connections")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dccp/ipv4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index b44e46dc8e040..cab82344de9be 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -623,9 +623,6 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_parse_options(sk, dreq, skb))
 		goto drop_and_free;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto drop_and_free;
-
 	ireq = inet_rsk(req);
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
@@ -633,6 +630,9 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	ireq->ireq_family = AF_INET;
 	ireq->ir_iif = sk->sk_bound_dev_if;
 
+	if (security_inet_conn_request(sk, skb, req))
+		goto drop_and_free;
+
 	/*
 	 * Step 3: Process LISTEN state
 	 *
-- 
2.42.0



