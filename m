Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D3C78AC8E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjH1KlE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjH1Kki (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:40:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EFE139
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A796100C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD22C433C9;
        Mon, 28 Aug 2023 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219234;
        bh=vOt8kBBnUKASIDFB+7UwYrqElb0sr0VykVjvdXTSvEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHcPdU0zxiUmY+xWlsN3FECRUeV1LaefWfknor1U0X2jcW43OJ4QEsg20mBHuE01j
         SQ8+s+8L8pac5HIX1Kftj94MhKWK55Pasokg8t+ldp3roU5k2F1IVAu2T/y+cn0wAI
         dBgy3C0KwhkdVQh26xtc3AdDxdYQVWTeGsSAyIeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 121/158] dccp: annotate data-races in dccp_poll()
Date:   Mon, 28 Aug 2023 12:13:38 +0200
Message-ID: <20230828101201.432247647@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cba3f1786916063261e3e5ccbb803abc325b24ef ]

We changed tcp_poll() over time, bug never updated dccp.

Note that we also could remove dccp instead of maintaining it.

Fixes: 7c657876b63c ("[DCCP]: Initial implementation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230818015820.2701595-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dccp/proto.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index cd868556452ec..491b148afa8f0 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -324,11 +324,15 @@ EXPORT_SYMBOL_GPL(dccp_disconnect);
 __poll_t dccp_poll(struct file *file, struct socket *sock,
 		       poll_table *wait)
 {
-	__poll_t mask;
 	struct sock *sk = sock->sk;
+	__poll_t mask;
+	u8 shutdown;
+	int state;
 
 	sock_poll_wait(file, sock, wait);
-	if (sk->sk_state == DCCP_LISTEN)
+
+	state = inet_sk_state_load(sk);
+	if (state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
 	/* Socket is not locked. We are protected from async events
@@ -337,20 +341,21 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	 */
 
 	mask = 0;
-	if (sk->sk_err)
+	if (READ_ONCE(sk->sk_err))
 		mask = EPOLLERR;
+	shutdown = READ_ONCE(sk->sk_shutdown);
 
-	if (sk->sk_shutdown == SHUTDOWN_MASK || sk->sk_state == DCCP_CLOSED)
+	if (shutdown == SHUTDOWN_MASK || state == DCCP_CLOSED)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* Connected? */
-	if ((1 << sk->sk_state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
+	if ((1 << state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
 		if (atomic_read(&sk->sk_rmem_alloc) > 0)
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
 			if (sk_stream_is_writeable(sk)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
@@ -368,7 +373,6 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	}
 	return mask;
 }
-
 EXPORT_SYMBOL_GPL(dccp_poll);
 
 int dccp_ioctl(struct sock *sk, int cmd, unsigned long arg)
-- 
2.40.1



