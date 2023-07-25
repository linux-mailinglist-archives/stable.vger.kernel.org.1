Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252FC761784
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjGYLtA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjGYLsx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:48:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F8119AD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C540F616BD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E3AC433C8;
        Tue, 25 Jul 2023 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285726;
        bh=zs3202jNfM2n7iLCh53NrKI38RiH4wN2ZjHVM+T1qjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogrEw52TSgh3DkHip6h4ZIunCkw/n1didiUvTcyMT9P8sg0nbrew3QRxhMYBBiqxg
         uaUGtPYIz8TgDVCD1B1h0/ffAsYAwbf6NgLryAMptP+HwGvoK0Z7mXQMUb3AxhfNSw
         XmewSvJ+ozOkapI8qSXIfTmHL2QA3t9It4GuRru8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cambda Zhu <cambda@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 308/313] net: Replace the limit of TCP_LINGER2 with TCP_FIN_TIMEOUT_MAX
Date:   Tue, 25 Jul 2023 12:47:41 +0200
Message-ID: <20230725104534.464555111@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cambda Zhu <cambda@linux.alibaba.com>

[ Upstream commit f0628c524fd188c3f9418e12478dfdfadacba815 ]

This patch changes the behavior of TCP_LINGER2 about its limit. The
sysctl_tcp_fin_timeout used to be the limit of TCP_LINGER2 but now it's
only the default value. A new macro named TCP_FIN_TIMEOUT_MAX is added
as the limit of TCP_LINGER2, which is 2 minutes.

Since TCP_LINGER2 used sysctl_tcp_fin_timeout as the default value
and the limit in the past, the system administrator cannot set the
default value for most of sockets and let some sockets have a greater
timeout. It might be a mistake that let the sysctl to be the limit of
the TCP_LINGER2. Maybe we can add a new sysctl to set the max of
TCP_LINGER2, but FIN-WAIT-2 timeout is usually no need to be too long
and 2 minutes are legal considering TCP specs.

Changes in v3:
- Remove the new socket option and change the TCP_LINGER2 behavior so
  that the timeout can be set to value between sysctl_tcp_fin_timeout
  and 2 minutes.

Changes in v2:
- Add int overflow check for the new socket option.

Changes in v1:
- Add a new socket option to set timeout greater than
  sysctl_tcp_fin_timeout.

Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9df5335ca974 ("tcp: annotate data-races around tp->linger2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 1 +
 net/ipv4/tcp.c    | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 077feeca6c99e..2f456bed33ec3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -125,6 +125,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 				  * to combine FIN-WAIT-2 timeout with
 				  * TIME-WAIT timer.
 				  */
+#define TCP_FIN_TIMEOUT_MAX (120 * HZ) /* max TCP_LINGER2 value (two minutes) */
 
 #define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */
 #if HZ >= 100
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e33abcff56080..c6c73b9407098 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3067,8 +3067,8 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 	case TCP_LINGER2:
 		if (val < 0)
 			tp->linger2 = -1;
-		else if (val > net->ipv4.sysctl_tcp_fin_timeout / HZ)
-			tp->linger2 = 0;
+		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
+			tp->linger2 = TCP_FIN_TIMEOUT_MAX;
 		else
 			tp->linger2 = val * HZ;
 		break;
-- 
2.39.2



