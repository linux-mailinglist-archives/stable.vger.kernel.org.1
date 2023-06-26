Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD7D73EA47
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjFZSpW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFZSpW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B098B9
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACFE660F4B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA04C433C0;
        Mon, 26 Jun 2023 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805120;
        bh=yAci5x5K8o2YMbN2h6gTIIMWfDQeM13K7n6GwNyzMe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2iePFnaGw+OiLBrrHQKxKqeblCqT+qKA+AJaaInCe/MQgBaa2BwY4+YxhwIJwWrJ
         qV5Vk4hqn1hcRPBoXSgVHyriH43ON3GAw3POqGrR+8bF23xAkLzk7a1LxLmKyk95VM
         Skrc77qn80B03CHcAInGpSCGobjIKqwKQA0U998E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 56/81] Revert "net: phy: dp83867: perform soft reset and retain established link"
Date:   Mon, 26 Jun 2023 20:12:38 +0200
Message-ID: <20230626180746.741183271@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit a129b41fe0a8b4da828c46b10f5244ca07a3fec3 ]

This reverts commit da9ef50f545f86ffe6ff786174d26500c4db737a.

This fixes a regression in which the link would come up, but no
communication was possible.

The reverted commit was also removing a comment about
DP83867_PHYCR_FORCE_LINK_GOOD, this is not added back in this commits
since it seems that this is unrelated to the original code change.

Closes: https://lore.kernel.org/all/ZGuDJos8D7N0J6Z2@francesco-nb.int.toradex.com/
Fixes: da9ef50f545f ("net: phy: dp83867: perform soft reset and retain established link")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Praneeth Bajjuri <praneeth@ti.com>
Link: https://lore.kernel.org/r/20230619154435.355485-1-francesco@dolcini.it
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83867.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 5fabcd15ef77a..834bf63dc2009 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -802,7 +802,7 @@ static int dp83867_phy_reset(struct phy_device *phydev)
 {
 	int err;
 
-	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESTART);
+	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESET);
 	if (err < 0)
 		return err;
 
-- 
2.39.2



