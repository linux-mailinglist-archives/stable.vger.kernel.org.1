Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE92B70C7B5
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjEVTcM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbjEVTcF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B81A3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E8D6291B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ACAC433D2;
        Mon, 22 May 2023 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783923;
        bh=jNYdsuy80PjVG4hMzPBbCjRDUF3V+5Hk/xjuaxhHALc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0kauxV0y6zT72yArOWiauHxUYJOROjkWNIubPXfUTe01v0XWcLU7wyUC3fS5dJoTF
         crGTXQD82SNRFWzh9fLjRe0a99ORsrlJygzLI3dfHMu755OOrEDfvkTchEAtW+YTnV
         oJnhUGPObts8CuLh5rc+m1XYz/6N2jWhjDJJWWbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 179/292] net: dsa: rzn1-a5psw: fix STP states handling
Date:   Mon, 22 May 2023 20:08:56 +0100
Message-Id: <20230522190410.438973779@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit ebe9bc50952757b4b25eaf514da7c464196c9606 ]

stp_set_state() should actually allow receiving BPDU while in LEARNING
mode which is not the case. Additionally, the BLOCKEN bit does not
actually forbid sending forwarded frames from that port. To fix this, add
a5psw_port_tx_enable() function which allows to disable TX. However, while
its name suggest that TX is totally disabled, it is not and can still
allow to send BPDUs even if disabled. This can be done by using forced
forwarding with the switch tagging mechanism but keeping "filtering"
disabled (which is already the case in the rzn1-a5sw tag driver). With
these fixes, STP support is now functional.

Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port switch driver")
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/rzn1_a5psw.c | 57 ++++++++++++++++++++++++++++++------
 drivers/net/dsa/rzn1_a5psw.h |  1 +
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 92a3ac78ab1e5..2b0463263767c 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -120,6 +120,22 @@ static void a5psw_port_mgmtfwd_set(struct a5psw *a5psw, int port, bool enable)
 	a5psw_port_pattern_set(a5psw, port, A5PSW_PATTERN_MGMTFWD, enable);
 }
 
+static void a5psw_port_tx_enable(struct a5psw *a5psw, int port, bool enable)
+{
+	u32 mask = A5PSW_PORT_ENA_TX(port);
+	u32 reg = enable ? mask : 0;
+
+	/* Even though the port TX is disabled through TXENA bit in the
+	 * PORT_ENA register, it can still send BPDUs. This depends on the tag
+	 * configuration added when sending packets from the CPU port to the
+	 * switch port. Indeed, when using forced forwarding without filtering,
+	 * even disabled ports will be able to send packets that are tagged.
+	 * This allows to implement STP support when ports are in a state where
+	 * forwarding traffic should be stopped but BPDUs should still be sent.
+	 */
+	a5psw_reg_rmw(a5psw, A5PSW_PORT_ENA, mask, reg);
+}
+
 static void a5psw_port_enable_set(struct a5psw *a5psw, int port, bool enable)
 {
 	u32 port_ena = 0;
@@ -292,6 +308,22 @@ static int a5psw_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	return 0;
 }
 
+static void a5psw_port_learning_set(struct a5psw *a5psw, int port, bool learn)
+{
+	u32 mask = A5PSW_INPUT_LEARN_DIS(port);
+	u32 reg = !learn ? mask : 0;
+
+	a5psw_reg_rmw(a5psw, A5PSW_INPUT_LEARN, mask, reg);
+}
+
+static void a5psw_port_rx_block_set(struct a5psw *a5psw, int port, bool block)
+{
+	u32 mask = A5PSW_INPUT_LEARN_BLOCK(port);
+	u32 reg = block ? mask : 0;
+
+	a5psw_reg_rmw(a5psw, A5PSW_INPUT_LEARN, mask, reg);
+}
+
 static void a5psw_flooding_set_resolution(struct a5psw *a5psw, int port,
 					  bool set)
 {
@@ -344,28 +376,35 @@ static void a5psw_port_bridge_leave(struct dsa_switch *ds, int port,
 
 static void a5psw_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
-	u32 mask = A5PSW_INPUT_LEARN_DIS(port) | A5PSW_INPUT_LEARN_BLOCK(port);
+	bool learning_enabled, rx_enabled, tx_enabled;
 	struct a5psw *a5psw = ds->priv;
-	u32 reg = 0;
 
 	switch (state) {
 	case BR_STATE_DISABLED:
 	case BR_STATE_BLOCKING:
-		reg |= A5PSW_INPUT_LEARN_DIS(port);
-		reg |= A5PSW_INPUT_LEARN_BLOCK(port);
-		break;
 	case BR_STATE_LISTENING:
-		reg |= A5PSW_INPUT_LEARN_DIS(port);
+		rx_enabled = false;
+		tx_enabled = false;
+		learning_enabled = false;
 		break;
 	case BR_STATE_LEARNING:
-		reg |= A5PSW_INPUT_LEARN_BLOCK(port);
+		rx_enabled = false;
+		tx_enabled = false;
+		learning_enabled = true;
 		break;
 	case BR_STATE_FORWARDING:
-	default:
+		rx_enabled = true;
+		tx_enabled = true;
+		learning_enabled = true;
 		break;
+	default:
+		dev_err(ds->dev, "invalid STP state: %d\n", state);
+		return;
 	}
 
-	a5psw_reg_rmw(a5psw, A5PSW_INPUT_LEARN, mask, reg);
+	a5psw_port_learning_set(a5psw, port, learning_enabled);
+	a5psw_port_rx_block_set(a5psw, port, !rx_enabled);
+	a5psw_port_tx_enable(a5psw, port, tx_enabled);
 }
 
 static void a5psw_port_fast_age(struct dsa_switch *ds, int port)
diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index b4fbf453ff741..b869192eef3f7 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -19,6 +19,7 @@
 #define A5PSW_PORT_OFFSET(port)		(0x400 * (port))
 
 #define A5PSW_PORT_ENA			0x8
+#define A5PSW_PORT_ENA_TX(port)		BIT(port)
 #define A5PSW_PORT_ENA_RX_SHIFT		16
 #define A5PSW_PORT_ENA_TX_RX(port)	(BIT((port) + A5PSW_PORT_ENA_RX_SHIFT) | \
 					 BIT(port))
-- 
2.39.2



