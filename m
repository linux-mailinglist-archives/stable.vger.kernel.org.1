Return-Path: <stable+bounces-72692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7797B9682A8
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2031C223EC
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D8187860;
	Mon,  2 Sep 2024 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e176yBZf"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DD187347;
	Mon,  2 Sep 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267919; cv=none; b=hduCC1SPmrA+nTmmoPOmDjGwZgHgeLF8S6nwWe+kWKEbzRD3SLZU6wyK/HXof5nTWTX9P8XxHaa0ZxYhv/greeyjjBnbIqKGrVJXZx6XRMhoP8B2yX+D2HUw0JRcOAA8SiiaaTWfm/oRKtFiroNqVQ1AEjNPLa0w9tYEiMCFRIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267919; c=relaxed/simple;
	bh=6kXgoEbyYiLZ1G6SnTdMu9MTeg2P5tAWgxwRiQilXV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/xosz6EEhazQI8rdQvfMeRLmZlcypfJ87I3WCTZktasUQWBmnmtJU78L6z0gS/rxWZhfrac1VqO1iL763mG1T1t15rMd5Z0jzLaVUOzNGTjt1AWEYlrhwvlKUf4CgrlKGghCFU4+Psq7QncJYzXN4a5p8G3NeURXsaW7HV3cjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e176yBZf; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 727b2664690a11ef8593d301e5c8a9c0-20240902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xIryvvfhdE0gevbKGyptfnYsNFkeLorENRvuAQSG+/8=;
	b=e176yBZf46FlAvTT0DwVVbjacXWH+MWmxU0F9o5iRiD4s3W74v7AQhXOrbPQ6N/mNIsd3TkGP9Vh/KG388FFKt5T+W6i7kpvozWcU0qC9QHlntL5CK0gmD4IO2cS25foMPTTJNz6DxO5mKxzUk7W0VC1Zqv5PttzbsvmcBVeDWI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:790c5ae8-e0f6-46a2-bc9a-1fe4d88a565a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:30564fbf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 727b2664690a11ef8593d301e5c8a9c0-20240902
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 972375557; Mon, 02 Sep 2024 17:05:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Sep 2024 17:05:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Sep 2024 17:05:06 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <stable@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yenchia Chen
	<yenchia.chen@mediatek.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5.15 v2] PM: sleep: Restore asynchronous device resume optimization
Date: Mon, 2 Sep 2024 17:04:11 +0800
Message-ID: <20240902090413.15942-1-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <2024090250-reliably-ecard-3b58@gregkh>
References: <2024090250-reliably-ecard-3b58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

commit 3e999770ac1c7c31a70685dd5b88e89473509e9c upstream.

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
Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
---
 drivers/base/power/main.c | 117 +++++++++++++++++++++-----------------
 include/linux/pm.h        |   1 +
 2 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 185ea0d93a5e..01591c105511 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -580,7 +580,7 @@ bool dev_pm_skip_resume(struct device *dev)
 }
 
 /**
- * __device_resume_noirq - Execute a "noirq resume" callback for given device.
+ * device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
@@ -588,7 +588,7 @@ bool dev_pm_skip_resume(struct device *dev)
  * The driver of @dev will not receive interrupts while this function is being
  * executed.
  */
-static void __device_resume_noirq(struct device *dev, pm_message_t state, bool async)
+static void device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -675,16 +675,22 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
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
 
@@ -692,18 +698,10 @@ static void async_resume_noirq(void *data, async_cookie_t cookie)
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
@@ -713,18 +711,28 @@ static void dpm_noirq_resume_devices(pm_message_t state)
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
@@ -750,14 +758,14 @@ void dpm_resume_noirq(pm_message_t state)
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
@@ -823,18 +831,10 @@ static void async_resume_early(void *data, async_cookie_t cookie)
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
@@ -848,18 +848,28 @@ void dpm_resume_early(pm_message_t state)
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
@@ -879,12 +889,12 @@ void dpm_resume_start(pm_message_t state)
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
@@ -978,18 +988,10 @@ static void async_resume(void *data, async_cookie_t cookie)
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
@@ -1009,16 +1011,25 @@ void dpm_resume(pm_message_t state)
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
index d1c19f5b1380..8f46e9f01929 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -606,6 +606,7 @@ struct dev_pm_info {
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
+	bool			async_in_progress:1;	/* Owned by the PM core */
 	unsigned int		must_resume:1;	/* Owned by the PM core */
 	unsigned int		may_skip_resume:1;	/* Set by subsystems */
 #else
-- 
2.18.0


