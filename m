Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AD77AD21
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjHMVsI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjHMVqe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D932D54
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 366F160CA3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4B6C433C8;
        Sun, 13 Aug 2023 21:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963192;
        bh=rzNYM/QcUhQYG6AZr4bycAVj3ysLoM1vSnqvvNb1ykc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPT2ubAuPm6dc8z4xh/Sq5+VP/GNSaJ4IPj2JZH+DGW7BPQJevOqNK8qra0E0i5iQ
         0BvJ91pIqhzp1x4HwJWlnrmAUdOdHFnx8hRZctREpEGfn9h4a7D1EmfnjY9Np88koM
         e8EIUU2f3WaisWPo1dayclAJS4S21wcZyatvpCHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Yang <leoyang.li@nxp.com>,
        David Bauer <mail@david-bauer.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 58/89] net: phy: at803x: remove set/get wol callbacks for AR8032
Date:   Sun, 13 Aug 2023 23:19:49 +0200
Message-ID: <20230813211712.534933779@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Yang <leoyang.li@nxp.com>

commit d7791cec2304aea22eb2ada944e4d467302f5bfe upstream.

Since the AR8032 part does not support wol, remove related callbacks
from it.

Fixes: 5800091a2061 ("net: phy: at803x: add support for AR8032 PHY")
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Cc: David Bauer <mail@david-bauer.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/at803x.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1375,8 +1375,6 @@ static struct phy_driver at803x_driver[]
 	.flags			= PHY_POLL_CABLE_TEST,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
-	.set_wol		= at803x_set_wol,
-	.get_wol		= at803x_get_wol,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	/* PHY_BASIC_FEATURES */


