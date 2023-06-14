Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67418726D52
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjFGUlI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjFGUlD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB90270A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CE826460B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B8BC433EF;
        Wed,  7 Jun 2023 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170448;
        bh=XhCsoPWVyoEY2O9W9vhCn/DhXr7VslGofdYJ8XFaJ/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2egJkpshFEZAjfheEzf2fALkbwZGKL0f55jEawoiwgLewt0QlG1RbVx7fGbTFWyS
         45zRj9Zm2aNaZOnkyBYnsC9KCJg9jRxfP225HJD/e8Mtrn9Wh+mPK9HZW7tuvrSUR6
         qrps0eBu9P1O+rUZ88MHaDugqwQP3DDx2cbbfqco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>,
        Mat Martineau <martineau@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/225] mptcp: add annotations around sk->sk_shutdown accesses
Date:   Wed,  7 Jun 2023 22:14:12 +0200
Message-ID: <20230607200916.282398106@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 6b9831bfd9322b297eb6d44257808cc055fdc586 ]

Christoph reported the mptcp variant of a recently addressed plain
TCP issue. Similar to commit e14cadfd80d7 ("tcp: add annotations around
sk->sk_shutdown accesses") add READ/WRITE ONCE annotations to silence
KCSAN reports around lockless sk_shutdown access.

Fixes: 71ba088ce0aa ("mptcp: cleanup accept and poll")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/401
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f4206001e2fe5..c25796eacd95f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -599,7 +599,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
-		sk->sk_shutdown |= RCV_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 
 		switch (sk->sk_state) {
@@ -906,7 +906,7 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 		/* hopefully temporary hack: propagate shutdown status
 		 * to msk, when all subflows agree on it
 		 */
-		sk->sk_shutdown |= RCV_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 		sk->sk_data_ready(sk);
@@ -2512,7 +2512,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	}
 
 	inet_sk_state_store(sk, TCP_CLOSE);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
 
@@ -2941,7 +2941,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	bool do_cancel_work = false;
 	int subflows_alive = 0;
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
 		inet_sk_state_store(sk, TCP_CLOSE);
@@ -3079,7 +3079,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 
-	sk->sk_shutdown = 0;
+	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
 	return 0;
 }
@@ -3815,9 +3815,6 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 
-	if (unlikely(sk->sk_shutdown & SEND_SHUTDOWN))
-		return EPOLLOUT | EPOLLWRNORM;
-
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 
@@ -3835,6 +3832,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	struct sock *sk = sock->sk;
 	struct mptcp_sock *msk;
 	__poll_t mask = 0;
+	u8 shutdown;
 	int state;
 
 	msk = mptcp_sk(sk);
@@ -3851,17 +3849,22 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		return inet_csk_listen_poll(ssock->sk);
 	}
 
+	shutdown = READ_ONCE(sk->sk_shutdown);
+	if (shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
+		mask |= EPOLLHUP;
+	if (shutdown & RCV_SHUTDOWN)
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
+
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);
-		mask |= mptcp_check_writeable(msk);
+		if (shutdown & SEND_SHUTDOWN)
+			mask |= EPOLLOUT | EPOLLWRNORM;
+		else
+			mask |= mptcp_check_writeable(msk);
 	} else if (state == TCP_SYN_SENT && inet_sk(sk)->defer_connect) {
 		/* cf tcp_poll() note about TFO */
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
-	if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
-		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
-		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-- 
2.39.2



