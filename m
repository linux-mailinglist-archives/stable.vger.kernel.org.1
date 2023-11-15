Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC407ED0CF
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjKOT5n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbjKOT5l (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:57:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5612C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:57:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7450EC433C8;
        Wed, 15 Nov 2023 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078257;
        bh=Sk6cwpoTXpFAQxAn12ZZpcGYhWAOmqwv72byA9TYz/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijE/p57JkJCHDlkUOKRGSgtJU//G4DMW44zXluQLiPg/KSOAWnkFYPpkSJwAx6Zca
         WDDp3FbAg2Fm9aEXJOh05WS2F9V8VG1SJe94HbElafAaqC1EV1JH23Y2v3qT2UM9kZ
         hFj2rpwWhgzuIBfzhc3y/Y4m0eEYef8BEjsEF5qU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danny Kaehn <danny.kaehn@plexus.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 209/379] hid: cp2112: Fix duplicate workqueue initialization
Date:   Wed, 15 Nov 2023 14:24:44 -0500
Message-ID: <20231115192657.474659552@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danny Kaehn <danny.kaehn@plexus.com>

[ Upstream commit e3c2d2d144c082dd71596953193adf9891491f42 ]

Previously the cp2112 driver called INIT_DELAYED_WORK within
cp2112_gpio_irq_startup, resulting in duplicate initilizations of the
workqueue on subsequent IRQ startups following an initial request. This
resulted in a warning in set_work_data in workqueue.c, as well as a rare
NULL dereference within process_one_work in workqueue.c.

Initialize the workqueue within _probe instead.

Fixes: 13de9cca514e ("HID: cp2112: add IRQ chip handling")
Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-cp2112.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 27cadadda7c9d..86e0861caf7ca 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1159,8 +1159,6 @@ static unsigned int cp2112_gpio_irq_startup(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cp2112_device *dev = gpiochip_get_data(gc);
 
-	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
-
 	if (!dev->gpio_poll) {
 		dev->gpio_poll = true;
 		schedule_delayed_work(&dev->gpio_poll_worker, 0);
@@ -1356,6 +1354,8 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	girq->handler = handle_simple_irq;
 	girq->threaded = true;
 
+	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
+
 	ret = gpiochip_add_data(&dev->gc, dev);
 	if (ret < 0) {
 		hid_err(hdev, "error registering gpio chip\n");
-- 
2.42.0



