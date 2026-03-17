Return-Path: <stable+bounces-226741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMu1EnGUuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:50:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D882B0375
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ADB333071ED
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2516B2FFDEA;
	Tue, 17 Mar 2026 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWdEGP0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6482D5940
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768004; cv=none; b=l6Pu+EMl5EBwBHNxOv4aDJowXF134Km2fTeko7dATp8u2k//Eat6KKgDYXw5yBo1W0zKu8zoM7U3njALvEiDZKitE5wapmGhLREG1XktWH3mbNv+ugmCpt0NFk1I9Q5oODnhJuyNH8ZfDCuPdBr4XXWbiC51HwEqtcLPmmAun2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768004; c=relaxed/simple;
	bh=x58RrmHbTCDvkv1RureJwzjZfV2LaTjBbFWat8iu2HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUe9hLzIi4HFyoRzCfUErgo10GDPjY7yUDkt1scaMXev+kgUOVUpjZ5sp3kHWGNCgxjh9FY0P85JGmw3TM4CCe9D0L/ZQ2lpONr6FWM1eU3h/TGd0fKCcx4e1ww12LZ8R14OeI6GREi+d2m0/x3GGgr6Fu2y8SBZADrKtshkcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWdEGP0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C63BC19424;
	Tue, 17 Mar 2026 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768004;
	bh=x58RrmHbTCDvkv1RureJwzjZfV2LaTjBbFWat8iu2HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWdEGP0lG7xvXxyiEse7JtSu/QuuCpwupJOObOKve6btO+upBdEz1m0MLI4AnybIn
	 qU6CCbJLD2Oc+qvdLf65AUBN6E53YFUX51/2sR2qr+FuXkTpOy80QBlXBqWuMWTkCG
	 pn2RH+eEMYViXcgMTP2boi0zmWqK77nz9OqfCrQTzmqfKhp4jwMGQnKo0e7RbtRUVl
	 PUVpZy3CBDRzigoWzvLvz1/XUmgtfi+J9aVIE5eeOanjQijbdccDGoiaFJJVb8zGvY
	 G+skO0WasFPHTtgW97wOcLhI87svVpJN2aq6+NYRDpB31laxk4yKh8mo/+QyttMP6K
	 z6ZfSJ/DXUdhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 8/8] device property: Allow secondary lookup in fwnode_get_next_child_node()
Date: Tue, 17 Mar 2026 13:19:54 -0400
Message-ID: <20260317171954.238398-8-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317171954.238398-1-sashal@kernel.org>
References: <2026031703-caravan-bladder-c63a@gregkh>
 <20260317171954.238398-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226741-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B0D882B0375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 2692c614f8f05929d692b3dbfd3faef1f00fbaf0 ]

When device_get_child_node_count() got split to the fwnode and device
respective APIs, the fwnode didn't inherit the ability to traverse over
the secondary fwnode. Hence any user, that switches from device to fwnode
API misses this feature. In particular, this was revealed by the commit
1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
that effectively broke the GPIO enumeration on Intel Galileo boards.
Fix this by moving the secondary lookup from device to fwnode API.

Note, in general no device_*() API should go into the depth of the fwnode
implementation.

Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try secondary")
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Link: https://patch.msgid.link/20260210135822.47335-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index ed767dc2630d0..2577d0e9bfbd7 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -740,7 +740,18 @@ struct fwnode_handle *
 fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 			   struct fwnode_handle *child)
 {
-	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	struct fwnode_handle *next;
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return NULL;
+
+	/* Try to find a child in primary fwnode */
+	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	if (next)
+		return next;
+
+	/* When no more children in primary, continue with secondary */
+	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
@@ -778,19 +789,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child)
 {
-	const struct fwnode_handle *fwnode = dev_fwnode(dev);
-	struct fwnode_handle *next;
-
-	if (IS_ERR_OR_NULL(fwnode))
-		return NULL;
-
-	/* Try to find a child in primary fwnode */
-	next = fwnode_get_next_child_node(fwnode, child);
-	if (next)
-		return next;
-
-	/* When no more children in primary, continue with secondary */
-	return fwnode_get_next_child_node(fwnode->secondary, child);
+	return fwnode_get_next_child_node(dev_fwnode(dev), child);
 }
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
-- 
2.51.0


