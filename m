Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8751177ACD0
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjHMVhZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjHMVhY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D82610E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9613363347
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC50FC433C8;
        Sun, 13 Aug 2023 21:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962646;
        bh=KIYmjJUlABjCAsYEljvtmFBRmg3FlNNrwIfd2rlFziA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOgNQyOKpQt81IZNh0wzJTVpyHsZrwMvZk3U1abZbNcOqPb37OlkSor4f545egf+X
         jtNuFYF/jp8q24FDGdNyPsrwEF3v5Fnq+xwBgpseEZYpCsScityFLxe4N9hERnXyDb
         afBqeSbd/bXyqSHDQHcqQhPPJcG9uxA4KsCu3aQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Yang <leoyang.li@nxp.com>,
        David Bauer <mail@david-bauer.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 105/149] net: phy: at803x: remove set/get wol callbacks for AR8032
Date:   Sun, 13 Aug 2023 23:19:10 +0200
Message-ID: <20230813211721.913497543@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
@@ -2087,8 +2087,6 @@ static struct phy_driver at803x_driver[]
 	.flags			= PHY_POLL_CABLE_TEST,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
-	.set_wol		= at803x_set_wol,
-	.get_wol		= at803x_get_wol,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	/* PHY_BASIC_FEATURES */


