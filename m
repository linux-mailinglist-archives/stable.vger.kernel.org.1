Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D327270C79C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjEVTbp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjEVTbp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A09C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2C2C62905
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCCFC433EF;
        Mon, 22 May 2023 19:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783903;
        bh=n14EcyC4I8qfb3PL6ajH9kdy6ns5c+GYmEo3sFs+ebY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+S1uX9xNl1qTIbfMC3aziysISEv32djjYd2awjRd15YJyi6CA6Z2sunb/cuWXwQJ
         O13Ik9YDeNJmSEhGDcSW0arELaUKAceXvrXc8bGU8pbSAJAYco+lIVzdLumtwICKzT
         mB0cJ+oe75Av8Fz6klhCuOpRw62Ooj7k3sNK6He0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 199/292] can: dev: fix missing CAN XL support in can_put_echo_skb()
Date:   Mon, 22 May 2023 20:09:16 +0100
Message-Id: <20230522190410.932524324@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

[ Upstream commit 6bffdc38f9935bae49f980448f3f6be2dada0564 ]

can_put_echo_skb() checks for the enabled IFF_ECHO flag and the
correct ETH_P type of the given skbuff. When implementing the CAN XL
support the new check for ETH_P_CANXL has been forgotten.

Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20230506184515.39241-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev/skb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 241ec636e91fd..f6d05b3ef59ab 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -54,7 +54,8 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	/* check flag whether this packet has to be looped back */
 	if (!(dev->flags & IFF_ECHO) ||
 	    (skb->protocol != htons(ETH_P_CAN) &&
-	     skb->protocol != htons(ETH_P_CANFD))) {
+	     skb->protocol != htons(ETH_P_CANFD) &&
+	     skb->protocol != htons(ETH_P_CANXL))) {
 		kfree_skb(skb);
 		return 0;
 	}
-- 
2.39.2



