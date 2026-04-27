Return-Path: <stable+bounces-241430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJsICYq472kbEQEAu9opvQ
	(envelope-from <stable+bounces-241430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:27:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD34793DE
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4503A302676D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E943E929C;
	Mon, 27 Apr 2026 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEsVnseL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52367402451
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318021; cv=none; b=DkfchNu4z2ddGgdwTrKYp5g4j7xBrRks17RqGpMVsdsLU1GjwVZy9W7KLD0IX0wd8rXMuG3hzMBjGBltlEfE15pyi/g3LqKxaCMAKSJvf8unNV0cegzqQ5vfONMvmias+Gimzfk94wCmqBoqyjssmGqbfBlt9puMZtyCLtj6sgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318021; c=relaxed/simple;
	bh=rSq10hQbWv6vOyBHdwmGL8zhh9cYjiCM8bx3qA+i2G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRMojMo17RozgB1dVTk6FLIGNBn/2kJ7rhaMSNiTXaJV8Su8s2QIWvAfLUL/56w6AW/flB+R3fgx6kRE+AQI2eY2KV8aplHTnd/8QIN4nT7JoNaJuSAlsJzBGVT31JlTcxlEg4ag2Dyuidf1FTjF23wQMvWe+gUlqIKiDWpIkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NEsVnseL; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba895adfeaso11222982eec.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777318016; x=1777922816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+a6GhFYB2hb2g/TqFYTCNs2821ZSa41+daiSdMOpAw=;
        b=NEsVnseL2pS8Qnjxl6pJXsB1rtkrkQyLKIBnImEeBsyvyH2lieCnI/wLd8d+G46TdL
         7lUfhp7onLqEmAyuONqRSYnvNBscezPGb7DHemLNEPfwV8P2lvLOKYXBL4YbAHr+w4MT
         PwMRRWmyhGsClaPhYDF7seaeiqGWodYLBf5HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777318016; x=1777922816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+a6GhFYB2hb2g/TqFYTCNs2821ZSa41+daiSdMOpAw=;
        b=ACSZOR06vxWJaZrOhvKIaTmN9Vjbof2ZYdwxVi8Ju8yUEEMd0LlLFt9/7lna8tokQ9
         ofesfhVQ6aHHwMgTQUS9LehwfwHuMxtF3e9huqMlS3RTdcPhS2GKrQt6VufMD8e5PCRk
         jTGkY02+vm9rK7Vwm4AatdFrNuFXgzalrPNjxtayjsr6Xda/CIa1aifjVCyRJ3l2VOZ0
         y+d1pWWLyGTf1+OQEosLxVDNKb7CGjh1AS6AX1guWjyhu11uP2ETVpAkSABtmtXwoLqs
         24lKO0L9zGsssBxRBhkvB9c8gQdG+Hb+Axl8ZVnorrs0j/PVkTzlmt6sOg9AjC9QuNk7
         v8Og==
X-Gm-Message-State: AOJu0Yyn35GYg47ULtPgrihl+bKBGz+OrT9L75l52C2jiztfAo4gNC/E
	FkFmE7jm2XP+NvO9USpiZXZXmzvg1bPmidIfYX8Ah0TK+p2ckqgmrzVbPOQjPkkAczjgriPDZdJ
	C4BfYig2K
X-Gm-Gg: AeBDiev+qlhwyzRhI6TthiWT4ymwOkyLngs2gEjfip6hHklNz/TDV6565r2jTQiRAbT
	IHhd701EOogxhvfutt7rRPOtxOHrx7CIi1DpeuGH+ASPSVtyrjqjUsXkgBkFC/Zm07K/Hj4FFSw
	B12vWafkjgmSQY/CBUkBvED4bdxmeMTVuDW5H4rAhs8AFWtmjxAkfcyUFQ7IQrab7sDUJGfs6FH
	x4ewJ1FqHqHifAmu2bKIE6dpCTqQdllaGGoD/9cn7C5u1W3Nb+QB69Ty6DGiGAqCOkHKcfHtxwa
	o66HtPKySv9evCJbR7zzi3bd+gXMvimA8Z6xd1tCVjqpZRuQD6fNcC28souq4tiBoHGIGLGautZ
	wBP7nTrIjUVhjzrg1+R5d8L/0VD/mRiEWWiWBP13NYbkmIlQstisToSCHnTnvGK4e9HG+T7b0dI
	+n9QZL0CYuWHln46gHb6Wr63P+yMkb/sMQg+HIppx0VXl2sIVUaz3Qub50MB574IRQa1laznS6p
	9UjLEXWPY1Ar8KsvOlJRA==
X-Received: by 2002:a05:7301:fa06:b0:2e2:27bb:a4a2 with SMTP id 5a478bee46e88-2ed0a191b7dmr87218eec.13.1777318015830;
        Mon, 27 Apr 2026 12:26:55 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:389e:b840:2892:97c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09fb6b74sm245544eec.11.2026.04.27.12.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 12:26:55 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.6.y] device property: Make modifications of fwnode "flags" thread safe
Date: Mon, 27 Apr 2026 12:26:46 -0700
Message-ID: <20260427192646.3452125-1-dianders@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <2026042715-tipper-erupt-7a49@gregkh>
References: <2026042715-tipper-erupt-7a49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70AD34793DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-241430-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email,chromium.org:dkim,chromium.org:mid,msgid.link:url,intel.com:email]

In various places in the kernel, we modify the fwnode "flags" member
by doing either:
  fwnode->flags |= SOME_FLAG;
  fwnode->flags &= ~SOME_FLAG;

This type of modification is not thread-safe. If two threads are both
mucking with the flags at the same time then one can clobber the
other.

While flags are often modified while under the "fwnode_link_lock",
this is not universally true.

Create some accessor functions for setting, clearing, and testing the
FWNODE flags and move all users to these accessor functions. New
accessor functions use set_bit() and clear_bit(), which are
thread-safe.

Cc: stable@vger.kernel.org
Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Saravana Kannan <saravanak@kernel.org>
Link: https://patch.msgid.link/20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid
[ Fix fwnode_clear_flag() argument alignment, restore dropped blank
  line in fwnode_dev_initialized(), and remove unnecessary parentheses
  around fwnode_test_flag() calls. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
(cherry picked from commit f72e77c33e4b5657af35125e75bab249256030f3)
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/base/core.c        | 24 ++++++++++-----------
 drivers/bus/imx-weim.c     |  2 +-
 drivers/i2c/i2c-core-of.c  |  2 +-
 drivers/net/phy/mdio_bus.c |  4 ++--
 drivers/of/base.c          |  2 +-
 drivers/of/dynamic.c       |  2 +-
 drivers/of/platform.c      |  2 +-
 drivers/spi/spi.c          |  2 +-
 include/linux/fwnode.h     | 44 ++++++++++++++++++++++++++++----------
 9 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a192ce5bb8f9..a7033e11e38f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -182,7 +182,7 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
 	if (fwnode->dev)
 		return;
 
-	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
 	fwnode_links_purge_consumers(fwnode);
 
 	fwnode_for_each_available_child_node(fwnode, child)
@@ -228,7 +228,7 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
 	if (fwnode->dev && fwnode->dev->bus)
 		return;
 
-	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
 	__fwnode_links_move_consumers(fwnode, new_sup);
 
 	fwnode_for_each_available_child_node(fwnode, child)
@@ -1013,7 +1013,7 @@ static void device_links_missing_supplier(struct device *dev)
 static bool dev_is_best_effort(struct device *dev)
 {
 	return (fw_devlink_best_effort && dev->can_match) ||
-		(dev->fwnode && (dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT));
+		(dev->fwnode && fwnode_test_flag(dev->fwnode, FWNODE_FLAG_BEST_EFFORT));
 }
 
 static struct fwnode_handle *fwnode_links_check_suppliers(
@@ -1729,11 +1729,11 @@ bool fw_devlink_is_strict(void)
 
 static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
 {
-	if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
+	if (fwnode_test_flag(fwnode, FWNODE_FLAG_LINKS_ADDED))
 		return;
 
 	fwnode_call_int_op(fwnode, add_links);
-	fwnode->flags |= FWNODE_FLAG_LINKS_ADDED;
+	fwnode_set_flag(fwnode, FWNODE_FLAG_LINKS_ADDED);
 }
 
 static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
@@ -1892,7 +1892,7 @@ static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
 	struct device *dev;
 	bool ret;
 
-	if (!(fwnode->flags & FWNODE_FLAG_INITIALIZED))
+	if (!fwnode_test_flag(fwnode, FWNODE_FLAG_INITIALIZED))
 		return false;
 
 	dev = get_dev_from_fwnode(fwnode);
@@ -1951,10 +1951,10 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 	 * We aren't trying to find all cycles. Just a cycle between con and
 	 * sup_handle.
 	 */
-	if (sup_handle->flags & FWNODE_FLAG_VISITED)
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_VISITED))
 		return false;
 
-	sup_handle->flags |= FWNODE_FLAG_VISITED;
+	fwnode_set_flag(sup_handle, FWNODE_FLAG_VISITED);
 
 	/* Termination condition. */
 	if (sup_handle == con_handle) {
@@ -2024,7 +2024,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 	}
 
 out:
-	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
+	fwnode_clear_flag(sup_handle, FWNODE_FLAG_VISITED);
 	put_device(sup_dev);
 	put_device(con_dev);
 	put_device(par_dev);
@@ -2077,7 +2077,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	 * When such a flag is set, we can't create device links where P is the
 	 * supplier of C as that would delay the probe of C.
 	 */
-	if (sup_handle->flags & FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD &&
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD) &&
 	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
 		return -EINVAL;
 
@@ -2100,7 +2100,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	else
 		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
-	if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NOT_DEVICE))
 		sup_dev = fwnode_get_next_parent_dev(sup_handle);
 	else
 		sup_dev = get_dev_from_fwnode(sup_handle);
@@ -2112,7 +2112,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		 * supplier device indefinitely.
 		 */
 		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
-		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
+		    fwnode_test_flag(sup_handle, FWNODE_FLAG_INITIALIZED)) {
 			dev_dbg(con,
 				"Not linking %pfwf - dev might never probe\n",
 				sup_handle);
diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index f9fd1582f150..5244013d328f 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -335,7 +335,7 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
 			 * fw_devlink doesn't skip adding consumers to this
 			 * device.
 			 */
-			rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+			fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 			if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
 				dev_err(&pdev->dev,
 					"Failed to create child device '%pOF'\n",
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index a6c407d36800..50e97e2ed2cf 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -182,7 +182,7 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
 		 * Clear the flag before adding the device so that fw_devlink
 		 * doesn't skip adding consumers to this device.
 		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 		client = of_i2c_register_device(adap, rd->dn);
 		if (IS_ERR(client)) {
 			dev_err(&adap->dev, "failed to create client for '%pOF'\n",
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 7da30a6752be..08b32b45126d 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -675,8 +675,8 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 		return -EINVAL;
 
 	if (bus->parent && bus->parent->of_node)
-		bus->parent->of_node->fwnode.flags |=
-					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
+		fwnode_set_flag(&bus->parent->of_node->fwnode,
+				FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD);
 
 	WARN(bus->state != MDIOBUS_ALLOCATED &&
 	     bus->state != MDIOBUS_UNREGISTERED,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index d10248a5c0a5..04c6a3b40429 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1759,7 +1759,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
 		if (of_stdout)
-			of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
+			fwnode_set_flag(&of_stdout->fwnode, FWNODE_FLAG_BEST_EFFORT);
 	}
 
 	if (!of_aliases)
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 18393800546c..ab109bb92cf4 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -224,7 +224,7 @@ static void __of_attach_node(struct device_node *np)
 	np->sibling = np->parent->child;
 	np->parent->child = np;
 	of_node_clear_flag(np, OF_DETACHED);
-	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(&np->fwnode, FWNODE_FLAG_NOT_DEVICE);
 
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ccf7f0ffa67f..18b72f891c5b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -774,7 +774,7 @@ static int of_platform_notify(struct notifier_block *nb,
 		 * Clear the flag before adding the device so that fw_devlink
 		 * doesn't skip adding consumers to this device.
 		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 		/* pdev_parent may be NULL when no bus platform device */
 		pdev_parent = of_find_device_by_node(rd->dn->parent);
 		pdev = of_platform_device_create(rd->dn, NULL,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 91da4cae011c..216a9378f0d6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4532,7 +4532,7 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		 * Clear the flag before adding the device so that fw_devlink
 		 * doesn't skip adding consumers to this device.
 		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 		spi = of_register_spi_device(ctlr, rd->dn);
 		put_device(&ctlr->dev);
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 7efb4493e51c..76680d583852 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
 
 struct fwnode_operations;
@@ -31,12 +32,12 @@ struct device;
  *		suppliers. Only enforce ordering with suppliers that have
  *		drivers.
  */
-#define FWNODE_FLAG_LINKS_ADDED			BIT(0)
-#define FWNODE_FLAG_NOT_DEVICE			BIT(1)
-#define FWNODE_FLAG_INITIALIZED			BIT(2)
-#define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
-#define FWNODE_FLAG_BEST_EFFORT			BIT(4)
-#define FWNODE_FLAG_VISITED			BIT(5)
+#define FWNODE_FLAG_LINKS_ADDED			0
+#define FWNODE_FLAG_NOT_DEVICE			1
+#define FWNODE_FLAG_INITIALIZED			2
+#define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	3
+#define FWNODE_FLAG_BEST_EFFORT			4
+#define FWNODE_FLAG_VISITED			5
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
@@ -44,7 +45,7 @@ struct fwnode_handle {
 	struct device *dev;
 	struct list_head suppliers;
 	struct list_head consumers;
-	u8 flags;
+	unsigned long flags;
 };
 
 /*
@@ -197,16 +198,37 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
 	INIT_LIST_HEAD(&fwnode->suppliers);
 }
 
+static inline void fwnode_set_flag(struct fwnode_handle *fwnode,
+				   unsigned int bit)
+{
+	set_bit(bit, &fwnode->flags);
+}
+
+static inline void fwnode_clear_flag(struct fwnode_handle *fwnode,
+				     unsigned int bit)
+{
+	clear_bit(bit, &fwnode->flags);
+}
+
+static inline void fwnode_assign_flag(struct fwnode_handle *fwnode,
+				      unsigned int bit, bool value)
+{
+	assign_bit(bit, &fwnode->flags, value);
+}
+
+static inline bool fwnode_test_flag(struct fwnode_handle *fwnode,
+				    unsigned int bit)
+{
+	return test_bit(bit, &fwnode->flags);
+}
+
 static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 					  bool initialized)
 {
 	if (IS_ERR_OR_NULL(fwnode))
 		return;
 
-	if (initialized)
-		fwnode->flags |= FWNODE_FLAG_INITIALIZED;
-	else
-		fwnode->flags &= ~FWNODE_FLAG_INITIALIZED;
+	fwnode_assign_flag(fwnode, FWNODE_FLAG_INITIALIZED, initialized);
 }
 
 extern bool fw_devlink_is_strict(void);
-- 
2.54.0.545.g6539524ca2-goog


