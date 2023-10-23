Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD35B7D32FA
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjJWLZe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjJWLZc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:25:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A2C2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:25:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538BBC433C9;
        Mon, 23 Oct 2023 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060329;
        bh=5QibKPPUyDqTISSQWtvLArm43YX5jPe4/oQtTrGVkhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCV/vRnVe3lSI9WBUTJuRJEVUH+lHvdo+VJsj27/QV0jSHfJB8nVopfsbTkAiar2x
         GPMy3PfRzfwKobjIP1xCs8wVCS32TVYRfC8rESz7W7h04OZgV9ADboAGDCFiKnsWmH
         aSKkBQnmmJ+YVZAT8/sWlFZ50lJa9CFEFmqH7Fro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 135/196] net/tls: split tls_rx_reader_lock
Date:   Mon, 23 Oct 2023 12:56:40 +0200
Message-ID: <20231023104832.304523522@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit f9ae3204fb45d0749befc1cdff50f691c7461e5a ]

Split tls_rx_reader_{lock,unlock} into an 'acquire/release' and
the actual locking part.
With that we can use the tls_rx_reader_lock in situations where
the socket is already locked.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20230726191556.41714-6-hare@suse.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9be00ebbb2341..c5c8fdadc05e8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1851,13 +1851,10 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 	return sk_flush_backlog(sk);
 }
 
-static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
-			      bool nonblock)
+static int tls_rx_reader_acquire(struct sock *sk, struct tls_sw_context_rx *ctx,
+				 bool nonblock)
 {
 	long timeo;
-	int err;
-
-	lock_sock(sk);
 
 	timeo = sock_rcvtimeo(sk, nonblock);
 
@@ -1871,26 +1868,30 @@ static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
 			      !READ_ONCE(ctx->reader_present), &wait);
 		remove_wait_queue(&ctx->wq, &wait);
 
-		if (timeo <= 0) {
-			err = -EAGAIN;
-			goto err_unlock;
-		}
-		if (signal_pending(current)) {
-			err = sock_intr_errno(timeo);
-			goto err_unlock;
-		}
+		if (timeo <= 0)
+			return -EAGAIN;
+		if (signal_pending(current))
+			return sock_intr_errno(timeo);
 	}
 
 	WRITE_ONCE(ctx->reader_present, 1);
 
 	return 0;
+}
 
-err_unlock:
-	release_sock(sk);
+static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
+			      bool nonblock)
+{
+	int err;
+
+	lock_sock(sk);
+	err = tls_rx_reader_acquire(sk, ctx, nonblock);
+	if (err)
+		release_sock(sk);
 	return err;
 }
 
-static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
+static void tls_rx_reader_release(struct sock *sk, struct tls_sw_context_rx *ctx)
 {
 	if (unlikely(ctx->reader_contended)) {
 		if (wq_has_sleeper(&ctx->wq))
@@ -1902,6 +1903,11 @@ static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
 	}
 
 	WRITE_ONCE(ctx->reader_present, 0);
+}
+
+static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
+{
+	tls_rx_reader_release(sk, ctx);
 	release_sock(sk);
 }
 
-- 
2.40.1



