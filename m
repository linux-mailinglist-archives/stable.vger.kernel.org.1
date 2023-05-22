Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB5470C812
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjEVTfl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjEVTfh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7AE196
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFC8161FF1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2012C433EF;
        Mon, 22 May 2023 19:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784052;
        bh=8vu415bm7cRMTv6jb4cllI2JnLcimu50U+uPxJ2hhJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKc8Kdw1P+2cK1Hmzfk7eRdodrn2vfPlZdGPkEO5/Yg1hFAiTFcT2xK9rWslLHhGI
         Awr9uWlV1ibyYfQGhddJpsxibWSJpoG7OwEfNAG570svc+Srhz4NjNCK/KKZrau6uX
         fehi0l/FVLGA6zdCKlzJ5o78L4aueT7yWBaxr60k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1 248/292] can: kvaser_pciefd: Call request_irq() before enabling interrupts
Date:   Mon, 22 May 2023 20:10:05 +0100
Message-Id: <20230522190412.147894432@linuxfoundation.org>
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

From: Jimmy Assarsson <extja@kvaser.com>

commit 84762d8da89d29ba842317eb842973e628c27391 upstream.

Make sure the interrupt handler is registered before enabling interrupts.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/r/20230516134318.104279-4-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/kvaser_pciefd.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1825,6 +1825,11 @@ static int kvaser_pciefd_probe(struct pc
 	if (err)
 		goto err_teardown_can_ctrls;
 
+	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
+			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
+	if (err)
+		goto err_teardown_can_ctrls;
+
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
 
@@ -1845,11 +1850,6 @@ static int kvaser_pciefd_probe(struct pc
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
 
-	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
-			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
-	if (err)
-		goto err_teardown_can_ctrls;
-
 	err = kvaser_pciefd_reg_candev(pcie);
 	if (err)
 		goto err_free_irq;


