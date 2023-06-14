Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6D713E1A
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjE1TcD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjE1TcC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E3E1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD89F61D93
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07784C433EF;
        Sun, 28 May 2023 19:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302318;
        bh=GLV1C1ErYgkvYT2GwjdOFnXlIsgHmDCo7sn7f3Hgii8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZ3usvkjufTQGARj4KB0dsJ0Xf0jVHNUhe+mgEY1A3uSi0TbE/tFiyEGdmQx9bwdv
         vWTCj9I8pyOt06PtiRYoI/enrSJyvP4lrsi+n/zFaDR+MemgvBE6/jy0ImAmS7bEVg
         Www7cYi+84umanOuatRXXPWS+JD7JsJZih5bacn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.3 086/127] power: supply: bq25890: Call power_supply_changed() after updating input current or voltage
Date:   Sun, 28 May 2023 20:11:02 +0100
Message-Id: <20230528190839.140549212@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
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

commit ad3d9c779b1f09f3f3a6fefd07af407c7bc7c9a7 upstream.

The bq25892 model relies on external charger-type detection and once
that is done the bq25890_charger code will update the input current
and if pumpexpress is used also the input voltage.

In this case, when the initial power_supply_changed() call is made
from the interrupt handler, the input settings are 5V/0.5A which
on many devices is not enough power to charge (while the device is on).

On many devices the fuel-gauge relies in its external_power_changed
callback to timely signal userspace about charging <-> discharging
status changes. Add a power_supply_changed() call after updating
the input current or voltage. This allows the fuel-gauge driver
to timely recheck if the battery is charging after the new input
settings have been applied and then it can immediately notify
userspace about this.

Fixes: 48f45b094dbb ("power: supply: bq25890: Support higher charging voltages through Pump Express+ protocol")
Fixes: eab25b4f93aa ("power: supply: bq25890: On the bq25892 set the IINLIM based on external charger detection")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/bq25890_charger.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -775,6 +775,7 @@ static void bq25890_charger_external_pow
 	}
 
 	bq25890_field_write(bq, F_IINLIM, input_current_limit);
+	power_supply_changed(psy);
 }
 
 static int bq25890_get_chip_state(struct bq25890_device *bq,
@@ -1106,6 +1107,8 @@ static void bq25890_pump_express_work(st
 	dev_info(bq->dev, "Hi-voltage charging requested, input voltage is %d mV\n",
 		 voltage);
 
+	power_supply_changed(bq->charger);
+
 	return;
 error_print:
 	bq25890_field_write(bq, F_PUMPX_EN, 0);


