Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AED73E95B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjFZSfB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjFZSfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5627E99
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D625560F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC02C433C8;
        Mon, 26 Jun 2023 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804498;
        bh=ZA6HGdFkzewqRjH4VHrbdjHoyYvgsQXlOpW98633N0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PxMq61pCE7+Y/3Pba/08GCUMwbyrQrfCCL0pJUIxhI4fck00la/AHsex5HGex3cH4
         m0UgkJBFLhE8/bcCk19S1hqkJx3p5BFIBWmeWvZBBptUYCjHZpU9oTmO+uwGbmj5J4
         jy7GqdbmmTrBT6Ip2ZIrIhyNxh2aUMC8y5mWcVaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Clark Wang <xiaoning.wang@nxp.com>,
        Carlos Song <carlos.song@nxp.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 169/170] i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle
Date:   Mon, 26 Jun 2023 20:12:18 +0200
Message-ID: <20230626180808.045601453@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Clark Wang <xiaoning.wang@nxp.com>

[ Upstream commit e69b9bc170c6d93ee375a5cbfd15f74c0fb59bdd ]

Claim clkhi and clklo as integer type to avoid possible calculation
errors caused by data overflow.

Fixes: a55fa9d0e42e ("i2c: imx-lpi2c: add low power i2c bus driver")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index a49b14d52a986..ff12018bc2060 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -201,8 +201,8 @@ static void lpi2c_imx_stop(struct lpi2c_imx_struct *lpi2c_imx)
 /* CLKLO = I2C_CLK_RATIO * CLKHI, SETHOLD = CLKHI, DATAVD = CLKHI/2 */
 static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	u8 prescale, filt, sethold, clkhi, clklo, datavd;
-	unsigned int clk_rate, clk_cycle;
+	u8 prescale, filt, sethold, datavd;
+	unsigned int clk_rate, clk_cycle, clkhi, clklo;
 	enum lpi2c_imx_pincfg pincfg;
 	unsigned int temp;
 
-- 
2.39.2



