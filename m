Return-Path: <stable+bounces-99016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC19E6DB5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23A8188127F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA91FF61F;
	Fri,  6 Dec 2024 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bDrsu0gQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4E1DACB4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486650; cv=none; b=iX2dIbW++iLdZEYxxNopEJX/LxblNwETZAxSoQeIvNDVJjDH3L6mvSeXNIcqWv4eSuHqGOSSjVwbDuBAaiGcDSVBXYPfYAQu0hhzGn3qMp9L6Fifo2e83Izv1R2GhlsYxcKPUvnDOYRCqTt9wpTamBTh5jk38xxnozwYboR1Wqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486650; c=relaxed/simple;
	bh=EZkYJIBctFumiI5i0qAk+DuQo7MJd4yNNc7DdWJc//s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T+VgYEezlB1sT65ixNfFrxj9Py0+y6x46qJo8nGMfN3MAldbjb3/BCm5ky+ERoeXuH3d6eBl3Pz4m2+X8fdRhK2XhMVcuAMXKiAKy//1fOtDOiHfBahRov55Lc6q3SAbd1VSx9HlWWJg/OIdqrLZPx1wVNepxH9g0y/z61UuyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bDrsu0gQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB867C4CED1;
	Fri,  6 Dec 2024 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733486650;
	bh=EZkYJIBctFumiI5i0qAk+DuQo7MJd4yNNc7DdWJc//s=;
	h=Subject:To:Cc:From:Date:From;
	b=bDrsu0gQ5qeQhQIXoutW0LTBa4LVjb4vgpRf0cBceV2VYSp97eUF/AJuqia4xLtHg
	 NRanCJjHWj0ElqnOvr1KfMbQsrTmzLcIhJw20L4VP6LZZBoHPi9N8umfOY4FBLDn+O
	 CecxsSJrOF+PLklXLuPEPnGtpSRcuAZ//xdGPMcI=
Subject: FAILED: patch "[PATCH] driver core: fw_devlink: Stop trying to optimize cycle" failed to apply to 6.1-stable tree
To: saravanak@google.com,gregkh@linuxfoundation.org,stable@kernel.org,tomi.valkeinen@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:03:59 +0100
Message-ID: <2024120659-hasty-crunching-8425@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bac3b10b78e54b7da3cede397258f75a2180609b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120659-hasty-crunching-8425@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bac3b10b78e54b7da3cede397258f75a2180609b Mon Sep 17 00:00:00 2001
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 30 Oct 2024 10:10:07 -0700
Subject: [PATCH] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic

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

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 54b25570a492..633fb4283282 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1989,10 +1989,10 @@ static struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwn
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
@@ -2009,22 +2009,22 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 
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
@@ -2033,7 +2033,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 		if (link->flags & FWLINK_FLAG_IGNORE)
 			continue;
 
-		if (__fw_devlink_relax_cycles(con, link->supplier)) {
+		if (__fw_devlink_relax_cycles(con_handle, link->supplier)) {
 			__fwnode_link_cycle(link);
 			ret = true;
 		}
@@ -2048,7 +2048,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 	else
 		par_dev = fwnode_get_next_parent_dev(sup_handle);
 
-	if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode)) {
+	if (par_dev && __fw_devlink_relax_cycles(con_handle, par_dev->fwnode)) {
 		pr_debug("%pfwf: cycle: child of %pfwf\n", sup_handle,
 			 par_dev->fwnode);
 		ret = true;
@@ -2066,7 +2066,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 		    !(dev_link->flags & DL_FLAG_CYCLE))
 			continue;
 
-		if (__fw_devlink_relax_cycles(con,
+		if (__fw_devlink_relax_cycles(con_handle,
 					      dev_link->supplier->fwnode)) {
 			pr_debug("%pfwf: cycle: depends on %pfwf\n", sup_handle,
 				 dev_link->supplier->fwnode);
@@ -2114,11 +2114,6 @@ static int fw_devlink_create_devlink(struct device *con,
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
@@ -2139,25 +2134,23 @@ static int fw_devlink_create_devlink(struct device *con,
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


