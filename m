Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0247063FB
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjEQJUn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjEQJUh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 05:20:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBA146BD
        for <stable@vger.kernel.org>; Wed, 17 May 2023 02:20:33 -0700 (PDT)
From:   Christian Gabriel <christian.gabriel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684315232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmQoXk3dPZVPk/NKwlj//MKOheKCkhJUA3FQvVP6Idg=;
        b=d+F7Gx7VYmJ1/wPvck26KWoCadR0fe3MncxmkNAJxAA3L/Rt0u/zkunXuxBhfrr9EVQG+a
        rY4RGb7THld/LFNLruhvnx1r26HAQ+RDnTo18q+Fw5jwms2tvR0+5E9VjX5vrQ2P2c+B6a
        8uv+0d8QUNCXwPGaluY3oDD5FpCqnyN3VLjn27xjUtMSxMqBFKeGB/Fw1xwzRhWPB9w+dZ
        QxAh2d8IVuLbgaYwZ4VkqjT9mWVXhdvXSbdquxFKhROXC1kD5Pv3kGwZYdTbJlGBOvV3oX
        02GW+9HPSVRK7h8AtGRaFf1VmBV6sG5RS8AEJsxAN0Y+Ex9WIued+8+G1v0h+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684315232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmQoXk3dPZVPk/NKwlj//MKOheKCkhJUA3FQvVP6Idg=;
        b=yPSHtvV0/xnp1IqJTAkl7ZUt7JfumKD7NxnmBP/FGt6II3k/SN/y9UfLr8baiZ2SPg4r/D
        XW6RBwbPOhlHhNAA==
To:     Steffen Kothe <steffen.kothe@linutronix.de>
Cc:     review@linutronix.de,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/5] nvmem: core: fix registration vs use race
Date:   Wed, 17 May 2023 11:20:23 +0200
Message-Id: <20230517092024.188665-5-christian.gabriel@linutronix.de>
In-Reply-To: <20230517092024.188665-1-christian.gabriel@linutronix.de>
References: <20230517092024.188665-1-christian.gabriel@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

The i.MX6 CPU frequency driver sometimes fails to register at boot time
due to nvmem_cell_read_u32() sporadically returning -ENOENT.

This happens because there is a window where __nvmem_device_get() in
of_nvmem_cell_get() is able to return the nvmem device, but as cells
have been setup, nvmem_find_cell_entry_by_node() returns NULL.

The occurs because the nvmem core registration code violates one of the
fundamental principles of kernel programming: do not publish data
structures before their setup is complete.

Fix this by making nvmem core code conform with this principle.

Cc: stable@vger.kernel.org
Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Christian Gabriel <christian.gabriel@linutronix.de>
---
 drivers/nvmem/core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 84f4078216a3..6aa8947c4d57 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -418,16 +418,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	device_initialize(&nvmem->dev);
 
-	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
-
-	rval = device_add(&nvmem->dev);
-	if (rval)
-		goto err_put_device;
-
 	if (config->compat) {
 		rval = nvmem_sysfs_setup_compat(nvmem, config);
 		if (rval)
-			goto err_device_del;
+			goto err_put_device;
 	}
 
 	if (config->cells) {
@@ -444,6 +438,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
+
+	rval = device_add(&nvmem->dev);
+	if (rval)
+		goto err_remove_cells;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
@@ -453,8 +453,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
-err_device_del:
-	device_del(&nvmem->dev);
 err_put_device:
 	put_device(&nvmem->dev);
 
-- 
2.30.2

