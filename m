Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309B775DD3
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjHILlm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjHILll (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:41:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501B8173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1C94636A0
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0347C433C7;
        Wed,  9 Aug 2023 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581300;
        bh=Rq4TIkjNywYrrIUVt/Gn1ER0N8t9snhKECXo1UcQkUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDUVDXaiEIZniS8iXp8D9AUP3haMj16BuiAzPhiM3bLnCbTdyBl8ceNurFbzNGSnl
         QrzU6QWCIt5z8FJePML91O6V+9xivFIHlXG1NtQ9GgAhmkqLtSxTQ1+mLMAFLWZU2N
         A4NCUYFYbYPTH/LQ3KuUKAJHN2ZbFGCu68c539/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 149/201] net: netsec: Ignore phy-mode on SynQuacer in DT mode
Date:   Wed,  9 Aug 2023 12:42:31 +0200
Message-ID: <20230809103648.694317927@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ Upstream commit f3bb7759a924713bc54d15f6d0d70733b5935fad ]

As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
property on ACPI systems") the SocioNext SynQuacer platform ships with
firmware defining the PHY mode as RGMII even though the physical
configuration of the PHY is for TX and RX delays.  Since bbc4d71d63549bc
("net: phy: realtek: fix rtl8211e rx/tx delay config") this has caused
misconfiguration of the PHY, rendering the network unusable.

This was worked around for ACPI by ignoring the phy-mode property but
the system is also used with DT.  For DT instead if we're running on a
SynQuacer force a working PHY mode, as well as the standard EDK2
firmware with DT there are also some of these systems that use u-boot
and might not initialise the PHY if not netbooting.  Newer firmware
imagaes for at least EDK2 are available from Linaro so print a warning
when doing this.

Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230731-synquacer-net-v3-1-944be5f06428@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/socionext/netsec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index b9acee214bb6a..bb86315581818 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1845,6 +1845,17 @@ static int netsec_of_probe(struct platform_device *pdev,
 		return err;
 	}
 
+	/*
+	 * SynQuacer is physically configured with TX and RX delays
+	 * but the standard firmware claimed otherwise for a long
+	 * time, ignore it.
+	 */
+	if (of_machine_is_compatible("socionext,developer-box") &&
+	    priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
+		dev_warn(&pdev->dev, "Outdated firmware reports incorrect PHY mode, overriding\n");
+		priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
+	}
+
 	priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
 	if (!priv->phy_np) {
 		dev_err(&pdev->dev, "missing required property 'phy-handle'\n");
-- 
2.40.1



