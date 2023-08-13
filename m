Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212977ABC7
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjHMVZj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjHMVZj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384310E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 969D66294C
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBADC433CC;
        Sun, 13 Aug 2023 21:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961940;
        bh=IaQdm7LkzryXjbAwr34+oFh68C878eWILHgPQlw6Jhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1GjZo0GVr7qXT8HO5LjjE7KWJ3FByNC6bji1r26jAJ0Zk9L7CKHZTu3lLYpFH4B08
         CNkBVTGuzD56fkUrtOjSorSmm9nGzkbfFdI+aq/VDLoste0Q+2zzUXS5YYIoKOtGgm
         OL6fFukWxRA7Q3UnCpM2yqquoY40qNuWsL8mW3aY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tao Ren <rentao.bupt@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.4 053/206] hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100
Date:   Sun, 13 Aug 2023 23:17:03 +0200
Message-ID: <20230813211726.534282460@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

commit f38963b9cd0645a336cf30c5da2e89e34e34fec3 upstream.

Skip status check for both pfe1100 and pfe3000 because the communication
error is also observed on pfe1100 devices.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Fixes: 626bb2f3fb3c hwmon: (pmbus) add driver for BEL PFE1100 and PFE3000
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230804221403.28931-1-rentao.bupt@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/bel-pfe.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/hwmon/pmbus/bel-pfe.c
+++ b/drivers/hwmon/pmbus/bel-pfe.c
@@ -17,12 +17,13 @@
 enum chips {pfe1100, pfe3000};
 
 /*
- * Disable status check for pfe3000 devices, because some devices report
- * communication error (invalid command) for VOUT_MODE command (0x20)
- * although correct VOUT_MODE (0x16) is returned: it leads to incorrect
- * exponent in linear mode.
+ * Disable status check because some devices report communication error
+ * (invalid command) for VOUT_MODE command (0x20) although the correct
+ * VOUT_MODE (0x16) is returned: it leads to incorrect exponent in linear
+ * mode.
+ * This affects both pfe3000 and pfe1100.
  */
-static struct pmbus_platform_data pfe3000_plat_data = {
+static struct pmbus_platform_data pfe_plat_data = {
 	.flags = PMBUS_SKIP_STATUS_CHECK,
 };
 
@@ -94,16 +95,15 @@ static int pfe_pmbus_probe(struct i2c_cl
 	int model;
 
 	model = (int)i2c_match_id(pfe_device_id, client)->driver_data;
+	client->dev.platform_data = &pfe_plat_data;
 
 	/*
 	 * PFE3000-12-069RA devices may not stay in page 0 during device
 	 * probe which leads to probe failure (read status word failed).
 	 * So let's set the device to page 0 at the beginning.
 	 */
-	if (model == pfe3000) {
-		client->dev.platform_data = &pfe3000_plat_data;
+	if (model == pfe3000)
 		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
-	}
 
 	return pmbus_do_probe(client, &pfe_driver_info[model]);
 }


