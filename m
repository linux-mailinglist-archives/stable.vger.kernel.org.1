Return-Path: <stable+bounces-241446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIoDCfvZ72mvGwEAu9opvQ
	(envelope-from <stable+bounces-241446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 23:49:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A5F47AEC8
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 23:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3A12303C508
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D137CD32;
	Mon, 27 Apr 2026 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8RT3Hkg"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F52389DFF
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326412; cv=none; b=fimvxIIqUKb9LhfcJXP7BYE8p7K7iIZsk9x0YZxRmoVkbwJcTDTmjn2Dn5LLNVnNnt8hYnKBO09GS8ayqtbBj3TzEjx19PNQYQLRQhysgI6P07KGnJWa2dLmsAvXNbCBTDL36aYa59qsnc3cyWLPQvKf8ZO+ya3ih9NY+OidDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326412; c=relaxed/simple;
	bh=vVh7zN1+CRHBKYHslOwiORfaf5rb26n/fJd66H0tTCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUbVEEJ/HwnopG17HVQbqGwrFtrUDdfRhXAfKxoyhF80wQ7zbBKb5YO1eLrLcLZ8ThA96E+nVSCNLjEaTb6W+KpD5RYQwdDsLeIke52jofMZ0tG9wDiiaACCSGMQaObb4LgPa7pEnyIIAlzc8zlZ2HGwyAWI7JUBbvNySD3+khE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S8RT3Hkg; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c7212836bso449163c88.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777326408; x=1777931208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNVa/wt5mqvpsBTCe2I/jlmFHECqeKe/YOHpVZsua6g=;
        b=S8RT3HkgPc/ZmFeBTpVrDWlUNfB9KltkxAL6CnseVQwSW/lfjwpI8aW6oYEzf/vg0A
         oKx5sukpaC4Izbx0f+/z3adiv9Srj4IjDRcw7+QN6jibVtBo/dw3/MDS7wMHBTSL8BDw
         uSJrIOOu+NYvzx3UjO0siErBCeYrHZZAuyl+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326408; x=1777931208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zNVa/wt5mqvpsBTCe2I/jlmFHECqeKe/YOHpVZsua6g=;
        b=OFYDfz9xjUhejijRW0styZKDQ09MPPItiKxzMHIscaa/4m4KHVZVTWq+daJ7Z98WJJ
         FkYBCnMfBs3LEFNLF+T7rIi0Vswe/MGwbeF7virnIwEzVkcMkZrn3vKzn2ui2A0hU4s2
         86qVv5EMJBjXG5wghZ0TvDS0h7qkLuqtlhZEra3oZK840MirIBhI/d1LHymG0oPwefTA
         E9xaXmAxNa+arVuop+kDczyzER6wyaTL+ehmQ+UF7dinx66UjuVS1UkYbV9IzN5MD7Ix
         +89VdmzBKYPc/qzEeh2CRNuUh5WhEHpUOOHh7IIzMMOPeYz5uXptp7ZdUCbfHaLQnhm+
         Ga/Q==
X-Gm-Message-State: AOJu0YzIyGTvEZGbgcyEUucP6vP1X7K1pq37jzuSFIpmv0z4KV4ypZD8
	lxW5axURzjMnRC7TNxswfGp+MtTxMEAw+WiqMAY8vIt2IYAFQh6wkLaDhQNRB3G4SBF80nMA/tq
	5Wlmu0YbE
X-Gm-Gg: AeBDievHV+s8g8jT0WZM3T8Mxo8WVR7zZizULYtmgdM7d3nzw0T+VHmWmTyy531msJH
	BCbhHE2q1oxFe6c1XPd6KsVKIMkUs7UZ90X6m8Yv+nuB7rx+5pR4tC+6qD5Wk4uNkJBqQ0RG5WW
	h/9tOfWiKtYmG29g6VtuGCBRsb0Y3PPNXmga5Qn01nyNo7LIkfRNjecKhTYbGCJbtvgZM0Rd+ix
	S/RA4D0MVNxwITDTbbmim3oBRAJ3OuMnLmaF2ydZ+Ep9cfKT50nA66MAFPVIl3QDXxiS6o54UDy
	Fv/BH1S/5d2wv+w17rlYMytuFAC46Ride5rQ7tkz5wZTPzZO3/elzAnC0Fc0eRBPaWxnjmVZz9z
	N4wkct03voGQ5KcT/NhbprJm6jq2fSjcAv1Ww8XOJGL+xiJVReJTX3ImAUSiDr7ob0yFAOdiWda
	BSZug7OwAf/ZmFA/hVTCff9+nfpFFQ0Oo8/cwgbCbHHeJnbETIzW/Q1UCE26uS0gqaxZZb7GHfT
	nfHX81eM4zTtzrFgbvnNA==
X-Received: by 2002:a05:7022:6984:b0:11b:ec5f:1c37 with SMTP id a92af1059eb24-12ddd9855dbmr389059c88.18.1777326408155;
        Mon, 27 Apr 2026 14:46:48 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:389e:b840:2892:97c2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9bc2b9sm577403c88.14.2026.04.27.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:46:45 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 5.15.y] device property: Make modifications of fwnode "flags" thread safe
Date: Mon, 27 Apr 2026 14:46:34 -0700
Message-ID: <20260427214635.992400-1-dianders@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <2026042717-tricycle-reaffirm-f074@gregkh>
References: <2026042717-tricycle-reaffirm-f074@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 90A5F47AEC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-241446-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,chromium.org:email,chromium.org:dkim,chromium.org:mid,sang-engineering.com:email]

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
 drivers/base/core.c        | 12 ++++++------
 drivers/net/phy/mdio_bus.c |  4 ++--
 drivers/of/property.c      |  2 +-
 include/linux/fwnode.h     | 40 +++++++++++++++++++++++++++++---------
 4 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4fc62624a95e..31b47d812fa5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -171,7 +171,7 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
 	if (fwnode->dev)
 		return;
 
-	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
 	fwnode_links_purge_consumers(fwnode);
 
 	fwnode_for_each_available_child_node(fwnode, child)
@@ -1620,11 +1620,11 @@ bool fw_devlink_is_strict(void)
 
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
@@ -1765,7 +1765,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	 * When such a flag is set, we can't create device links where P is the
 	 * supplier of C as that would delay the probe of C.
 	 */
-	if (sup_handle->flags & FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD &&
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD) &&
 	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
 		return -EINVAL;
 
@@ -1777,7 +1777,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		 * supplier device indefinitely.
 		 */
 		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
-		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
+		    fwnode_test_flag(sup_handle, FWNODE_FLAG_INITIALIZED)) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -1802,7 +1802,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	}
 
 	/* Supplier that's already initialized without a struct device. */
-	if (sup_handle->flags & FWNODE_FLAG_INITIALIZED)
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_INITIALIZED))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index a8a4cd68f688..1c60581b46d1 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -534,8 +534,8 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 		return -EINVAL;
 
 	if (bus->parent && bus->parent->of_node)
-		bus->parent->of_node->fwnode.flags |=
-					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
+		fwnode_set_flag(&bus->parent->of_node->fwnode,
+				FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD);
 
 	BUG_ON(bus->state != MDIOBUS_ALLOCATED &&
 	       bus->state != MDIOBUS_UNREGISTERED);
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 905ac6466a5b..922f70aa46f3 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1130,7 +1130,7 @@ static int of_link_to_phandle(struct device_node *con_np,
 	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
 	if (!sup_dev &&
 	    (of_node_check_flag(sup_np, OF_POPULATED) ||
-	     sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
+	     fwnode_test_flag(&sup_np->fwnode, FWNODE_FLAG_NOT_DEVICE))) {
 		pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
 			 con_np, sup_np);
 		of_node_put(sup_np);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index f0833bafe6bd..022d9795269e 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
 
 struct fwnode_operations;
@@ -27,10 +28,10 @@ struct device;
  *			     their respective drivers as soon as they are
  *			     added.
  */
-#define FWNODE_FLAG_LINKS_ADDED			BIT(0)
-#define FWNODE_FLAG_NOT_DEVICE			BIT(1)
-#define FWNODE_FLAG_INITIALIZED			BIT(2)
-#define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
+#define FWNODE_FLAG_LINKS_ADDED			0
+#define FWNODE_FLAG_NOT_DEVICE			1
+#define FWNODE_FLAG_INITIALIZED			2
+#define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	3
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
@@ -38,7 +39,7 @@ struct fwnode_handle {
 	struct device *dev;
 	struct list_head suppliers;
 	struct list_head consumers;
-	u8 flags;
+	unsigned long flags;
 };
 
 struct fwnode_link {
@@ -176,16 +177,37 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
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
 
 extern u32 fw_devlink_get_flags(void);
-- 
2.54.0.545.g6539524ca2-goog


