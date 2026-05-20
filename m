Return-Path: <stable+bounces-249937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAQFE8fBDWr32wUAu9opvQ
	(envelope-from <stable+bounces-249937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:14:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4530258F647
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D977F3066962
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EBC3E7BCB;
	Wed, 20 May 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="C5n40Iuz"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94F3E7BB5
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285756; cv=none; b=k5LL6s9n+LCLjappqjbysr/onRAr8i+9GdqHgqSpO12pzgWN5a/Luu+mit9Orb0DU64Ks4vPV7GTb16Yoq++2wxjr99IrZokLrf1uJ/FBNsTQRQzfUJVhsfrZF0etOFe7c2Y1mTrk2hVt7GbQZeJu7rabwJ1xoZwFxyxpdakl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285756; c=relaxed/simple;
	bh=qweb2liQy0LkasezJVbUY35ZabLZpGCk+uWueF+/AAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAw/k0C2kBzO0LkWuICSc3H36n4O9vrFgSHfh0skKB63YkxlMiXCxyYnKTSFdV7gS2nRnSTqUrIQ5kwqXAKOo7Pjs8BTb0lO4nXGKkgxmknysY+lS4Woo9lXF4XVbvBVC7nVrwJrz1zjsyV//6n6ZMsjtjyx26FdOq6tcYaZHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=C5n40Iuz; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779285754; x=1810821754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qo9Dte9ErgoFlmwH1S4V1Rhw1b2TTsk60wHP8SaYcm4=;
  b=C5n40IuzQuorBC1XBxizsh0763FxB/KQDL9kNJG2L1QPliTY/suGMozb
   Einubh+rzWpk2OOqszfVJlMzUZLCD2tftCsU8F3C5jPiRvyKY3vQZqwb0
   j7b3nvtOPlkkXOk7t/R0FSK5pDgY3WKC0dhint+rVrw5HdG7HAfP+N4X8
   XitKrjwTcXmVmiep57/R30k11OFPY6+Y6F33wP2HPTugFPNQ4dX+DmATG
   obyqev67c9jCTkcqCN1gY+AcrXWeWZPNXYD5B+MXb1nfVaxbqkSJoqyH8
   krZsGVORR6YX1JrQkgsDyA5EAAOGjXmM7iQrYzXGCp5BIJ6UL6ahqyFta
   g==;
X-CSE-ConnectionGUID: P2FYl7a4SheSfijr//9nlg==
X-CSE-MsgGUID: NBr0rL01RSi08bJHV3HY+Q==
X-IronPort-AV: E=Sophos;i="6.23,244,1770595200"; 
   d="scan'208";a="19889374"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 14:02:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:19608]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.251:2525] with esmtp (Farcaster)
 id 0b4dfb8f-3e47-49e9-b7cf-97ee01b0b7c4; Wed, 20 May 2026 14:02:31 +0000 (UTC)
X-Farcaster-Flow-ID: 0b4dfb8f-3e47-49e9-b7cf-97ee01b0b7c4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 20 May 2026 14:02:30 +0000
Received: from dev-dsk-dssauerw-1b-2c5f429c.eu-west-1.amazon.com
 (10.13.238.31) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 20 May 2026
 14:02:28 +0000
From: David Sauerwein <dssauerw@amazon.de>
To: <stable@vger.kernel.org>
CC: <nh-open-source@amazon.com>, Danilo Krummrich <dakr@kernel.org>, "Gui-Dong
 Han" <hanguidong02@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, "David
 Sauerwein" <dssauerw@amazon.de>
Subject: [PATCH 6.6.y 2/2] driver core: platform: use generic driver_override infrastructure
Date: Wed, 20 May 2026 14:02:00 +0000
Message-ID: <20260520140200.45804-2-dssauerw@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520140200.45804-1-dssauerw@amazon.de>
References: <20260520140200.45804-1-dssauerw@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,amazon.de:email,amazon.de:mid,amazon.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url];
	FREEMAIL_CC(0.00)[amazon.com,kernel.org,gmail.com,linuxfoundation.org,amazon.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249937-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dssauerw@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4530258F647
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit 2b38efc05bf7a8568ec74bfffea0f5cfa62bc01d ]

When a driver is probed through __driver_attach(), the bus' match()
callback is called without the device lock held, thus accessing the
driver_override field without a lock, which can cause a UAF.

Fix this by using the driver-core driver_override infrastructure taking
care of proper locking internally.

Note that calling match() from __driver_attach() without the device lock
held is intentional. [1]

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
Fixes: 3d713e0e382e ("driver core: platform: add device binding path 'driver_override'")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20260303115720.48783-5-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: David Sauerwein <dssauerw@amazon.de>
---
 drivers/base/platform.c         | 37 +++++----------------------------
 drivers/bus/simple-pm-bus.c     |  4 ++--
 drivers/clk/imx/clk-scu.c       |  3 +--
 drivers/slimbus/qcom-ngd-ctrl.c |  6 ++----
 include/linux/platform_device.h |  5 -----
 sound/soc/samsung/i2s.c         |  6 +++---
 6 files changed, 13 insertions(+), 48 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba25003..1cc9a876b3cd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -561,7 +561,6 @@ static void platform_device_release(struct device *dev)
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
-	kfree(pa->pdev.driver_override);
 	kfree(pa);
 }
 
@@ -1265,38 +1264,9 @@ static ssize_t numa_node_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(numa_node);
 
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
-	device_unlock(dev);
-
-	return len;
-}
-
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 static struct attribute *platform_dev_attrs[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_numa_node.attr,
-	&dev_attr_driver_override.attr,
 	NULL,
 };
 
@@ -1336,10 +1306,12 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct platform_driver *pdrv = to_platform_driver(drv);
+	int ret;
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (pdev->driver_override)
-		return !strcmp(pdev->driver_override, drv->name);
+	ret = device_match_driver_override(dev, drv);
+	if (ret >= 0)
+		return ret;
 
 	/* Attempt an OF style match first */
 	if (of_driver_match_device(dev, drv))
@@ -1482,6 +1454,7 @@ static const struct dev_pm_ops platform_dev_pm_ops = {
 struct bus_type platform_bus_type = {
 	.name		= "platform",
 	.dev_groups	= platform_dev_groups,
+	.driver_override = true,
 	.match		= platform_match,
 	.uevent		= platform_uevent,
 	.probe		= platform_probe,
diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index aafcc481de91..cb71774400d4 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -36,7 +36,7 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	 * that's not listed in simple_pm_bus_of_match. We don't want to do any
 	 * of the simple-pm-bus tasks for these devices, so return early.
 	 */
-	if (pdev->driver_override)
+	if (device_has_driver_override(&pdev->dev))
 		return 0;
 
 	match = of_match_device(dev->driver->of_match_table, dev);
@@ -78,7 +78,7 @@ static int simple_pm_bus_remove(struct platform_device *pdev)
 {
 	const void *data = of_device_get_match_data(&pdev->dev);
 
-	if (pdev->driver_override || data)
+	if (device_has_driver_override(&pdev->dev) || data)
 		return 0;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 564f549ec204..3a68576cdae7 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -700,8 +700,7 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
-				  "imx-scu-clk", strlen("imx-scu-clk"));
+	ret = device_set_driver_override(&pdev->dev, "imx-scu-clk");
 	if (ret) {
 		platform_device_put(pdev);
 		return ERR_PTR(ret);
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index fe3a96577f31..d0d289c49c8d 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1537,10 +1537,8 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
 
-		ret = driver_set_override(&ngd->pdev->dev,
-					  &ngd->pdev->driver_override,
-					  QCOM_SLIM_NGD_DRV_NAME,
-					  strlen(QCOM_SLIM_NGD_DRV_NAME));
+		ret = device_set_driver_override(&ngd->pdev->dev,
+						 QCOM_SLIM_NGD_DRV_NAME);
 		if (ret) {
 			platform_device_put(ngd->pdev);
 			kfree(ngd);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7a41c72c1959..8828b0d275d7 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -31,11 +31,6 @@ struct platform_device {
 	struct resource	*resource;
 
 	const struct platform_device_id	*id_entry;
-	/*
-	 * Driver name to force a match.  Do not set directly, because core
-	 * frees it.  Use driver_set_override() to set or clear it.
-	 */
-	const char *driver_override;
 
 	/* MFD cell pointer */
 	struct mfd_cell *mfd_cell;
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 3af48c9b5ab7..925782e67673 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1364,10 +1364,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
 	if (!pdev_sec)
 		return -ENOMEM;
 
-	pdev_sec->driver_override = kstrdup("samsung-i2s", GFP_KERNEL);
-	if (!pdev_sec->driver_override) {
+	ret = device_set_driver_override(&pdev_sec->dev, "samsung-i2s");
+	if (ret) {
 		platform_device_put(pdev_sec);
-		return -ENOMEM;
+		return ret;
 	}
 
 	ret = platform_device_add(pdev_sec);
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


