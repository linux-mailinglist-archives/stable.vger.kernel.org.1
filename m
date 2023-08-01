Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435076AFAC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjHAJtt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjHAJt2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BE92D5D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E51D61509
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1F8C433C9;
        Tue,  1 Aug 2023 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883290;
        bh=dl9so49zX5+pwokDGFm0VI8GY1mht+rVIs0ov3NRTUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nE5EVTcLCj5VaRUHWy5Zu4PPXO8lUQRdEe21rF757ngP3sH8fWC6mdcTjoIJDTBch
         VT12j+oxP+j7g71mID8y1gisbXJUNqVeniKZEdS13vsIfkZQI4wNZLapJ/Lc5r+ACU
         LtDwQdWmrgBzTZZ5hriiw69TgfxfSyt/RFvVarJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.4 183/239] hwmon: (pmbus_core) Fix NULL pointer dereference
Date:   Tue,  1 Aug 2023 11:20:47 +0200
Message-ID: <20230801091932.268596440@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

commit 0bd66784274a287beada2933c2c0fa3a0ddae0d7 upstream.

Pass i2c_client to _pmbus_is_enabled to drop the assumption
that a regulator device is passed in.

This will fix the issue of a NULL pointer dereference when called from
_pmbus_get_flags.

Fixes: df5f6b6af01c ("hwmon: (pmbus/core) Generalise pmbus get status")
Cc: stable@vger.kernel.org # v6.4
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Link: https://lore.kernel.org/r/20230725125428.3966803-2-Naresh.Solanki@9elements.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/pmbus_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 42fb7286805b..30aeb59062a5 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2745,9 +2745,8 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
 	},
 };
 
-static int _pmbus_is_enabled(struct device *dev, u8 page)
+static int _pmbus_is_enabled(struct i2c_client *client, u8 page)
 {
-	struct i2c_client *client = to_i2c_client(dev->parent);
 	int ret;
 
 	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
@@ -2758,14 +2757,13 @@ static int _pmbus_is_enabled(struct device *dev, u8 page)
 	return !!(ret & PB_OPERATION_CONTROL_ON);
 }
 
-static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
+static int __maybe_unused pmbus_is_enabled(struct i2c_client *client, u8 page)
 {
-	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	int ret;
 
 	mutex_lock(&data->update_lock);
-	ret = _pmbus_is_enabled(dev, page);
+	ret = _pmbus_is_enabled(client, page);
 	mutex_unlock(&data->update_lock);
 
 	return ret;
@@ -2844,7 +2842,7 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
 	if (status < 0)
 		return status;
 
-	if (_pmbus_is_enabled(dev, page)) {
+	if (_pmbus_is_enabled(client, page)) {
 		if (status & PB_STATUS_OFF) {
 			*flags |= REGULATOR_ERROR_FAIL;
 			*event |= REGULATOR_EVENT_FAIL;
@@ -2898,7 +2896,10 @@ static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsi
 #if IS_ENABLED(CONFIG_REGULATOR)
 static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
 {
-	return pmbus_is_enabled(rdev_get_dev(rdev), rdev_get_id(rdev));
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+
+	return pmbus_is_enabled(client, rdev_get_id(rdev));
 }
 
 static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
-- 
2.41.0



