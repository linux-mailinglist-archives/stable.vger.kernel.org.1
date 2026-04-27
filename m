Return-Path: <stable+bounces-241424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GjaOYKt72lIDwEAu9opvQ
	(envelope-from <stable+bounces-241424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:40:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD0D478BA3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24163034286
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759433ECBC4;
	Mon, 27 Apr 2026 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bU0WgdDr"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526363EC2F6
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315168; cv=none; b=aBwTES7OLEgdIBkrRst4sxspYsSAQv9VMoP+r3Vz48UHN859aWMpAhziZ4Pc5Lmay+TTd7x49fezC1Xx0PvsDFx6SEopscSgfdlE5JPhnoLkXhgh4Z4GBcvhqTi5RNf5GE7YqpOrouRyIGgg6be5E8xhzCL94WT46YQMrYiC0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315168; c=relaxed/simple;
	bh=k9EOpcUlwgGrF8EGfohUsGYYx6IDnuBNtdp/Dp0kQ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChuZ2otbUHtUOluaRA7Ci5drE5HtJOKKVi/owAt5Ano4ynMJx4kWF+4ag29s30epBW86V1bidaC7I9yWIxTpXKAZBSDjzpczdLVcdcApDuwbJ+5s5mTPKOrTSCTUaD1tlpEM2HzD8nGqKp0hSV55ByYn8cIDllKd5mjqS1h7lRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bU0WgdDr; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c8cc7a77eso5033349c88.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777315165; x=1777919965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obinCWH0mpYeQM/wTjcTBLBJSeHtwz00WlO6qVRfSmc=;
        b=bU0WgdDrwOinXtHO0kPJ0BbIj0GfSoBhQj7OTbQFp7BbBAU32tPlSTda6M0/ZGqPIz
         adwky3dxgxF0Ak2f4XY8372PNbruWDwUR8AoyYA/j3wyTa8lBoPpPX2zc/s9r0hBlzxI
         nzYHHDbP9tZHXv3bsy9JuSIUq9/R1Kaf/XYCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777315165; x=1777919965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obinCWH0mpYeQM/wTjcTBLBJSeHtwz00WlO6qVRfSmc=;
        b=MpRo7Quz/37ih1uGSIK/9Q0+ZU8P7UTJl/ajbVkhy1K9OpFN1jJfv/qCYPfS+XWlMi
         fHyIbIFo7F7t9THEsOk5odJbJFzJvQulJ+fmDy6mxljcU+DVrJ7NSiiUxqIBTDccJis3
         vcbqZwCNhp4ki8GqV/RXnqUxjIfKDF9J2SkyYPegROvCkAra4QlQ1bdEolLuKqA9gUTD
         EGeMk83Kv7Y3b8n8y64E3EH4O3u3ckIOvaG0mUCUaOMTaI0lgCstxd99ttp5lPsVhFPS
         DwvHVkAypcVpmXQPQJ2vKKYTEGawDZMzadokVPcJpLK8Py8Z+eMhbeqTFq5MFxsC36jZ
         vd1A==
X-Gm-Message-State: AOJu0YyBxqb3uZSijiHT64veb8fvf1uKqaSV6HQddzaVUCkrOBnX/7pQ
	DN7E1K/skezzsEoXAh4A9ASlBe1DW2sthPeIUV6mn4ictB6ooG0SKHt1F5kjCcxFJ6cPbKh+ooy
	r2SH8Ytkb
X-Gm-Gg: AeBDievlZxgq1YpkpSdlkfhhKzkJoUwJT4ZekMPNuNLqcKdKdeDTOrb7hj64GxLlbUX
	s4YxEEB8Xrgkj/dK53Mhq3sS/4DR0TIff6xGVLSbjvG13eS4/TJpT5IZIsWbEMMBjnf+LMYcKWI
	MXCmX06GKv4qY4+CYFr+nMtzY4mkL21daUs3JuX2r1ZaSorhJVLLvc4tAZe4gtUBwbd4P6I9eAA
	eNxTcngHHGwX+K6AOQRbdIwiBz0y8YfG8xnhw70jH3ktbcHCV7WBhjsawV1S0X/yAa2qTjz2+ph
	Pn1NHbpXEfCnwacWgSSfE7Uin2N8TqMRUorJSFUBz9b5nuvBH1+g5AHRaeHqGCx/by2DDWgwzg3
	w85tOQ5DoyBqTFdNkFC7vWyx3uX8iX5Wc8eQd8NJFFzM8h/ZFsYWnPe0/Ibragok3FGaLoxDle9
	p9Wo9lDYle7nGcovuozkoxgGEeVhZgACS8ToBETBbg++IigPfzcuHcvu1ZOFL9qyXw42gcrHUKo
	sw9JpyTY/40bqit7uNAyiDdWbgaV6+U
X-Received: by 2002:a05:7022:2219:b0:123:3c24:b15 with SMTP id a92af1059eb24-12ddd6601f8mr117054c88.19.1777315164523;
        Mon, 27 Apr 2026 11:39:24 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:389e:b840:2892:97c2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9493bcsm75972c88.8.2026.04.27.11.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:39:23 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.12.y] device property: Make modifications of fwnode "flags" thread safe
Date: Mon, 27 Apr 2026 11:38:54 -0700
Message-ID: <20260427183854.1889456-1-dianders@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <2026042714-catcher-manly-e588@gregkh>
References: <2026042714-catcher-manly-e588@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FD0D478BA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241424-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[chromium.org:+];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,chromium.org:email,chromium.org:dkim,chromium.org:mid,sang-engineering.com:email]

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
index 09139e265c9b..88895d538b7d 100644
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
@@ -1724,11 +1724,11 @@ bool fw_devlink_is_strict(void)
 
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
@@ -1888,7 +1888,7 @@ static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
 	struct device *dev;
 	bool ret;
 
-	if (!(fwnode->flags & FWNODE_FLAG_INITIALIZED))
+	if (!fwnode_test_flag(fwnode, FWNODE_FLAG_INITIALIZED))
 		return false;
 
 	dev = get_dev_from_fwnode(fwnode);
@@ -2004,10 +2004,10 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
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
@@ -2077,7 +2077,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 	}
 
 out:
-	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
+	fwnode_clear_flag(sup_handle, FWNODE_FLAG_VISITED);
 	put_device(sup_dev);
 	put_device(con_dev);
 	put_device(par_dev);
@@ -2130,7 +2130,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	 * When such a flag is set, we can't create device links where P is the
 	 * supplier of C as that would delay the probe of C.
 	 */
-	if (sup_handle->flags & FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD &&
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD) &&
 	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
 		return -EINVAL;
 
@@ -2153,7 +2153,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	else
 		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
-	if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NOT_DEVICE))
 		sup_dev = fwnode_get_next_parent_dev(sup_handle);
 	else
 		sup_dev = get_dev_from_fwnode(sup_handle);
@@ -2165,7 +2165,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		 * supplier device indefinitely.
 		 */
 		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
-		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
+		    fwnode_test_flag(sup_handle, FWNODE_FLAG_INITIALIZED)) {
 			dev_dbg(con,
 				"Not linking %pfwf - dev might never probe\n",
 				sup_handle);
diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 83d623d97f5f..f735e0462c55 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -332,7 +332,7 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
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
index d80b80ba20a1..1d6216a96d7f 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -705,8 +705,8 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 		return -EINVAL;
 
 	if (bus->parent && bus->parent->of_node)
-		bus->parent->of_node->fwnode.flags |=
-					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
+		fwnode_set_flag(&bus->parent->of_node->fwnode,
+				FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD);
 
 	WARN(bus->state != MDIOBUS_ALLOCATED &&
 	     bus->state != MDIOBUS_UNREGISTERED,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 576f119c2832..83f4065d009e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1793,7 +1793,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
 		if (of_stdout)
-			of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
+			fwnode_set_flag(&of_stdout->fwnode, FWNODE_FLAG_BEST_EFFORT);
 	}
 
 	if (!of_aliases)
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 492f0354a792..f5f624fc327f 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -225,7 +225,7 @@ static void __of_attach_node(struct device_node *np)
 	np->sibling = np->parent->child;
 	np->parent->child = np;
 	of_node_clear_flag(np, OF_DETACHED);
-	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(&np->fwnode, FWNODE_FLAG_NOT_DEVICE);
 
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 11124e965f65..7fe456dddce3 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -744,7 +744,7 @@ static int of_platform_notify(struct notifier_block *nb,
 		 * Clear the flag before adding the device so that fw_devlink
 		 * doesn't skip adding consumers to this device.
 		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 		/* pdev_parent may be NULL when no bus platform device */
 		pdev_parent = of_find_device_by_node(parent);
 		pdev = of_platform_device_create(rd->dn, NULL,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0c3200d08fe4..60ff547dcf0a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4811,7 +4811,7 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		 * Clear the flag before adding the device so that fw_devlink
 		 * doesn't skip adding consumers to this device.
 		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 		spi = of_register_spi_device(ctlr, rd->dn);
 		put_device(&ctlr->dev);
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 487d4bd9b0c9..1455e24ac29e 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -10,6 +10,7 @@
 #define _LINUX_FWNODE_H_
 
 #include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/types.h>
@@ -37,12 +38,12 @@ struct device;
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
@@ -52,7 +53,7 @@ struct fwnode_handle {
 	struct device *dev;
 	struct list_head suppliers;
 	struct list_head consumers;
-	u8 flags;
+	unsigned long flags;
 };
 
 /*
@@ -204,16 +205,37 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
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
 
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
-- 
2.54.0.545.g6539524ca2-goog


