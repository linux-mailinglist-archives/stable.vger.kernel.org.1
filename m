Return-Path: <stable+bounces-268422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Iv+BJckoPWqvyAgAu9opvQ
	(envelope-from <stable+bounces-268422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:10:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB0F6C5F8C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:10:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CnIkjKjk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268422-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268422-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 984CE30B4785
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B9D2C027B;
	Thu, 25 Jun 2026 13:06:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127D149C6F;
	Thu, 25 Jun 2026 13:06:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392800; cv=none; b=M1MTH5ot/IFXJBxQbk/i31v2707ILWZ5icoVcVBl8XmRTc+oVsiKxHjIDw6+FpaNTAURZFn8RgaoLVa3WjueeItcojM6g73CZHf29VHdjgLXtNqoovTyfI3inXqRuglC8Lc95jmFYkzE/q9zNTtdQc5M6WlsVs+IGNqsThr/Hws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392800; c=relaxed/simple;
	bh=6fO+kMeAk7VSiVRapOHpJf+e5ind+Hg2ilLkla4rZbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDxipmJbgBaPCZlXjeadl5DsHbYdOEdjvOZhSqG6m1oU6Mw/hr8iNLF6DgwQhWQHJD3YzBgqXrQvixg1jNafJyiTdQbzcKunnoNcP8MGkQupvXEOMsfgNtftxH1OgPwU9twnXczBSgU8+4Ln7NwqIw0oAkxlaXClNxmN5f++C5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CnIkjKjk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0180E1F000E9;
	Thu, 25 Jun 2026 13:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392799;
	bh=wVaNDCCEEJfa3dPnP3jXiH76Mhpx8y4QeSRj5/tBE28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CnIkjKjkNblXqswHBwaWkaWrKu9Gdk0FuAURNE1frDwx3NO5Orq3kdfx+6YaLNk6W
	 hdKjtOon/gddMPExq7odCU1NxQ1KT9FsZsLHX/DLB1jkmsSpV5r2gGi0Na2aoi3yx6
	 YNxw3rC+6uS7FmawZCFic3KcN3npYcr5XD4aVays=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yicong Yang <yang.yicong@picoheart.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 13/60] ACPI: scan: Use async schedule function in acpi_scan_clear_dep_fn()
Date: Thu, 25 Jun 2026 14:02:58 +0100
Message-ID: <20260625125647.473021316@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
References: <20260625125645.554579168@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268422-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yang.yicong@picoheart.com,m:rafael.j.wysocki@intel.com,m:wangruikang@iscas.ac.cn,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFB0F6C5F8C

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
[ Vivian: Adjust system_dfl_wq -> system_unbound_wq in removed lines ]
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/scan.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 50f60da6cf27fc..16704c2a730c04 100644
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
-	queue_work(system_unbound_wq, &cdw->work);
-
-	return true;
+	return async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev);
 }
 
 static void acpi_scan_delete_dep_data(struct acpi_dep_data *dep)
-- 
2.53.0




