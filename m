Return-Path: <stable+bounces-54506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0A90EE92
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5691C244ED
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7271A14D6E4;
	Wed, 19 Jun 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Fz75new"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4314B96F;
	Wed, 19 Jun 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803781; cv=none; b=AnhO7DY0in1uSm6/g7Bzs0I7pwZgTOfGpuI1Wzi3YwJjcu2DRRqo3L9VBNOuDPt6vIAzklOxai1k2FtUUOfih86yECPchkN/Z7cnMlejikKf5uOuDMNcEsNya08RZE/WI8FsJDTTRHdLYKEK6qJU1F7dXsGEJBB/4nAjcbaA4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803781; c=relaxed/simple;
	bh=n213PVulcsgTSFaO3dFR0kNLfYv3ZgD4Q4MdNs5K588=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raX64SXxV7Y3E+KC8z9SB0F+KwrpGy3Of7gD+jQKZzMHj2liaiboEzp4dKiK+VAYzo1HkH4lBj7ZSE9oCu8ALjwqYnG4eBUEV8k43qX6tPltjAdqiX0a1SOz6za+1bldg4bpqs2W0dOGqVHuA3gn7acT9Bz9/EgyivWBcseSaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Fz75new; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA6DC2BBFC;
	Wed, 19 Jun 2024 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803781;
	bh=n213PVulcsgTSFaO3dFR0kNLfYv3ZgD4Q4MdNs5K588=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Fz75newZ7/e9np8pkCHNDseEe7lDLNoPPDNCtbriBww8ydiAuL2l9uIS9kDi2MiV
	 asKOXZAOocKRfrJ1VUJqrVCFuU1I+rvfCo9LbjbxBh6Vtc/zTmoKGVoWznNjGOiA5L
	 sAc3lUIsha3Jr4Ud4VSvQVc6mMquyT1c9xrLl50M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 070/217] i2c: add fwnode APIs
Date: Wed, 19 Jun 2024 14:55:13 +0200
Message-ID: <20240619125559.384665325@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit 373c612d72461ddaea223592df31e62c934aae61 ]

Add fwnode APIs for finding and getting I2C adapters, which will be
used by the SFP code. These are passed the fwnode corresponding to
the adapter, and return the I2C adapter. It is the responsibility of
the caller to find the appropriate fwnode.

We keep the DT and ACPI interfaces, but where appropriate, recode them
to use the fwnode interfaces internally.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 3f858bbf04db ("i2c: acpi: Unbind mux adapters before delete")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-acpi.c | 13 +----
 drivers/i2c/i2c-core-base.c | 98 +++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core-of.c   | 66 -------------------------
 include/linux/i2c.h         | 24 +++++++--
 4 files changed, 120 insertions(+), 81 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 4dd777cc0c89f..d6037a3286690 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -442,18 +442,7 @@ EXPORT_SYMBOL_GPL(i2c_acpi_find_adapter_by_handle);
 
 static struct i2c_client *i2c_acpi_find_client_by_adev(struct acpi_device *adev)
 {
-	struct device *dev;
-	struct i2c_client *client;
-
-	dev = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
-	if (!dev)
-		return NULL;
-
-	client = i2c_verify_client(dev);
-	if (!client)
-		put_device(dev);
-
-	return client;
+	return i2c_find_device_by_fwnode(acpi_fwnode_handle(adev));
 }
 
 static int i2c_acpi_notify(struct notifier_block *nb, unsigned long value,
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1ebc953799149..8af82f42af30b 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1017,6 +1017,35 @@ void i2c_unregister_device(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
 
+/**
+ * i2c_find_device_by_fwnode() - find an i2c_client for the fwnode
+ * @fwnode: &struct fwnode_handle corresponding to the &struct i2c_client
+ *
+ * Look up and return the &struct i2c_client corresponding to the @fwnode.
+ * If no client can be found, or @fwnode is NULL, this returns NULL.
+ *
+ * The user must call put_device(&client->dev) once done with the i2c client.
+ */
+struct i2c_client *i2c_find_device_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct i2c_client *client;
+	struct device *dev;
+
+	if (!fwnode)
+		return NULL;
+
+	dev = bus_find_device_by_fwnode(&i2c_bus_type, fwnode);
+	if (!dev)
+		return NULL;
+
+	client = i2c_verify_client(dev);
+	if (!client)
+		put_device(dev);
+
+	return client;
+}
+EXPORT_SYMBOL(i2c_find_device_by_fwnode);
+
 
 static const struct i2c_device_id dummy_id[] = {
 	{ "dummy", 0 },
@@ -1767,6 +1796,75 @@ int devm_i2c_add_adapter(struct device *dev, struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL_GPL(devm_i2c_add_adapter);
 
+static int i2c_dev_or_parent_fwnode_match(struct device *dev, const void *data)
+{
+	if (dev_fwnode(dev) == data)
+		return 1;
+
+	if (dev->parent && dev_fwnode(dev->parent) == data)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * i2c_find_adapter_by_fwnode() - find an i2c_adapter for the fwnode
+ * @fwnode: &struct fwnode_handle corresponding to the &struct i2c_adapter
+ *
+ * Look up and return the &struct i2c_adapter corresponding to the @fwnode.
+ * If no adapter can be found, or @fwnode is NULL, this returns NULL.
+ *
+ * The user must call put_device(&adapter->dev) once done with the i2c adapter.
+ */
+struct i2c_adapter *i2c_find_adapter_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct i2c_adapter *adapter;
+	struct device *dev;
+
+	if (!fwnode)
+		return NULL;
+
+	dev = bus_find_device(&i2c_bus_type, NULL, fwnode,
+			      i2c_dev_or_parent_fwnode_match);
+	if (!dev)
+		return NULL;
+
+	adapter = i2c_verify_adapter(dev);
+	if (!adapter)
+		put_device(dev);
+
+	return adapter;
+}
+EXPORT_SYMBOL(i2c_find_adapter_by_fwnode);
+
+/**
+ * i2c_get_adapter_by_fwnode() - find an i2c_adapter for the fwnode
+ * @fwnode: &struct fwnode_handle corresponding to the &struct i2c_adapter
+ *
+ * Look up and return the &struct i2c_adapter corresponding to the @fwnode,
+ * and increment the adapter module's use count. If no adapter can be found,
+ * or @fwnode is NULL, this returns NULL.
+ *
+ * The user must call i2c_put_adapter(adapter) once done with the i2c adapter.
+ * Note that this is different from i2c_find_adapter_by_node().
+ */
+struct i2c_adapter *i2c_get_adapter_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct i2c_adapter *adapter;
+
+	adapter = i2c_find_adapter_by_fwnode(fwnode);
+	if (!adapter)
+		return NULL;
+
+	if (!try_module_get(adapter->owner)) {
+		put_device(&adapter->dev);
+		adapter = NULL;
+	}
+
+	return adapter;
+}
+EXPORT_SYMBOL(i2c_get_adapter_by_fwnode);
+
 static void i2c_parse_timing(struct device *dev, char *prop_name, u32 *cur_val_p,
 			    u32 def_val, bool use_def)
 {
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 1073f82d5dd47..545436b7dd535 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -113,72 +113,6 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 	of_node_put(bus);
 }
 
-static int of_dev_or_parent_node_match(struct device *dev, const void *data)
-{
-	if (dev->of_node == data)
-		return 1;
-
-	if (dev->parent)
-		return dev->parent->of_node == data;
-
-	return 0;
-}
-
-/* must call put_device() when done with returned i2c_client device */
-struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
-{
-	struct device *dev;
-	struct i2c_client *client;
-
-	dev = bus_find_device_by_of_node(&i2c_bus_type, node);
-	if (!dev)
-		return NULL;
-
-	client = i2c_verify_client(dev);
-	if (!client)
-		put_device(dev);
-
-	return client;
-}
-EXPORT_SYMBOL(of_find_i2c_device_by_node);
-
-/* must call put_device() when done with returned i2c_adapter device */
-struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
-{
-	struct device *dev;
-	struct i2c_adapter *adapter;
-
-	dev = bus_find_device(&i2c_bus_type, NULL, node,
-			      of_dev_or_parent_node_match);
-	if (!dev)
-		return NULL;
-
-	adapter = i2c_verify_adapter(dev);
-	if (!adapter)
-		put_device(dev);
-
-	return adapter;
-}
-EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
-
-/* must call i2c_put_adapter() when done with returned i2c_adapter device */
-struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
-{
-	struct i2c_adapter *adapter;
-
-	adapter = of_find_i2c_adapter_by_node(node);
-	if (!adapter)
-		return NULL;
-
-	if (!try_module_get(adapter->owner)) {
-		put_device(&adapter->dev);
-		adapter = NULL;
-	}
-
-	return adapter;
-}
-EXPORT_SYMBOL(of_get_i2c_adapter_by_node);
-
 static const struct of_device_id*
 i2c_of_match_device_sysfs(const struct of_device_id *matches,
 				  struct i2c_client *client)
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f7c49bbdb8a18..cfc59c3371cb2 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -964,15 +964,33 @@ int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
 
 #endif /* I2C */
 
+/* must call put_device() when done with returned i2c_client device */
+struct i2c_client *i2c_find_device_by_fwnode(struct fwnode_handle *fwnode);
+
+/* must call put_device() when done with returned i2c_adapter device */
+struct i2c_adapter *i2c_find_adapter_by_fwnode(struct fwnode_handle *fwnode);
+
+/* must call i2c_put_adapter() when done with returned i2c_adapter device */
+struct i2c_adapter *i2c_get_adapter_by_fwnode(struct fwnode_handle *fwnode);
+
 #if IS_ENABLED(CONFIG_OF)
 /* must call put_device() when done with returned i2c_client device */
-struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
+static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
+{
+	return i2c_find_device_by_fwnode(of_fwnode_handle(node));
+}
 
 /* must call put_device() when done with returned i2c_adapter device */
-struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node);
+static inline struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
+{
+	return i2c_find_adapter_by_fwnode(of_fwnode_handle(node));
+}
 
 /* must call i2c_put_adapter() when done with returned i2c_adapter device */
-struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node);
+static inline struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
+{
+	return i2c_get_adapter_by_fwnode(of_fwnode_handle(node));
+}
 
 const struct of_device_id
 *i2c_of_match_device(const struct of_device_id *matches,
-- 
2.43.0




