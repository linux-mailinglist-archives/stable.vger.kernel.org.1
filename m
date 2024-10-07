Return-Path: <stable+bounces-81227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663BA99280D
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7A828180E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644318CC0A;
	Mon,  7 Oct 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fvc70dH8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A441741E0
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293235; cv=none; b=MZ1LdfkqCRd4BBSw/E6TvHji1zFYjSSgGB+uHfwGDvtkO99CFrpKeSFxTx917Un0Ec/E3o2PLe00QZhiVE/KpFkbfs3EB9WaS8tu72X6LQRFsoIJCngVSvfLuPKs9OfaLTxxlteKZjpKV2QZ4L4M6zqH40a5Y2eztpBv/WScV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293235; c=relaxed/simple;
	bh=A+RPNifFqXmtQsdEdXdUWwI5tkU0NZG+Sggv80gvsdk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mTeYqcWAnOX+0qoVdyMn8V3o5seh26wW+V+dipuux+iKRhaj3NRSx8/5ktrfRENP61miF/5bd4STbnFxASJBH43qdEOZjP0vu28ow9c/rsDP54nweUUBZ4/DVHIUiU0B40Dk41PiOVHqXxjE0DU9TnJeWaijzd6wM0AvT0vLdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fvc70dH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D06C4CEC6;
	Mon,  7 Oct 2024 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728293235;
	bh=A+RPNifFqXmtQsdEdXdUWwI5tkU0NZG+Sggv80gvsdk=;
	h=Subject:To:Cc:From:Date:From;
	b=fvc70dH8/yxwrcgHimg6ehNBcbErumamBiS8kK01P18Dx+c/kB4mqEYENxkHjZigo
	 2Np6FX6LMze2pAlrRTm4lRBCfiq0xWBYAa+KuNnwiNX3BbSyDrymuFFSWahyefT+X4
	 c0bMN7KCKgcjfTpBDGv027jzmh8xgDIPx83BpZHk=
Subject: FAILED: patch "[PATCH] i2c: core: Lock address during client device instantiation" failed to apply to 6.6-stable tree
To: hkallweit1@gmail.com,ole@ans.pl,wsa+renesas@sang-engineering.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 11:27:12 +0200
Message-ID: <2024100712-pranker-disband-ee25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8d3cefaf659265aa82b0373a563fdb9d16a2b947
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100712-pranker-disband-ee25@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

8d3cefaf6592 ("i2c: core: Lock address during client device instantiation")
73febd775bdb ("i2c: create debugfs entry per adapter")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d3cefaf659265aa82b0373a563fdb9d16a2b947 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Thu, 15 Aug 2024 21:44:50 +0200
Subject: [PATCH] i2c: core: Lock address during client device instantiation

Krzysztof reported an issue [0] which is caused by parallel attempts to
instantiate the same I2C client device. This can happen if driver
supports auto-detection, but certain devices are also instantiated
explicitly.
The original change isn't actually wrong, it just revealed that I2C core
isn't prepared yet to handle this scenario.
Calls to i2c_new_client_device() can be nested, therefore we can't use a
simple mutex here. Parallel instantiation of devices at different addresses
is ok, so we just have to prevent parallel instantiation at the same address.
We can use a bitmap with one bit per 7-bit I2C client address, and atomic
bit operations to set/check/clear bits.
Now a parallel attempt to instantiate a device at the same address will
result in -EBUSY being returned, avoiding the "sysfs: cannot create duplicate
filename" splash.

Note: This patch version includes small cosmetic changes to the Tested-by
      version, only functional change is that address locking is supported
      for slave addresses too.

[0] https://lore.kernel.org/linux-i2c/9479fe4e-eb0c-407e-84c0-bd60c15baf74@ans.pl/T/#m12706546e8e2414d8f1a0dc61c53393f731685cc

Fixes: caba40ec3531 ("eeprom: at24: Probe for DDR3 thermal sensor in the SPD case")
Cc: stable@vger.kernel.org
Tested-by: Krzysztof Piotr Oledzki <ole@ans.pl>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index b63f75e44296..e39e8d792d03 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -915,6 +915,27 @@ int i2c_dev_irq_from_resources(const struct resource *resources,
 	return 0;
 }
 
+/*
+ * Serialize device instantiation in case it can be instantiated explicitly
+ * and by auto-detection
+ */
+static int i2c_lock_addr(struct i2c_adapter *adap, unsigned short addr,
+			 unsigned short flags)
+{
+	if (!(flags & I2C_CLIENT_TEN) &&
+	    test_and_set_bit(addr, adap->addrs_in_instantiation))
+		return -EBUSY;
+
+	return 0;
+}
+
+static void i2c_unlock_addr(struct i2c_adapter *adap, unsigned short addr,
+			    unsigned short flags)
+{
+	if (!(flags & I2C_CLIENT_TEN))
+		clear_bit(addr, adap->addrs_in_instantiation);
+}
+
 /**
  * i2c_new_client_device - instantiate an i2c device
  * @adap: the adapter managing the device
@@ -962,6 +983,10 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 		goto out_err_silent;
 	}
 
+	status = i2c_lock_addr(adap, client->addr, client->flags);
+	if (status)
+		goto out_err_silent;
+
 	/* Check for address business */
 	status = i2c_check_addr_busy(adap, i2c_encode_flags_to_addr(client));
 	if (status)
@@ -993,6 +1018,8 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	dev_dbg(&adap->dev, "client [%s] registered with bus id %s\n",
 		client->name, dev_name(&client->dev));
 
+	i2c_unlock_addr(adap, client->addr, client->flags);
+
 	return client;
 
 out_remove_swnode:
@@ -1004,6 +1031,7 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	dev_err(&adap->dev,
 		"Failed to register i2c client %s at 0x%02x (%d)\n",
 		client->name, client->addr, status);
+	i2c_unlock_addr(adap, client->addr, client->flags);
 out_err_silent:
 	if (need_put)
 		put_device(&client->dev);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 7eedd0c662da..8d79440cd8ce 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -761,6 +761,9 @@ struct i2c_adapter {
 	struct regulator *bus_regulator;
 
 	struct dentry *debugfs;
+
+	/* 7bit address space */
+	DECLARE_BITMAP(addrs_in_instantiation, 1 << 7);
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 


