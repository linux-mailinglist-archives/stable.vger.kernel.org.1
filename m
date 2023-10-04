Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12CE7B8761
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbjJDSEk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbjJDSEj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:04:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5300DA7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:04:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986DFC433C7;
        Wed,  4 Oct 2023 18:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442676;
        bh=e/ZOhKi+uJzwu3s+23MWtiwP84fYqA8U2cWOU/e+nyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygTBQfHwbzwQ/cf3aGwWqvhKm+QzwNneuI+IlArq+m38wS92Ol8MX/AwTX//rU/PH
         CanoN5tG8sOKTYJ09zJLbBHACsGmzBvULs65+2dxQvDC0HJJ5iHDPQFV9NW2hB8AgJ
         pPlhbcWPzIBWP1lecWlgnQk6e9jRJEnlZBDEVeOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Evan Green <evgreen@chromium.org>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 070/183] =?UTF-8?q?i2c:=20mux:=20gpio:=C2=A0Replace=20custom=20acpi=5Fget?= =?UTF-8?q?=5Flocal=5Faddress()?=
Date:   Wed,  4 Oct 2023 19:55:01 +0200
Message-ID: <20231004175206.811986852@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 379920f5c013c49e0a740634972faf77e26d4ac3 ]

Recently ACPI gained the acpi_get_local_address() API which may be used
instead of home grown i2c_mux_gpio_get_acpi_adr().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Acked-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: db6aee6083a5 ("i2c: mux: gpio: Add missing fwnode_handle_put()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 43 ++------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index bac415a52b780..31e6eb1591bb9 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -49,45 +49,6 @@ static int i2c_mux_gpio_deselect(struct i2c_mux_core *muxc, u32 chan)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-
-static int i2c_mux_gpio_get_acpi_adr(struct device *dev,
-				     struct fwnode_handle *fwdev,
-				     unsigned int *adr)
-
-{
-	unsigned long long adr64;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(ACPI_HANDLE_FWNODE(fwdev),
-				       METHOD_NAME__ADR,
-				       NULL, &adr64);
-
-	if (!ACPI_SUCCESS(status)) {
-		dev_err(dev, "Cannot get address\n");
-		return -EINVAL;
-	}
-
-	*adr = adr64;
-	if (*adr != adr64) {
-		dev_err(dev, "Address out of range\n");
-		return -ERANGE;
-	}
-
-	return 0;
-}
-
-#else
-
-static int i2c_mux_gpio_get_acpi_adr(struct device *dev,
-				     struct fwnode_handle *fwdev,
-				     unsigned int *adr)
-{
-	return -EINVAL;
-}
-
-#endif
-
 static int i2c_mux_gpio_probe_fw(struct gpiomux *mux,
 				 struct platform_device *pdev)
 {
@@ -141,9 +102,9 @@ static int i2c_mux_gpio_probe_fw(struct gpiomux *mux,
 			fwnode_property_read_u32(child, "reg", values + i);
 
 		} else if (is_acpi_node(child)) {
-			rc = i2c_mux_gpio_get_acpi_adr(dev, child, values + i);
+			rc = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), values + i);
 			if (rc)
-				return rc;
+				return dev_err_probe(dev, rc, "Cannot get address\n");
 		}
 
 		i++;
-- 
2.40.1



