Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB80074631A
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGCS5m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjGCS5k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6417FE64
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02E3361015
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5BDC433CB;
        Mon,  3 Jul 2023 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410658;
        bh=29SpfZ6eHZKYF8KzgvVLa7lyQQ3liUyD8sWVDCO+I0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ak5NvvJiBuf/irDe9NKnAnj3FNrOSvCeUx+fcGLA8Xd6x2pToINa+TpolSJw3MxBp
         LW9W3G1Ma3ZoYvA1oKW//3EkHzz7tyTRZZSL/K/pS9Exv3qmk2pfv1Hi1/gZBj4bu0
         b+c5IIEmJSmCBVvJCSoFm+G9ZKI6LH+fRh1oo1oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Carsten Schmidt <carsten.schmidt-achim@t-online.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15 08/15] can: isotp: isotp_sendmsg(): fix return error fix on TX path
Date:   Mon,  3 Jul 2023 20:54:53 +0200
Message-ID: <20230703184519.121589562@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184518.896751186@linuxfoundation.org>
References: <20230703184518.896751186@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit e38910c0072b541a91954682c8b074a93e57c09b upstream.

With commit d674a8f123b4 ("can: isotp: isotp_sendmsg(): fix return
error on FC timeout on TX path") the missing correct return value in
the case of a protocol error was introduced.

But the way the error value has been read and sent to the user space
does not follow the common scheme to clear the error after reading
which is provided by the sock_error() function. This leads to an error
report at the following write() attempt although everything should be
working.

Fixes: d674a8f123b4 ("can: isotp: isotp_sendmsg(): fix return error on FC timeout on TX path")
Reported-by: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20230607072708.38809-1-socketcan@hartkopp.net
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/isotp.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -992,8 +992,9 @@ static int isotp_sendmsg(struct socket *
 		/* wait for complete transmission of current pdu */
 		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 
-		if (sk->sk_err)
-			return -sk->sk_err;
+		err = sock_error(sk);
+		if (err)
+			return err;
 	}
 
 	return size;


