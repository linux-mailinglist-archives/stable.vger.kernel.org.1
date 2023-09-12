Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA679B9CD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbjIKVIC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbjIKN63 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:58:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E14CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:58:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D624C433C9;
        Mon, 11 Sep 2023 13:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440704;
        bh=y51NwiQyRBfkk0p0lC6jFQpINC17XsmlY05a2PvV9+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWv5GRNeF02WiRnpAwpMqRKujGNzZDvMABsy15KBU86olWpdG3LutsQ38JyHJeolG
         V/4OsW1IA4CWnYUC/i4m5yi2hfAoN7DH75ijnv4TvZbOoBtKAoymrLvGoj1iPa0sZk
         ypIbf+rFJNUBVCK7jpwi10cmQLbqKh2d05Xhq0bk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 155/739] net: annotate data-races around sk->sk_lingertime
Date:   Mon, 11 Sep 2023 15:39:14 +0200
Message-ID: <20230911134655.473945530@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit bc1fb82ae11753c5dec53c667a055dc37796dbd2 ]

sk_getsockopt() runs locklessly. This means sk->sk_lingertime
can be read while other threads are changing its value.

Other reads also happen without socket lock being held,
and must be annotated.

Remove preprocessor logic using BITS_PER_LONG, compilers
are smart enough to figure this by themselves.

v2: fixed a clang W=1 (-Wtautological-constant-out-of-range-compare) warning
    (Jakub)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c |  2 +-
 net/bluetooth/sco.c |  2 +-
 net/core/sock.c     | 18 +++++++++---------
 net/sched/em_meta.c |  2 +-
 net/smc/af_smc.c    |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index fa3765bc8a5cd..6053871629f87 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1486,7 +1486,7 @@ static int iso_sock_release(struct socket *sock)
 
 	iso_sock_close(sk);
 
-	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+	if (sock_flag(sk, SOCK_LINGER) && READ_ONCE(sk->sk_lingertime) &&
 	    !(current->flags & PF_EXITING)) {
 		lock_sock(sk);
 		err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 7762604ddfc05..99b149261949a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1267,7 +1267,7 @@ static int sco_sock_release(struct socket *sock)
 
 	sco_sock_close(sk);
 
-	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+	if (sock_flag(sk, SOCK_LINGER) && READ_ONCE(sk->sk_lingertime) &&
 	    !(current->flags & PF_EXITING)) {
 		lock_sock(sk);
 		err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);
diff --git a/net/core/sock.c b/net/core/sock.c
index c9cffb7acbeae..1c5c01b116e6f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -797,7 +797,7 @@ EXPORT_SYMBOL(sock_set_reuseport);
 void sock_no_linger(struct sock *sk)
 {
 	lock_sock(sk);
-	sk->sk_lingertime = 0;
+	WRITE_ONCE(sk->sk_lingertime, 0);
 	sock_set_flag(sk, SOCK_LINGER);
 	release_sock(sk);
 }
@@ -1230,15 +1230,15 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			ret = -EFAULT;
 			break;
 		}
-		if (!ling.l_onoff)
+		if (!ling.l_onoff) {
 			sock_reset_flag(sk, SOCK_LINGER);
-		else {
-#if (BITS_PER_LONG == 32)
-			if ((unsigned int)ling.l_linger >= MAX_SCHEDULE_TIMEOUT/HZ)
-				sk->sk_lingertime = MAX_SCHEDULE_TIMEOUT;
+		} else {
+			unsigned long t_sec = ling.l_linger;
+
+			if (t_sec >= MAX_SCHEDULE_TIMEOUT / HZ)
+				WRITE_ONCE(sk->sk_lingertime, MAX_SCHEDULE_TIMEOUT);
 			else
-#endif
-				sk->sk_lingertime = (unsigned int)ling.l_linger * HZ;
+				WRITE_ONCE(sk->sk_lingertime, t_sec * HZ);
 			sock_set_flag(sk, SOCK_LINGER);
 		}
 		break;
@@ -1691,7 +1691,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	case SO_LINGER:
 		lv		= sizeof(v.ling);
 		v.ling.l_onoff	= sock_flag(sk, SOCK_LINGER);
-		v.ling.l_linger	= sk->sk_lingertime / HZ;
+		v.ling.l_linger	= READ_ONCE(sk->sk_lingertime) / HZ;
 		break;
 
 	case SO_BSDCOMPAT:
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 6fdba069f6bfd..da34fd4c92695 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -502,7 +502,7 @@ META_COLLECTOR(int_sk_lingertime)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_lingertime / HZ;
+	dst->value = READ_ONCE(sk->sk_lingertime) / HZ;
 }
 
 META_COLLECTOR(int_sk_err_qlen)
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f5834af5fad53..7c77565c39d19 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1820,7 +1820,7 @@ void smc_close_non_accepted(struct sock *sk)
 	lock_sock(sk);
 	if (!sk->sk_lingertime)
 		/* wait for peer closing */
-		sk->sk_lingertime = SMC_MAX_STREAM_WAIT_TIMEOUT;
+		WRITE_ONCE(sk->sk_lingertime, SMC_MAX_STREAM_WAIT_TIMEOUT);
 	__smc_release(smc);
 	release_sock(sk);
 	sock_put(sk); /* sock_hold above */
-- 
2.40.1



