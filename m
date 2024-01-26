Return-Path: <stable+bounces-15954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C568D83E565
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345C51F237FA
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7DB2557D;
	Fri, 26 Jan 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eWuIWpBD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02C2556D
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308044; cv=none; b=ambBZumqhJmpV8rNuJEbSs6Xd7fam6H0kOttmeTu/9kIJSMgICvff8/+TvlHH12y+aaf39bBLNO5DQKY+Fwr9B4eQnldjU7fxkhmq2DzV3Aa2r20fpc+Xrq0r6CWAHm/HFbBUJouv/rVDQrHsSu4FSl/V8vI+p4oN5eOJ6EJsbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308044; c=relaxed/simple;
	bh=zfa3iS06t367IS9ewJ0I3BFcRD41CTQkSEwS6ZNAYgo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E/fwePe1gmYCqB2D9FqrJH+40YvQaELCi7iruW75gIMUQObuAb4/lwEy9qX5ZVLVuFJVauz25g98t8jvIy9N91dTIiaGHqdBWNU8kXsliQIDEZCr0h2luFtxWZzivqtg9VBpCbnLuhCeLdCtSF+GEow3D0Ue2ATGETLfz3u2Ksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eWuIWpBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A6CC433C7;
	Fri, 26 Jan 2024 22:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706308043;
	bh=zfa3iS06t367IS9ewJ0I3BFcRD41CTQkSEwS6ZNAYgo=;
	h=Subject:To:Cc:From:Date:From;
	b=eWuIWpBDO50TBTVr96IAorXa062JfcT8N+rkdoG0oF7ZroBNSkMQSUYONMTBy6RlZ
	 OTIdaURsKe7+81OotLtzAv3ovfOF6X+sdb/cODGvzHHvh9iGR/p7UpPVO/9Ri1cY1n
	 kgr1IHw3VIIVcODxDE7k8G7gtcqdpzKVQ/pZHwBE=
Subject: FAILED: patch "[PATCH] PM: sleep: Fix possible deadlocks in core system-wide PM code" failed to apply to 5.15-stable tree
To: rafael.j.wysocki@intel.com,stable@vger.kernel.org,stanislaw.gruszka@linux.intel.com,ulf.hansson@linaro.org,youngmin.nam@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:27:22 -0800
Message-ID: <2024012622-sleeve-morale-1ef9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7839d0078e0d5e6cc2fa0b0dfbee71de74f1e557
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012622-sleeve-morale-1ef9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

7839d0078e0d ("PM: sleep: Fix possible deadlocks in core system-wide PM code")
73d73f5ee7fb ("PM: core: Remove unnecessary (void *) conversions")
2aa36604e824 ("PM: sleep: Avoid calling put_device() under dpm_list_mtx")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7839d0078e0d5e6cc2fa0b0dfbee71de74f1e557 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 27 Dec 2023 21:41:06 +0100
Subject: [PATCH] PM: sleep: Fix possible deadlocks in core system-wide PM code

It is reported that in low-memory situations the system-wide resume core
code deadlocks, because async_schedule_dev() executes its argument
function synchronously if it cannot allocate memory (and not only in
that case) and that function attempts to acquire a mutex that is already
held.  Executing the argument function synchronously from within
dpm_async_fn() may also be problematic for ordering reasons (it may
cause a consumer device's resume callback to be invoked before a
requisite supplier device's one, for example).

Address this by changing the code in question to use
async_schedule_dev_nocall() for scheduling the asynchronous
execution of device suspend and resume functions and to directly
run them synchronously if async_schedule_dev_nocall() returns false.

Link: https://lore.kernel.org/linux-pm/ZYvjiqX6EsL15moe@perf/
Reported-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: 5.7+ <stable@vger.kernel.org> # 5.7+: 6aa09a5bccd8 async: Split async_schedule_node_domain()
Cc: 5.7+ <stable@vger.kernel.org> # 5.7+: 7d4b5d7a37bd async: Introduce async_schedule_dev_nocall()
Cc: 5.7+ <stable@vger.kernel.org> # 5.7+

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f85f3515c258..9c5a5f4dba5a 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -579,7 +579,7 @@ bool dev_pm_skip_resume(struct device *dev)
 }
 
 /**
- * device_resume_noirq - Execute a "noirq resume" callback for given device.
+ * __device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
@@ -587,7 +587,7 @@ bool dev_pm_skip_resume(struct device *dev)
  * The driver of @dev will not receive interrupts while this function is being
  * executed.
  */
-static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
+static void __device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -655,7 +655,13 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 Out:
 	complete_all(&dev->power.completion);
 	TRACE_RESUME(error);
-	return error;
+
+	if (error) {
+		suspend_stats.failed_resume_noirq++;
+		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
+	}
 }
 
 static bool is_async(struct device *dev)
@@ -668,11 +674,15 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
 {
 	reinit_completion(&dev->power.completion);
 
-	if (is_async(dev)) {
-		get_device(dev);
-		async_schedule_dev(func, dev);
+	if (!is_async(dev))
+		return false;
+
+	get_device(dev);
+
+	if (async_schedule_dev_nocall(func, dev))
 		return true;
-	}
+
+	put_device(dev);
 
 	return false;
 }
@@ -680,15 +690,19 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
-	int error;
-
-	error = device_resume_noirq(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
 
+	__device_resume_noirq(dev, pm_transition, true);
 	put_device(dev);
 }
 
+static void device_resume_noirq(struct device *dev)
+{
+	if (dpm_async_fn(dev, async_resume_noirq))
+		return;
+
+	__device_resume_noirq(dev, pm_transition, false);
+}
+
 static void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
@@ -698,14 +712,6 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
-	/*
-	 * Advanced the async threads upfront,
-	 * in case the starting of async threads is
-	 * delayed by non-async resuming devices.
-	 */
-	list_for_each_entry(dev, &dpm_noirq_list, power.entry)
-		dpm_async_fn(dev, async_resume_noirq);
-
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
 		get_device(dev);
@@ -713,17 +719,7 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 
 		mutex_unlock(&dpm_list_mtx);
 
-		if (!is_async(dev)) {
-			int error;
-
-			error = device_resume_noirq(dev, state, false);
-			if (error) {
-				suspend_stats.failed_resume_noirq++;
-				dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
-				dpm_save_failed_dev(dev_name(dev));
-				pm_dev_err(dev, state, " noirq", error);
-			}
-		}
+		device_resume_noirq(dev);
 
 		put_device(dev);
 
@@ -751,14 +747,14 @@ void dpm_resume_noirq(pm_message_t state)
 }
 
 /**
- * device_resume_early - Execute an "early resume" callback for given device.
+ * __device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
  *
  * Runtime PM is disabled for @dev while this function is being executed.
  */
-static int device_resume_early(struct device *dev, pm_message_t state, bool async)
+static void __device_resume_early(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -811,21 +807,31 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 
 	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
-	return error;
+
+	if (error) {
+		suspend_stats.failed_resume_early++;
+		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async early" : " early", error);
+	}
 }
 
 static void async_resume_early(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
-	int error;
-
-	error = device_resume_early(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
 
+	__device_resume_early(dev, pm_transition, true);
 	put_device(dev);
 }
 
+static void device_resume_early(struct device *dev)
+{
+	if (dpm_async_fn(dev, async_resume_early))
+		return;
+
+	__device_resume_early(dev, pm_transition, false);
+}
+
 /**
  * dpm_resume_early - Execute "early resume" callbacks for all devices.
  * @state: PM transition of the system being carried out.
@@ -839,14 +845,6 @@ void dpm_resume_early(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
-	/*
-	 * Advanced the async threads upfront,
-	 * in case the starting of async threads is
-	 * delayed by non-async resuming devices.
-	 */
-	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
-		dpm_async_fn(dev, async_resume_early);
-
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
 		get_device(dev);
@@ -854,17 +852,7 @@ void dpm_resume_early(pm_message_t state)
 
 		mutex_unlock(&dpm_list_mtx);
 
-		if (!is_async(dev)) {
-			int error;
-
-			error = device_resume_early(dev, state, false);
-			if (error) {
-				suspend_stats.failed_resume_early++;
-				dpm_save_failed_step(SUSPEND_RESUME_EARLY);
-				dpm_save_failed_dev(dev_name(dev));
-				pm_dev_err(dev, state, " early", error);
-			}
-		}
+		device_resume_early(dev);
 
 		put_device(dev);
 
@@ -888,12 +876,12 @@ void dpm_resume_start(pm_message_t state)
 EXPORT_SYMBOL_GPL(dpm_resume_start);
 
 /**
- * device_resume - Execute "resume" callbacks for given device.
+ * __device_resume - Execute "resume" callbacks for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
  */
-static int device_resume(struct device *dev, pm_message_t state, bool async)
+static void __device_resume(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -975,20 +963,30 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 
 	TRACE_RESUME(error);
 
-	return error;
+	if (error) {
+		suspend_stats.failed_resume++;
+		dpm_save_failed_step(SUSPEND_RESUME);
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async" : "", error);
+	}
 }
 
 static void async_resume(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
-	int error;
 
-	error = device_resume(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
+	__device_resume(dev, pm_transition, true);
 	put_device(dev);
 }
 
+static void device_resume(struct device *dev)
+{
+	if (dpm_async_fn(dev, async_resume))
+		return;
+
+	__device_resume(dev, pm_transition, false);
+}
+
 /**
  * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
  * @state: PM transition of the system being carried out.
@@ -1008,27 +1006,17 @@ void dpm_resume(pm_message_t state)
 	pm_transition = state;
 	async_error = 0;
 
-	list_for_each_entry(dev, &dpm_suspended_list, power.entry)
-		dpm_async_fn(dev, async_resume);
-
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
+
 		get_device(dev);
-		if (!is_async(dev)) {
-			int error;
 
-			mutex_unlock(&dpm_list_mtx);
+		mutex_unlock(&dpm_list_mtx);
+
+		device_resume(dev);
 
-			error = device_resume(dev, state, false);
-			if (error) {
-				suspend_stats.failed_resume++;
-				dpm_save_failed_step(SUSPEND_RESUME);
-				dpm_save_failed_dev(dev_name(dev));
-				pm_dev_err(dev, state, "", error);
-			}
+		mutex_lock(&dpm_list_mtx);
 
-			mutex_lock(&dpm_list_mtx);
-		}
 		if (!list_empty(&dev->power.entry))
 			list_move_tail(&dev->power.entry, &dpm_prepared_list);
 


