Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FAF70C69F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjEVTUU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjEVTUR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1F8B0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD9962817
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD69AC433EF;
        Mon, 22 May 2023 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783215;
        bh=RYiZc5MGyNQ1CFaVPXfOjthdqbWcH8faoWa3XdNOwFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFxm8nvLFZv7MuE/upOfQtD7YLmwiKXmOTodvRnNFrhbPCc87ILNmPmNF1/eEO+wP
         pYf3/h0S4aazixCS4CdW59Acbt9cwYNfyF8pmH8olX1UTKEyoleI8vMxJ7Aon15M3e
         7I1NF/QgdlZtZEEYFpPxtXwRvrI0xCVBgqH02LFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.15 176/203] can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag
Date:   Mon, 22 May 2023 20:10:00 +0100
Message-Id: <20230522190359.871052465@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

commit db2773d65b02aed319a93efdfb958087771d4e19 upstream.

The control message provided by isotp support MSG_CMSG_COMPAT but
blocked recvmsg() syscalls that have set this flag, i.e. on 32bit user
space on 64 bit kernels.

Link: https://github.com/hartkopp/can-isotp/issues/59
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading from socket")
Link: https://lore.kernel.org/20230505110308.81087-2-mkl@pengutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/isotp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1018,7 +1018,7 @@ static int isotp_recvmsg(struct socket *
 	int noblock = flags & MSG_DONTWAIT;
 	int ret = 0;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (!so->bound)


