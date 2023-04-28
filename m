Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB046F16AC
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbjD1L3X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbjD1L3X (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733EB55A3
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1046A61315
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2148EC433EF;
        Fri, 28 Apr 2023 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681361;
        bh=u2ImX3bGwlWGqc/nfLy2Ar/BmZ9LM3hO0uhSXRbR+/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVi5oYCajm9skPmtggBgSwLamIn8aKAX3SY7XiozaB9ikvaHh3K3wh3+44koRj4St
         on00J4EvoAjaeye0BTpR8yQNUg8XQLW4x5uhsckCVyTs7b1OyBXMRh97zwJzsV/HWK
         VcTXulnO8ZB8UN90PZl6VlRDNHJjepicKL13ivTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 02/16] phy: phy-brcm-usb: Utilize platform_get_irq_byname_optional()
Date:   Fri, 28 Apr 2023 13:27:54 +0200
Message-Id: <20230428112040.138768041@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
References: <20230428112040.063291126@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 53bffe0055741440a6c91abb80bad1c62ea443e3 upstream.

The wake-up interrupt lines are entirely optional, avoid printing
messages that interrupts were not found by switching to the _optional
variant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Justin Chen <justinpopo6@gmail.com>
Link: https://lore.kernel.org/r/20221026224450.2958762-1-f.fainelli@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/broadcom/phy-brcm-usb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -445,9 +445,9 @@ static int brcm_usb_phy_dvr_init(struct
 		priv->suspend_clk = NULL;
 	}
 
-	priv->wake_irq = platform_get_irq_byname(pdev, "wake");
+	priv->wake_irq = platform_get_irq_byname_optional(pdev, "wake");
 	if (priv->wake_irq < 0)
-		priv->wake_irq = platform_get_irq_byname(pdev, "wakeup");
+		priv->wake_irq = platform_get_irq_byname_optional(pdev, "wakeup");
 	if (priv->wake_irq >= 0) {
 		err = devm_request_irq(dev, priv->wake_irq,
 				       brcm_usb_phy_wake_isr, 0,


