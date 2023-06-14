Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16A72C100
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbjFLK4A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjFLKzq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6354EF1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10D9615B7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E41C433D2;
        Mon, 12 Jun 2023 10:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566561;
        bh=cZfWCa99St9eb01zjbzxJth1IR50E8rE0F8769taugE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xb2eutNqSZ+0mTxb53yALRmIZ4F/cEtHQLFYdH56785GCNou3rhqUvVZrNXX8g9sD
         jcbnA+4qzKe5Vr29gfX0z22q8Jv6LyGFjrdwo2cjxpnLHtg/pyuCpMlNHoFB3J5nh9
         C0q+DIVRdIGqpbS/ONnZiiqkD9DnMQy03jInCGEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1 078/132] can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket
Date:   Mon, 12 Jun 2023 12:26:52 +0200
Message-ID: <20230612101713.811928465@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit 2a84aea80e925ecba6349090559754f8e8eb68ef upstream.

This patch addresses an issue within the j1939_sk_send_loop_abort()
function in the j1939/socket.c file, specifically in the context of
Transport Protocol (TP) sessions.

Without this patch, when a TP session is initiated and a Clear To Send
(CTS) frame is received from the remote side requesting one data packet,
the kernel dispatches the first Data Transport (DT) frame and then waits
for the next CTS. If the remote side doesn't respond with another CTS,
the kernel aborts due to a timeout. This leads to the user-space
receiving an EPOLLERR on the socket, and the socket becomes active.

However, when trying to read the error queue from the socket with
sock.recvmsg(, , socket.MSG_ERRQUEUE), it returns -EAGAIN,
given that the socket is non-blocking. This situation results in an
infinite loop: the user-space repeatedly calls epoll(), epoll() returns
the socket file descriptor with EPOLLERR, but the socket then blocks on
the recv() of ERRQUEUE.

This patch introduces an additional check for the J1939_SOCK_ERRQUEUE
flag within the j1939_sk_send_loop_abort() function. If the flag is set,
it indicates that the application has subscribed to receive error queue
messages. In such cases, the kernel can communicate the current transfer
state via the error queue. This allows for the function to return early,
preventing the unnecessary setting of the socket into an error state,
and breaking the infinite loop. It is crucial to note that a socket
error is only needed if the application isn't using the error queue, as,
without it, the application wouldn't be aware of transfer issues.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: David Jander <david@protonic.nl>
Tested-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20230526081946.715190-1-o.rempel@pengutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/j1939/socket.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1088,6 +1088,11 @@ void j1939_sk_errqueue(struct j1939_sess
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
 {
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	if (jsk->state & J1939_SOCK_ERRQUEUE)
+		return;
+
 	sk->sk_err = err;
 
 	sk_error_report(sk);


