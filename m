Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD079BEA0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbjIKU6m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbjIKO2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:28:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E10F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:28:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DE3C433C9;
        Mon, 11 Sep 2023 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442519;
        bh=gZ6CBj0FDNnEsOMhoeNctjqEUpr+z3BROmGKOuggT9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDushILIABXEoRDSGS4CdGOG6slVjZZquJoQTspnkgR3P5zBPmWoG/T5dI5a+IHxq
         XjlSCmVVrzu505000xrc6GxNTgPZiwrXZjY2D/A4xSOAACPXfT0nPQVoO3sRg0Hh4A
         GXaOflvt0/wYL2NByXrNkG19DY9v+A9O/9JrtVsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukasz Majewski <lukma@denx.de>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 052/737] net: dsa: microchip: KSZ9477 register regmap alignment to 32 bit boundaries
Date:   Mon, 11 Sep 2023 15:38:31 +0200
Message-ID: <20230911134651.926619927@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukasz Majewski <lukma@denx.de>

[ Upstream commit 8d7ae22ae9f8c8a4407f8e993df64440bdbd0cee ]

The commit (SHA1: 5c844d57aa7894154e49cf2fc648bfe2f1aefc1c) provided code
to apply "Module 6: Certain PHY registers must be written as pairs instead
of singly" errata for KSZ9477 as this chip for certain PHY registers
(0xN120 to 0xN13F, N=1,2,3,4,5) must be accesses as 32 bit words instead
of 16 or 8 bit access.
Otherwise, adjacent registers (no matter if reserved or not) are
overwritten with 0x0.

Without this patch some registers (e.g. 0x113c or 0x1134) required for 32
bit access are out of valid regmap ranges.

As a result, following error is observed and KSZ9477 is not properly
configured:

ksz-switch spi1.0: can't rmw 32bit reg 0x113c: -EIO
ksz-switch spi1.0: can't rmw 32bit reg 0x1134: -EIO
ksz-switch spi1.0 lan1 (uninitialized): failed to connect to PHY: -EIO
ksz-switch spi1.0 lan1 (uninitialized): error -5 setting up PHY for tree 0, switch 0, port 0

The solution is to modify regmap_reg_range to allow accesses with 4 bytes
boundaries.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 35 +++++++++++---------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index a0ba2605bb620..f87ed14fa2ab2 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -635,10 +635,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x1030, 0x1030),
 	regmap_reg_range(0x1100, 0x1115),
 	regmap_reg_range(0x111a, 0x111f),
-	regmap_reg_range(0x1122, 0x1127),
-	regmap_reg_range(0x112a, 0x112b),
-	regmap_reg_range(0x1136, 0x1139),
-	regmap_reg_range(0x113e, 0x113f),
+	regmap_reg_range(0x1120, 0x112b),
+	regmap_reg_range(0x1134, 0x113b),
+	regmap_reg_range(0x113c, 0x113f),
 	regmap_reg_range(0x1400, 0x1401),
 	regmap_reg_range(0x1403, 0x1403),
 	regmap_reg_range(0x1410, 0x1417),
@@ -669,10 +668,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x2030, 0x2030),
 	regmap_reg_range(0x2100, 0x2115),
 	regmap_reg_range(0x211a, 0x211f),
-	regmap_reg_range(0x2122, 0x2127),
-	regmap_reg_range(0x212a, 0x212b),
-	regmap_reg_range(0x2136, 0x2139),
-	regmap_reg_range(0x213e, 0x213f),
+	regmap_reg_range(0x2120, 0x212b),
+	regmap_reg_range(0x2134, 0x213b),
+	regmap_reg_range(0x213c, 0x213f),
 	regmap_reg_range(0x2400, 0x2401),
 	regmap_reg_range(0x2403, 0x2403),
 	regmap_reg_range(0x2410, 0x2417),
@@ -703,10 +701,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x3030, 0x3030),
 	regmap_reg_range(0x3100, 0x3115),
 	regmap_reg_range(0x311a, 0x311f),
-	regmap_reg_range(0x3122, 0x3127),
-	regmap_reg_range(0x312a, 0x312b),
-	regmap_reg_range(0x3136, 0x3139),
-	regmap_reg_range(0x313e, 0x313f),
+	regmap_reg_range(0x3120, 0x312b),
+	regmap_reg_range(0x3134, 0x313b),
+	regmap_reg_range(0x313c, 0x313f),
 	regmap_reg_range(0x3400, 0x3401),
 	regmap_reg_range(0x3403, 0x3403),
 	regmap_reg_range(0x3410, 0x3417),
@@ -737,10 +734,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x4030, 0x4030),
 	regmap_reg_range(0x4100, 0x4115),
 	regmap_reg_range(0x411a, 0x411f),
-	regmap_reg_range(0x4122, 0x4127),
-	regmap_reg_range(0x412a, 0x412b),
-	regmap_reg_range(0x4136, 0x4139),
-	regmap_reg_range(0x413e, 0x413f),
+	regmap_reg_range(0x4120, 0x412b),
+	regmap_reg_range(0x4134, 0x413b),
+	regmap_reg_range(0x413c, 0x413f),
 	regmap_reg_range(0x4400, 0x4401),
 	regmap_reg_range(0x4403, 0x4403),
 	regmap_reg_range(0x4410, 0x4417),
@@ -771,10 +767,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x5030, 0x5030),
 	regmap_reg_range(0x5100, 0x5115),
 	regmap_reg_range(0x511a, 0x511f),
-	regmap_reg_range(0x5122, 0x5127),
-	regmap_reg_range(0x512a, 0x512b),
-	regmap_reg_range(0x5136, 0x5139),
-	regmap_reg_range(0x513e, 0x513f),
+	regmap_reg_range(0x5120, 0x512b),
+	regmap_reg_range(0x5134, 0x513b),
+	regmap_reg_range(0x513c, 0x513f),
 	regmap_reg_range(0x5400, 0x5401),
 	regmap_reg_range(0x5403, 0x5403),
 	regmap_reg_range(0x5410, 0x5417),
-- 
2.40.1



