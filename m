Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217E270C973
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjEVTsW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjEVTsV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8F95
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 136BA62285
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237BCC433EF;
        Mon, 22 May 2023 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784899;
        bh=cSf7MDYJB7Pr3JHaxM6ciIWH/DnC8gw8dAeIfacyCMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzwHYkYdtLxrq1HzD6Y/dnI94PYgO99KRp5MppbCU3q5aygk080vrnfD8lk9fbpu3
         yewp0cHpjYLvVUBIGEJlBA/4XuYTeg/6X5HXJ0DxQVJvo2PGgsOMhHWU9qP6jRuVi8
         e5a/cRXT+DDFzfSmE/SEFMdy21enwuFRu6nDBbrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Piotr Raczynski <piotr.raczynski@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 238/364] net: dsa: rzn1-a5psw: enable management frames for CPU port
Date:   Mon, 22 May 2023 20:09:03 +0100
Message-Id: <20230522190418.653355886@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Clément Léger <clement.leger@bootlin.com>

[ Upstream commit 9e4b45f20c5aac786c728619e5ee746bffce1798 ]

Currently, management frame were discarded before reaching the CPU port due
to a misconfiguration of the MGMT_CONFIG register. Enable them by setting
the correct value in this register in order to correctly receive management
frame and handle STP.

Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port switch driver")
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/rzn1_a5psw.c | 2 +-
 drivers/net/dsa/rzn1_a5psw.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 919027cf20124..8a419e2ffe2a4 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -673,7 +673,7 @@ static int a5psw_setup(struct dsa_switch *ds)
 	}
 
 	/* Configure management port */
-	reg = A5PSW_CPU_PORT | A5PSW_MGMT_CFG_DISCARD;
+	reg = A5PSW_CPU_PORT | A5PSW_MGMT_CFG_ENABLE;
 	a5psw_reg_writel(a5psw, A5PSW_MGMT_CFG, reg);
 
 	/* Set pattern 0 to forward all frame to mgmt port */
diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index c67abd49c013d..b4fbf453ff741 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -36,7 +36,7 @@
 #define A5PSW_INPUT_LEARN_BLOCK(p)	BIT(p)
 
 #define A5PSW_MGMT_CFG			0x20
-#define A5PSW_MGMT_CFG_DISCARD		BIT(7)
+#define A5PSW_MGMT_CFG_ENABLE		BIT(6)
 
 #define A5PSW_MODE_CFG			0x24
 #define A5PSW_MODE_STATS_RESET		BIT(31)
-- 
2.39.2



