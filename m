Return-Path: <stable+bounces-254421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPLBDLPnFWqXegcAu9opvQ
	(envelope-from <stable+bounces-254421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:34:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 948935DB644
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FE0130300C0
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC70B421EF3;
	Tue, 26 May 2026 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="H7uRJQIE"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE9421EE6;
	Tue, 26 May 2026 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820449; cv=pass; b=GHpwmIvYDf9Bec2h6ViCubHmzIkLuPo52qD520MgwWmVPnezwsE/JaMvyc+GFfW+KQDGS80p8rDOmRrg1C/BAjQ6IJi5kNKAsU8+F/F+M65D/6DQ3X2rWLMe+Uc5nGl1xPOPJtxvfQvSPOty/NONE5uTUgTCq+VzCVb2RbpXjAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820449; c=relaxed/simple;
	bh=VuxzRL3waxV7wariDHQL7/MuXVxo1OsydyT36gX8NUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THoafPW3m4jy+R6T2TcuxUutuqVTIps58Fs2MFAtxKdXfnsoK9D7y4DDjP4+hpdXfQxmn1Mw5vIE8Z7udd+/5g/xJ4t4hX0JmVYCf7rhKulsfDSNnnKoJ3kphhYth4x/ue7LL3qkzhDFFOeF7sxVprFUEdZM8wGjLl99gDc4Pqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=H7uRJQIE; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1779820437; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C/7uAFJTBijLMkYwoqqmh/fsrFzdj2gavWaueTmn0YvWtxYDUcePOSeE7Sx19UFVB9om2Od9fSjeB5J0R4LX/yHkMGvZqFC0z81YjVc8zS5QKObX/mufnyZJ2l4uRzWx5F67gTuwVTjK1Z+qIMVEe7kM3cDyjAOY/+fWey5HJ/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779820437; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZAqx81ncxxdbkyglMNedqUT6QaWlryJv4v9cmskdtvw=; 
	b=bQ+UIGJkQtvnj3WSItchb+f8ZndQ6xnrm1yEIOWeXglH7o3Jz8BnUvX08Po1HflAac8tEdMsLiFnY1wubR9LLx6RlgFdoLdd3QOrDipgKrWGwbGXb8vdtNgxkW6Qg9C3tcAe6RXhj1p2AdM9UfZATt5pxlQM/y6OTgCGoGyuiPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779820437;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=ZAqx81ncxxdbkyglMNedqUT6QaWlryJv4v9cmskdtvw=;
	b=H7uRJQIEymgiKzrUecQP+3R/YGvNRc7+2pQkP/2pkYdehpRYrVgv9FWuF+wp+xbm
	zTKZLinmI1QnYA/1DM5ES9QOqFWrHUfP+Ov8osyW51W30oyDTCFRqaeGVJphhhbr4ct
	5ldbMtqI4wbU44nzULpsmfN/T7Kdr8hJWKrEwfjMzH+ES8PISMl+yBNBRNHZJPqdRIO
	J7npA84p2f9MD8228u0xlxhKXcXi1RkMc5GQsTTUuXRGOpV8S/p+/c/XKmi5prHmqvt
	hPT1DNVO9dRVwXLm9fSIJwqqS/08n0Wu9jtJxWM1nHamehZQmLFvwjH1gv17bqbUmMK
	YKztESgdrA==
Received: by mx.zohomail.com with SMTPS id 1779820434504677.2244680612367;
	Tue, 26 May 2026 11:33:54 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Wed, 27 May 2026 02:31:32 +0800
Subject: [PATCH 2/2] ACPI: battery: Merge consecutive battery notifications
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-b4-acpi-battery-notification-v1-2-2303bed8ec0b@rong.moe>
References: <20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe>
In-Reply-To: <20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, stable@vger.kernel.org, 
 Rick <rickk1166@gmail.com>, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-d5d98
X-ZohoMailClient: External
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,waelti.dev,gmail.com,rong.moe];
	TAGGED_FROM(0.00)[bounces-254421-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rong.moe:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[waelti.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: 948935DB644
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It's a very common pattern to emit consecutive battery notifications,
for example:

    Method (_Qxx, 0, NotSerialized)
    {
        Notify (BAT0, 0x80) // Status Change
        Notify (BAT0, 0x81) // Information Change
    }

In this case, the current code path will update battery state twice
within a short period, which is not optimal, as the same data are
fetched twice. Moreover, both notifications are likely to call
power_supply_changed(), causing power_supply_uevent() to read all
battery properties in order to assemble uevents. Even worse, after the
first uevent reaches userspace, some userspace processes start to read
all battery properties in order to refresh their internal states, which
competes with the second notification's handling and uevent assembling.

This generates significant pressure on _STA, _BST and _BIX/_BIF methods.
Not only that, power_supply_ext properties may also rely on some other
ACPI methods, so both uevent assembling and userspace processes call
them. It becomes a nightmare when all these methods share the same ACPI
mutex protecting EC accesses and hence vulnerable to lock starvation.
This is exactly the case of some Lenovo devices, where the mentioned EC
query pattern eventually leads to a catastrophic situation that a bunch
of ACPI methods (including but not limited to the mentioned ones) fail
to acquire the same mutex due to timeout. These devices don't handle
mutex acquisition failure gracefully and return garbage data, causing
even more chaos.

Improve battery notification handling by merging consecutive battery
notifications within 10ms using a delayed work, so that they only
refresh and/or update battery state once. ACPI netlink event and
notifier call chain are still triggered multiple times in order not to
break other components. Finally, call power_supply_changed() once and
lead to a single uevent instead of a bunch, preventing userspace
programs from causing too much pressure on power supply properties and
underlying ACPI methods.

Tested-by: Jeffrey Wälti <jeffrey@waelti.dev>
Cc: stable@vger.kernel.org
Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/acpi/battery.c | 73 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 5f06841b48a1..f6e2b0d8e878 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -21,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include <linux/unaligned.h>
 
@@ -43,6 +45,9 @@
 
 #define MAX_STRING_LENGTH	64
 
+#define MAX_QUEUED_EVENTS	16
+#define NOTIF_MERGING_MS	10
+
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
@@ -95,6 +100,8 @@ struct acpi_battery {
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
 	struct device *phys_dev;
+	struct kfifo acpi_notif_fifo;
+	struct delayed_work acpi_notif_dwork;
 	struct notifier_block pm_nb;
 	struct list_head list;
 	unsigned long update_time;
@@ -1067,14 +1074,22 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 }
 
 /* Driver Interface */
-static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_battery_notification_worker(struct work_struct *work)
 {
-	struct acpi_battery *battery = data;
+	struct acpi_battery *battery = container_of(work, struct acpi_battery,
+						    acpi_notif_dwork.work);
 	struct acpi_device *device = battery->device;
+	u32 events[MAX_QUEUED_EVENTS];
 	struct power_supply *old;
+	unsigned int count, i;
 
 	guard(mutex)(&battery->update_lock);
 
+	count = kfifo_out(&battery->acpi_notif_fifo, events, sizeof(events));
+	count /= sizeof(events[0]);
+
+	pr_debug("merged %u battery notifications within %dms\n", count, NOTIF_MERGING_MS);
+
 	old = battery->bat;
 	/*
 	 * On Acer Aspire V5-573G notifications are sometimes triggered too
@@ -1084,19 +1099,45 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	 */
 	if (battery_notification_delay_ms > 0)
 		msleep(battery_notification_delay_ms);
-	if (event == ACPI_BATTERY_NOTIFY_INFO)
-		acpi_battery_refresh(battery);
+
+	for (i = 0; i < count; i++) {
+		if (events[i] == ACPI_BATTERY_NOTIFY_INFO) {
+			acpi_battery_refresh(battery);
+			break;
+		}
+	}
+
 	acpi_battery_update(battery, false);
-	acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
-					dev_name(&device->dev), event,
-					acpi_battery_present(battery));
-	acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(device),
-				 event, acpi_battery_present(battery));
+
+	for (i = 0; i < count; i++) {
+		acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
+						dev_name(&device->dev), events[i],
+						acpi_battery_present(battery));
+		acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(device),
+					 events[i], acpi_battery_present(battery));
+	}
+
 	/* acpi_battery_update could remove power_supply object */
 	if (old && battery->bat)
 		power_supply_changed(battery->bat);
 }
 
+static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_battery *battery = data;
+
+	guard(mutex)(&battery->update_lock);
+
+	if (kfifo_avail(&battery->acpi_notif_fifo) < sizeof(event)) {
+		pr_err("too many battery notifications within %dms", NOTIF_MERGING_MS);
+		return;
+	}
+
+	kfifo_in(&battery->acpi_notif_fifo, &event, sizeof(event));
+
+	schedule_delayed_work(&battery->acpi_notif_dwork, msecs_to_jiffies(NOTIF_MERGING_MS));
+}
+
 static int battery_notify(struct notifier_block *nb,
 			  unsigned long mode, void *_unused)
 {
@@ -1264,13 +1305,22 @@ static int acpi_battery_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, true);
 
+	result = kfifo_alloc(&battery->acpi_notif_fifo,
+			     MAX_QUEUED_EVENTS * sizeof(u32), GFP_KERNEL);
+	if (result)
+		goto fail_pm;
+
+	INIT_DELAYED_WORK(&battery->acpi_notif_dwork, acpi_battery_notification_worker);
+
 	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
 						 acpi_battery_notify, battery);
 	if (result)
-		goto fail_pm;
+		goto fail_kfifo;
 
 	return 0;
 
+fail_kfifo:
+	kfifo_free(&battery->acpi_notif_fifo);
 fail_pm:
 	device_init_wakeup(&pdev->dev, false);
 	unregister_pm_notifier(&battery->pm_nb);
@@ -1287,6 +1337,9 @@ static void acpi_battery_remove(struct platform_device *pdev)
 	acpi_dev_remove_notify_handler(battery->device, ACPI_ALL_NOTIFY,
 				       acpi_battery_notify);
 
+	cancel_delayed_work_sync(&battery->acpi_notif_dwork);
+	kfifo_free(&battery->acpi_notif_fifo);
+
 	device_init_wakeup(&pdev->dev, false);
 	unregister_pm_notifier(&battery->pm_nb);
 

-- 
2.53.0


