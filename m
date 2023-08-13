Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE177AD50
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjHMVsZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjHMVsH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1741BD6
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C65C61A2D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DFCC433C8;
        Sun, 13 Aug 2023 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962898;
        bh=qfWiR1Sh5nVMaXTp90bFRDWFlk/45eMnGQpkaD1Rbjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PU2tz6CN9kh6i9p63+wOv8jJ5tQkNwvQBXyX53HnHgkML7mxZEAiCSUygy/Apt7ZT
         X1LXZLLkXmEi8YTVgkZo+usLGwhI1/Ynhs+Ymm7TFSb48rS6i1KaD2hJZNvBll5+XO
         swl0wwEW2vYcc436+Q0vioxuCMU9+jdPKWW2U2G4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Yang <leoyang.li@nxp.com>,
        David Bauer <mail@david-bauer.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 47/68] net: phy: at803x: remove set/get wol callbacks for AR8032
Date:   Sun, 13 Aug 2023 23:19:48 +0200
Message-ID: <20230813211709.583129963@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
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
@@ -1115,8 +1115,6 @@ static struct phy_driver at803x_driver[]
 	.flags			= PHY_POLL_CABLE_TEST,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
-	.set_wol		= at803x_set_wol,
-	.get_wol		= at803x_get_wol,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	/* PHY_BASIC_FEATURES */


