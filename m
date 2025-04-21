Return-Path: <stable+bounces-134842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BECA95267
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC853B39DB
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7ABDDBE;
	Mon, 21 Apr 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YIiD6Lkj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C115800
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244232; cv=none; b=kUm3BONORkAadcH5yB44CewZPHKdIpm/jODIQkcQbx+JZCqTFH3NdDTfU3jNtejr+YAlpxu7JTlFOtU0eLdDDtc6Wp2r2urqGng6RwrLNhamrAnKp9clSaOQ6pGpjSSRA8rp/tuSvgIZtHVYRJXDSCwMrHE6rmiU3VSRU/qltMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244232; c=relaxed/simple;
	bh=bVCFBjioCXy5ULTsDtQGs2mEoDIn8QFiPutVwD8m/84=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jnuGX2yzuhtOGbeAwwKnCPUa2QU1w2ZscdI67xnwieN5tXuFvpxALc1Avp5rmfqpGfR2VduotbeyM5GIgpwHVu13GKl4qma8hOKHt2nTFhD5MzWbNcGuCLuMd3lQOjRRFIi8471kVbKj0JqXVldycxAi6OnvPYz1/pVJ4g+A+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YIiD6Lkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B51FC4CEE4;
	Mon, 21 Apr 2025 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745244231;
	bh=bVCFBjioCXy5ULTsDtQGs2mEoDIn8QFiPutVwD8m/84=;
	h=Subject:To:Cc:From:Date:From;
	b=YIiD6LkjUZmnU+RAq9/NtwUAQ5X1yB1hMmJk9pRSMAPlWuK0m6SLLUfuYgnXGvhkt
	 /bObpGQ5mm7bDoYBeZ42/0ZdjPKmhDdoTrww61eZBU5SQ6p/gCxqMzsR+88wnzSwq7
	 T6rfydkFABpW2rTgt+9J7oNxLiEzvbGUzXPJ6bvc=
Subject: FAILED: patch "[PATCH] platform/x86: msi-wmi-platform: Workaround a ACPI firmware" failed to apply to 6.14-stable tree
To: W_Armin@gmx.de,ilpo.jarvinen@linux.intel.com,lkml@antheas.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 16:03:39 +0200
Message-ID: <2025042139-flyable-unexpired-1208@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x baf2f2c2b4c8e1d398173acd4d2fa9131a86b84e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042139-flyable-unexpired-1208@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From baf2f2c2b4c8e1d398173acd4d2fa9131a86b84e Mon Sep 17 00:00:00 2001
From: Armin Wolf <W_Armin@gmx.de>
Date: Mon, 14 Apr 2025 16:04:53 +0200
Subject: [PATCH] platform/x86: msi-wmi-platform: Workaround a ACPI firmware
 bug
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ACPI byte code inside the ACPI control method responsible for
handling the WMI method calls uses a global buffer for constructing
the return value, yet the ACPI control method itself is not marked
as "Serialized".
This means that calling WMI methods on this WMI device is not
thread-safe, as concurrent WMI method calls will corrupt the global
buffer.

Fix this by serializing the WMI method calls using a mutex.

Cc: stable@vger.kernel.org # 6.x.x: 912d614ac99e: platform/x86: msi-wmi-platform: Rename "data" variable
Fixes: 9c0beb6b29e7 ("platform/x86: wmi: Add MSI WMI Platform driver")
Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20250414140453.7691-2-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/Documentation/wmi/devices/msi-wmi-platform.rst b/Documentation/wmi/devices/msi-wmi-platform.rst
index 31a136942892..73197b31926a 100644
--- a/Documentation/wmi/devices/msi-wmi-platform.rst
+++ b/Documentation/wmi/devices/msi-wmi-platform.rst
@@ -138,6 +138,10 @@ input data, the meaning of which depends on the subfeature being accessed.
 The output buffer contains a single byte which signals success or failure (``0x00`` on failure)
 and 31 bytes of output data, the meaning if which depends on the subfeature being accessed.
 
+.. note::
+   The ACPI control method responsible for handling the WMI method calls is not thread-safe.
+   This is a firmware bug that needs to be handled inside the driver itself.
+
 WMI method Get_EC()
 -------------------
 
diff --git a/drivers/platform/x86/msi-wmi-platform.c b/drivers/platform/x86/msi-wmi-platform.c
index e15681dfca8d..dc5e9878cb68 100644
--- a/drivers/platform/x86/msi-wmi-platform.c
+++ b/drivers/platform/x86/msi-wmi-platform.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/device/driver.h>
@@ -17,6 +18,7 @@
 #include <linux/hwmon.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/printk.h>
 #include <linux/rwsem.h>
 #include <linux/types.h>
@@ -76,8 +78,13 @@ enum msi_wmi_platform_method {
 	MSI_PLATFORM_GET_WMI		= 0x1d,
 };
 
-struct msi_wmi_platform_debugfs_data {
+struct msi_wmi_platform_data {
 	struct wmi_device *wdev;
+	struct mutex wmi_lock;	/* Necessary when calling WMI methods */
+};
+
+struct msi_wmi_platform_debugfs_data {
+	struct msi_wmi_platform_data *data;
 	enum msi_wmi_platform_method method;
 	struct rw_semaphore buffer_lock;	/* Protects debugfs buffer */
 	size_t length;
@@ -132,8 +139,9 @@ static int msi_wmi_platform_parse_buffer(union acpi_object *obj, u8 *output, siz
 	return 0;
 }
 
-static int msi_wmi_platform_query(struct wmi_device *wdev, enum msi_wmi_platform_method method,
-				  u8 *input, size_t input_length, u8 *output, size_t output_length)
+static int msi_wmi_platform_query(struct msi_wmi_platform_data *data,
+				  enum msi_wmi_platform_method method, u8 *input,
+				  size_t input_length, u8 *output, size_t output_length)
 {
 	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer in = {
@@ -147,9 +155,15 @@ static int msi_wmi_platform_query(struct wmi_device *wdev, enum msi_wmi_platform
 	if (!input_length || !output_length)
 		return -EINVAL;
 
-	status = wmidev_evaluate_method(wdev, 0x0, method, &in, &out);
-	if (ACPI_FAILURE(status))
-		return -EIO;
+	/*
+	 * The ACPI control method responsible for handling the WMI method calls
+	 * is not thread-safe. Because of this we have to do the locking ourself.
+	 */
+	scoped_guard(mutex, &data->wmi_lock) {
+		status = wmidev_evaluate_method(data->wdev, 0x0, method, &in, &out);
+		if (ACPI_FAILURE(status))
+			return -EIO;
+	}
 
 	obj = out.pointer;
 	if (!obj)
@@ -170,13 +184,13 @@ static umode_t msi_wmi_platform_is_visible(const void *drvdata, enum hwmon_senso
 static int msi_wmi_platform_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 				 int channel, long *val)
 {
-	struct wmi_device *wdev = dev_get_drvdata(dev);
+	struct msi_wmi_platform_data *data = dev_get_drvdata(dev);
 	u8 input[32] = { 0 };
 	u8 output[32];
 	u16 value;
 	int ret;
 
-	ret = msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_FAN, input, sizeof(input), output,
+	ret = msi_wmi_platform_query(data, MSI_PLATFORM_GET_FAN, input, sizeof(input), output,
 				     sizeof(output));
 	if (ret < 0)
 		return ret;
@@ -231,7 +245,7 @@ static ssize_t msi_wmi_platform_write(struct file *fp, const char __user *input,
 		return ret;
 
 	down_write(&data->buffer_lock);
-	ret = msi_wmi_platform_query(data->wdev, data->method, payload, data->length, data->buffer,
+	ret = msi_wmi_platform_query(data->data, data->method, payload, data->length, data->buffer,
 				     data->length);
 	up_write(&data->buffer_lock);
 
@@ -277,17 +291,17 @@ static void msi_wmi_platform_debugfs_remove(void *data)
 	debugfs_remove_recursive(dir);
 }
 
-static void msi_wmi_platform_debugfs_add(struct wmi_device *wdev, struct dentry *dir,
+static void msi_wmi_platform_debugfs_add(struct msi_wmi_platform_data *drvdata, struct dentry *dir,
 					 const char *name, enum msi_wmi_platform_method method)
 {
 	struct msi_wmi_platform_debugfs_data *data;
 	struct dentry *entry;
 
-	data = devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&drvdata->wdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return;
 
-	data->wdev = wdev;
+	data->data = drvdata;
 	data->method = method;
 	init_rwsem(&data->buffer_lock);
 
@@ -298,82 +312,82 @@ static void msi_wmi_platform_debugfs_add(struct wmi_device *wdev, struct dentry
 
 	entry = debugfs_create_file(name, 0600, dir, data, &msi_wmi_platform_debugfs_fops);
 	if (IS_ERR(entry))
-		devm_kfree(&wdev->dev, data);
+		devm_kfree(&drvdata->wdev->dev, data);
 }
 
-static void msi_wmi_platform_debugfs_init(struct wmi_device *wdev)
+static void msi_wmi_platform_debugfs_init(struct msi_wmi_platform_data *data)
 {
 	struct dentry *dir;
 	char dir_name[64];
 	int ret, method;
 
-	scnprintf(dir_name, ARRAY_SIZE(dir_name), "%s-%s", DRIVER_NAME, dev_name(&wdev->dev));
+	scnprintf(dir_name, ARRAY_SIZE(dir_name), "%s-%s", DRIVER_NAME, dev_name(&data->wdev->dev));
 
 	dir = debugfs_create_dir(dir_name, NULL);
 	if (IS_ERR(dir))
 		return;
 
-	ret = devm_add_action_or_reset(&wdev->dev, msi_wmi_platform_debugfs_remove, dir);
+	ret = devm_add_action_or_reset(&data->wdev->dev, msi_wmi_platform_debugfs_remove, dir);
 	if (ret < 0)
 		return;
 
 	for (method = MSI_PLATFORM_GET_PACKAGE; method <= MSI_PLATFORM_GET_WMI; method++)
-		msi_wmi_platform_debugfs_add(wdev, dir, msi_wmi_platform_debugfs_names[method - 1],
+		msi_wmi_platform_debugfs_add(data, dir, msi_wmi_platform_debugfs_names[method - 1],
 					     method);
 }
 
-static int msi_wmi_platform_hwmon_init(struct wmi_device *wdev)
+static int msi_wmi_platform_hwmon_init(struct msi_wmi_platform_data *data)
 {
 	struct device *hdev;
 
-	hdev = devm_hwmon_device_register_with_info(&wdev->dev, "msi_wmi_platform", wdev,
+	hdev = devm_hwmon_device_register_with_info(&data->wdev->dev, "msi_wmi_platform", data,
 						    &msi_wmi_platform_chip_info, NULL);
 
 	return PTR_ERR_OR_ZERO(hdev);
 }
 
-static int msi_wmi_platform_ec_init(struct wmi_device *wdev)
+static int msi_wmi_platform_ec_init(struct msi_wmi_platform_data *data)
 {
 	u8 input[32] = { 0 };
 	u8 output[32];
 	u8 flags;
 	int ret;
 
-	ret = msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_EC, input, sizeof(input), output,
+	ret = msi_wmi_platform_query(data, MSI_PLATFORM_GET_EC, input, sizeof(input), output,
 				     sizeof(output));
 	if (ret < 0)
 		return ret;
 
 	flags = output[MSI_PLATFORM_EC_FLAGS_OFFSET];
 
-	dev_dbg(&wdev->dev, "EC RAM version %lu.%lu\n",
+	dev_dbg(&data->wdev->dev, "EC RAM version %lu.%lu\n",
 		FIELD_GET(MSI_PLATFORM_EC_MAJOR_MASK, flags),
 		FIELD_GET(MSI_PLATFORM_EC_MINOR_MASK, flags));
-	dev_dbg(&wdev->dev, "EC firmware version %.28s\n",
+	dev_dbg(&data->wdev->dev, "EC firmware version %.28s\n",
 		&output[MSI_PLATFORM_EC_VERSION_OFFSET]);
 
 	if (!(flags & MSI_PLATFORM_EC_IS_TIGERLAKE)) {
 		if (!force)
 			return -ENODEV;
 
-		dev_warn(&wdev->dev, "Loading on a non-Tigerlake platform\n");
+		dev_warn(&data->wdev->dev, "Loading on a non-Tigerlake platform\n");
 	}
 
 	return 0;
 }
 
-static int msi_wmi_platform_init(struct wmi_device *wdev)
+static int msi_wmi_platform_init(struct msi_wmi_platform_data *data)
 {
 	u8 input[32] = { 0 };
 	u8 output[32];
 	int ret;
 
-	ret = msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_WMI, input, sizeof(input), output,
+	ret = msi_wmi_platform_query(data, MSI_PLATFORM_GET_WMI, input, sizeof(input), output,
 				     sizeof(output));
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(&wdev->dev, "WMI interface version %u.%u\n",
+	dev_dbg(&data->wdev->dev, "WMI interface version %u.%u\n",
 		output[MSI_PLATFORM_WMI_MAJOR_OFFSET],
 		output[MSI_PLATFORM_WMI_MINOR_OFFSET]);
 
@@ -381,7 +395,8 @@ static int msi_wmi_platform_init(struct wmi_device *wdev)
 		if (!force)
 			return -ENODEV;
 
-		dev_warn(&wdev->dev, "Loading despite unsupported WMI interface version (%u.%u)\n",
+		dev_warn(&data->wdev->dev,
+			 "Loading despite unsupported WMI interface version (%u.%u)\n",
 			 output[MSI_PLATFORM_WMI_MAJOR_OFFSET],
 			 output[MSI_PLATFORM_WMI_MINOR_OFFSET]);
 	}
@@ -391,19 +406,31 @@ static int msi_wmi_platform_init(struct wmi_device *wdev)
 
 static int msi_wmi_platform_probe(struct wmi_device *wdev, const void *context)
 {
+	struct msi_wmi_platform_data *data;
 	int ret;
 
-	ret = msi_wmi_platform_init(wdev);
+	data = devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->wdev = wdev;
+	dev_set_drvdata(&wdev->dev, data);
+
+	ret = devm_mutex_init(&wdev->dev, &data->wmi_lock);
 	if (ret < 0)
 		return ret;
 
-	ret = msi_wmi_platform_ec_init(wdev);
+	ret = msi_wmi_platform_init(data);
 	if (ret < 0)
 		return ret;
 
-	msi_wmi_platform_debugfs_init(wdev);
+	ret = msi_wmi_platform_ec_init(data);
+	if (ret < 0)
+		return ret;
 
-	return msi_wmi_platform_hwmon_init(wdev);
+	msi_wmi_platform_debugfs_init(data);
+
+	return msi_wmi_platform_hwmon_init(data);
 }
 
 static const struct wmi_device_id msi_wmi_platform_id_table[] = {


