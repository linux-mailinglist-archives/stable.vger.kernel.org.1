Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C853713D74
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjE1TZd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjE1TZc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34878BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD63D61BF5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDEEC433D2;
        Sun, 28 May 2023 19:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301930;
        bh=qPw+/eNpcMNiyXLrKB0z9cpPtu2GilE4emWYw2iRPMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLg/O5c0XYHzWwtEc09m5PFqlZY9bvkMUExEt5hZkt/hvOXLiGNwDIS58HEhVX8dB
         515bEYFkF75XoBNioZU2dPNfaiwvyYC+RykfPvi46YqYlbQp1F7jVsdIw6BiNRyg1y
         Y1WyDB0zpi7ZYX3Hn/FU+8DetW6dBROtRL5o02Xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.4 092/161] can: kvaser_pciefd: Call request_irq() before enabling interrupts
Date:   Sun, 28 May 2023 20:10:16 +0100
Message-Id: <20230528190840.042434711@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -1823,6 +1823,11 @@ static int kvaser_pciefd_probe(struct pc
 	if (err)
 		goto err_teardown_can_ctrls;
 
+	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
+			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
+	if (err)
+		goto err_teardown_can_ctrls;
+
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
 
@@ -1843,11 +1848,6 @@ static int kvaser_pciefd_probe(struct pc
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


