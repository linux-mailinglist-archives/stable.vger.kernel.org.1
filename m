Return-Path: <stable+bounces-43663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC62A8C4278
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3195CB22BF3
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB40153502;
	Mon, 13 May 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FDlM+mQJ"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BB1E497
	for <Stable@vger.kernel.org>; Mon, 13 May 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608117; cv=none; b=fky2Vttzh8RrwfkNwm19jqNa9giQJvrUA49i8de7JYtPZkWFj8Ah5mv/obHcEiDNkX0LJ83YFe3u9ewERPURY9BckzpFWm4fm/mehcXj99JxDNUXKKqPLJiHWTXtdtXcLXpqU8m6jGsF4UdK5cmFS9yZYLSoA/Z2XLRnrV6Prwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608117; c=relaxed/simple;
	bh=7Fzb4RVBVYbn1tNTt5oBFJvc6wk4wR8abuMIb5Gyk7g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gh2v0Pcu/YkALb3zf/5wbbUYJWH9splPWQ3CdWke7j8jVs4+gYAFiVHqVZhE+3dkeg9mCbyIr5GWZ7emxzavngc07JE8Sl4tWLkCLztyImav22wFvygVYQsyknofxlvF+YxF60Tm9LCXO3+6W13YA1CtvJJW9M2Di3aiYqIejy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FDlM+mQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ECBC32782;
	Mon, 13 May 2024 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608116;
	bh=7Fzb4RVBVYbn1tNTt5oBFJvc6wk4wR8abuMIb5Gyk7g=;
	h=Subject:To:Cc:From:Date:From;
	b=FDlM+mQJOocDyOJK5Zvu56ThDu6MxMZh6s5GuAC/6W/Jwy9kWDLI4bn7S5h7OE1GP
	 zZo+hRGihTrwYe/c8ox3/u/Q9616/CUI7JQd00z5ivj++3lkftJVlqP9d90RoLtyvm
	 FTaT27/7rGz+3h1Z55tI8DwbqwaijhqcAexs3POE=
Subject: FAILED: patch "[PATCH] iio: accel: mxc4005: Reset chip on probe() and resume()" failed to apply to 6.1-stable tree
To: hdegoede@redhat.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:48:22 +0200
Message-ID: <2024051321-finishing-applause-7489@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6b8cffdc4a31e4a72f75ecd1bc13fbf0dafee390
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051321-finishing-applause-7489@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6b8cffdc4a31 ("iio: accel: mxc4005: Reset chip on probe() and resume()")
57a1592784d6 ("iio: accel: mxc4005: Interrupt handling fixes")
4d7c16d08d24 ("iio: accel: mxc4005: allow module autoloading via OF compatible")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b8cffdc4a31e4a72f75ecd1bc13fbf0dafee390 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Mar 2024 12:37:00 +0100
Subject: [PATCH] iio: accel: mxc4005: Reset chip on probe() and resume()

On some designs the chip is not properly reset when powered up at boot or
after a suspend/resume cycle.

Use the sw-reset feature to ensure that the chip is in a clean state
after probe() / resume() and in the case of resume() restore the settings
(scale, trigger-enabled).

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218578
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240326113700.56725-3-hdegoede@redhat.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 111f4bcf24ad..63c3566a533b 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
@@ -36,6 +37,7 @@
 
 #define MXC4005_REG_INT_CLR1		0x01
 #define MXC4005_REG_INT_CLR1_BIT_DRDYC	0x01
+#define MXC4005_REG_INT_CLR1_SW_RST	0x10
 
 #define MXC4005_REG_CONTROL		0x0D
 #define MXC4005_REG_CONTROL_MASK_FSR	GENMASK(6, 5)
@@ -43,6 +45,9 @@
 
 #define MXC4005_REG_DEVICE_ID		0x0E
 
+/* Datasheet does not specify a reset time, this is a conservative guess */
+#define MXC4005_RESET_TIME_US		2000
+
 enum mxc4005_axis {
 	AXIS_X,
 	AXIS_Y,
@@ -66,6 +71,8 @@ struct mxc4005_data {
 		s64 timestamp __aligned(8);
 	} scan;
 	bool trigger_enabled;
+	unsigned int control;
+	unsigned int int_mask1;
 };
 
 /*
@@ -349,6 +356,7 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
 		return ret;
 	}
 
+	data->int_mask1 = val;
 	data->trigger_enabled = state;
 	mutex_unlock(&data->mutex);
 
@@ -384,6 +392,13 @@ static int mxc4005_chip_init(struct mxc4005_data *data)
 
 	dev_dbg(data->dev, "MXC4005 chip id %02x\n", reg);
 
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
+			   MXC4005_REG_INT_CLR1_SW_RST);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "resetting chip\n");
+
+	fsleep(MXC4005_RESET_TIME_US);
+
 	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
 	if (ret < 0)
 		return dev_err_probe(data->dev, ret, "writing INT_MASK0\n");
@@ -479,6 +494,58 @@ static int mxc4005_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static int mxc4005_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mxc4005_data *data = iio_priv(indio_dev);
+	int ret;
+
+	/* Save control to restore it on resume */
+	ret = regmap_read(data->regmap, MXC4005_REG_CONTROL, &data->control);
+	if (ret < 0)
+		dev_err(data->dev, "failed to read reg_control\n");
+
+	return ret;
+}
+
+static int mxc4005_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mxc4005_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
+			   MXC4005_REG_INT_CLR1_SW_RST);
+	if (ret) {
+		dev_err(data->dev, "failed to reset chip: %d\n", ret);
+		return ret;
+	}
+
+	fsleep(MXC4005_RESET_TIME_US);
+
+	ret = regmap_write(data->regmap, MXC4005_REG_CONTROL, data->control);
+	if (ret) {
+		dev_err(data->dev, "failed to restore control register\n");
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
+	if (ret) {
+		dev_err(data->dev, "failed to restore interrupt 0 mask\n");
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1, data->int_mask1);
+	if (ret) {
+		dev_err(data->dev, "failed to restore interrupt 1 mask\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mxc4005_pm_ops, mxc4005_suspend, mxc4005_resume);
+
 static const struct acpi_device_id mxc4005_acpi_match[] = {
 	{"MXC4005",	0},
 	{"MXC6655",	0},
@@ -506,6 +573,7 @@ static struct i2c_driver mxc4005_driver = {
 		.name = MXC4005_DRV_NAME,
 		.acpi_match_table = mxc4005_acpi_match,
 		.of_match_table = mxc4005_of_match,
+		.pm = pm_sleep_ptr(&mxc4005_pm_ops),
 	},
 	.probe		= mxc4005_probe,
 	.id_table	= mxc4005_id,


