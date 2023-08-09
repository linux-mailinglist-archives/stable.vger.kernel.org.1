Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7E775B7E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjHILSD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjHILSD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E3E1724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9441A63158
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7927C433CC;
        Wed,  9 Aug 2023 11:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579882;
        bh=1tTUMOrtH4t8FeyFBPR6ECdpDSgokq1hd0pzlKF9KLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bd/qEF1KfkvcPaCBMo4D0jj50pBDfAtPoCJ3ijAyIrOe6uc5w4RMNvBKOo0eR1ky6
         +BYGbwg7K7z0IHQzi1MEve7pdY0Gbx8faEtx1zBuno9TNo+6Objd2IQD3Zye7U0PjA
         R6Mlsmw1RjcrZMbwXY5blaz0BTKqfiKIKJ0Eloac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 150/323] pinctrl: amd: Fix mistake in handling clearing pins at startup
Date:   Wed,  9 Aug 2023 12:39:48 +0200
Message-ID: <20230809103705.024293747@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit a855724dc08b8cb0c13ab1e065a4922f1e5a7552 upstream.

commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe")
had a mistake in loop iteration 63 that it would clear offset 0xFC instead
of 0x100.  Offset 0xFC is actually `WAKE_INT_MASTER_REG`.  This was
clearing bits 13 and 15 from the register which significantly changed the
expected handling for some platforms for GPIO0.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217315
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230421120625.3366-3-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -794,9 +794,9 @@ static void amd_gpio_irq_init(struct amd
 
 		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
-		pin_reg = readl(gpio_dev->base + i * 4);
+		pin_reg = readl(gpio_dev->base + pin * 4);
 		pin_reg &= ~mask;
-		writel(pin_reg, gpio_dev->base + i * 4);
+		writel(pin_reg, gpio_dev->base + pin * 4);
 
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 	}


