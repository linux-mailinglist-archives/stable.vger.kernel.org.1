Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF95C7612DD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjGYLGO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjGYLFx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4A53C3C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CEF86165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412D2C433C7;
        Tue, 25 Jul 2023 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283035;
        bh=l74UtzMNqyfYk8EA66oyd3UuHqs3Vsh4yUWAe5nsHzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftpoihpTG615I6fME4v8rt5g1l+IV34ZZ37NIOJrAykZ6iFhLXn+7G1v69fM/xK8Y
         RGEhJnJccOJNDUnDKYqIEc5kCaFiLNxLeA8AG+S2kLQ7Boi64CLW5pGnAeKOeQeCal
         0tghaHQHpG9qw7q0kpqeBdSrJOqFiBFUhwObe/3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 115/183] net: dsa: microchip: ksz8: Make ksz8_r_sta_mac_table() static
Date:   Tue, 25 Jul 2023 12:45:43 +0200
Message-ID: <20230725104512.107829082@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit b5751cdd7dbe618a03951bdd4c982a71ba448b1b ]

As ksz8_r_sta_mac_table() is only used within ksz8795.c, there is no need
to export it. Make the function static for better encapsulation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 4bdf79d686b4 ("net: dsa: microchip: correct KSZ8795 static MAC table access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz8.h    | 2 --
 drivers/net/dsa/microchip/ksz8795.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 8582b4b67d989..28137c4bf2928 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -21,8 +21,6 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
 int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
 int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 			 u8 *fid, u8 *src_port, u8 *timestamp, u16 *entries);
-int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
-			 struct alu_struct *alu);
 void ksz8_w_sta_mac_table(struct ksz_device *dev, u16 addr,
 			  struct alu_struct *alu);
 void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt);
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 38fd9b8e0287a..a2f67be66b97d 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -406,8 +406,8 @@ int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 	return rc;
 }
 
-int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
-			 struct alu_struct *alu)
+static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
+				struct alu_struct *alu)
 {
 	u32 data_hi, data_lo;
 	const u8 *shifts;
-- 
2.39.2



