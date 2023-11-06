Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FF77E259B
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjKFNdn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjKFNdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:33:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C737A134
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:33:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12227C433C7;
        Mon,  6 Nov 2023 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277618;
        bh=+u4AQJUqYfi+6Z/IwIf+Go3jbgnIJsbnMp+9T3DXicc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZegRrhYhLb9KV7LowB73Y4Sdai2JeXmG2DME+h8fyzlmArKe94jyLJifeX2cAS5Z
         gens56mKUb48LAn0pxKy0gnpQXPk8qEx5m4KUYgPMUSdloM3vfCDYdi/PVHRoAYBdP
         SLz+zddmYEwxyoZmWtSfGg+0Gqo6vQmtvWHv6gSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Patrick Menschel <menschel.p@posteo.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.10 79/95] can: isotp: add symbolic error message to isotp_module_init()
Date:   Mon,  6 Nov 2023 14:04:47 +0100
Message-ID: <20231106130307.602848917@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Menschel <menschel.p@posteo.de>

commit 6a5ddae578842652719fb926b22f1d510fe50bee upstream

This patch adds the value of err with format %pe to the already
existing error message.

Link: https://lore.kernel.org/r/20210427052150.2308-3-menschel.p@posteo.de
Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/isotp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1550,7 +1550,7 @@ static __init int isotp_module_init(void
 
 	err = can_proto_register(&isotp_can_proto);
 	if (err < 0)
-		pr_err("can: registration of isotp protocol failed\n");
+		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
 	else
 		register_netdevice_notifier(&canisotp_notifier);
 


