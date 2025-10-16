Return-Path: <stable+bounces-186158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24317BE3D05
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408544F3C68
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088FA33CE98;
	Thu, 16 Oct 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjw6e3Fi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2333CE90
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622857; cv=none; b=Txnx9llDlJpy4PnC8Po9RQ3Z99ivL+htOaoBM4TM2K9lG2E8KPdksBfATaKQiSIy8rZ89chcSYK18/RlxcO+jFoDNPu3vJHDpynr+WWqjONPHKtmnFhr1fwF5IoLkD8nkO9ebv1D5Xg19JdYq0qfz4p43MnadD9g0amy3S2ZBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622857; c=relaxed/simple;
	bh=2glWaX8EtVwJVKotdSCnaIpsUykLDECLb15hDnSRchc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1bI5UeHcamWzta7HFs7u08GjoZZR11SIU57SjB1FKeqHF3WuwSu0glezXr3TecGtpDpNXNhgPLVx1gJx9jhsUhNawKA8zSSw1Xx5HmC0nkVZRoRnbJJxVKKh73U9CdONHaIC4Mo9n9QNthTaVRBbQZab1BXdjBvD7cPaWY22qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjw6e3Fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175E6C4CEFE;
	Thu, 16 Oct 2025 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622857;
	bh=2glWaX8EtVwJVKotdSCnaIpsUykLDECLb15hDnSRchc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjw6e3FixgWUejrgj3iyF/asx41mwkDcCy8Jm+C7CHIKzSiB/itEz9nyJv8IpFflQ
	 RAhX1Cmkby9FqGUIdF8nIkaHAUj+tvn/d5F6aJJkpfWuY0lrYTyrlztKUdTOijmAWF
	 PUBswbpl1g4kFsyu5z15t0qBsohjJu9LQEXqvZAuzUQeQ9B6w+n8j8E2VG12+U9bh4
	 KXeSXrAdjy+tCd5Zt6gfvG+qaz3xh0T8AdRdS09M1mZCITvpXF8+q7Uftrzac017qg
	 U0WzJWHfKq0NdSnqEGzojOhiIs23Mp9YSgHCPpfMiwrvmNiif8J3v8rmoKVturY5DP
	 P9gBJv/y9B9vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	GuangFei Luo <luogf2025@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] ACPI: battery: Add synchronization between interface updates
Date: Thu, 16 Oct 2025 09:54:12 -0400
Message-ID: <20251016135412.3299634-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016135412.3299634-1-sashal@kernel.org>
References: <2025101635-disaster-pasture-f32d@gregkh>
 <20251016135412.3299634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 399dbcadc01ebf0035f325eaa8c264f8b5cd0a14 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 43 ++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b1aa44f5a6a00..a70b6db3bf059 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -94,7 +94,7 @@ enum {
 
 struct acpi_battery {
 	struct mutex lock;
-	struct mutex sysfs_lock;
+	struct mutex update_lock;
 	struct power_supply *bat;
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
@@ -888,15 +888,12 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 
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
@@ -1056,6 +1053,9 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 
 	if (!battery)
 		return;
+
+	guard(mutex)(&battery->update_lock);
+
 	old = battery->bat;
 	/*
 	 * On Acer Aspire V5-573G notifications are sometimes triggered too
@@ -1078,21 +1078,22 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
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
@@ -1104,7 +1105,6 @@ static int battery_notify(struct notifier_block *nb,
 
 		acpi_battery_init_alarm(battery);
 		acpi_battery_get_state(battery);
-		break;
 	}
 
 	return 0;
@@ -1182,6 +1182,8 @@ static int acpi_battery_update_retry(struct acpi_battery *battery)
 {
 	int retry, ret;
 
+	guard(mutex)(&battery->update_lock);
+
 	for (retry = 5; retry; retry--) {
 		ret = acpi_battery_update(battery, false);
 		if (!ret)
@@ -1192,6 +1194,13 @@ static int acpi_battery_update_retry(struct acpi_battery *battery)
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
@@ -1214,7 +1223,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (result)
 		return result;
 
-	result = devm_mutex_init(&device->dev, &battery->sysfs_lock);
+	result = devm_mutex_init(&device->dev, &battery->update_lock);
 	if (result)
 		return result;
 
@@ -1244,7 +1253,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
-	sysfs_remove_battery(battery);
+	sysfs_battery_cleanup(battery);
 
 	return result;
 }
@@ -1263,6 +1272,9 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
+
+	guard(mutex)(&battery->update_lock);
+
 	sysfs_remove_battery(battery);
 }
 
@@ -1280,6 +1292,9 @@ static int acpi_battery_resume(struct device *dev)
 		return -EINVAL;
 
 	battery->update_time = 0;
+
+	guard(mutex)(&battery->update_lock);
+
 	acpi_battery_update(battery, true);
 	return 0;
 }
-- 
2.51.0


