Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E986FACAF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjEHL1C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjEHL0s (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0EA3B7AB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F4E62D22
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5582C433D2;
        Mon,  8 May 2023 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545198;
        bh=osggGEj4JKsmz6/Dvz6kPG2mchpBugrtqzbtUMynS+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NiFB0mJLasstvRw5LyIFEN/iHMKAWNtPF58ZyZRo+ZiK7Sa6HGNOql7QTPC9gqGeZ
         h+zFg5q/kkJ8wRMogOtPcjHyK9ZqRm+BXBXnkWARolLQnmd9kpvcD37eq0/mFOhCkr
         DSPKdX0nzoOU8xchnlSCuNQUrCYZGyZvcwavbu5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 657/694] pinctrl-bcm2835.c: fix race condition when setting gpio dir
Date:   Mon,  8 May 2023 11:48:12 +0200
Message-Id: <20230508094457.297080441@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit b7badd752de05312fdb1aeb388480f706d0c087f ]

In the past setting the pin direction called pinctrl_gpio_direction()
which uses a mutex to serialize this. That was changed to set the
direction directly in the pin controller driver, but that lost the
serialization mechanism. Since the direction of multiple pins are in
the same register you can have a race condition, something that was
in fact observed with the cec-gpio driver.

Add a new spinlock to serialize writing to the FSEL registers.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Fixes: 1a4541b68e25 ("pinctrl-bcm2835: don't call pinctrl_gpio_direction()")
Link: https://lore.kernel.org/r/4302b66b-ca20-0f19-d2aa-ee8661118863@xs4all.nl
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 8e2551a08c372..7435173e10f43 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -90,6 +90,8 @@ struct bcm2835_pinctrl {
 	struct pinctrl_gpio_range gpio_range;
 
 	raw_spinlock_t irq_lock[BCM2835_NUM_BANKS];
+	/* Protect FSEL registers */
+	spinlock_t fsel_lock;
 };
 
 /* pins are just named GPIO0..GPIO53 */
@@ -284,14 +286,19 @@ static inline void bcm2835_pinctrl_fsel_set(
 		struct bcm2835_pinctrl *pc, unsigned pin,
 		enum bcm2835_fsel fsel)
 {
-	u32 val = bcm2835_gpio_rd(pc, FSEL_REG(pin));
-	enum bcm2835_fsel cur = (val >> FSEL_SHIFT(pin)) & BCM2835_FSEL_MASK;
+	u32 val;
+	enum bcm2835_fsel cur;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pc->fsel_lock, flags);
+	val = bcm2835_gpio_rd(pc, FSEL_REG(pin));
+	cur = (val >> FSEL_SHIFT(pin)) & BCM2835_FSEL_MASK;
 
 	dev_dbg(pc->dev, "read %08x (%u => %s)\n", val, pin,
-			bcm2835_functions[cur]);
+		bcm2835_functions[cur]);
 
 	if (cur == fsel)
-		return;
+		goto unlock;
 
 	if (cur != BCM2835_FSEL_GPIO_IN && fsel != BCM2835_FSEL_GPIO_IN) {
 		/* always transition through GPIO_IN */
@@ -309,6 +316,9 @@ static inline void bcm2835_pinctrl_fsel_set(
 	dev_dbg(pc->dev, "write %08x (%u <= %s)\n", val, pin,
 			bcm2835_functions[fsel]);
 	bcm2835_gpio_wr(pc, FSEL_REG(pin), val);
+
+unlock:
+	spin_unlock_irqrestore(&pc->fsel_lock, flags);
 }
 
 static int bcm2835_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -1248,6 +1258,7 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 	pc->gpio_chip = *pdata->gpio_chip;
 	pc->gpio_chip.parent = dev;
 
+	spin_lock_init(&pc->fsel_lock);
 	for (i = 0; i < BCM2835_NUM_BANKS; i++) {
 		unsigned long events;
 		unsigned offset;
-- 
2.39.2



