Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE57CDB3E
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjJRMGC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 08:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjJRMGB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 08:06:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC3114
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 05:05:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FA8C433C7;
        Wed, 18 Oct 2023 12:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697630759;
        bh=PaY8FycMXyGe0XsysnNSEMcHX0l6NjLlBS80VcGhGuM=;
        h=From:To:Cc:Subject:Date:From;
        b=dSPxrgPNDf/JV2ZFsJwQgB/z68XvxF2jnHRF2sdcpIWH4meOZo/0TwhQbxNstyRyj
         2LuRCQIRSlD4kQ4vsXY3MIZlGxBciqk7s5MZUVd/46AO0WD3y/muVWio1rHR3yOLH9
         nl/pzSuBLQ/6Fnb67U3nXGQ2Drlvws8oMSFKhTb2T1UM5x31zsNyhIfyFK5GvuQCY7
         rIu+lMRm/xyviFwHGM9lgs+OdG0Vf3WKJzrakcSzgl0eRWYj4CP4BWWaA20aRZ9Nq6
         8iCBJehcfbov7xPKt3z3+xRxBn+khqvznp6nHbKQFKI/tQsOjDI54e9t9MyC+bUb93
         HUzkZCicPb6jg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4.19.y 1/3] driver: platform: Add helper for safer setting of driver_override
Date:   Wed, 18 Oct 2023 13:05:46 +0100
Message-ID: <20231018120552.2110677-1-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 6c2f421174273de8f83cde4286d1c076d43a2d35 upstream.

Several core drivers and buses expect that driver_override is a
dynamically allocated memory thus later they can kfree() it.

However such assumption is not documented, there were in the past and
there are already users setting it to a string literal. This leads to
kfree() of static memory during device release (e.g. in error paths or
during unbind):

    kernel BUG at ../mm/slub.c:3960!
    Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
    ...
    (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
    (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
    (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
    (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
    (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
    (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
    (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
    (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
    (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
    (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
    (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
    (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
    (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
    (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
    (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
    (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
    (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)

Provide a helper which clearly documents the usage of driver_override.
This will allow later to reuse the helper and reduce the amount of
duplicated code.

Convert the platform driver to use a new helper and make the
driver_override field const char (it is not modified by the core).

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220419113435.246203-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/base/driver.c           | 69 +++++++++++++++++++++++++++++++++
 drivers/base/platform.c         | 28 ++-----------
 include/linux/device.h          |  2 +
 include/linux/platform_device.h |  6 ++-
 4 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 857c8f1b876e5..668c6c8c22f1f 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -29,6 +29,75 @@ static struct device *next_device(struct klist_iter *i)
 	return dev;
 }
 
+/**
+ * driver_set_override() - Helper to set or clear driver override.
+ * @dev: Device to change
+ * @override: Address of string to change (e.g. &device->driver_override);
+ *            The contents will be freed and hold newly allocated override.
+ * @s: NUL-terminated string, new driver name to force a match, pass empty
+ *     string to clear it ("" or "\n", where the latter is only for sysfs
+ *     interface).
+ * @len: length of @s
+ *
+ * Helper to set or clear driver override in a device, intended for the cases
+ * when the driver_override field is allocated by driver/bus code.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len)
+{
+	const char *new, *old;
+	char *cp;
+
+	if (!override || !s)
+		return -EINVAL;
+
+	/*
+	 * The stored value will be used in sysfs show callback (sysfs_emit()),
+	 * which has a length limit of PAGE_SIZE and adds a trailing newline.
+	 * Thus we can store one character less to avoid truncation during sysfs
+	 * show.
+	 */
+	if (len >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (!len) {
+		/* Empty string passed - clear override */
+		device_lock(dev);
+		old = *override;
+		*override = NULL;
+		device_unlock(dev);
+		kfree(old);
+
+		return 0;
+	}
+
+	cp = strnchr(s, len, '\n');
+	if (cp)
+		len = cp - s;
+
+	new = kstrndup(s, len, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	device_lock(dev);
+	old = *override;
+	if (cp != s) {
+		*override = new;
+	} else {
+		/* "\n" passed - clear override */
+		kfree(new);
+		*override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(driver_set_override);
+
 /**
  * driver_for_each_device - Iterator for devices bound to a driver.
  * @drv: Driver we're iterating.
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 2f89e618b142c..a09e7a681f7a7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -891,31 +891,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	char *driver_override, *old, *cp;
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 37e359d81a86f..bccd367c11de5 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -330,6 +330,8 @@ extern int __must_check driver_create_file(struct device_driver *driver,
 extern void driver_remove_file(struct device_driver *driver,
 			       const struct driver_attribute *attr);
 
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len);
 extern int __must_check driver_for_each_device(struct device_driver *drv,
 					       struct device *start,
 					       void *data,
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 9e5c98fcea8c6..8268439975b21 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -29,7 +29,11 @@ struct platform_device {
 	struct resource	*resource;
 
 	const struct platform_device_id	*id_entry;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	/* MFD cell pointer */
 	struct mfd_cell *mfd_cell;
-- 
2.42.0.655.g421f12c284-goog

