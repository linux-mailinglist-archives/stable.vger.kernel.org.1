Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9224726FC9
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbjFGVBr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjFGVBU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:01:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA8A2130
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBA016491A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF666C433EF;
        Wed,  7 Jun 2023 21:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171663;
        bh=FYJR6qWSJWlnYbwYLYW3Kfbp2BqXiYtyYtr+SGGnWy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9wvDIMRBWHu2grE6gadd17fEHeUzT8FpVuMEN8tZmWCmjU/fs9z2gxJTeFdWgJyZ
         mtfFOBr3kIkOVTEI7Qy2ydt+5NjfpPzILeifpY7ee4kyipXz0TMuqj2YQa4J1p+4Ol
         X2lQ4FMge8TUuLL6aJva6LhSTuzlyCha3cHzgmiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 103/159] iio: light: vcnl4035: fixed chip ID check
Date:   Wed,  7 Jun 2023 22:16:46 +0200
Message-ID: <20230607200907.053406872@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frank Li <Frank.Li@nxp.com>

commit a551c26e8e568fad42120843521529241b9bceec upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/vcnl4035.c |    3 +++
 1 file changed, 3 insertions(+)

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
@@ -413,6 +415,7 @@ static int vcnl4035_init(struct vcnl4035
 		return ret;
 	}
 
+	id = FIELD_GET(VCNL4035_DEV_ID_MASK, id);
 	if (id != VCNL4035_DEV_ID_VAL) {
 		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
 			id, VCNL4035_DEV_ID_VAL);


