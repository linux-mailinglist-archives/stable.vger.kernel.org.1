Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54407ED6C0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbjKOWDV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbjKOWDS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:03:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B081A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:03:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED626C433C9;
        Wed, 15 Nov 2023 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085795;
        bh=Cahiath/kNRqhlR4593vQcDmlikxZ4n8IgKfhiVzGBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBu5MSeXTP8N28eSlt8LBNbl1JiV3NxJF215oIsnkvzddYSw/j5fHGEjfJhbHHcSh
         aBm4abcOYoiALHICtM/FHeoGo4yON84wb1+wqcMzIm1eanoQEZISFeQrurQrlDRig4
         z2EPgTKKhV93rMIT8lju7yRTeTU/PUQqL8yo28yM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danny Kaehn <danny.kaehn@plexus.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 058/119] hid: cp2112: Fix duplicate workqueue initialization
Date:   Wed, 15 Nov 2023 17:00:48 -0500
Message-ID: <20231115220134.425991397@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index f2ff244c6b106..648201b6c624d 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1156,8 +1156,6 @@ static unsigned int cp2112_gpio_irq_startup(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cp2112_device *dev = gpiochip_get_data(gc);
 
-	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
-
 	if (!dev->gpio_poll) {
 		dev->gpio_poll = true;
 		schedule_delayed_work(&dev->gpio_poll_worker, 0);
@@ -1353,6 +1351,8 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_simple_irq;
 
+	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
+
 	ret = gpiochip_add_data(&dev->gc, dev);
 	if (ret < 0) {
 		hid_err(hdev, "error registering gpio chip\n");
-- 
2.42.0



