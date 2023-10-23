Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D56C7D307B
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjJWK7N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjJWK7M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 06:59:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76EED7A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 03:59:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EDDC433CA;
        Mon, 23 Oct 2023 10:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058750;
        bh=O3mbqYE7nbvTezNo2wXsUM7cWK8Wd/3/mdbcR8n83qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1QCdRYS2pfXNM4JDePxS7io5TkJ8yLV5RvaA9PEblDEEYIFKE51xMM+LCk/mveSZ
         jPIm6tZPmsBZQke7g3i32PSF1mzUpnZN78hs3EzZjXJjcus6xuoOPFEYiYQJ+7Zhkg
         oZLi4Gg9Pd+faUnthveaWJ68G/luxaD0DvVYABMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 14/66] iio: pressure: bmp280: Fix NULL pointer exception
Date:   Mon, 23 Oct 2023 12:56:04 +0200
Message-ID: <20231023104811.320665489@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Elwell <phil@raspberrypi.com>

commit 85dfb43bf69281adb1f345dfd9a39faf2e5a718d upstream.

The bmp085 EOC IRQ support is optional, but the driver's common probe
function queries the IRQ properties whether or not it exists, which
can trigger a NULL pointer exception. Avoid any exception by making
the query conditional on the possession of a valid IRQ.

Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20230811155829.51208-1-phil@raspberrypi.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/pressure/bmp280-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1050,7 +1050,7 @@ int bmp280_common_probe(struct device *d
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
+	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
 			goto out_disable_vdda;


