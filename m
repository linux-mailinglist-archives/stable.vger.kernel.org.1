Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A073E9D8
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjFZSko (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjFZSkn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:40:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2E102
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42AF960F4B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFC9C433C8;
        Mon, 26 Jun 2023 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804841;
        bh=T7IvSxqxpK1ikItY9Nc9X3zmjDnOnxEZVBeNctXJdR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wv60pxhfF8fPMw8Ohbk+94yatvRWyQe//iuX6vGQ6sLZjkjT/2y+N65n9BBxQ9bW+
         yv9wZAC+yN2nYU5GDBRJ1I8Gel6qM/MUxCNZ7s8ze4W0/RphI3uEN/n1MGXwcHXZb2
         OtsemaGerYDlv8WkjFF0JomAwRCX/HNW2IQ2vU20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 59/96] net: dsa: mt7530: fix handling of BPDUs on MT7530 switch
Date:   Mon, 26 Jun 2023 20:12:14 +0200
Message-ID: <20230626180749.397841575@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit d7c66073559386b836bded7cdc8b66ee5c049129 ]

BPDUs are link-local frames, therefore they must be trapped to the CPU
port. Currently, the MT7530 switch treats BPDUs as regular multicast
frames, therefore flooding them to user ports. To fix this, set BPDUs to be
trapped to the CPU port. Group this on mt7530_setup() and
mt7531_setup_common() into mt753x_trap_frames() and call that.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 4aa3d0cba7b84..f74d9fbd08178 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -993,6 +993,14 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	mutex_unlock(&priv->reg_mutex);
 }
 
+static void
+mt753x_trap_frames(struct mt7530_priv *priv)
+{
+	/* Trap BPDUs to the CPU port(s) */
+	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_BPDU_CPU_ONLY);
+}
+
 static int
 mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 {
@@ -2194,6 +2202,8 @@ mt7530_setup(struct dsa_switch *ds)
 
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
+	mt753x_trap_frames(priv);
+
 	/* Enable and reset MIB counters */
 	mt7530_mib_reset(ds);
 
@@ -2300,8 +2310,8 @@ mt7531_setup_common(struct dsa_switch *ds)
 			   BIT(cpu_dp->index));
 		break;
 	}
-	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
-		   MT753X_BPDU_CPU_ONLY);
+
+	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
 	mt7530_mib_reset(ds);
-- 
2.39.2



