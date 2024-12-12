Return-Path: <stable+bounces-101520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89449EECFF
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C24D16A008
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002F2185A0;
	Thu, 12 Dec 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMBM6JIW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAFA6F2FE;
	Thu, 12 Dec 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017843; cv=none; b=ONYE3HX2h9QSkcLSnR6fTrcM2y8EFNvfIHfjVvLStQcDyDkzB0S0yET9+0frUWRQ8kumz4AT6Pz1JKLR7GIRiJjQ8hl8OPFoHI0+DiISb7V65gTEXBKYNblbFapDNK2Fp1W5CBoMFgr0pBhQZzO1ujVYF10IrSLKTl45Ez/rzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017843; c=relaxed/simple;
	bh=sTb7CAGkav8LoJcstNouq9XAjViDmjne1c5bV6uaOPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxAyI6Z1LPDDLEUoPF7rtNKCf5RnyCwbJQGfTq31prX6LVyVTsmxrjhKKvOwKTQKtqXxl1aow4Bh/LEFMUxnBGOgj3EtbQNvhZ3a8y9IoTLSKqLa7PTLAVtGftMc08PFLd/mKL5QwEQvzn2XcfIQd3OX6C3uAJ/PqAD9lJTSVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oMBM6JIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C86C4CED4;
	Thu, 12 Dec 2024 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017843;
	bh=sTb7CAGkav8LoJcstNouq9XAjViDmjne1c5bV6uaOPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMBM6JIWNa5OpJVTs35xHAxGEWAeaz5ckFZEw8dU8JFy0lqN8in3Nrn/vibGfqwf5
	 VBpvvavO8CKXczG4iN3Z3R0Q1AgJShlanFj4UqT8YqLOnjfHbuQWoUOy2g6+FIHnL6
	 fkMtBLwgDdNxkW+D6OShuAbOBOtLXvc/lssTh68A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	stable <stable@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 096/356] driver core: fw_devlink: Stop trying to optimize cycle detection logic
Date: Thu, 12 Dec 2024 15:56:55 +0100
Message-ID: <20241212144248.409382211@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saravana Kannan <saravanak@google.com>

[ Upstream commit bac3b10b78e54b7da3cede397258f75a2180609b ]

In attempting to optimize fw_devlink runtime, I introduced numerous cycle
detection bugs by foregoing cycle detection logic under specific
conditions. Each fix has further narrowed the conditions for optimization.

It's time to give up on these optimization attempts and just run the cycle
detection logic every time fw_devlink tries to create a device link.

The specific bug report that triggered this fix involved a supplier fwnode
that never gets a device created for it. Instead, the supplier fwnode is
represented by the device that corresponds to an ancestor fwnode.

In this case, fw_devlink didn't do any cycle detection because the cycle
detection logic is only run when a device link is created between the
devices that correspond to the actual consumer and supplier fwnodes.

With this change, fw_devlink will run cycle detection logic even when
creating SYNC_STATE_ONLY proxy device links from a device that is an
ancestor of a consumer fwnode.

Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com/
Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of overlapping cycles")
Cc: stable <stable@kernel.org>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Link: https://lore.kernel.org/r/20241030171009.1853340-1-saravanak@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c | 55 ++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3aaf234dbb088..18a73e4921026 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1936,10 +1936,10 @@ static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
  *
  * Return true if one or more cycles were found. Otherwise, return false.
  */
-static bool __fw_devlink_relax_cycles(struct device *con,
+static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 				 struct fwnode_handle *sup_handle)
 {
-	struct device *sup_dev = NULL, *par_dev = NULL;
+	struct device *sup_dev = NULL, *par_dev = NULL, *con_dev = NULL;
 	struct fwnode_link *link;
 	struct device_link *dev_link;
 	bool ret = false;
@@ -1956,22 +1956,22 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 
 	sup_handle->flags |= FWNODE_FLAG_VISITED;
 
-	sup_dev = get_dev_from_fwnode(sup_handle);
-
 	/* Termination condition. */
-	if (sup_dev == con) {
+	if (sup_handle == con_handle) {
 		pr_debug("----- cycle: start -----\n");
 		ret = true;
 		goto out;
 	}
 
+	sup_dev = get_dev_from_fwnode(sup_handle);
+	con_dev = get_dev_from_fwnode(con_handle);
 	/*
 	 * If sup_dev is bound to a driver and @con hasn't started binding to a
 	 * driver, sup_dev can't be a consumer of @con. So, no need to check
 	 * further.
 	 */
 	if (sup_dev && sup_dev->links.status ==  DL_DEV_DRIVER_BOUND &&
-	    con->links.status == DL_DEV_NO_DRIVER) {
+	    con_dev && con_dev->links.status == DL_DEV_NO_DRIVER) {
 		ret = false;
 		goto out;
 	}
@@ -1980,7 +1980,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 		if (link->flags & FWLINK_FLAG_IGNORE)
 			continue;
 
-		if (__fw_devlink_relax_cycles(con, link->supplier)) {
+		if (__fw_devlink_relax_cycles(con_handle, link->supplier)) {
 			__fwnode_link_cycle(link);
 			ret = true;
 		}
@@ -1995,7 +1995,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 	else
 		par_dev = fwnode_get_next_parent_dev(sup_handle);
 
-	if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode)) {
+	if (par_dev && __fw_devlink_relax_cycles(con_handle, par_dev->fwnode)) {
 		pr_debug("%pfwf: cycle: child of %pfwf\n", sup_handle,
 			 par_dev->fwnode);
 		ret = true;
@@ -2013,7 +2013,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 		    !(dev_link->flags & DL_FLAG_CYCLE))
 			continue;
 
-		if (__fw_devlink_relax_cycles(con,
+		if (__fw_devlink_relax_cycles(con_handle,
 					      dev_link->supplier->fwnode)) {
 			pr_debug("%pfwf: cycle: depends on %pfwf\n", sup_handle,
 				 dev_link->supplier->fwnode);
@@ -2061,11 +2061,6 @@ static int fw_devlink_create_devlink(struct device *con,
 	if (link->flags & FWLINK_FLAG_IGNORE)
 		return 0;
 
-	if (con->fwnode == link->consumer)
-		flags = fw_devlink_get_flags(link->flags);
-	else
-		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
-
 	/*
 	 * In some cases, a device P might also be a supplier to its child node
 	 * C. However, this would defer the probe of C until the probe of P
@@ -2086,25 +2081,23 @@ static int fw_devlink_create_devlink(struct device *con,
 		return -EINVAL;
 
 	/*
-	 * SYNC_STATE_ONLY device links don't block probing and supports cycles.
-	 * So, one might expect that cycle detection isn't necessary for them.
-	 * However, if the device link was marked as SYNC_STATE_ONLY because
-	 * it's part of a cycle, then we still need to do cycle detection. This
-	 * is because the consumer and supplier might be part of multiple cycles
-	 * and we need to detect all those cycles.
+	 * Don't try to optimize by not calling the cycle detection logic under
+	 * certain conditions. There's always some corner case that won't get
+	 * detected.
 	 */
-	if (!device_link_flag_is_sync_state_only(flags) ||
-	    flags & DL_FLAG_CYCLE) {
-		device_links_write_lock();
-		if (__fw_devlink_relax_cycles(con, sup_handle)) {
-			__fwnode_link_cycle(link);
-			flags = fw_devlink_get_flags(link->flags);
-			pr_debug("----- cycle: end -----\n");
-			dev_info(con, "Fixed dependency cycle(s) with %pfwf\n",
-				 sup_handle);
-		}
-		device_links_write_unlock();
+	device_links_write_lock();
+	if (__fw_devlink_relax_cycles(link->consumer, sup_handle)) {
+		__fwnode_link_cycle(link);
+		pr_debug("----- cycle: end -----\n");
+		pr_info("%pfwf: Fixed dependency cycle(s) with %pfwf\n",
+			link->consumer, sup_handle);
 	}
+	device_links_write_unlock();
+
+	if (con->fwnode == link->consumer)
+		flags = fw_devlink_get_flags(link->flags);
+	else
+		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
 	if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
 		sup_dev = fwnode_get_next_parent_dev(sup_handle);
-- 
2.43.0




