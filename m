Return-Path: <stable+bounces-113207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E1A29076
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD0C3A21CE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560D27DA6A;
	Wed,  5 Feb 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sMQMWZQt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5F151988;
	Wed,  5 Feb 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766181; cv=none; b=YlerOSU0SUOq7+zIiMsKnWJhUYTdbLKLNh0V1SwClLiRf8C2USc1GLj37su0nkScTl81oML+lTR1dqYPimCajZIyzUTCRdRDh3hpzA22hTHc64mJ0pyw/j9TUwFZgQiDCfLt7XoDV1WXrT+svGzHWb2Yim5edKNs3CgXVONMavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766181; c=relaxed/simple;
	bh=936TuQTZHEz8tsVTZ3mo4sqWzXffcnasqg8Vo86P+oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUxrSRuNqj7avKiRVnMw1WoL4P9bBc8yDSJT3ygrlfACsMH0WvEFzvsBDaPXLFmMXPqJwyOtgm7D5skh+w7seXbbSGsdbUmQrBx0kikgfWIjRQZaP8Pd2gq27I1bYs0Xe9i+u8Pq8MxZgIoJnoOvYq7Z1+t+1szgx6QRuW1IQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sMQMWZQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73254C4CED1;
	Wed,  5 Feb 2025 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766180;
	bh=936TuQTZHEz8tsVTZ3mo4sqWzXffcnasqg8Vo86P+oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMQMWZQtvaD3AeTEZXVmrG8T+xIAbellMNoYi3LqQwsiwzHzaH40JSi5+DfFIJia/
	 fcgK3VYZheA0GG7hKO3czmFTLq8GGfO5QWEnkHWi8vqKH/7nKxP86gtUdgrejF2mhg
	 dfYZfs2drlnxEHyXKb3iVndL+xorLAcjXrMkTMGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 337/393] PM: sleep: Restore asynchronous device resume optimization
Date: Wed,  5 Feb 2025 14:44:16 +0100
Message-ID: <20250205134433.204322904@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 3e999770ac1c7c31a70685dd5b88e89473509e9c ]

Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
system-wide PM code"), the resume of devices that were allowed to resume
asynchronously was scheduled before starting the resume of the other
devices, so the former did not have to wait for the latter unless
functional dependencies were present.

Commit 7839d0078e0d removed that optimization in order to address a
correctness issue, but it can be restored with the help of a new device
power management flag, so do that now.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Stable-dep-of: 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of parents and children")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/main.c | 117 +++++++++++++++++++++-----------------
 include/linux/pm.h        |   1 +
 2 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 9c5a5f4dba5a6..fadcd0379dc2d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -579,7 +579,7 @@ bool dev_pm_skip_resume(struct device *dev)
 }
 
 /**
- * __device_resume_noirq - Execute a "noirq resume" callback for given device.
+ * device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
@@ -587,7 +587,7 @@ bool dev_pm_skip_resume(struct device *dev)
  * The driver of @dev will not receive interrupts while this function is being
  * executed.
  */
-static void __device_resume_noirq(struct device *dev, pm_message_t state, bool async)
+static void device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -674,16 +674,22 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
 {
 	reinit_completion(&dev->power.completion);
 
-	if (!is_async(dev))
-		return false;
-
-	get_device(dev);
+	if (is_async(dev)) {
+		dev->power.async_in_progress = true;
 
-	if (async_schedule_dev_nocall(func, dev))
-		return true;
+		get_device(dev);
 
-	put_device(dev);
+		if (async_schedule_dev_nocall(func, dev))
+			return true;
 
+		put_device(dev);
+	}
+	/*
+	 * Because async_schedule_dev_nocall() above has returned false or it
+	 * has not been called at all, func() is not running and it is safe to
+	 * update the async_in_progress flag without extra synchronization.
+	 */
+	dev->power.async_in_progress = false;
 	return false;
 }
 
@@ -691,18 +697,10 @@ static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
 
-	__device_resume_noirq(dev, pm_transition, true);
+	device_resume_noirq(dev, pm_transition, true);
 	put_device(dev);
 }
 
-static void device_resume_noirq(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_resume_noirq))
-		return;
-
-	__device_resume_noirq(dev, pm_transition, false);
-}
-
 static void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
@@ -712,18 +710,28 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
+	/*
+	 * Trigger the resume of "async" devices upfront so they don't have to
+	 * wait for the "non-async" ones they don't depend on.
+	 */
+	list_for_each_entry(dev, &dpm_noirq_list, power.entry)
+		dpm_async_fn(dev, async_resume_noirq);
+
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
-		get_device(dev);
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
 
-		mutex_unlock(&dpm_list_mtx);
+		if (!dev->power.async_in_progress) {
+			get_device(dev);
 
-		device_resume_noirq(dev);
+			mutex_unlock(&dpm_list_mtx);
 
-		put_device(dev);
+			device_resume_noirq(dev, state, false);
 
-		mutex_lock(&dpm_list_mtx);
+			put_device(dev);
+
+			mutex_lock(&dpm_list_mtx);
+		}
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
@@ -747,14 +755,14 @@ void dpm_resume_noirq(pm_message_t state)
 }
 
 /**
- * __device_resume_early - Execute an "early resume" callback for given device.
+ * device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
  *
  * Runtime PM is disabled for @dev while this function is being executed.
  */
-static void __device_resume_early(struct device *dev, pm_message_t state, bool async)
+static void device_resume_early(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -820,18 +828,10 @@ static void async_resume_early(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
 
-	__device_resume_early(dev, pm_transition, true);
+	device_resume_early(dev, pm_transition, true);
 	put_device(dev);
 }
 
-static void device_resume_early(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_resume_early))
-		return;
-
-	__device_resume_early(dev, pm_transition, false);
-}
-
 /**
  * dpm_resume_early - Execute "early resume" callbacks for all devices.
  * @state: PM transition of the system being carried out.
@@ -845,18 +845,28 @@ void dpm_resume_early(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
+	/*
+	 * Trigger the resume of "async" devices upfront so they don't have to
+	 * wait for the "non-async" ones they don't depend on.
+	 */
+	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
+		dpm_async_fn(dev, async_resume_early);
+
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
-		get_device(dev);
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
 
-		mutex_unlock(&dpm_list_mtx);
+		if (!dev->power.async_in_progress) {
+			get_device(dev);
 
-		device_resume_early(dev);
+			mutex_unlock(&dpm_list_mtx);
 
-		put_device(dev);
+			device_resume_early(dev, state, false);
 
-		mutex_lock(&dpm_list_mtx);
+			put_device(dev);
+
+			mutex_lock(&dpm_list_mtx);
+		}
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
@@ -876,12 +886,12 @@ void dpm_resume_start(pm_message_t state)
 EXPORT_SYMBOL_GPL(dpm_resume_start);
 
 /**
- * __device_resume - Execute "resume" callbacks for given device.
+ * device_resume - Execute "resume" callbacks for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
  */
-static void __device_resume(struct device *dev, pm_message_t state, bool async)
+static void device_resume(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -975,18 +985,10 @@ static void async_resume(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
 
-	__device_resume(dev, pm_transition, true);
+	device_resume(dev, pm_transition, true);
 	put_device(dev);
 }
 
-static void device_resume(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_resume))
-		return;
-
-	__device_resume(dev, pm_transition, false);
-}
-
 /**
  * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
  * @state: PM transition of the system being carried out.
@@ -1006,16 +1008,25 @@ void dpm_resume(pm_message_t state)
 	pm_transition = state;
 	async_error = 0;
 
+	/*
+	 * Trigger the resume of "async" devices upfront so they don't have to
+	 * wait for the "non-async" ones they don't depend on.
+	 */
+	list_for_each_entry(dev, &dpm_suspended_list, power.entry)
+		dpm_async_fn(dev, async_resume);
+
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
 
 		get_device(dev);
 
-		mutex_unlock(&dpm_list_mtx);
+		if (!dev->power.async_in_progress) {
+			mutex_unlock(&dpm_list_mtx);
 
-		device_resume(dev);
+			device_resume(dev, state, false);
 
-		mutex_lock(&dpm_list_mtx);
+			mutex_lock(&dpm_list_mtx);
+		}
 
 		if (!list_empty(&dev->power.entry))
 			list_move_tail(&dev->power.entry, &dpm_prepared_list);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 629c1633bbd00..943b553720f82 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -681,6 +681,7 @@ struct dev_pm_info {
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
+	bool			async_in_progress:1;	/* Owned by the PM core */
 	unsigned int		must_resume:1;	/* Owned by the PM core */
 	unsigned int		may_skip_resume:1;	/* Set by subsystems */
 #else
-- 
2.39.5




