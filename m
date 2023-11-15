Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B784D7ECB6A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjKOTWK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjKOTWI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17BD1A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509BAC433C9;
        Wed, 15 Nov 2023 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076124;
        bh=gDXIgWZ0CTDB4DQTsuu+3KgTehqouyoROFgO6xkv72E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qgutqe2nW0L3xdddyWSAAMGBsZDeVY6kExh9UQopWJP6Lb1ija85Ov1qivQ6wL9L9
         rKU8E3dI06av3E34sUrYm+CCnmTBpTWA0b1EqeM6jFtAJlDLSp1N8Xv8Zwr9bMdXqQ
         Xweejoq49O4urn5sq/dHBun/TEnKq3/hW1c5VmVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 064/550] udplite: remove UDPLITE_BIT
Date:   Wed, 15 Nov 2023 14:10:48 -0500
Message-ID: <20231115191605.121451485@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 729549aa350c56a777bb342941ed4d69b6585769 ]

This flag is set but never read, we can remove it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 882af43a0fc3 ("udplite: fix various data-races")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/udp.h | 5 ++---
 net/ipv4/udplite.c  | 1 -
 net/ipv6/udplite.c  | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 0cf83270a4a28..58156edec0096 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -55,9 +55,8 @@ struct udp_sock {
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 
 /* indicator bits used by pcflag: */
-#define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
-#define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
-#define UDPLITE_RECV_CC  0x4		/* set via udplite setsocktopt        */
+#define UDPLITE_SEND_CC  0x1  		/* set via udplite setsockopt         */
+#define UDPLITE_RECV_CC  0x2		/* set via udplite setsocktopt        */
 	__u8		 pcflag;        /* marks socket as UDP-Lite if > 0    */
 	/*
 	 * Following member retains the information to create a UDP header
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index 39ecdad1b50ce..af37af3ab727b 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -21,7 +21,6 @@ EXPORT_SYMBOL(udplite_table);
 static int udplite_sk_init(struct sock *sk)
 {
 	udp_init_sock(sk);
-	udp_sk(sk)->pcflag = UDPLITE_BIT;
 	pr_warn_once("UDP-Lite is deprecated and scheduled to be removed in 2025, "
 		     "please contact the netdev mailing list\n");
 	return 0;
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index 267d491e97075..a60bec9b14f14 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -17,7 +17,6 @@
 static int udplitev6_sk_init(struct sock *sk)
 {
 	udpv6_init_sock(sk);
-	udp_sk(sk)->pcflag = UDPLITE_BIT;
 	pr_warn_once("UDP-Lite is deprecated and scheduled to be removed in 2025, "
 		     "please contact the netdev mailing list\n");
 	return 0;
-- 
2.42.0



