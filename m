Return-Path: <stable+bounces-171991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F5DB2F894
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79C11CE303C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9D93218CD;
	Thu, 21 Aug 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kq7+2mf8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB53218BA
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780170; cv=none; b=OfqfP9aCLP2iiN4f7NYu+m9fi2iNEg2HP8W2XqjobdUI6Z41tgWhP8v/4m8/mF/2Q7X9bOLb7jCvipgCXFIP6b6rZzCZA7MssovR8ks4LuTaSczSBjXVqF2cLVVWr9V8ZJ0gEJ/T0B7AJyiucfGLfUcvbbXqixNeGQ0XD3LA+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780170; c=relaxed/simple;
	bh=HcRoiaCqfa6Cjd8Pbsp8TsD+H2VJGFT0Q/40QCEe0cg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mec7ZJM5rlOB6CkHpn0vY8qS1FyALWG3Lf3OelgyoYNEEfqWBY/ewozH/oo93zfJlzUaEDFe0PTSSD/UqC+Fa9TWIHOVbPGUoC2jP1C5FcVE4IV6KgttIrVnvcGy+cbmcqnGQoQ13B6q9pQYzVZQDK0adXSrypwETrRdgjiq/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kq7+2mf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D40BC113CF;
	Thu, 21 Aug 2025 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780170;
	bh=HcRoiaCqfa6Cjd8Pbsp8TsD+H2VJGFT0Q/40QCEe0cg=;
	h=Subject:To:Cc:From:Date:From;
	b=kq7+2mf88gG1X1QYWTXrrQkaQH9DVJBgT4NbgoFAzsPuNZu5uMK0oEFi+dqXjoWHH
	 eu+sArSYQIFvP43BXymfH8fmA2w0CTbwDas/xsSgubw0I15HW5YUuFNXc49cY0cTcf
	 VWBMOSqekzKiJxnjtsGp3iej4ifiU6ReS6wHfgas=
Subject: FAILED: patch "[PATCH] PM: runtime: Take active children into account in" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,sakari.ailus@linux.intel.com,stable@vger.kernel.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:42:30 +0200
Message-ID: <2025082130-droop-update-8564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 51888393cc64dd0462d0b96c13ab94873abbc030
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082130-droop-update-8564@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51888393cc64dd0462d0b96c13ab94873abbc030 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 9 Jul 2025 12:41:45 +0200
Subject: [PATCH] PM: runtime: Take active children into account in
 pm_runtime_get_if_in_use()

For all practical purposes, there is no difference between the situation
in which a given device is not ignoring children and its active child
count is nonzero and the situation in which its runtime PM usage counter
is nonzero.  However, pm_runtime_get_if_in_use() will only increment the
device's usage counter and return 1 in the latter case.

For consistency, make it do so in the former case either by adjusting
pm_runtime_get_conditional() and update the related kerneldoc comments
accordingly.

Fixes: c111566bea7c ("PM: runtime: Add pm_runtime_get_if_active()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: 5.10+ <stable@vger.kernel.org> # 5.10+: c0ef3df8dbae: PM: runtime: Simplify pm_runtime_get_if_active() usage
Cc: 5.10+ <stable@vger.kernel.org> # 5.10+
Link: https://patch.msgid.link/12700973.O9o76ZdvQC@rjwysocki.net

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index c55a7c70bc1a..2ba0dfd1de5a 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1191,10 +1191,12 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
  *
  * Return -EINVAL if runtime PM is disabled for @dev.
  *
- * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and either
- * @ign_usage_count is %true or the runtime PM usage counter of @dev is not
- * zero, increment the usage counter of @dev and return 1. Otherwise, return 0
- * without changing the usage counter.
+ * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage_count
+ * is set, or (2) @dev is not ignoring children and its active child count is
+ * nonero, or (3) the runtime PM usage counter of @dev is not zero, increment
+ * the usage counter of @dev and return 1.
+ *
+ * Otherwise, return 0 without changing the usage counter.
  *
  * If @ign_usage_count is %true, this function can be used to prevent suspending
  * the device when its runtime PM status is %RPM_ACTIVE.
@@ -1216,7 +1218,8 @@ static int pm_runtime_get_conditional(struct device *dev, bool ign_usage_count)
 		retval = -EINVAL;
 	} else if (dev->power.runtime_status != RPM_ACTIVE) {
 		retval = 0;
-	} else if (ign_usage_count) {
+	} else if (ign_usage_count || (!dev->power.ignore_children &&
+		   atomic_read(&dev->power.child_count) > 0)) {
 		retval = 1;
 		atomic_inc(&dev->power.usage_count);
 	} else {
@@ -1249,10 +1252,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
  * @dev: Target device.
  *
  * Increment the runtime PM usage counter of @dev if its runtime PM status is
- * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
- * it returns 1. If the device is in a different state or its usage_count is 0,
- * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device,
- * in which case also the usage_count will remain unmodified.
+ * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or it is not
+ * ignoring children and its active child count is nonzero.  1 is returned in
+ * this case.
+ *
+ * If @dev is in a different state or it is not in use (that is, its usage
+ * counter is 0, or it is ignoring children, or its active child count is 0),
+ * 0 is returned.
+ *
+ * -EINVAL is returned if runtime PM is disabled for the device, in which case
+ * also the usage counter of @dev is not updated.
  */
 int pm_runtime_get_if_in_use(struct device *dev)
 {


