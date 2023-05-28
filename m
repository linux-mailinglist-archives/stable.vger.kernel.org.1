Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A7713EB6
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjE1TiI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjE1TiH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CACAB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D203861E6D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB2DC433D2;
        Sun, 28 May 2023 19:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302685;
        bh=hrgivyb+sD5/81uys1LLnydphck7HBVNV63SYJ2emn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8jLbczeGNFfUsWt59XHTrZIHU8M/P9bQwefx9U5zOMcQCcC4sQCURcwEa6YZgtZB
         Krckh4eQx9mQvBCbMH1mIYmDz5Imqq/nSL3YJtxF0ap+juebHHG2IjT+V4NgIk3yi5
         +FSI/71baCwKL1vXaYUn5Zph+N3aj2i/+LEKVgJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.1 076/119] power: supply: bq27xxx: Fix I2C IRQ race on remove
Date:   Sun, 28 May 2023 20:11:16 +0100
Message-Id: <20230528190838.047196273@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 444ff00734f3878cd54ddd1ed5e2e6dbea9326d5 upstream.

devm_request_threaded_irq() requested IRQs are only free-ed after
the driver's remove function has ran. So the IRQ could trigger and
call bq27xxx_battery_update() after bq27xxx_battery_teardown() has
already run.

Switch to explicitly free-ing the IRQ in bq27xxx_battery_i2c_remove()
to fix this.

Fixes: 8807feb91b76 ("power: bq27xxx_battery: Add interrupt handling support")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/bq27xxx_battery_i2c.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -179,7 +179,7 @@ static int bq27xxx_battery_i2c_probe(str
 	i2c_set_clientdata(client, di);
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = request_threaded_irq(client->irq,
 				NULL, bq27xxx_battery_irq_handler_thread,
 				IRQF_ONESHOT,
 				di->name, di);
@@ -209,6 +209,7 @@ static void bq27xxx_battery_i2c_remove(s
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
+	free_irq(client->irq, di);
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);


