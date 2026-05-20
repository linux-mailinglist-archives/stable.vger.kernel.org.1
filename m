Return-Path: <stable+bounces-249935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDXLGrbBDWr32wUAu9opvQ
	(envelope-from <stable+bounces-249935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:14:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFBF58F638
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE9EC30AB745
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E63E7171;
	Wed, 20 May 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="basJseAD"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A33E6389
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285752; cv=none; b=HXCNpOjIRP9eNiNYBlzbAnHcDfBFn7wSgZGy5k+FiwY2MdEWEM8XC5iaZvI9U/D8ozw8cHXN9cpA7RCV1e7WedMXpIFtPeF9W26K897Z3ng+4uAhg4jtTEM04w/MPmKq0AxSUntTbaXH6Qrmtn0IlF09XmSEg108jrp3g0IKcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285752; c=relaxed/simple;
	bh=lKoFJ9i0bet8G65PcwDRrx4hwXgMycPx/StI5btk2JI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KclWVwammtOa5MwBWvKFHteLVjxcaIKs6ZUxmEeq4Hv41yp63eBEPUcweHZo6/VfPxFcnGfSPOyxS+YanZY5vVIeW5eRsAh8vlGuoHaQBbz9IbmHG1x1EU6QQjfUgvhyV64dnr1hxTIo3D6uenKDDP+ZouWuL+b5ygsF/thXDVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=basJseAD; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779285750; x=1810821750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3/EVpesJKeirlDI7IpFDvUAU0yw995jPrvx5T4XZes8=;
  b=basJseADw5ni8LykDT53we4HjEjQKRd79q6n7S6IZY/LiYz8G6ssQPx4
   7DvFDJhhgQgcAmjZ9cj1zQ3QUBDfchHhx2ZkQlaEyh+WhL4IW09v1QFuK
   H1yZhk/vVGbRX281Qx+J+XclpwOS5pKLW98jqHdSWFUr0F8FyQzqy/xdU
   I9NQL58BNcNBPvJ6y1uz2q9/SstJlAp3XDKiULXzh7QBU1LEvovADdsit
   VXnhsi6yDFeQphEy2n8AIOiC1Ip20o84F8PsbXHgi9GMwkBIRYSdlHPyG
   olyktkUsmxjrpz8LOlfPaDTHvWdS3/3RgjdUOuUOtEe/hWm4Xt+r55R2M
   A==;
X-CSE-ConnectionGUID: o2QeCLHzSIG7oSNrYW50Uw==
X-CSE-MsgGUID: QlIQHxhuS/+GZfTlm+uJHA==
X-IronPort-AV: E=Sophos;i="6.23,244,1770595200"; 
   d="scan'208";a="20081247"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 14:02:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:29880]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.3:2525] with esmtp (Farcaster)
 id f9981e95-e2e6-4368-aea2-3624c10dbc0a; Wed, 20 May 2026 14:02:26 +0000 (UTC)
X-Farcaster-Flow-ID: f9981e95-e2e6-4368-aea2-3624c10dbc0a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 20 May 2026 14:02:25 +0000
Received: from dev-dsk-dssauerw-1b-2c5f429c.eu-west-1.amazon.com
 (10.13.238.31) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 20 May 2026
 14:02:23 +0000
From: David Sauerwein <dssauerw@amazon.de>
To: <stable@vger.kernel.org>
CC: <nh-open-source@amazon.com>, Danilo Krummrich <dakr@kernel.org>, "Gui-Dong
 Han" <hanguidong02@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, "David
 Sauerwein" <dssauerw@amazon.de>
Subject: [PATCH 6.6.y 1/2] driver core: generalize driver_override in struct device
Date: Wed, 20 May 2026 14:01:59 +0000
Message-ID: <20260520140200.45804-1-dssauerw@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amazon.de:email,amazon.de:mid,amazon.de:dkim,msgid.link:url,linuxfoundation.org:email];
	FREEMAIL_CC(0.00)[amazon.com,kernel.org,gmail.com,linuxfoundation.org,amazon.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249935-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dssauerw@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8DFBF58F638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit cb3d1049f4ea77d5ad93f17d8ac1f2ed4da70501 ]

Currently, there are 12 busses (including platform and PCI) that
duplicate the driver_override logic for their individual devices.

All of them seem to be prone to the bug described in [1].

While this could be solved for every bus individually using a separate
lock, solving this in the driver-core generically results in less (and
cleaner) changes overall.

Thus, move driver_override to struct device, provide corresponding
accessors for busses and handle locking with a separate lock internally.

In particular, add device_set_driver_override(),
device_has_driver_override(), device_match_driver_override() and
generalize the sysfs store() and show() callbacks via a driver_override
feature flag in struct bus_type.

Until all busses have migrated, keep driver_set_override() in place.

Note that we can't use the device lock for the reasons described in [2].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220789 [1]
Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [2]
Tested-by: Gui-Dong Han <hanguidong02@gmail.com>
Co-developed-by: Gui-Dong Han <hanguidong02@gmail.com>
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20260303115720.48783-2-dakr@kernel.org
[ Use dev->bus instead of sp->bus for consistency; fix commit message to
  refer to the struct bus_type's driver_override feature flag. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Stable-dep-of: 2b38efc05bf7 ("driver core: platform: use generic driver_override infrastructure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: David Sauerwein <dssauerw@amazon.de>
---
 drivers/base/bus.c         | 43 ++++++++++++++++++++++++++-
 drivers/base/core.c        |  2 ++
 drivers/base/dd.c          | 60 ++++++++++++++++++++++++++++++++++++++
 include/linux/device.h     | 54 ++++++++++++++++++++++++++++++++++
 include/linux/device/bus.h |  4 +++
 5 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index b97e13a52c33..ae57df879bca 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -463,6 +463,36 @@ int bus_for_each_drv(const struct bus_type *bus, struct device_driver *start,
 }
 EXPORT_SYMBOL_GPL(bus_for_each_drv);
 
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int ret;
+
+	ret = __device_set_driver_override(dev, buf, count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	guard(spinlock)(&dev->driver_override.lock);
+	return sysfs_emit(buf, "%s\n", dev->driver_override.name);
+}
+static DEVICE_ATTR_RW(driver_override);
+
+static struct attribute *driver_override_dev_attrs[] = {
+	&dev_attr_driver_override.attr,
+	NULL,
+};
+
+static const struct attribute_group driver_override_dev_group = {
+	.attrs = driver_override_dev_attrs,
+};
+
 /**
  * bus_add_device - add device to bus
  * @dev: device being added
@@ -496,9 +526,15 @@ int bus_add_device(struct device *dev)
 	if (error)
 		goto out_put;
 
+	if (dev->bus->driver_override) {
+		error = device_add_group(dev, &driver_override_dev_group);
+		if (error)
+			goto out_groups;
+	}
+
 	error = sysfs_create_link(&sp->devices_kset->kobj, &dev->kobj, dev_name(dev));
 	if (error)
-		goto out_groups;
+		goto out_override;
 
 	error = sysfs_create_link(&dev->kobj, &sp->subsys.kobj, "subsystem");
 	if (error)
@@ -509,6 +545,9 @@ int bus_add_device(struct device *dev)
 
 out_subsys:
 	sysfs_remove_link(&sp->devices_kset->kobj, dev_name(dev));
+out_override:
+	if (dev->bus->driver_override)
+		device_remove_group(dev, &driver_override_dev_group);
 out_groups:
 	device_remove_groups(dev, sp->bus->dev_groups);
 out_put:
@@ -567,6 +606,8 @@ void bus_remove_device(struct device *dev)
 
 	sysfs_remove_link(&dev->kobj, "subsystem");
 	sysfs_remove_link(&sp->devices_kset->kobj, dev_name(dev));
+	if (dev->bus->driver_override)
+		device_remove_group(dev, &driver_override_dev_group);
 	device_remove_groups(dev, dev->bus->dev_groups);
 	if (klist_node_attached(&dev->p->knode_bus))
 		klist_del(&dev->p->knode_bus);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3c172e6d3fe0..5048849cb97a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2505,6 +2505,7 @@ static void device_release(struct kobject *kobj)
 	devres_release_all(dev);
 
 	kfree(dev->dma_range_map);
+	kfree(dev->driver_override.name);
 
 	if (dev->release)
 		dev->release(dev);
@@ -3153,6 +3154,7 @@ void device_initialize(struct device *dev)
 	kobject_init(&dev->kobj, &device_ktype);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	mutex_init(&dev->mutex);
+	spin_lock_init(&dev->driver_override.lock);
 	lockdep_set_novalidate_class(&dev->mutex);
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d371c3437dc6..44f9d0a06d5b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -380,6 +380,66 @@ static void __exit deferred_probe_exit(void)
 }
 __exitcall(deferred_probe_exit);
 
+int __device_set_driver_override(struct device *dev, const char *s, size_t len)
+{
+	const char *new, *old;
+	char *cp;
+
+	if (!s)
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
+	/*
+	 * Compute the real length of the string in case userspace sends us a
+	 * bunch of \0 characters like python likes to do.
+	 */
+	len = strlen(s);
+
+	if (!len) {
+		/* Empty string passed - clear override */
+		spin_lock(&dev->driver_override.lock);
+		old = dev->driver_override.name;
+		dev->driver_override.name = NULL;
+		spin_unlock(&dev->driver_override.lock);
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
+	spin_lock(&dev->driver_override.lock);
+	old = dev->driver_override.name;
+	if (cp != s) {
+		dev->driver_override.name = new;
+		spin_unlock(&dev->driver_override.lock);
+	} else {
+		/* "\n" passed - clear override */
+		dev->driver_override.name = NULL;
+		spin_unlock(&dev->driver_override.lock);
+
+		kfree(new);
+	}
+	kfree(old);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__device_set_driver_override);
+
 /**
  * device_is_bound() - Check if device is bound to a driver
  * @dev: device to check
diff --git a/include/linux/device.h b/include/linux/device.h
index 8fb9bd71fcd0..2a9017eec15c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -643,6 +643,8 @@ enum struct_device_flags {
  * 		on.  This shrinks the "Board Support Packages" (BSPs) and
  * 		minimizes board-specific #ifdefs in drivers.
  * @driver_data: Private pointer for driver specific info.
+ * @driver_override: Driver name to force a match.  Do not touch directly; use
+ *		     device_set_driver_override() instead.
  * @links:	Links to suppliers and consumers of this device.
  * @power:	For device power management.
  *		See Documentation/driver-api/pm/devices.rst for details.
@@ -735,6 +737,10 @@ struct device {
 					   core doesn't touch it */
 	void		*driver_data;	/* Driver data, set and get with
 					   dev_set_drvdata/dev_get_drvdata */
+	struct {
+		const char	*name;
+		spinlock_t	lock;
+	} driver_override;
 	struct mutex		mutex;	/* mutex to synchronize calls to
 					 * its driver.
 					 */
@@ -882,6 +888,54 @@ struct device_link {
 
 #define kobj_to_dev(__kobj)	container_of_const(__kobj, struct device, kobj)
 
+int __device_set_driver_override(struct device *dev, const char *s, size_t len);
+
+/**
+ * device_set_driver_override() - Helper to set or clear driver override.
+ * @dev: Device to change
+ * @s: NUL-terminated string, new driver name to force a match, pass empty
+ *     string to clear it ("" or "\n", where the latter is only for sysfs
+ *     interface).
+ *
+ * Helper to set or clear driver override of a device.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static inline int device_set_driver_override(struct device *dev, const char *s)
+{
+	return __device_set_driver_override(dev, s, s ? strlen(s) : 0);
+}
+
+/**
+ * device_has_driver_override() - Check if a driver override has been set.
+ * @dev: device to check
+ *
+ * Returns true if a driver override has been set for this device.
+ */
+static inline bool device_has_driver_override(struct device *dev)
+{
+	guard(spinlock)(&dev->driver_override.lock);
+	return !!dev->driver_override.name;
+}
+
+/**
+ * device_match_driver_override() - Match a driver against the device's driver_override.
+ * @dev: device to check
+ * @drv: driver to match against
+ *
+ * Returns > 0 if a driver override is set and matches the given driver, 0 if a
+ * driver override is set but does not match, or < 0 if a driver override is not
+ * set at all.
+ */
+static inline int device_match_driver_override(struct device *dev,
+					       const struct device_driver *drv)
+{
+	guard(spinlock)(&dev->driver_override.lock);
+	if (dev->driver_override.name)
+		return !strcmp(dev->driver_override.name, drv->name);
+	return -1;
+}
+
 /**
  * device_iommu_mapped - Returns true when the device DMA is translated
  *			 by an IOMMU
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index ae10c4322754..d43ce072d747 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -65,6 +65,9 @@ struct fwnode_handle;
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
  *              driver implementations to a bus and allow the driver to do
  *              bus-specific setup
+ * @driver_override:	Set to true if this bus supports the driver_override
+ *			mechanism, which allows userspace to force a specific
+ *			driver to bind to a device via a sysfs attribute.
  * @need_parent_lock:	When probing or removing a device on this bus, the
  *			device core should lock the device's parent.
  *
@@ -106,6 +109,7 @@ struct bus_type {
 
 	const struct iommu_ops *iommu_ops;
 
+	bool driver_override;
 	bool need_parent_lock;
 };
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


