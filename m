Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296CC77ACC3
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjHMVgu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjHMVgs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1D10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C67A631E7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28577C433C7;
        Sun, 13 Aug 2023 21:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962609;
        bh=QdlyopDjs1CN9CfUj0QnNaTh4A1rMMh2uch3Loy50As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=de3QPdWyDh/3Ocl2k1PkUU2D0xmhqu9BSslvq+Ist3YWtEfncc4mR+vccprKdNH7+
         V7pdGQsQKp2zv71/v8C1lAKt/B4bU1q4SfrqRbRnoRbB5NxBCd33Gh+HJ8o32d98CR
         e2Z8vpvo8HtdamU5xupPv1K2kq+3sdy0aodvfxFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wenjia Zhang <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 090/149] net/smc: Use correct buffer sizes when switching between TCP and SMC
Date:   Sun, 13 Aug 2023 23:18:55 +0200
Message-ID: <20230813211721.480103187@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gerd Bayer <gbayer@linux.ibm.com>

commit 30c3c4a4497c3765bf6b298f5072c8165aeaf7cc upstream.

Tuning of the effective buffer size through setsockopts was working for
SMC traffic only but not for TCP fall-back connections even before
commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and
make them tunable"). That change made it apparent that TCP fall-back
connections would use net.smc.[rw]mem as buffer size instead of
net.ipv4_tcp_[rw]mem.

Amend the code that copies attributes between the (TCP) clcsock and the
SMC socket and adjust buffer sizes appropriately:
- Copy over sk_userlocks so that both sockets agree on whether tuning
  via setsockopt is active.
- When falling back to TCP use sk_sndbuf or sk_rcvbuf as specified with
  setsockopt. Otherwise, use the sysctl value for TCP/IPv4.
- Likewise, use either values from setsockopt or from sysctl for SMC
  (duplicated) on successful SMC connect.

In smc_tcp_listen_work() drop the explicit copy of buffer sizes as that
is taken care of by the attribute copy.

Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |   73 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 22 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -438,13 +438,60 @@ out:
 	return rc;
 }
 
+/* copy only relevant settings and flags of SOL_SOCKET level from smc to
+ * clc socket (since smc is not called for these options from net/core)
+ */
+
+#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
+			     (1UL << SOCK_KEEPOPEN) | \
+			     (1UL << SOCK_LINGER) | \
+			     (1UL << SOCK_BROADCAST) | \
+			     (1UL << SOCK_TIMESTAMP) | \
+			     (1UL << SOCK_DBG) | \
+			     (1UL << SOCK_RCVTSTAMP) | \
+			     (1UL << SOCK_RCVTSTAMPNS) | \
+			     (1UL << SOCK_LOCALROUTE) | \
+			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
+			     (1UL << SOCK_RXQ_OVFL) | \
+			     (1UL << SOCK_WIFI_STATUS) | \
+			     (1UL << SOCK_NOFCS) | \
+			     (1UL << SOCK_FILTER_LOCKED) | \
+			     (1UL << SOCK_TSTAMP_NEW))
+
+/* if set, use value set by setsockopt() - else use IPv4 or SMC sysctl value */
+static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
+				     unsigned long mask)
+{
+	struct net *nnet = sock_net(nsk);
+
+	nsk->sk_userlocks = osk->sk_userlocks;
+	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
+		nsk->sk_sndbuf = osk->sk_sndbuf;
+	} else {
+		if (mask == SK_FLAGS_SMC_TO_CLC)
+			WRITE_ONCE(nsk->sk_sndbuf,
+				   READ_ONCE(nnet->ipv4.sysctl_tcp_wmem[1]));
+		else
+			WRITE_ONCE(nsk->sk_sndbuf,
+				   2 * READ_ONCE(nnet->smc.sysctl_wmem));
+	}
+	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
+		nsk->sk_rcvbuf = osk->sk_rcvbuf;
+	} else {
+		if (mask == SK_FLAGS_SMC_TO_CLC)
+			WRITE_ONCE(nsk->sk_rcvbuf,
+				   READ_ONCE(nnet->ipv4.sysctl_tcp_rmem[1]));
+		else
+			WRITE_ONCE(nsk->sk_rcvbuf,
+				   2 * READ_ONCE(nnet->smc.sysctl_rmem));
+	}
+}
+
 static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 				   unsigned long mask)
 {
 	/* options we don't get control via setsockopt for */
 	nsk->sk_type = osk->sk_type;
-	nsk->sk_sndbuf = osk->sk_sndbuf;
-	nsk->sk_rcvbuf = osk->sk_rcvbuf;
 	nsk->sk_sndtimeo = osk->sk_sndtimeo;
 	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
 	nsk->sk_mark = READ_ONCE(osk->sk_mark);
@@ -455,26 +502,10 @@ static void smc_copy_sock_settings(struc
 
 	nsk->sk_flags &= ~mask;
 	nsk->sk_flags |= osk->sk_flags & mask;
+
+	smc_adjust_sock_bufsizes(nsk, osk, mask);
 }
 
-#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
-			     (1UL << SOCK_KEEPOPEN) | \
-			     (1UL << SOCK_LINGER) | \
-			     (1UL << SOCK_BROADCAST) | \
-			     (1UL << SOCK_TIMESTAMP) | \
-			     (1UL << SOCK_DBG) | \
-			     (1UL << SOCK_RCVTSTAMP) | \
-			     (1UL << SOCK_RCVTSTAMPNS) | \
-			     (1UL << SOCK_LOCALROUTE) | \
-			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
-			     (1UL << SOCK_RXQ_OVFL) | \
-			     (1UL << SOCK_WIFI_STATUS) | \
-			     (1UL << SOCK_NOFCS) | \
-			     (1UL << SOCK_FILTER_LOCKED) | \
-			     (1UL << SOCK_TSTAMP_NEW))
-/* copy only relevant settings and flags of SOL_SOCKET level from smc to
- * clc socket (since smc is not called for these options from net/core)
- */
 static void smc_copy_sock_settings_to_clc(struct smc_sock *smc)
 {
 	smc_copy_sock_settings(smc->clcsock->sk, &smc->sk, SK_FLAGS_SMC_TO_CLC);
@@ -2466,8 +2497,6 @@ static void smc_tcp_listen_work(struct w
 		sock_hold(lsk); /* sock_put in smc_listen_work */
 		INIT_WORK(&new_smc->smc_listen_work, smc_listen_work);
 		smc_copy_sock_settings_to_smc(new_smc);
-		new_smc->sk.sk_sndbuf = lsmc->sk.sk_sndbuf;
-		new_smc->sk.sk_rcvbuf = lsmc->sk.sk_rcvbuf;
 		sock_hold(&new_smc->sk); /* sock_put in passive closing */
 		if (!queue_work(smc_hs_wq, &new_smc->smc_listen_work))
 			sock_put(&new_smc->sk);


