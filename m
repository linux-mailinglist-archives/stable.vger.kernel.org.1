Return-Path: <stable+bounces-220161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNz3IWkto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4FE1C553F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7373310433E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414D33F8D6;
	Sat, 28 Feb 2026 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWI/Fi4c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E17495533;
	Sat, 28 Feb 2026 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300069; cv=none; b=FCLlgFzGVufEnUzRH4mRE04Ft5ml7uzyINEDm5UvIIkCDhvYNYA4HyuRgBsjrC7qTUXbQhmXiFNfS9eUm5B+Hc0RvlAvpJIbD/d5Cm2sdsL5vJIcg/NzAiIeIidegk5nW2ioYFaSMNTQcwUSqbDnRX2zNpWnOVHltGKP5xzXBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300069; c=relaxed/simple;
	bh=2pipMRddz6ailbs3zM8XCtd8z26OQ4v2LeH8oipn5UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHzvhsNZpWLbMSEaZlE3y/Y79ET0LIm0cvxFRA2iOdDgmjWV/idJiaB/le9KfbX+IQN461cIAG6SSTTF6KWZH1aZc3QC1D8TZxrN9Ds2GVIKgyD59GmTI8W2UpNc45r0YCl6Zjxrh0L0vJRVGEQNkLrXTxl20XxVaaGFk38G1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWI/Fi4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E94C4AF0B;
	Sat, 28 Feb 2026 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300069;
	bh=2pipMRddz6ailbs3zM8XCtd8z26OQ4v2LeH8oipn5UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWI/Fi4cHHU97E+Us3UEjdk28loRMIZCK9tKLGak7LC0jeO1ncqEpJQRRIXe16QeT
	 wCQn6ptnP2ZjdyGNnnCr71Qz1tWGT8k81K/r5NCGGJrDtMDMZFtNWA+gVyhNeI3S1u
	 MvMKySD9jrduVLlkMnCGeCKTzLmVRLSBUFM+C9Vw8YJbPLBAU6V8QUi4uz2IIF1ktd
	 Zj1cF2d6I4zDUe2dweNMzU5emxe0Rizkud1o4XkLqQMHpOIVrHX/lIWa7+Ivp7fINF
	 Vwi9IJ+QAsF+QM64rT4O1Fzm8jSov1llwaydVwf3Guqwlet0lHeSdm4blZKV0yTXiV
	 Ckmoj3F+sZuug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yicong Yang <yang.yicong@picoheart.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 083/844] ACPI: scan: Use async schedule function in acpi_scan_clear_dep_fn()
Date: Sat, 28 Feb 2026 12:19:56 -0500
Message-ID: <20260228173244.1509663-84-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220161-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,picoheart.com:email,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 9A4FE1C553F
X-Rspamd-Action: no action

From: Yicong Yang <yang.yicong@picoheart.com>

[ Upstream commit 7cf28b3797a81b616bb7eb3e90cf131afc452919 ]

The device object rescan in acpi_scan_clear_dep_fn() is scheduled on a
system workqueue which is not guaranteed to be finished before entering
userspace. This may cause some key devices to be missing when userspace
init task tries to find them. Two issues observed on RISCV platforms:

 - Kernel panic due to userspace init cannot have an opened
   console.

   The console device scanning is queued by acpi_scan_clear_dep_queue()
   and not finished by the time userspace init process running, thus by
   the time userspace init runs, no console is present.

 - Entering rescue shell due to the lack of root devices (PCIe nvme in
   our case).

   Same reason as above, the PCIe host bridge scanning is queued on
   a system workqueue and finished after init process runs.

The reason is because both devices (console, PCIe host bridge) depend on
riscv-aplic irqchip to serve their interrupts (console's wired interrupt
and PCI's INTx interrupts). In order to keep the dependency, these
devices are scanned and created after initializing riscv-aplic. The
riscv-aplic is initialized in device_initcall() and a device scan work
is queued via acpi_scan_clear_dep_queue(), which is close to the time
userspace init process is run. Since system_dfl_wq is used in
acpi_scan_clear_dep_queue() with no synchronization, the issues will
happen if userspace init runs before these devices are ready.

The solution is to wait for the queued work to complete before entering
userspace init. One possible way would be to use a dedicated workqueue
instead of system_dfl_wq, and explicitly flush it somewhere in the
initcall stage before entering userspace. Another way is to use
async_schedule_dev_nocall() for scanning these devices. It's designed
for asynchronous initialization and will work in the same way as before
because it's using a dedicated unbound workqueue as well, but the kernel
init code calls async_synchronize_full() right before entering userspace
init which will wait for the work to complete.

Compared to a dedicated workqueue, the second approach is simpler
because the async schedule framework takes care of all of the details.
The ACPI code only needs to focus on its job. A dedicated workqueue for
this could also be redundant because some platforms don't need
acpi_scan_clear_dep_queue() for their device scanning.

Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
[ rjw: Subject adjustment, changelog edits ]
Link: https://patch.msgid.link/20260128132848.93638-1-yang.yicong@picoheart.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/scan.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 416d87f9bd107..b78f6be2f9468 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
+#include <linux/async.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -2360,46 +2361,34 @@ static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *da
 	return 0;
 }
 
-struct acpi_scan_clear_dep_work {
-	struct work_struct work;
-	struct acpi_device *adev;
-};
-
-static void acpi_scan_clear_dep_fn(struct work_struct *work)
+static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
 {
-	struct acpi_scan_clear_dep_work *cdw;
-
-	cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
+	struct acpi_device *adev = to_acpi_device(dev);
 
 	acpi_scan_lock_acquire();
-	acpi_bus_attach(cdw->adev, (void *)true);
+	acpi_bus_attach(adev, (void *)true);
 	acpi_scan_lock_release();
 
-	acpi_dev_put(cdw->adev);
-	kfree(cdw);
+	acpi_dev_put(adev);
 }
 
 static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
 {
-	struct acpi_scan_clear_dep_work *cdw;
-
 	if (adev->dep_unmet)
 		return false;
 
-	cdw = kmalloc(sizeof(*cdw), GFP_KERNEL);
-	if (!cdw)
-		return false;
-
-	cdw->adev = adev;
-	INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
 	/*
-	 * Since the work function may block on the lock until the entire
-	 * initial enumeration of devices is complete, put it into the unbound
-	 * workqueue.
+	 * Async schedule the deferred acpi_scan_clear_dep_fn() since:
+	 * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
+	 *   be acquired under acpi_dep_list_lock (held here)
+	 * - the deferred work at boot stage is ensured to be finished
+	 *   before userspace init task by the async_synchronize_full()
+	 *   barrier
+	 *
+	 * Use _nocall variant since it'll return on failure instead of
+	 * run the function synchronously.
 	 */
-	queue_work(system_dfl_wq, &cdw->work);
-
-	return true;
+	return async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev);
 }
 
 static void acpi_scan_delete_dep_data(struct acpi_dep_data *dep)
-- 
2.51.0


