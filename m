Return-Path: <stable+bounces-185889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48FCBE22E0
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1806919A5914
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58C2FF14D;
	Thu, 16 Oct 2025 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JFol5uYX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8B2FB0A0
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603988; cv=none; b=HFJjUlLiKI56NWEBUalG9bwB9WXpeslprtTdweTqbp1jFVTQ7POZ6JSwN1cgdFrA6nAhpaIMlHxPkLJyBD1TX+Wk8nZxp7ncz4HTzjS9btQIkzAap9NAElVlNS2M8kbmuEGrplmrh6pLXG98peQjXzXtUYvWxRyHMatlqXLoQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603988; c=relaxed/simple;
	bh=cg9p4saGxZ1QxnmoeX2qsh2vPuYF1bv7ABZdjZRPkXM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A1/BginN3TiVZOxU5D7PE3RwVVgW7Q1hKAmH6HFVhAe1L/J2ZTXf4RIUvIshbkKnGHM3BTzqUg87HCyAu02APnQacK8t+fuKfX4KrmjVYlSNdAGufYoJN7G6wsrkxBCYnVv4UmAjFW02/Iyrn6Lmy5aQUmEcfkaWaa5209BkJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JFol5uYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F07FC4CEF1;
	Thu, 16 Oct 2025 08:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760603986;
	bh=cg9p4saGxZ1QxnmoeX2qsh2vPuYF1bv7ABZdjZRPkXM=;
	h=Subject:To:Cc:From:Date:From;
	b=JFol5uYXpAxH4GpuKOIF0IbUTTcRP/iBahKPVZeUY084Idhsufqu8sxFO9B6lLNPa
	 sCHU5AiyrYCpZJT0olT220zaJoV4i+CRMRb58N/NcdvcObnuxUkXfjWW8H6Nz5t+Qf
	 hGTmXCViNNnqN4mX7pFvqeyBuVPpWk68SOHjVRhw=
Subject: FAILED: patch "[PATCH] ACPI: battery: Add synchronization between interface updates" failed to apply to 6.6-stable tree
To: rafael.j.wysocki@intel.com,luogf2025@163.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:39:35 +0200
Message-ID: <2025101635-disaster-pasture-f32d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 399dbcadc01ebf0035f325eaa8c264f8b5cd0a14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101635-disaster-pasture-f32d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 399dbcadc01ebf0035f325eaa8c264f8b5cd0a14 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Sun, 28 Sep 2025 12:18:29 +0200
Subject: [PATCH] ACPI: battery: Add synchronization between interface updates

There is no synchronization between different code paths in the ACPI
battery driver that update its sysfs interface or its power supply
class device interface.  In some cases this results to functional
failures due to race conditions.

One example of this is when two ACPI notifications:

  - ACPI_BATTERY_NOTIFY_STATUS (0x80)
  - ACPI_BATTERY_NOTIFY_INFO   (0x81)

are triggered (by the platform firmware) in a row with a little delay
in between after removing and reinserting a laptop battery.  Both
notifications cause acpi_battery_update() to be called and if the delay
between them is sufficiently small, sysfs_add_battery() can be re-entered
before battery->bat is set which leads to a duplicate sysfs entry error:

 sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
 CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded Not tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
 Hardware name: Gateway          NV44             /SJV40-MV        , BIOS V1.3121 04/08/2009
 Workqueue: kacpi_notify acpi_os_execute_deferred
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5d/0x80
  sysfs_warn_dup.cold+0x17/0x23
  sysfs_create_dir_ns+0xce/0xe0
  kobject_add_internal+0xba/0x250
  kobject_add+0x96/0xc0
  ? get_device_parent+0xde/0x1e0
  device_add+0xe2/0x870
  __power_supply_register.part.0+0x20f/0x3f0
  ? wake_up_q+0x4e/0x90
  sysfs_add_battery+0xa4/0x1d0 [battery]
  acpi_battery_update+0x19e/0x290 [battery]
  acpi_battery_notify+0x50/0x120 [battery]
  acpi_ev_notify_dispatch+0x49/0x70
  acpi_os_execute_deferred+0x1a/0x30
  process_one_work+0x177/0x330
  worker_thread+0x251/0x390
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xd2/0x100
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 kobject: kobject_add_internal failed for BAT1 with -EEXIST, don't try to register things with the same name in the same directory.

There are also other scenarios in which analogous issues may occur.

Address this by using a common lock in all of the code paths leading
to updates of driver interfaces: ACPI Notify () handler, system resume
callback and post-resume notification, device addition and removal.

This new lock replaces sysfs_lock that has been used only in
sysfs_remove_battery() which now is going to be always called under
the new lock, so it doesn't need any internal locking any more.

Fixes: 10666251554c ("ACPI: battery: Install Notify() handler directly")
Closes: https://lore.kernel.org/linux-acpi/20250910142653.313360-1-luogf2025@163.com/
Reported-by: GuangFei Luo <luogf2025@163.com>
Tested-by: GuangFei Luo <luogf2025@163.com>
Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6905b56bf3e4..67b76492c839 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -92,7 +92,7 @@ enum {
 
 struct acpi_battery {
 	struct mutex lock;
-	struct mutex sysfs_lock;
+	struct mutex update_lock;
 	struct power_supply *bat;
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
@@ -904,15 +904,12 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
-	mutex_lock(&battery->sysfs_lock);
-	if (!battery->bat) {
-		mutex_unlock(&battery->sysfs_lock);
+	if (!battery->bat)
 		return;
-	}
+
 	battery_hook_remove_battery(battery);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
-	mutex_unlock(&battery->sysfs_lock);
 }
 
 static void find_battery(const struct dmi_header *dm, void *private)
@@ -1072,6 +1069,9 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 
 	if (!battery)
 		return;
+
+	guard(mutex)(&battery->update_lock);
+
 	old = battery->bat;
 	/*
 	 * On Acer Aspire V5-573G notifications are sometimes triggered too
@@ -1094,21 +1094,22 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 }
 
 static int battery_notify(struct notifier_block *nb,
-			       unsigned long mode, void *_unused)
+			  unsigned long mode, void *_unused)
 {
 	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
 						    pm_nb);
-	int result;
 
-	switch (mode) {
-	case PM_POST_HIBERNATION:
-	case PM_POST_SUSPEND:
+	if (mode == PM_POST_SUSPEND || mode == PM_POST_HIBERNATION) {
+		guard(mutex)(&battery->update_lock);
+
 		if (!acpi_battery_present(battery))
 			return 0;
 
 		if (battery->bat) {
 			acpi_battery_refresh(battery);
 		} else {
+			int result;
+
 			result = acpi_battery_get_info(battery);
 			if (result)
 				return result;
@@ -1120,7 +1121,6 @@ static int battery_notify(struct notifier_block *nb,
 
 		acpi_battery_init_alarm(battery);
 		acpi_battery_get_state(battery);
-		break;
 	}
 
 	return 0;
@@ -1198,6 +1198,8 @@ static int acpi_battery_update_retry(struct acpi_battery *battery)
 {
 	int retry, ret;
 
+	guard(mutex)(&battery->update_lock);
+
 	for (retry = 5; retry; retry--) {
 		ret = acpi_battery_update(battery, false);
 		if (!ret)
@@ -1208,6 +1210,13 @@ static int acpi_battery_update_retry(struct acpi_battery *battery)
 	return ret;
 }
 
+static void sysfs_battery_cleanup(struct acpi_battery *battery)
+{
+	guard(mutex)(&battery->update_lock);
+
+	sysfs_remove_battery(battery);
+}
+
 static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -1230,7 +1239,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (result)
 		return result;
 
-	result = devm_mutex_init(&device->dev, &battery->sysfs_lock);
+	result = devm_mutex_init(&device->dev, &battery->update_lock);
 	if (result)
 		return result;
 
@@ -1262,7 +1271,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
-	sysfs_remove_battery(battery);
+	sysfs_battery_cleanup(battery);
 
 	return result;
 }
@@ -1281,6 +1290,9 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
+
+	guard(mutex)(&battery->update_lock);
+
 	sysfs_remove_battery(battery);
 }
 
@@ -1297,6 +1309,9 @@ static int acpi_battery_resume(struct device *dev)
 		return -EINVAL;
 
 	battery->update_time = 0;
+
+	guard(mutex)(&battery->update_lock);
+
 	acpi_battery_update(battery, true);
 	return 0;
 }


