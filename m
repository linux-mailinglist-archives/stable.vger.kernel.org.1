Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D417BE1A1
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377449AbjJINwT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377424AbjJINwT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:52:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF694
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:52:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92AAC433C7;
        Mon,  9 Oct 2023 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859538;
        bh=O/RX0D7+8c+vzrhYY+eL1aw7BS5w+P8H0Kk+CrQD8kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZrYUdJ11BYm090ZEkJ1mCvpY9HqJbeox5oGZ46K0QN7x56+mWVrgtJjvu+PI9XwH
         fxw7hCSbZO5CUJTxZWcIGn+KBxqvbakl2KIqvOBCpeMxtAUVn5v17se/BgVS1ERNMq
         M9vnSHv12gRpFqJ9hSwAJB5s/vMeGl32O5hCWIsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 4.19 53/91] i2c: i801: unregister tco_pdev in i801_probe() error path
Date:   Mon,  9 Oct 2023 15:06:25 +0200
Message-ID: <20231009130113.355009249@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 3914784553f68c931fc666dbe7e86fe881aada38 upstream.

We have to unregister tco_pdev also if i2c_add_adapter() fails.

Fixes: 9424693035a5 ("i2c: i801: Create iTCO device on newer Intel PCHs")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-i801.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1679,6 +1679,7 @@ static int i801_probe(struct pci_dev *de
 		"SMBus I801 adapter at %04lx", priv->smba);
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
+		platform_device_unregister(priv->tco_pdev);
 		i801_acpi_remove(priv);
 		return err;
 	}


