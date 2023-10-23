Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3877D31D4
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjJWLNo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjJWLNo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:13:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3755BA4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:13:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750C5C433C8;
        Mon, 23 Oct 2023 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059621;
        bh=ujHTTZezBnBZFcFZeEHPTHALu6NSm7VyDeKTjVQ75SA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MS/zGO08Jh3ebg36bPp2bkUp+JlaNk4qshEpsOMibbDKgMyhYjvMWEP1LZbRlZhSi
         YJVCeQBP0rpBrfqp/hx6Y1kAbqdRuyNfWWrwWohCaPv+nT42ncYoECFDuazXEWbpVi
         VZRNCX/cEIZhLMPxWK+OfoE7O1IJ3uRkMwDVz+ns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ferry Toth <ftoth@exalondelft.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.5 212/241] gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()
Date:   Mon, 23 Oct 2023 12:56:38 +0200
Message-ID: <20231023104839.017756748@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 479ac419206b5fe4ce4e40de61ac3210a36711aa upstream.

When refactoring the acpi_get_gpiod_from_data() the change missed
cleaning up the variable on stack. Add missing memset().

Reported-by: Ferry Toth <ftoth@exalondelft.nl>
Fixes: 16ba046e86e9 ("gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fbda452fb4d6..51e41676de0b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -951,6 +951,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
 	if (!propname)
 		return ERR_PTR(-EINVAL);
 
+	memset(&lookup, 0, sizeof(lookup));
 	lookup.index = index;
 
 	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
-- 
2.42.0



