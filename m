Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039FC775DA9
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjHILkB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjHILkA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A561FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B23D563617
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1C2C433C8;
        Wed,  9 Aug 2023 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581196;
        bh=F7AL7vukE5KEdwhGO2B+1N4+SXnAM1eH1pyLlZsgskM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJjE01zCbE+1Q0cJDSe15JlsPK8Ie9vSxIAaTyEOf2OVz8r12VYEpqnebmGlxhGHn
         q1NMYKxcQjh09oYA/Psn6Jvauc0mVRwQYzPkiXIRvATjcO5eXSSCRjj+xuik1z8+T5
         fazHwg1HiLxwXojb82HmGAwuBlacZE+5aq96OhyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 139/201] net: add missing READ_ONCE(sk->sk_sndbuf) annotation
Date:   Wed,  9 Aug 2023 12:42:21 +0200
Message-ID: <20230809103648.391646803@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
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

[ Upstream commit 74bc084327c643499474ba75df485607da37dd6e ]

In a prior commit, I forgot to change sk_getsockopt()
when reading sk->sk_sndbuf locklessly.

Fixes: e292f05e0df7 ("tcp: annotate sk->sk_sndbuf lockless reads")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 66aab0981f666..6f422882d34f2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1332,7 +1332,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_SNDBUF:
-		v.val = sk->sk_sndbuf;
+		v.val = READ_ONCE(sk->sk_sndbuf);
 		break;
 
 	case SO_RCVBUF:
-- 
2.40.1



