Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2073529C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjFSKgn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjFSKgU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2AD18C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF1860B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BE0C433C8;
        Mon, 19 Jun 2023 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170977;
        bh=QRkO86VZ+1mSyUquvznmlow2pQTKnNJ8Z72lt8SS5aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xd5L4+CjYYn8XYuP8hz6yI4YP0Cx+p6SG+wvAAAlNAHAqJ1WOqJcWlhZmAqZc4HXa
         Clk1AvBv8kXX9XmStn2F7f81D4uaClx5tlisGTBcaTy/B2qerJ2COIYjv07lNj1iE8
         98x9SY7qLymxSV99b+pE8u8fIdGETcZ3pcrhNQZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6.3 104/187] usb: gadget: udc: renesas_usb3: Fix RZ/V2M {modprobe,bind} error
Date:   Mon, 19 Jun 2023 12:28:42 +0200
Message-ID: <20230619102202.604229965@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3e6ac852fbc71a234de24b5455086f6b98d3d958 upstream.

Currently {modprobe, bind} after {rmmod, unbind} results in probe failure.

genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs. 00000004 (85070400.usb3drd)
renesas_usb3: probe of 85070000.usb3peri failed with error -16

The reason is, it is trying to register an interrupt handler for the same
IRQ twice. The devm_request_irq() was called with the parent device.
So the interrupt handler won't be unregistered when the usb3-peri device
is unbound.

Fix this issue by replacing "parent dev"->"dev" as the irq resource
is managed by this driver.

Fixes: 9cad72dfc556 ("usb: gadget: Add support for RZ/V2M USB3DRD driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Message-ID: <20230530161720.179927-1-biju.das.jz@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/renesas_usb3.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2898,9 +2898,9 @@ static int renesas_usb3_probe(struct pla
 		struct rzv2m_usb3drd *ddata = dev_get_drvdata(pdev->dev.parent);
 
 		usb3->drd_reg = ddata->reg;
-		ret = devm_request_irq(ddata->dev, ddata->drd_irq,
+		ret = devm_request_irq(&pdev->dev, ddata->drd_irq,
 				       renesas_usb3_otg_irq, 0,
-				       dev_name(ddata->dev), usb3);
+				       dev_name(&pdev->dev), usb3);
 		if (ret < 0)
 			return ret;
 	}


