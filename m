Return-Path: <stable+bounces-148995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C220DACAF9E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE90A1892083
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96829221D94;
	Mon,  2 Jun 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bwm/SB5E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542402C3247;
	Mon,  2 Jun 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872200; cv=none; b=oQSIz2oUiXYd4sEL61uhyVfmxyj6Uh+Z8Rg7sbVJp08GlO1+C7bFOv1XwCXVUqtHIPUwnsuQTaQUEEnYSC3cRNTUsihUSxxulWiIcj3TjPKrq0H/A2M7sXAHsQB17hSUXRD+FTBA+/NJOu28qsQFhJLNdbsz0OjHrFod4XkRir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872200; c=relaxed/simple;
	bh=4PXBtjq7uUo4PZn+j07LhQjekNZv/H+h8WvgY6dCPhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z06HNK6WVugbIsFK6QFY0xcCOZ0udMMfnxcdWwMLqKDQl1dFjXwkDK4lpzWNjwXPKqBnAF87qDKVMRTZjrWne09WinhDJRuX2fwy4Iu9PLAl5aJ1Hvx80o4tQeW1yT8WXTtyOaegCLAEk0EKzrr7pgL4tv39U3y9crblq8vs95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bwm/SB5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617EFC4CEEB;
	Mon,  2 Jun 2025 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872199;
	bh=4PXBtjq7uUo4PZn+j07LhQjekNZv/H+h8WvgY6dCPhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bwm/SB5E3x3xmxFM/SfTyB9Zxw5qDoZ3q7L6Oo6zT/u5qIF22uXhMhiJonIl+7Y6M
	 ZmtJWdJkxbdzcAZV1/3TFwSAzZTZbHUkuRtmTP7xuZcI4qhVQyblTFxtqTSKHUQNSj
	 MO8/6e2dwQjNNhagwpUxvlvc38fl39k04jNvG/Lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.15 49/49] iommu: Handle yet another race around registration
Date: Mon,  2 Jun 2025 15:47:41 +0200
Message-ID: <20250602134239.863972055@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
References: <20250602134237.940995114@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

commit da33e87bd2bfc63531cf7448a3cd7a3d42182f08 upstream.

Next up on our list of race windows to close is another one during
iommu_device_register() - it's now OK again for multiple instances to
run their bus_iommu_probe() in parallel, but an iommu_probe_device() can
still also race against a running bus_iommu_probe(). As Johan has
managed to prove, this has now become a lot more visible on DT platforms
wth driver_async_probe where a client driver is attempting to probe in
parallel with its IOMMU driver - although commit b46064a18810 ("iommu:
Handle race with default domain setup") resolves this from the client
driver's point of view, this isn't before of_iommu_configure() has had
the chance to attempt to "replay" a probe that the bus walk hasn't even
tried yet, and so still cause the out-of-order group allocation
behaviour that we're trying to clean up (and now warning about).

The most reliable thing to do here is to explicitly keep track of the
"iommu_device_register() is still running" state, so we can then
special-case the ops lookup for the replay path (based on dev->iommu
again) to let that think it's still waiting for the IOMMU driver to
appear at all. This still leaves the longstanding theoretical case of
iommu_bus_notifier() being triggered during bus_iommu_probe(), but it's
not so simple to defer a notifier, and nobody's ever reported that being
a visible issue, so let's quietly kick that can down the road for now...

Reported-by: Johan Hovold <johan@kernel.org>
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/88d54c1b48fed8279aa47d30f3d75173685bb26a.1745516488.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommu.c |   26 ++++++++++++++++++--------
 include/linux/iommu.h |    2 ++
 2 files changed, 20 insertions(+), 8 deletions(-)

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -277,6 +277,8 @@ int iommu_device_register(struct iommu_d
 		err = bus_iommu_probe(iommu_buses[i]);
 	if (err)
 		iommu_device_unregister(iommu);
+	else
+		WRITE_ONCE(iommu->ready, true);
 	return err;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register);
@@ -2832,31 +2834,39 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode)
+static const struct iommu_device *iommu_from_fwnode(const struct fwnode_handle *fwnode)
 {
-	const struct iommu_ops *ops = NULL;
-	struct iommu_device *iommu;
+	const struct iommu_device *iommu, *ret = NULL;
 
 	spin_lock(&iommu_device_lock);
 	list_for_each_entry(iommu, &iommu_device_list, list)
 		if (iommu->fwnode == fwnode) {
-			ops = iommu->ops;
+			ret = iommu;
 			break;
 		}
 	spin_unlock(&iommu_device_lock);
-	return ops;
+	return ret;
+}
+
+const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode)
+{
+	const struct iommu_device *iommu = iommu_from_fwnode(fwnode);
+
+	return iommu ? iommu->ops : NULL;
 }
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 {
-	const struct iommu_ops *ops = iommu_ops_from_fwnode(iommu_fwnode);
+	const struct iommu_device *iommu = iommu_from_fwnode(iommu_fwnode);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!ops)
+	if (!iommu)
 		return driver_deferred_probe_check_state(dev);
+	if (!dev->iommu && !READ_ONCE(iommu->ready))
+		return -EPROBE_DEFER;
 
 	if (fwspec)
-		return ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
+		return iommu->ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
 
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -750,6 +750,7 @@ struct iommu_domain_ops {
  * @dev: struct device for sysfs handling
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
+ * @ready: set once iommu_device_register() has completed successfully
  */
 struct iommu_device {
 	struct list_head list;
@@ -758,6 +759,7 @@ struct iommu_device {
 	struct device *dev;
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
+	bool ready;
 };
 
 /**



