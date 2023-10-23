Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFDD7D32A3
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjJWLW1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjJWLW0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:22:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093E100
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:22:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6EFC433C8;
        Mon, 23 Oct 2023 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060142;
        bh=OnKnlbgX1oCBCL1CqcNPo2P3iGNB/XmLwNO01Iw7Mvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piWgr9paUzw6A49ZVj28hX9dF6C8YDjHCf582+2NX4Enhz7qcWWh1iNZdm7NQsCzJ
         KzKM4PT8QAqPuuM+hCTCaMEN8rQ5ec+iHoAa7+IHmi8+eN1goExAqIUeJwYPahJNqS
         0Eg0fWxHrtRdD1B6Sg1tsnkM5jl2YwCP8O8mXddk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Justin Chen <justin.chen@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 072/196] net: phy: bcm7xxx: Add missing 16nm EPHY statistics
Date:   Mon, 23 Oct 2023 12:55:37 +0200
Message-ID: <20231023104830.584188543@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian.fainelli@broadcom.com>

commit 6200e00e112ce2d17b066a20dd2476d9aecbefa6 upstream.

The .probe() function would allocate the necessary space and ensure that
the library call sizes the number of statistics but the callbacks
necessary to fetch the name and values were not wired up.

Reported-by: Justin Chen <justin.chen@broadcom.com>
Fixes: f68d08c437f9 ("net: phy: bcm7xxx: Add EPHY entry for 72165")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20231017205119.416392-1-florian.fainelli@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/bcm7xxx.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -907,6 +907,9 @@ static void bcm7xxx_28nm_remove(struct p
 	.name		= _name,					\
 	/* PHY_BASIC_FEATURES */					\
 	.flags		= PHY_IS_INTERNAL,				\
+	.get_sset_count	= bcm_phy_get_sset_count,			\
+	.get_strings	= bcm_phy_get_strings,				\
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
 	.probe		= bcm7xxx_28nm_probe,				\
 	.remove		= bcm7xxx_28nm_remove,				\
 	.config_init	= bcm7xxx_16nm_ephy_config_init,		\


