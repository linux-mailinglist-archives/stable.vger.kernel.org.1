Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D186FA9DF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjEHK4f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjEHK4S (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:56:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A0830AD1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE7066299C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E30C433D2;
        Mon,  8 May 2023 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543314;
        bh=AXJkpZ9JRhjiJl1jigINIdJrv4oj98063XQaj7pNkds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMl8I8LNpp+4PItlN8NS1NS5CjU4fjfSENFoEc/ZRvb6cwyH4y85qzITdJ42Ae30P
         CLpdafguUjztdkyTFTkeY0Ohwk7SCpw9PqJlm2vK9cJoJmba7/6CeKu8oPGB+sKtxx
         KoafKBJpDy115UR8H7lp3zCHx2hdZizBq2e6u2hE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.3 020/694] media: ov8856: Do not check for for module version
Date:   Mon,  8 May 2023 11:37:35 +0200
Message-Id: <20230508094433.288314439@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ricardo Ribalda <ribalda@chromium.org>

commit 5a4e1b5aed2a36a10d6a3b30fafb6b3bf41c3186 upstream.

It the device is probed in non-zero ACPI D state, the module
identification is delayed until the first streamon.

The module identification has two parts: deviceID and version. To rea
the version we have to enable OTP read. This cannot be done during
streamon, becase it modifies REG_MODE_SELECT.

Since the driver has the same behaviour for all the module versions, do
not read the module version from the sensor's OTP.

Cc: stable@vger.kernel.org
Fixes: 0e014f1a8d54 ("media: ov8856: support device probe in non-zero ACPI D state")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov8856.c |   40 ----------------------------------------
 1 file changed, 40 deletions(-)

--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -1709,46 +1709,6 @@ static int ov8856_identify_module(struct
 		return -ENXIO;
 	}
 
-	ret = ov8856_write_reg(ov8856, OV8856_REG_MODE_SELECT,
-			       OV8856_REG_VALUE_08BIT, OV8856_MODE_STREAMING);
-	if (ret)
-		return ret;
-
-	ret = ov8856_write_reg(ov8856, OV8856_OTP_MODE_CTRL,
-			       OV8856_REG_VALUE_08BIT, OV8856_OTP_MODE_AUTO);
-	if (ret) {
-		dev_err(&client->dev, "failed to set otp mode");
-		return ret;
-	}
-
-	ret = ov8856_write_reg(ov8856, OV8856_OTP_LOAD_CTRL,
-			       OV8856_REG_VALUE_08BIT,
-			       OV8856_OTP_LOAD_CTRL_ENABLE);
-	if (ret) {
-		dev_err(&client->dev, "failed to enable load control");
-		return ret;
-	}
-
-	ret = ov8856_read_reg(ov8856, OV8856_MODULE_REVISION,
-			      OV8856_REG_VALUE_08BIT, &val);
-	if (ret) {
-		dev_err(&client->dev, "failed to read module revision");
-		return ret;
-	}
-
-	dev_info(&client->dev, "OV8856 revision %x (%s) at address 0x%02x\n",
-		 val,
-		 val == OV8856_2A_MODULE ? "2A" :
-		 val == OV8856_1B_MODULE ? "1B" : "unknown revision",
-		 client->addr);
-
-	ret = ov8856_write_reg(ov8856, OV8856_REG_MODE_SELECT,
-			       OV8856_REG_VALUE_08BIT, OV8856_MODE_STANDBY);
-	if (ret) {
-		dev_err(&client->dev, "failed to exit streaming mode");
-		return ret;
-	}
-
 	ov8856->identified = true;
 
 	return 0;


