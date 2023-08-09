Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F90A7758C1
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjHIKzP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjHIKzD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525F030D4
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40E7163130
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DD4C433C7;
        Wed,  9 Aug 2023 10:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578390;
        bh=BXIUvC0cUv55HgX07SYhpYopfR/7+pmRHsoigTIM5wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkzXfSAPcAsg6K/pfgLdCwvMQk3B2tFFTtY5+yjjzWlwDr2wYHPLMIcCYB0bVDalw
         9aFB1gSP0OqjRjJdk4Y/94dUAmQXGsAh8OMyyIEuqA6QwfNP2xXoMyID6b05eW+aJF
         WZIEfiZCAemGsEFb7DhuQrAxxDivWPlW+k0227Hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Wei Wang <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 035/127] net: annotate data-races around sk->sk_reserved_mem
Date:   Wed,  9 Aug 2023 12:40:22 +0200
Message-ID: <20230809103637.820196429@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
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

[ Upstream commit fe11fdcb4207907d80cda2e73777465d68131e66 ]

sk_getsockopt() runs locklessly. This means sk->sk_reserved_mem
can be read while other threads are changing its value.

Add missing annotations where they are needed.

Fixes: 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weiwan@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 0c1baa5517f11..9483820833c5b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -996,7 +996,7 @@ static void sock_release_reserved_memory(struct sock *sk, int bytes)
 	bytes = round_down(bytes, PAGE_SIZE);
 
 	WARN_ON(bytes > sk->sk_reserved_mem);
-	sk->sk_reserved_mem -= bytes;
+	WRITE_ONCE(sk->sk_reserved_mem, sk->sk_reserved_mem - bytes);
 	sk_mem_reclaim(sk);
 }
 
@@ -1033,7 +1033,8 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	}
 	sk->sk_forward_alloc += pages << PAGE_SHIFT;
 
-	sk->sk_reserved_mem += pages << PAGE_SHIFT;
+	WRITE_ONCE(sk->sk_reserved_mem,
+		   sk->sk_reserved_mem + (pages << PAGE_SHIFT));
 
 	return 0;
 }
@@ -1922,7 +1923,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_RESERVE_MEM:
-		v.val = sk->sk_reserved_mem;
+		v.val = READ_ONCE(sk->sk_reserved_mem);
 		break;
 
 	case SO_TXREHASH:
-- 
2.40.1



