Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF67BBB15
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjJFPBf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjJFPBe (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 6 Oct 2023 11:01:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE427EA
        for <Stable@vger.kernel.org>; Fri,  6 Oct 2023 08:01:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27738C433CA;
        Fri,  6 Oct 2023 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696604492;
        bh=ATg8lgRrjQkqlX/MIwA7EpZowAIo6Wuf2gUu+6WTBMY=;
        h=Subject:To:From:Date:From;
        b=RF34tg1h/2Zg+IE0qghBDDUxhYZEoZBGNS7RzuX2SbojA49QWR3MYmYX+gZNCQaxi
         zeRn3nvnHxIn2YbXRDRZVMOTNDudsoeDCQupGCSg9hYjOwBqWjFki3mZ+NBKB+u+N+
         0ksPGT+yLd3UsPZ5YJRrRy3WTw/nvO8iT37NHOuU=
Subject: patch "iio: light: vcnl4000: Don't power on/off chip in config" added to char-misc-linus
To:     marten.lindahl@axis.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 06 Oct 2023 17:01:08 +0200
Message-ID: <2023100608-follicle-petticoat-0b22@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: light: vcnl4000: Don't power on/off chip in config

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 7e87ab38eed09c9dec56da361d74158159ae84a3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Date: Mon, 11 Sep 2023 14:43:01 +0200
Subject: iio: light: vcnl4000: Don't power on/off chip in config
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling/disabling interrupts on the vcnl4040 chip the als and/or
ps sensor is powered on or off depending on the interrupt enable bits.
This is made as a last step in write_event_config.

But there is no reason to do this as the runtime PM handles the power
state of the sensors. Interfering with this may impact sensor readings.

Consider the following:
 1. Userspace makes sensor data reading which triggers RPM resume
    (sensor powered on) and a RPM suspend timeout. The timeout is 2000ms
    before RPM suspend powers the sensor off if no new reading is made
    within the timeout period.
 2. Userspace disables interrupts => powers sensor off
 3. Userspace reads sensor data = 0 because sensor is off and the
    suspend timeout has not passed. For each new reading made within the
    timeout period the timeout is renewed with 2000ms and RPM will not
    make a new resume (device was not suspended). So the sensor will
    not be powered on.
 4. No further userspace reading for 2000ms ends RPM suspend timeout and
    triggers suspend (powers off already powered off sensor).

Powering sensor off in (2) makes all consecutive readings made within
2000ms to the previous reading (3) return invalid data.

Skip setting power state when writing new event config.

Fixes: 546676121cb9 ("iio: light: vcnl4000: Add interrupt support for vcnl4040")
Fixes: bc292aaf9cb4 ("iio: light: vcnl4000: add illuminance irq vcnl4040/4200")
Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
Link: https://lore.kernel.org/r/20230907-vcnl4000-pm-fix-v2-1-298e01f54db4@axis.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/vcnl4000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 3a52b09c2823..fdf763a04b0b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1513,7 +1513,6 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 
 out:
 	mutex_unlock(&data->vcnl4000_lock);
-	data->chip_spec->set_power_state(data, data->ps_int || data->als_int);
 
 	return ret;
 }
-- 
2.42.0


