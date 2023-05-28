Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BEC713D72
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjE1TZ1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjE1TZ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8681CA3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE6061BF8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C845C433EF;
        Sun, 28 May 2023 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301924;
        bh=f/B95GWl0V89cK7SWyr8lHVD5SuLpvXDoOEZ6S7HRCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwC1GN3FU5CLK1usz0kEyfpEQEKBzW7fWom7I1Yy1GsybFxe0At7dZfuWLUTNa1D6
         oBh1vyLRXzg/id6Vz59hnYLFaK84TQuX1Ry4pnBTx9Ee/woCC5eaQ7zQtTwah1JxbC
         r+HRk7tyHbFlfpkC1CCyLm+1IqRvoccz11//EPOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.4 090/161] can: j1939: recvmsg(): allow MSG_CMSG_COMPAT flag
Date:   Sun, 28 May 2023 20:10:14 +0100
Message-Id: <20230528190839.981979754@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit 1db080cbdbab28752bbb1c86d64daf96253a5da1 upstream.

The control message provided by J1939 support MSG_CMSG_COMPAT but
blocked recvmsg() syscalls that have set this flag, i.e. on 32bit user
space on 64 bit kernels.

Link: https://github.com/hartkopp/can-isotp/issues/59
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Link: https://lore.kernel.org/20230505110308.81087-3-mkl@pengutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/j1939/socket.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -798,7 +798,7 @@ static int j1939_sk_recvmsg(struct socke
 	struct j1939_sk_buff_cb *skcb;
 	int ret = 0;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_ERRQUEUE))
+	if (flags & ~(MSG_DONTWAIT | MSG_ERRQUEUE | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (flags & MSG_ERRQUEUE)


