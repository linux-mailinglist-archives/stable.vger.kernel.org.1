Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B87758C4
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjHIKzS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjHIKzH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE3B3585
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BDE66313C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472C0C433C8;
        Wed,  9 Aug 2023 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578421;
        bh=epQON+OFentVD/JjSZ9Cz6JatOtbglUbCmCcf0ndNlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYbq4EfRg7aC0UJatzuOrDKEm5SFSIGMRA6+b+zHI8FZkCpmPCcMVYEkfT7bStGWq
         Ei22+FWjrUfHW833R1c/ruDndMFxMFZaCofZQlgOB0HAch2wX/6o+OvUYCeypZLY16
         Qzc4OgsBBuU0XApUQkED7qzdlEk2ITHxlRAtTQRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Akhmat Karakotov <hmukos@yandex-team.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 036/127] net: annotate data-race around sk->sk_txrehash
Date:   Wed,  9 Aug 2023 12:40:23 +0200
Message-ID: <20230809103637.849570655@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
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

[ Upstream commit c76a0328899bbe226f8adeb88b8da9e4167bd316 ]

sk_getsockopt() runs locklessly. This means sk->sk_txrehash
can be read while other threads are changing its value.

Other locations were handled in commit cb6cd2cec799
("tcp: Change SYN ACK retransmit behaviour to account for rehash")

Fixes: 26859240e4ee ("txhash: Add socket option to control TX hash rethink behavior")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Akhmat Karakotov <hmukos@yandex-team.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9483820833c5b..77abd69c56dde 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1521,7 +1521,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		}
 		if ((u8)val == SOCK_TXREHASH_DEFAULT)
 			val = READ_ONCE(sock_net(sk)->core.sysctl_txrehash);
-		/* Paired with READ_ONCE() in tcp_rtx_synack() */
+		/* Paired with READ_ONCE() in tcp_rtx_synack()
+		 * and sk_getsockopt().
+		 */
 		WRITE_ONCE(sk->sk_txrehash, (u8)val);
 		break;
 
@@ -1927,7 +1929,8 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_TXREHASH:
-		v.val = sk->sk_txrehash;
+		/* Paired with WRITE_ONCE() in sk_setsockopt() */
+		v.val = READ_ONCE(sk->sk_txrehash);
 		break;
 
 	default:
-- 
2.40.1



