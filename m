Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA86713C21
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjE1TFN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjE1TFJ (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF0C7
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F933618BF
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F124C4339B;
        Sun, 28 May 2023 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300707;
        bh=6c0ePsoJjhjkRTU2GdeGoHJ9zzmQiscto2TZP2yKmZk=;
        h=Subject:To:From:Date:From;
        b=kK0FiQTH80LXtJZxFOG8uOuoqlfw9xR7vVfl4MrbK0ylSaAML8D7m33/HM5RZXT67
         MhKpubF9PbedEpGNAxDGQo/7L9ijkI9JOZSZDKxU9g3rl0y7kzoYWqUBHJNhbqLudN
         Ngk3a2Qh0aHW2OQSKWcwH3fRsM8+d8u2ZqrwgC6M=
Subject: patch "iio: light: vcnl4035: fixed chip ID check" added to char-misc-linus
To:     Frank.Li@nxp.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:39 +0100
Message-ID: <2023052839-tainted-canine-1a6d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


This is a note to let you know that I've just added the patch titled

    iio: light: vcnl4035: fixed chip ID check

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a551c26e8e568fad42120843521529241b9bceec Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 1 May 2023 10:36:04 -0400
Subject: iio: light: vcnl4035: fixed chip ID check

VCNL4035 register(0xE) ID_L and ID_M define as:

 ID_L: 0x80
 ID_H: 7:6 (0:0)
       5:4 (0:0) slave address = 0x60 (7-bit)
           (0:1) slave address = 0x51 (7-bit)
           (1:0) slave address = 0x40 (7-bit)
           (1:0) slave address = 0x41 (7-bit)
       3:0 Version code default	(0:0:0:0)

So just check ID_L.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20230501143605.1615549-1-Frank.Li@nxp.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/vcnl4035.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 14e29330e972..94f5d611e98c 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -8,6 +8,7 @@
  * TODO: Proximity
  */
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -42,6 +43,7 @@
 #define VCNL4035_ALS_PERS_MASK		GENMASK(3, 2)
 #define VCNL4035_INT_ALS_IF_H_MASK	BIT(12)
 #define VCNL4035_INT_ALS_IF_L_MASK	BIT(13)
+#define VCNL4035_DEV_ID_MASK		GENMASK(7, 0)
 
 /* Default values */
 #define VCNL4035_MODE_ALS_ENABLE	BIT(0)
@@ -413,6 +415,7 @@ static int vcnl4035_init(struct vcnl4035_data *data)
 		return ret;
 	}
 
+	id = FIELD_GET(VCNL4035_DEV_ID_MASK, id);
 	if (id != VCNL4035_DEV_ID_VAL) {
 		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
 			id, VCNL4035_DEV_ID_VAL);
-- 
2.40.1


