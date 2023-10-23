Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA37D3149
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjJWLHg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjJWLHf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:07:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC9D7C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:07:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CE2C433CB;
        Mon, 23 Oct 2023 11:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059253;
        bh=PSsnyk3iOjdqG8GmVKXhcbzoyT/H4yt0/BAGSI+H6o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXUaUW5wHPULj+NCh4ptmcK42tD+yoNRBOuNN7b0b+j5e5HkXWeUN15WuVNjs+X2b
         AN3VVA1+3s3MObv0rlWn9h2qKmQ21aushXcxss8AQV5gu0SvwjY6j/SwN2hOf54Rvm
         pW/fBcVp62VP9bAtUG0s9Gwb+Rylojp8c2QmZaT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Justin Chen <justin.chen@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 089/241] net: phy: bcm7xxx: Add missing 16nm EPHY statistics
Date:   Mon, 23 Oct 2023 12:54:35 +0200
Message-ID: <20231023104836.060936286@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
@@ -894,6 +894,9 @@ static int bcm7xxx_28nm_probe(struct phy
 	.name		= _name,					\
 	/* PHY_BASIC_FEATURES */					\
 	.flags		= PHY_IS_INTERNAL,				\
+	.get_sset_count	= bcm_phy_get_sset_count,			\
+	.get_strings	= bcm_phy_get_strings,				\
+	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
 	.probe		= bcm7xxx_28nm_probe,				\
 	.config_init	= bcm7xxx_16nm_ephy_config_init,		\
 	.config_aneg	= genphy_config_aneg,				\


