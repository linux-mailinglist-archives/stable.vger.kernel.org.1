Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EF07A39B2
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbjIQTxK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbjIQTww (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:52:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBDE43
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:52:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F33C433C8;
        Sun, 17 Sep 2023 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980360;
        bh=BPuIRrUwfJ47sTB4CucXvWPn5VDk5gxUsVevzPwaVSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3J9htnGojmzliPFx6IT+uLzPf8KMbVT4goB4sRsTcu+vygbin96bCwIhEWSmC0wk
         nXPC8yV9cjCKoCT2OaSMz7tsZAAiKEEqlumivegFvu2PpN3lSp8Qb8w6A0Il5JCRId
         Y28VokuOofsZfpOhFmogP88ndJDqlXAItVjuBH4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 131/285] net: phy: micrel: Correct bit assignments for phy_device flags
Date:   Sun, 17 Sep 2023 21:12:11 +0200
Message-ID: <20230917191056.197765475@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 719c5e37e99d2fd588d1c994284d17650a66354c ]

Previously, the defines for phy_device flags in the Micrel driver were
ambiguous in their representation. They were intended to be bit masks
but were mistakenly defined as bit positions. This led to the following
issues:

- MICREL_KSZ8_P1_ERRATA, designated for KSZ88xx switches, overlapped
  with MICREL_PHY_FXEN and MICREL_PHY_50MHZ_CLK.
- Due to this overlap, the code path for MICREL_PHY_FXEN, tailored for
  the KSZ8041 PHY, was not executed for KSZ88xx PHYs.
- Similarly, the code associated with MICREL_PHY_50MHZ_CLK wasn't
  triggered for KSZ88xx.

To rectify this, all three flags have now been explicitly converted to
use the `BIT()` macro, ensuring they are defined as bit masks and
preventing potential overlaps in the future.

Fixes: 49011e0c1555 ("net: phy: micrel: ksz886x/ksz8081: add cabletest support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/micrel_phy.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 8bef1ab62bba3..322d872559847 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -41,9 +41,9 @@
 #define	PHY_ID_KSZ9477		0x00221631
 
 /* struct phy_device dev_flags definitions */
-#define MICREL_PHY_50MHZ_CLK	0x00000001
-#define MICREL_PHY_FXEN		0x00000002
-#define MICREL_KSZ8_P1_ERRATA	0x00000003
+#define MICREL_PHY_50MHZ_CLK	BIT(0)
+#define MICREL_PHY_FXEN		BIT(1)
+#define MICREL_KSZ8_P1_ERRATA	BIT(2)
 
 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
-- 
2.40.1



