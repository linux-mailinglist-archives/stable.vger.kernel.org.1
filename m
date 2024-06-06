Return-Path: <stable+bounces-48352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE48FE8A2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEA71F24513
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E545E197548;
	Thu,  6 Jun 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tv9lhDas"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359B197544;
	Thu,  6 Jun 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682917; cv=none; b=ajSo0ScD5CSKmzR86sRnZVEldCsrZL9f+HOGjKS7RcxsajxrH59qyo+FD4L4ViV2A3PYEzi08TnjMoTJKUKVc3YYv747mlnO2rppKCLUUiU2Ol+nazHLfKoTdKwmkLaALDgufdQRYmfVoDoYS08jaQpD4AF5Yeav4s63T9jcAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682917; c=relaxed/simple;
	bh=oydoCPkQ8wTmaTHRPd/t9o2fMec5kOwQGjRuH/V1KZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkg6enhOu4w4xF9Cvu60ZN941dHrL30Uea7LkXBPuZV3wP3zeHAh18z8d1YUX9SQD1GTTWV40QSh9FH2PXV4Pybf4R5zDp8jkuw96PX/5rEHOMHFwN3oQm+/3/JgflYqoojuVXl3WQeLPt7F4NSMiHGdHnStlCtOZGcQfe2lzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tv9lhDas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BE8C2BD10;
	Thu,  6 Jun 2024 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682917;
	bh=oydoCPkQ8wTmaTHRPd/t9o2fMec5kOwQGjRuH/V1KZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tv9lhDas1kP40kzbpr4ua4PiLu2/7nIQYTp1c5idlONfM+ivp3KPwhnlJH+Wqel4W
	 PTlYXG5r4xGMnrk4u3bKMCzjIPT5CLx695maxAvy0+xgXeS4pTIDYF0M5+G23fbelU
	 DZvMH3j94FWSUoPtXm7lG2DapGNXfxLAqlUDNmTk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xu Yilun <yilun.xu@intel.com>,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 011/374] fpga: bridge: add owner module and take its refcount
Date: Thu,  6 Jun 2024 15:59:50 +0200
Message-ID: <20240606131652.130568441@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Pagani <marpagan@redhat.com>

[ Upstream commit 1da11f822042eb6ef4b6064dc048f157a7852529 ]

The current implementation of the fpga bridge assumes that the low-level
module registers a driver for the parent device and uses its owner pointer
to take the module's refcount. This approach is problematic since it can
lead to a null pointer dereference while attempting to get the bridge if
the parent device does not have a driver.

To address this problem, add a module owner pointer to the fpga_bridge
struct and use it to take the module's refcount. Modify the function for
registering a bridge to take an additional owner module parameter and
rename it to avoid conflicts. Use the old function name for a helper macro
that automatically sets the module that registers the bridge as the owner.
This ensures compatibility with existing low-level control modules and
reduces the chances of registering a bridge without setting the owner.

Also, update the documentation to keep it consistent with the new interface
for registering an fpga bridge.

Other changes: opportunistically move put_device() from __fpga_bridge_get()
to fpga_bridge_get() and of_fpga_bridge_get() to improve code clarity since
the bridge device is taken in these functions.

Fixes: 21aeda950c5f ("fpga: add fpga bridge framework")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Russ Weight <russ.weight@linux.dev>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20240322171839.233864-1-marpagan@redhat.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/driver-api/fpga/fpga-bridge.rst |  7 ++-
 drivers/fpga/fpga-bridge.c                    | 57 ++++++++++---------
 include/linux/fpga/fpga-bridge.h              | 10 +++-
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 6042085340953..833f68fb07008 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -6,9 +6,12 @@ API to implement a new FPGA bridge
 
 * struct fpga_bridge - The FPGA Bridge structure
 * struct fpga_bridge_ops - Low level Bridge driver ops
-* fpga_bridge_register() - Create and register a bridge
+* __fpga_bridge_register() - Create and register a bridge
 * fpga_bridge_unregister() - Unregister a bridge
 
+The helper macro ``fpga_bridge_register()`` automatically sets
+the module that registers the FPGA bridge as the owner.
+
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge
 
@@ -16,7 +19,7 @@ API to implement a new FPGA bridge
    :functions: fpga_bridge_ops
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_register
+   :functions: __fpga_bridge_register
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
    :functions: fpga_bridge_unregister
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 79c473b3c7c3d..8ef395b49bf8a 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -55,33 +55,26 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_disable);
 
-static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
+static struct fpga_bridge *__fpga_bridge_get(struct device *bridge_dev,
 					     struct fpga_image_info *info)
 {
 	struct fpga_bridge *bridge;
-	int ret = -ENODEV;
 
-	bridge = to_fpga_bridge(dev);
+	bridge = to_fpga_bridge(bridge_dev);
 
 	bridge->info = info;
 
-	if (!mutex_trylock(&bridge->mutex)) {
-		ret = -EBUSY;
-		goto err_dev;
-	}
+	if (!mutex_trylock(&bridge->mutex))
+		return ERR_PTR(-EBUSY);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_ll_mod;
+	if (!try_module_get(bridge->br_ops_owner)) {
+		mutex_unlock(&bridge->mutex);
+		return ERR_PTR(-ENODEV);
+	}
 
 	dev_dbg(&bridge->dev, "get\n");
 
 	return bridge;
-
-err_ll_mod:
-	mutex_unlock(&bridge->mutex);
-err_dev:
-	put_device(dev);
-	return ERR_PTR(ret);
 }
 
 /**
@@ -98,13 +91,18 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
 struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 				       struct fpga_image_info *info)
 {
-	struct device *dev;
+	struct fpga_bridge *bridge;
+	struct device *bridge_dev;
 
-	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
-	if (!dev)
+	bridge_dev = class_find_device_by_of_node(&fpga_bridge_class, np);
+	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
 
@@ -125,6 +123,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 struct fpga_bridge *fpga_bridge_get(struct device *dev,
 				    struct fpga_image_info *info)
 {
+	struct fpga_bridge *bridge;
 	struct device *bridge_dev;
 
 	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
@@ -132,7 +131,11 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
 	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(bridge_dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_get);
 
@@ -146,7 +149,7 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
 	dev_dbg(&bridge->dev, "put\n");
 
 	bridge->info = NULL;
-	module_put(bridge->dev.parent->driver->owner);
+	module_put(bridge->br_ops_owner);
 	mutex_unlock(&bridge->mutex);
 	put_device(&bridge->dev);
 }
@@ -316,18 +319,19 @@ static struct attribute *fpga_bridge_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_bridge);
 
 /**
- * fpga_bridge_register - create and register an FPGA Bridge device
+ * __fpga_bridge_register - create and register an FPGA Bridge device
  * @parent:	FPGA bridge device from pdev
  * @name:	FPGA bridge name
  * @br_ops:	pointer to structure of fpga bridge ops
  * @priv:	FPGA bridge private data
+ * @owner:	owner module containing the br_ops
  *
  * Return: struct fpga_bridge pointer or ERR_PTR()
  */
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv)
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops,
+		       void *priv, struct module *owner)
 {
 	struct fpga_bridge *bridge;
 	int id, ret;
@@ -357,6 +361,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	bridge->name = name;
 	bridge->br_ops = br_ops;
+	bridge->br_ops_owner = owner;
 	bridge->priv = priv;
 
 	bridge->dev.groups = br_ops->groups;
@@ -386,7 +391,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_bridge_register);
+EXPORT_SYMBOL_GPL(__fpga_bridge_register);
 
 /**
  * fpga_bridge_unregister - unregister an FPGA bridge
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 223da48a6d18b..94c4edd047e54 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -45,6 +45,7 @@ struct fpga_bridge_info {
  * @dev: FPGA bridge device
  * @mutex: enforces exclusive reference to bridge
  * @br_ops: pointer to struct of FPGA bridge ops
+ * @br_ops_owner: module containing the br_ops
  * @info: fpga image specific information
  * @node: FPGA bridge list node
  * @priv: low level driver private date
@@ -54,6 +55,7 @@ struct fpga_bridge {
 	struct device dev;
 	struct mutex mutex; /* for exclusive reference to bridge */
 	const struct fpga_bridge_ops *br_ops;
+	struct module *br_ops_owner;
 	struct fpga_image_info *info;
 	struct list_head node;
 	void *priv;
@@ -79,10 +81,12 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
 			       struct fpga_image_info *info,
 			       struct list_head *bridge_list);
 
+#define fpga_bridge_register(parent, name, br_ops, priv) \
+	__fpga_bridge_register(parent, name, br_ops, priv, THIS_MODULE)
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv);
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops, void *priv,
+		       struct module *owner);
 void fpga_bridge_unregister(struct fpga_bridge *br);
 
 #endif /* _LINUX_FPGA_BRIDGE_H */
-- 
2.43.0




