Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A9713C8C
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjE1TQH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjE1TQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AB5C7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFD1619A2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B50CC433EF;
        Sun, 28 May 2023 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301364;
        bh=+VJuZYN8GXBCTtABmfOokaNG2dH20Sluq0G1PTNnJsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ksv1Lu1lAEejtl7GLVeRn2+gPTun96zfeQ2ffnvnnef+Ml5JG42TaHjf+LHjD3vlb
         3ANYV3zptG2T5zElhQ5odlXesjAg+tWodMPLlOzIgNjyzNmA+8SqiuMWW6A7oEtQMN
         w7sqhhpY2/2Vtnqry1HpodoSWzgZFyzN7/pkrJbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.14 80/86] power: supply: bq27xxx: Fix I2C IRQ race on remove
Date:   Sun, 28 May 2023 20:10:54 +0100
Message-Id: <20230528190831.609348916@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
References: <20230528190828.564682883@linuxfoundation.org>
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
@@ -187,7 +187,7 @@ static int bq27xxx_battery_i2c_probe(str
 	i2c_set_clientdata(client, di);
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = request_threaded_irq(client->irq,
 				NULL, bq27xxx_battery_irq_handler_thread,
 				IRQF_ONESHOT,
 				di->name, di);
@@ -217,6 +217,7 @@ static int bq27xxx_battery_i2c_remove(st
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
+	free_irq(client->irq, di);
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);


