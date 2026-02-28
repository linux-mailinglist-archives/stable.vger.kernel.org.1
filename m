Return-Path: <stable+bounces-220905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL8NOI9Io2mm/AQAu9opvQ
	(envelope-from <stable+bounces-220905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5441C79BF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B15930E3AE0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B36429E64;
	Sat, 28 Feb 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXiKLlE4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5967429E59;
	Sat, 28 Feb 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300794; cv=none; b=EA3/g+0V+LTktWPh8Brhew7XZlkGeuwPMVGUkVAa9jno5fOBytwFQEz6VXLkDLZzv9ZatdzD3GTVmpXZ8HJsnToIye2sTfyHXh4wCkFmaP7s3t7XFMP8HyMZhnuxUgRzfztj+51QlMwp80ObI7kp33hgckFLuGwHIt0EVL5j52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300794; c=relaxed/simple;
	bh=cs/97a256N680BtD71IFBJGPXwTJYGVdh7qNlNd6X54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAcc95C003DzKX36CBzcFa4D3qXhuTRwj+qMlBBugr6F6laQuCsbxt+/Ja8+JuY+4DepDxuKrYNY0GRWoT6WobzgRnAcOUQ1R7cnZ1j2BjdkbRWLt9ibkO8PvGVoFtE9zAMDdsOZarno4YveajbByDS9RntF6M0J1lFC3843S0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXiKLlE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454FDC19423;
	Sat, 28 Feb 2026 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300793;
	bh=cs/97a256N680BtD71IFBJGPXwTJYGVdh7qNlNd6X54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXiKLlE4rurv/qfPpBsPcDGUm9mAacDEIMKT/VQhVYDWulTL2Y+glQjwSU3IqOZIL
	 d1wvJxa7O1By6RJv8XsSY8F7GUqX/e82hQ6se9+5Jn+iaKvbuwy1PPhtKsG76t+rw/
	 TYByDirquFVN/BppntGWTUOwDIZ4eMozUpG9W/st8CxJ2JpNsE2nZiimxcJMZzVaDI
	 bNsvp2Y6lnpFw8DrGy9AHADpuKWf65u4Ad2AiiBskylXD9ZbIFtjNIEwa46INIn4f/
	 wJnnrwqghHym18Ql7B+pqp4Pxd5eTWJBz3toH4P2mWaaIR/qLp7yGBVKgs9GH5mXtY
	 PhKpa+tvZkimQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 826/844] gpio: sysfs: fix chip removal with GPIOs exported over sysfs
Date: Sat, 28 Feb 2026 12:32:19 -0500
Message-ID: <20260228173244.1509663-827-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220905-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 8D5441C79BF
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 6766f59012301f1bf3f46c6e7149caca45d92309 ]

Currently if we export a GPIO over sysfs and unbind the parent GPIO
controller, the exported attribute will remain under /sys/class/gpio
because once we remove the parent device, we can no longer associate the
descriptor with it in gpiod_unexport() and never drop the final
reference.

Rework the teardown code: provide an unlocked variant of
gpiod_unexport() and remove all exported GPIOs with the sysfs_lock taken
before unregistering the parent device itself. This is done to prevent
any new exports happening before we unregister the device completely.

Cc: stable@vger.kernel.org
Fixes: 1cd53df733c2 ("gpio: sysfs: don't look up exported lines as class devices")
Link: https://patch.msgid.link/20260212133505.81516-1-bartosz.golaszewski@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-sysfs.c | 106 ++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index cd553acf3055e..d4a46a0a37d8f 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -919,63 +919,68 @@ int gpiod_export_link(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(gpiod_export_link);
 
-/**
- * gpiod_unexport - reverse effect of gpiod_export()
- * @desc: GPIO to make unavailable
- *
- * This is implicit on gpiod_free().
- */
-void gpiod_unexport(struct gpio_desc *desc)
+static void gpiod_unexport_unlocked(struct gpio_desc *desc)
 {
 	struct gpiod_data *tmp, *desc_data = NULL;
 	struct gpiodev_data *gdev_data;
 	struct gpio_device *gdev;
 
-	if (!desc) {
-		pr_warn("%s: invalid GPIO\n", __func__);
+	if (!test_bit(GPIOD_FLAG_EXPORT, &desc->flags))
 		return;
-	}
 
-	scoped_guard(mutex, &sysfs_lock) {
-		if (!test_bit(GPIOD_FLAG_EXPORT, &desc->flags))
-			return;
-
-		gdev = gpiod_to_gpio_device(desc);
-		gdev_data = gdev_get_data(gdev);
-		if (!gdev_data)
-			return;
+	gdev = gpiod_to_gpio_device(desc);
+	gdev_data = gdev_get_data(gdev);
+	if (!gdev_data)
+		return;
 
-		list_for_each_entry(tmp, &gdev_data->exported_lines, list) {
-			if (gpiod_is_equal(desc, tmp->desc)) {
-				desc_data = tmp;
-				break;
-			}
+	list_for_each_entry(tmp, &gdev_data->exported_lines, list) {
+		if (gpiod_is_equal(desc, tmp->desc)) {
+			desc_data = tmp;
+			break;
 		}
+	}
 
-		if (!desc_data)
-			return;
+	if (!desc_data)
+		return;
 
-		list_del(&desc_data->list);
-		clear_bit(GPIOD_FLAG_EXPORT, &desc->flags);
+	list_del(&desc_data->list);
+	clear_bit(GPIOD_FLAG_EXPORT, &desc->flags);
 #if IS_ENABLED(CONFIG_GPIO_SYSFS_LEGACY)
-		sysfs_put(desc_data->value_kn);
-		device_unregister(desc_data->dev);
-
-		/*
-		 * Release irq after deregistration to prevent race with
-		 * edge_store.
-		 */
-		if (desc_data->irq_flags)
-			gpio_sysfs_free_irq(desc_data);
+	sysfs_put(desc_data->value_kn);
+	device_unregister(desc_data->dev);
+
+	/*
+	 * Release irq after deregistration to prevent race with
+	 * edge_store.
+	 */
+	if (desc_data->irq_flags)
+		gpio_sysfs_free_irq(desc_data);
 #endif /* CONFIG_GPIO_SYSFS_LEGACY */
 
-		sysfs_remove_groups(desc_data->parent,
-				    desc_data->chip_attr_groups);
-	}
+	sysfs_remove_groups(desc_data->parent,
+			    desc_data->chip_attr_groups);
 
 	mutex_destroy(&desc_data->mutex);
 	kfree(desc_data);
 }
+
+/**
+ * gpiod_unexport - reverse effect of gpiod_export()
+ * @desc: GPIO to make unavailable
+ *
+ * This is implicit on gpiod_free().
+ */
+void gpiod_unexport(struct gpio_desc *desc)
+{
+	if (!desc) {
+		pr_warn("%s: invalid GPIO\n", __func__);
+		return;
+	}
+
+	guard(mutex)(&sysfs_lock);
+
+	gpiod_unexport_unlocked(desc);
+}
 EXPORT_SYMBOL_GPL(gpiod_unexport);
 
 int gpiochip_sysfs_register(struct gpio_device *gdev)
@@ -1054,29 +1059,28 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	struct gpio_desc *desc;
 	struct gpio_chip *chip;
 
-	scoped_guard(mutex, &sysfs_lock) {
-		data = gdev_get_data(gdev);
-		if (!data)
-			return;
+	guard(mutex)(&sysfs_lock);
 
-#if IS_ENABLED(CONFIG_GPIO_SYSFS_LEGACY)
-		device_unregister(data->cdev_base);
-#endif /* CONFIG_GPIO_SYSFS_LEGACY */
-		device_unregister(data->cdev_id);
-		kfree(data);
-	}
+	data = gdev_get_data(gdev);
+	if (!data)
+		return;
 
 	guard(srcu)(&gdev->srcu);
-
 	chip = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (!chip)
 		return;
 
 	/* unregister gpiod class devices owned by sysfs */
 	for_each_gpio_desc_with_flag(chip, desc, GPIOD_FLAG_SYSFS) {
-		gpiod_unexport(desc);
+		gpiod_unexport_unlocked(desc);
 		gpiod_free(desc);
 	}
+
+#if IS_ENABLED(CONFIG_GPIO_SYSFS_LEGACY)
+	device_unregister(data->cdev_base);
+#endif /* CONFIG_GPIO_SYSFS_LEGACY */
+	device_unregister(data->cdev_id);
+	kfree(data);
 }
 
 /*
-- 
2.51.0


