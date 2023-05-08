Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0579F6FA3EC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjEHJxH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjEHJxG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C2F24529
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56096614B1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A581C433EF;
        Mon,  8 May 2023 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539582;
        bh=AXJkpZ9JRhjiJl1jigINIdJrv4oj98063XQaj7pNkds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQxoACYgV+w80+npVR99nOwLu9WotM29q0E4znBXJHHZG+0H2SV18sWv2ZixbGqLy
         mWExpsP4EJrpZJfIp8b+v06/I+bONeeWEeby3xOijIc/rpT0CDtd7z7orgKG53dpqr
         eQaksU/D86mPV+TCx0F7+1vXz8chG0zP0uNCD62w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.1 039/611] media: ov8856: Do not check for for module version
Date:   Mon,  8 May 2023 11:38:01 +0200
Message-Id: <20230508094423.089371143@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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


