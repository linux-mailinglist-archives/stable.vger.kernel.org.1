Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33393775A6C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjHILIT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjHILIS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB81ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53D6463148
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E43C433C8;
        Wed,  9 Aug 2023 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579296;
        bh=iNBoEObbPZc+5k7PbCPGP4r9zMTpY0m5aIgwSVi1li8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeNVR040IwdOfLRe4lidTch256MGYTXfAa+NPdHE3DOlCMKhz9BUfkDVolIZlOGrz
         myQsIFyK5Ocfki6BKd3YiZ3Fy3QEFkrwWLxhjY8gXU8sexccNo011itPfZC603sLvU
         L0sI1Aeh2F2g7ehHwQDpEG1jyEuGFtsZW/OFKL6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 146/204] tcp: annotate data-races around fastopenq.max_qlen
Date:   Wed,  9 Aug 2023 12:41:24 +0200
Message-ID: <20230809103647.464321299@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
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

[ Upstream commit 70f360dd7042cb843635ece9d28335a4addff9eb ]

This field can be read locklessly.

Fixes: 1536e2857bd3 ("tcp: Add a TCP_FASTOPEN socket option to get a max backlog on its listner")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-12-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tcp.h     |    2 +-
 net/ipv4/tcp.c          |    2 +-
 net/ipv4/tcp_fastopen.c |    6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -425,7 +425,7 @@ static inline void fastopen_queue_tune(s
 	struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
 	int somaxconn = READ_ONCE(sock_net(sk)->core.sysctl_somaxconn);
 
-	queue->fastopenq.max_qlen = min_t(unsigned int, backlog, somaxconn);
+	WRITE_ONCE(queue->fastopenq.max_qlen, min_t(unsigned int, backlog, somaxconn));
 }
 
 static inline void tcp_move_syn(struct tcp_sock *tp,
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3193,7 +3193,7 @@ static int do_tcp_getsockopt(struct sock
 		break;
 
 	case TCP_FASTOPEN:
-		val = icsk->icsk_accept_queue.fastopenq.max_qlen;
+		val = READ_ONCE(icsk->icsk_accept_queue.fastopenq.max_qlen);
 		break;
 
 	case TCP_FASTOPEN_CONNECT:
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -239,6 +239,7 @@ static struct sock *tcp_fastopen_create_
 static bool tcp_fastopen_queue_check(struct sock *sk)
 {
 	struct fastopen_queue *fastopenq;
+	int max_qlen;
 
 	/* Make sure the listener has enabled fastopen, and we don't
 	 * exceed the max # of pending TFO requests allowed before trying
@@ -251,10 +252,11 @@ static bool tcp_fastopen_queue_check(str
 	 * temporarily vs a server not supporting Fast Open at all.
 	 */
 	fastopenq = &inet_csk(sk)->icsk_accept_queue.fastopenq;
-	if (fastopenq->max_qlen == 0)
+	max_qlen = READ_ONCE(fastopenq->max_qlen);
+	if (max_qlen == 0)
 		return false;
 
-	if (fastopenq->qlen >= fastopenq->max_qlen) {
+	if (fastopenq->qlen >= max_qlen) {
 		struct request_sock *req1;
 		spin_lock(&fastopenq->lock);
 		req1 = fastopenq->rskq_rst_head;


