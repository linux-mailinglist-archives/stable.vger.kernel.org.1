Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69B761580
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjGYL3p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjGYL3o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:29:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F09F2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B3A61648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFDDC433C7;
        Tue, 25 Jul 2023 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284581;
        bh=fu8CJD/THZTXHNlEh0mtEDWCdNvQyzUavi+Geh1wHzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpdkJvqPNKQoO9w1XAro0wtKL9lWO0xcj6TvGEd3vlfq+kRN/NKJ5XCJcy8DKeBRF
         qK1ea599IU5GV/rKlmuyu/kRoeD/Eph6Uw3R8XrUgxeG4BiJJXNto+fN1epYeU/dQu
         qan6JBTOVGyQeQAJHUnc3YVAQI50FYbstFYaKGaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jan Visser <starquake@linuxeverywhere.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.10 379/509] pinctrl: amd: Only use special debounce behavior for GPIO 0
Date:   Tue, 25 Jul 2023 12:45:18 +0200
Message-ID: <20230725104611.080188347@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 0d5ace1a07f7e846d0f6d972af60d05515599d0b upstream.

It's uncommon to use debounce on any other pin, but technically
we should only set debounce to 0 when working off GPIO0.

Cc: stable@vger.kernel.org
Tested-by: Jan Visser <starquake@linuxeverywhere.org>
Fixes: 968ab9261627 ("pinctrl: amd: Detect internal GPIO0 debounce handling")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230705133005.577-2-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -128,9 +128,11 @@ static int amd_gpio_set_debounce(struct
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
 	/* Use special handling for Pin0 debounce */
-	pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
-	if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
-		debounce = 0;
+	if (offset == 0) {
+		pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+		if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
+			debounce = 0;
+	}
 
 	pin_reg = readl(gpio_dev->base + offset * 4);
 


