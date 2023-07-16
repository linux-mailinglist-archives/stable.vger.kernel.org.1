Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572DF75543B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGPU2F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGPU2E (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF03BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAA660E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41900C433C8;
        Sun, 16 Jul 2023 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539282;
        bh=nAGxizrJ1pgVm6a4R4Y70MTLSdUnbCFnc1q7DrFlZZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFZI0wFtI8Qaab1tgQhKtb1fU7+N4R7EhjosdtFSNcub29d08pyysDn0bsXJd+W/b
         MLU3SIeY6qehsJiFBDLvawc00JsB8sKQybLdUCwUTsxfse5DbPlHdsw+ANcvB6G0Nz
         JQawwtw++2UIvYx+ZiH1J886d8By4grDbd86q8gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 6.4 751/800] usb: typec: ucsi: Mark dGPUs as DEVICE scope
Date:   Sun, 16 Jul 2023 21:50:04 +0200
Message-ID: <20230716195006.566940940@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit a7fbfd44c0204f0629288edfd0d77829edb4a2f8 upstream.

power_supply_is_system_supplied() checks whether any power
supplies are present that aren't batteries to decide whether
the system is running on DC or AC.  Downstream drivers use
this to make performance decisions.

Navi dGPUs include an UCSI function that has been exported
since commit 17631e8ca2d3 ("i2c: designware: Add driver
support for AMD NAVI GPU").

This UCSI function registers a power supply since commit
992a60ed0d5e ("usb: typec: ucsi: register with power_supply class")
but this is not a system power supply.

As the power supply for a dGPU is only for powering devices connected
to dGPU, create a device property to indicate that the UCSI endpoint
is only for the scope of `POWER_SUPPLY_SCOPE_DEVICE`.

Link: https://lore.kernel.org/lkml/20230516182541.5836-2-mario.limonciello@amd.com/
Reviewed-by: Evan Quan <evan.quan@amd.com>
Tested-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c |   13 ++++++++++++-
 drivers/i2c/busses/i2c-nvidia-gpu.c        |    3 +++
 drivers/usb/typec/ucsi/psy.c               |   14 ++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
+#include <linux/power_supply.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
@@ -234,6 +235,16 @@ static const struct dev_pm_ops i2c_dw_pm
 	SET_RUNTIME_PM_OPS(i2c_dw_pci_runtime_suspend, i2c_dw_pci_runtime_resume, NULL)
 };
 
+static const struct property_entry dgpu_properties[] = {
+	/* USB-C doesn't power the system */
+	PROPERTY_ENTRY_U8("scope", POWER_SUPPLY_SCOPE_DEVICE),
+	{}
+};
+
+static const struct software_node dgpu_node = {
+	.properties = dgpu_properties,
+};
+
 static int i2c_dw_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -325,7 +336,7 @@ static int i2c_dw_pci_probe(struct pci_d
 	}
 
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU) {
-		dev->slave = i2c_new_ccgx_ucsi(&dev->adapter, dev->irq, NULL);
+		dev->slave = i2c_new_ccgx_ucsi(&dev->adapter, dev->irq, &dgpu_node);
 		if (IS_ERR(dev->slave))
 			return dev_err_probe(dev->dev, PTR_ERR(dev->slave),
 					     "register UCSI failed\n");
--- a/drivers/i2c/busses/i2c-nvidia-gpu.c
+++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/power_supply.h>
 
 #include <asm/unaligned.h>
 
@@ -261,6 +262,8 @@ MODULE_DEVICE_TABLE(pci, gpu_i2c_ids);
 static const struct property_entry ccgx_props[] = {
 	/* Use FW built for NVIDIA GPU only */
 	PROPERTY_ENTRY_STRING("firmware-name", "nvidia,gpu"),
+	/* USB-C doesn't power the system */
+	PROPERTY_ENTRY_U8("scope", POWER_SUPPLY_SCOPE_DEVICE),
 	{ }
 };
 
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -27,8 +27,20 @@ static enum power_supply_property ucsi_p
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_SCOPE,
 };
 
+static int ucsi_psy_get_scope(struct ucsi_connector *con,
+			      union power_supply_propval *val)
+{
+	u8 scope = POWER_SUPPLY_SCOPE_UNKNOWN;
+	struct device *dev = con->ucsi->dev;
+
+	device_property_read_u8(dev, "scope", &scope);
+	val->intval = scope;
+	return 0;
+}
+
 static int ucsi_psy_get_online(struct ucsi_connector *con,
 			       union power_supply_propval *val)
 {
@@ -194,6 +206,8 @@ static int ucsi_psy_get_prop(struct powe
 		return ucsi_psy_get_current_max(con, val);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		return ucsi_psy_get_current_now(con, val);
+	case POWER_SUPPLY_PROP_SCOPE:
+		return ucsi_psy_get_scope(con, val);
 	default:
 		return -EINVAL;
 	}


