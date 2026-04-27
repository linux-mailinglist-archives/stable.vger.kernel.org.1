Return-Path: <stable+bounces-241440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEUaGaXH72m4FwEAu9opvQ
	(envelope-from <stable+bounces-241440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:31:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2247A0B2
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04933009B2A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1E36D503;
	Mon, 27 Apr 2026 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cvYCL+Jv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28731302742
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321596; cv=none; b=kseMfdCUBAUestTr2Men3GWHr82ncGhqk4BVsoxdYe6qsuO5R4XoOFR+IJuKiUvnBG6SkeBLQJYkoeA8+QIR4I3sawM96aRwpo2Vv3nRe1OQpRH6RKTglcR++MRMKqOnbIJ1Y+n0aMmi61Stw7Kufh7Fg4C7uZcNmP2870TlMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321596; c=relaxed/simple;
	bh=Bk17j20ufcdLqEX1RS+ruQusW52+kIPlhjmXDpnmjjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4nBuna/4RFpVXkE3gvZenKlQyYtSTlUnbyOZAESKpZta0oF8LuT9pV95xS903MrKBumDTTaw3rU/b+oBeJ6/lyFMynjKrmCw7JGxYymTG3FtOp/p+hCCXtb3NeVPt7gmiHZbcccNYgWhXqUi8QVqIlJ2+AbpDilc2qcyNDzWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cvYCL+Jv; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c15849aa2cso14261698eec.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777321592; x=1777926392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViU8w1ZmgIzNxynsCjWM+kZcEoyOjIDhwLYuomGluIY=;
        b=cvYCL+JvZ4Xf1u9zbiNrx3K1drk35sOFhJ2CrtEWmv/xkvggDmad/wlNORX7cULb2v
         iEWntG30FzbzpZt4wIzwDMnc10Nm/ASiDoncNJfWslMr7EqFt/UhYyjbDFrUSW8WEvIt
         fOPsZkXQ66/OOl2D7S5n/Lr2sjstQpVr9gOGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321592; x=1777926392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViU8w1ZmgIzNxynsCjWM+kZcEoyOjIDhwLYuomGluIY=;
        b=rlXOCk59RCS/sZdR3GQn8HdZLPBRWPea7hzIOPZmD1kyh2p/YgsK7CMx3OvT15GGku
         /APUVbUcJZyhjPYWdSPVK8oZEwAIqCZVde0gRF0QRG5IuqPxsYkDj1SBB0ygLOjsPm4E
         IpUKK1gWwEEZRIPPHgM4xfnAnDZL+ALHd729EwzcxLYAuYBnfJ3W7+1hG/98wTA8GdLl
         /SD/8UyEQMKRjBqilWPB7HxZsCUDwbfyGGPmK1M5GZikl9Y7dobtDS1QsW1dXYkvau0h
         DtZ2FT+K9MmNieFwxqRiL1odpmlewy9BIUIwD2U4sogxZLePUBox6RWyaoJEJHifjJQr
         L1Jg==
X-Gm-Message-State: AOJu0YxgmrZ0ogb3aPR0i9MsEAttIgONvns3pVUqn8OXrg+oFBu8uUsM
	ZVZxkehBGzTNxjvXj2690HkhKXi9DnB4ndrUvkK+HQij3VtvZNutmESTQeBSDVeKmrRsq9+CnC7
	rNbR5lpoW
X-Gm-Gg: AeBDietBncn5r0yJSMsPJdycqLUNYxIP3O8CZccsztLAsKL60XGaXNqzU1Uz7JkqDrh
	/JNzOQBSo4kVs9c3DawPJ/tsa9WWU3yFNBmynMdO6qL2HL3ktSNha+tY4pT4NIHu9n9Jn1qfu0r
	SiiXrdt+y4eWTq+rwWOVdaqk3IJpiDSxCW7I6dd/NWg5Ua3XZ/4HgXi0PmvcCq+HkYvgwoiYNsx
	9S3rwTHhvTp1x1YMgzgyMOOqpnX9QI2euRksMOHqFBgLklgMHHqVx4jbRgVIClrr/TVcnZ5iYS6
	tJNCp4TJyuznRJAFt40Phmgz0+2yvHcnXWNzbIzMctlhp9uEi1+ZrdIGxx5Z1d9CNaSpfepoO/C
	yuVld0Jxdv9iaQzsm1xbSRtr++yzrxzp1FD+QOY4gHxxKOA/ysXMPZWZxF/7lab58VuDPDzBSKg
	GHdwqPXqD8rRB3uatNFVblriRqtqeSr5g9XI6G+nBoAWZcLRyYyAjlkpPWu7vN0FVZA66jA2VVD
	UNp1meVu48NTYlOF7FiZg==
X-Received: by 2002:a05:7301:1691:b0:2dd:144b:6c2 with SMTP id 5a478bee46e88-2ed0a177bcamr200377eec.27.1777321592441;
        Mon, 27 Apr 2026 13:26:32 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:389e:b840:2892:97c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a0ce7cesm448465eec.17.2026.04.27.13.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:26:31 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.1.y] device property: Make modifications of fwnode "flags" thread safe
Date: Mon, 27 Apr 2026 13:26:22 -0700
Message-ID: <20260427202622.2304714-1-dianders@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <2026042716-relish-stumble-7a90@gregkh>
References: <2026042716-relish-stumble-7a90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8F2247A0B2
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
	TAGGED_FROM(0.00)[bounces-241440-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url]

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
index d985c4b87de5..157775dc401b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -194,7 +194,7 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
 	if (fwnode->dev)
 		return;
 
-	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
 	fwnode_links_purge_consumers(fwnode);
 
 	fwnode_for_each_available_child_node(fwnode, child)
@@ -240,7 +240,7 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
 	if (fwnode->dev && fwnode->dev->bus)
 		return;
 
-	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
 	__fwnode_links_move_consumers(fwnode, new_sup);
 
 	fwnode_for_each_available_child_node(fwnode, child)
@@ -1070,7 +1070,7 @@ static void device_links_missing_supplier(struct device *dev)
 static bool dev_is_best_effort(struct device *dev)
 {
 	return (fw_devlink_best_effort && dev->can_match) ||
-		(dev->fwnode && (dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT));
+		(dev->fwnode && fwnode_test_flag(dev->fwnode, FWNODE_FLAG_BEST_EFFORT));
 }
 
 static struct fwnode_handle *fwnode_links_check_suppliers(
@@ -1764,11 +1764,11 @@ bool fw_devlink_is_strict(void)
 
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
@@ -1889,7 +1889,7 @@ static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
 	struct device *dev;
 	bool ret;
 
-	if (!(fwnode->flags & FWNODE_FLAG_INITIALIZED))
+	if (!fwnode_test_flag(fwnode, FWNODE_FLAG_INITIALIZED))
 		return false;
 
 	dev = get_dev_from_fwnode(fwnode);
@@ -1948,10 +1948,10 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
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
@@ -2021,7 +2021,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 	}
 
 out:
-	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
+	fwnode_clear_flag(sup_handle, FWNODE_FLAG_VISITED);
 	put_device(sup_dev);
 	put_device(con_dev);
 	put_device(par_dev);
@@ -2074,7 +2074,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	 * When such a flag is set, we can't create device links where P is the
 	 * supplier of C as that would delay the probe of C.
 	 */
-	if (sup_handle->flags & FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD &&
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD) &&
 	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
 		return -EINVAL;
 
@@ -2097,7 +2097,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	else
 		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
-	if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NOT_DEVICE))
 		sup_dev = fwnode_get_next_parent_dev(sup_handle);
 	else
 		sup_dev = get_dev_from_fwnode(sup_handle);
@@ -2109,7 +2109,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		 * supplier device indefinitely.
 		 */
 		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
-		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
+		    fwnode_test_flag(sup_handle, FWNODE_FLAG_INITIALIZED)) {
 			dev_dbg(con,
 				"Not linking %pfwf - dev might never probe\n",
 				sup_handle);
diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 64f9eacd1b38..6e894a1c278c 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -336,7 +336,7 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
 			 * fw_devlink doesn't skip adding consumers to this
 			 * device.
 			 */
-			rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+			fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 			if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
 				dev_err(&pdev->dev,
 					"Failed to create child device '%pOF'\n",
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 545436b7dd53..cf7380acd779 100644
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
index 726799b1e7fa..f9d12ccdcd27 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -539,8 +539,8 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 		return -EINVAL;
 
 	if (bus->parent && bus->parent->of_node)
-		bus->parent->of_node->fwnode.flags |=
-					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
+		fwnode_set_flag(&bus->parent->of_node->fwnode,
+				FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD);
 
 	WARN(bus->state != MDIOBUS_ALLOCATED &&
 	     bus->state != MDIOBUS_UNREGISTERED,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 17d5b3759fcb..b88bf567e0a7 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1927,7 +1927,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
 		if (of_stdout)
-			of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
+			fwnode_set_flag(&of_stdout->fwnode, FWNODE_FLAG_BEST_EFFORT);
 	}
 
 	if (!of_aliases)
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index e2a9651014c6..7ecfd885999b 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -227,7 +227,7 @@ static void __of_attach_node(struct device_node *np)
 	np->sibling = np->parent->child;
 	np->parent->child = np;
 	of_node_clear_flag(np, OF_DETACHED);
-	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(&np->fwnode, FWNODE_FLAG_NOT_DEVICE);
 }
 
 /**
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 28ae47fcf3bf..212dcfe71b73 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -745,7 +745,7 @@ static int of_platform_notify(struct notifier_block *nb,
 		 * Clear the flag before adding the device so that fw_devlink
 		 * doesn't skip adding consumers to this device.
 		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 		/* pdev_parent may be NULL when no bus platform device */
 		pdev_parent = of_find_device_by_node(rd->dn->parent);
 		pdev = of_platform_device_create(rd->dn, NULL,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 98f720652e07..7e0ae99d953e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4480,7 +4480,7 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
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


