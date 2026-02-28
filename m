Return-Path: <stable+bounces-221194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC7wEAhOo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-221194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:20:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B14A81C83D5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 941FE3255772
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A77347D931;
	Sat, 28 Feb 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov9hI3m/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B9375226;
	Sat, 28 Feb 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301551; cv=none; b=lck0+Hy+uxnkwvCKkszG7tNxKWa4QeTsJyodoZcNcoSxeaVVFbkNfqX7BG3Q9zySFPq6JT8yEZ43gcM4aCTs82p8qMDinMviBmXrrgKe0MOoH7oJBQJIlA5CR3UJSb4rzAbJoqdhvB9/EggvSYEsiQb8ogKgWJJnrR0lfNgfBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301551; c=relaxed/simple;
	bh=k1DnN2Hm2VVazC3n3KjivJWVQHEahzdU2aXAU7qCdv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdHKI0cDL3PyOTqnaqemE5Zb/11dcZ6YmQc5HyNQXMQfnNK0c0ggkqh2tAGqFdUz1rfU9bH6WnfqyaBxJMj3wD6QttoQWDpWgo0jEiCVsfr4VNB9wMiZVfwHyVD/vkzWJzFeGXgsG+AgU/74BGtrbKx8ehcPfI1Al2eEUF+6snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov9hI3m/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B04C19423;
	Sat, 28 Feb 2026 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301551;
	bh=k1DnN2Hm2VVazC3n3KjivJWVQHEahzdU2aXAU7qCdv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ov9hI3m/yIwNJxOW8QNaQAnif6aRcm2Vu08a9txf/QEXG5C4lXdJBpQ7Qf/GzS3pL
	 IiHuo/akqK+EHC/t/Z2TtnjLiR5MyaWTydrV0raf+3RMPbmFNpQo3iLugo/NcTY9jQ
	 pongonxWXtQJkOM2W5UDqtz09HWlNbq9b3mdtjvtz70wvSsWWv1PEWNmJ4TcZHZSEt
	 uFgscZexIbIiHq5ku0On4pR/XaFcGKgB5g5rOvX+aSkEHuoq0F4Mc+NNVbAD3uZe2N
	 58R6SkntbAz/iQHxKnfjjzCiQjdAGcZir8iiW4dK48MZU4mYeZYbct/2faKzhICih2
	 WE0CqgduBtROw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 734/752] gpio: sysfs: fix chip removal with GPIOs exported over sysfs
Date: Sat, 28 Feb 2026 12:47:25 -0500
Message-ID: <20260228174750.1542406-734-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221194-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: B14A81C83D5
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
index 7d5fc1ea2aa54..e044690ad412b 100644
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


