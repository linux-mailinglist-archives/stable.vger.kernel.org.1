Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F477ECDFD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjKOTjj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjKOTji (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742CDA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1470C433C9;
        Wed, 15 Nov 2023 19:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077175;
        bh=qBCPzqFJLgtJxCt/CoZd0Zk9nCyuNkmG3aEjo5OEmzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ra3HEkcvMDTgA5OkClQzUbNoQTOY/m1JptcWUMhJ2qnPSPeryDozCV4aioTLgOCrO
         bRuRpNX0xKluoOmfcjmLCbcwIun6ZfbChTqO9hL0Ahha+s+ZE24BEG/OUw+5LkBqbh
         SuqsrBn5FaAr6xsufeWo9vcivMZcEhgcb+UtAGhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 545/550] io_uring/net: ensure socket is marked connected on connect retry
Date:   Wed, 15 Nov 2023 14:18:49 -0500
Message-ID: <20231115191638.696418658@linuxfoundation.org>
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

From: Jens Axboe <axboe@kernel.dk>

commit f8f9ab2d98116e79d220f1d089df7464ad4e026d upstream.

io_uring does non-blocking connection attempts, which can yield some
unexpected results if a connect request is re-attempted by an an
application. This is equivalent to the following sync syscall sequence:

sock = socket(AF_INET, SOCK_STREAM | SOCK_NONBLOCK, IPPROTO_TCP);
connect(sock, &addr, sizeof(addr);

ret == -1 and errno == EINPROGRESS expected here. Now poll for POLLOUT
on sock, and when that returns, we expect the socket to be connected.
But if we follow that procedure with:

connect(sock, &addr, sizeof(addr));

you'd expect ret == -1 and errno == EISCONN here, but you actually get
ret == 0. If we attempt the connection one more time, then we get EISCON
as expected.

io_uring used to do this, but turns out that bluetooth fails with EBADFD
if you attempt to re-connect. Also looks like EISCONN _could_ occur with
this sequence.

Retain the ->in_progress logic, but work-around a potential EISCONN or
EBADFD error and only in those cases look at the sock_error(). This
should work in general and avoid the odd sequence of a repeated connect
request returning success when the socket is already connected.

This is all a side effect of the socket state being in a CONNECTING
state when we get EINPROGRESS, and only a re-connect or other related
operation will turn that into CONNECTED.

Cc: stable@vger.kernel.org
Fixes: 3fb1bd688172 ("io_uring/net: handle -EINPROGRESS correct for IORING_OP_CONNECT")
Link: https://github.com/axboe/liburing/issues/980
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/net.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1461,16 +1461,6 @@ int io_connect(struct io_kiocb *req, uns
 	int ret;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 
-	if (connect->in_progress) {
-		struct socket *socket;
-
-		ret = -ENOTSOCK;
-		socket = sock_from_file(req->file);
-		if (socket)
-			ret = sock_error(socket->sk);
-		goto out;
-	}
-
 	if (req_has_async_data(req)) {
 		io = req->async_data;
 	} else {
@@ -1490,9 +1480,7 @@ int io_connect(struct io_kiocb *req, uns
 	    && force_nonblock) {
 		if (ret == -EINPROGRESS) {
 			connect->in_progress = true;
-			return -EAGAIN;
-		}
-		if (ret == -ECONNABORTED) {
+		} else if (ret == -ECONNABORTED) {
 			if (connect->seen_econnaborted)
 				goto out;
 			connect->seen_econnaborted = true;
@@ -1506,6 +1494,16 @@ int io_connect(struct io_kiocb *req, uns
 		memcpy(req->async_data, &__io, sizeof(__io));
 		return -EAGAIN;
 	}
+	if (connect->in_progress) {
+		/*
+		 * At least bluetooth will return -EBADFD on a re-connect
+		 * attempt, and it's (supposedly) also valid to get -EISCONN
+		 * which means the previous result is good. For both of these,
+		 * grab the sock_error() and use that for the completion.
+		 */
+		if (ret == -EBADFD || ret == -EISCONN)
+			ret = sock_error(sock_from_file(req->file)->sk);
+	}
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
 out:


