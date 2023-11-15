Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C937ECF1B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjKOTqZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjKOTqY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254AA189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94796C433C7;
        Wed, 15 Nov 2023 19:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077580;
        bh=eLQoQzRnWqdKlfC2FkiKPSiYwsGHNYhZgrjgnNPEQVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uiD2VqEX+Xe9hRUdguWD/Wy6fRfPdCkW9QjXyx/QVSnMNsA/DrCTkw04ySSGNOIJ+
         M0h/vepfSp0+cBNXHKk7IDGsy07iR3dnbYzH4g2LUeJmQrLit65odyMoeDe4LBPkRf
         YVrY9IrAPF1oKpiLXalSizhtND6hUb2FxgWdZ1gE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danny Kaehn <danny.kaehn@plexus.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 389/603] hid: cp2112: Fix IRQ shutdown stopping polling for all IRQs on chip
Date:   Wed, 15 Nov 2023 14:15:34 -0500
Message-ID: <20231115191640.115606443@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danny Kaehn <danny.kaehn@plexus.com>

[ Upstream commit dc3115e6c5d9863ec1a9ff1acf004ede93c34361 ]

Previously cp2112_gpio_irq_shutdown() always cancelled the
gpio_poll_worker, even if other IRQs were still active, and did not set
the gpio_poll flag to false. This resulted in any call to _shutdown()
resulting in interrupts no longer functioning on the chip until a
_remove() occurred (a.e. the cp2112 is unplugged or system rebooted).

Only cancel polling if all IRQs are disabled/masked, and correctly set
the gpio_poll flag, allowing polling to restart when an interrupt is
next enabled.

Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
Fixes: 13de9cca514e ("HID: cp2112: add IRQ chip handling")
Link: https://lore.kernel.org/r/20231011182317.1053344-1-danny.kaehn@plexus.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-cp2112.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 36f76c6dfa202..20a0d1315d90f 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1166,7 +1166,11 @@ static void cp2112_gpio_irq_shutdown(struct irq_data *d)
 	struct cp2112_device *dev = gpiochip_get_data(gc);
 
 	cp2112_gpio_irq_mask(d);
-	cancel_delayed_work_sync(&dev->gpio_poll_worker);
+
+	if (!dev->irq_mask) {
+		dev->gpio_poll = false;
+		cancel_delayed_work_sync(&dev->gpio_poll_worker);
+	}
 }
 
 static int cp2112_gpio_irq_type(struct irq_data *d, unsigned int type)
-- 
2.42.0



