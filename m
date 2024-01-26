Return-Path: <stable+bounces-15960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BADFF83E570
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2445BB22BC7
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E72563D;
	Fri, 26 Jan 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LvwKcAjI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3D720DC5
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308225; cv=none; b=cEJOOBh3tTeiACGsco/FrdcGIjCF1lK2oms7w4MVX7pCNTbr0XDBngy/HydfEa+0Mnd5XgENzGJjSEI4tTI/X2oQ4+Hu2IoyDCD3Fe5XKaXls9MduPSthl7ydmYm6JsXxN+EGdKTRWYxjgknItBFNsPmvZgJR4WYT2fiLz4AKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308225; c=relaxed/simple;
	bh=ZhB2CLFZs4cWO5L9WK+3b2r26D53Bd6XUC2i0Hj1CcI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dgTrZiCIYFqIc0+rgWlgU/paBT1RgnKniiF5qFG6pydQaoLmqhZSvdH4BJc4K8owepmI4a8muLF30Hus7xcotTAk9uLDC9Na94zBvFC71812RhW5OxEsn8MsaLnn7R9VLwDCGq/AS/K3s+aHm2rsghhhDvminNqCFvLLOOoVwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LvwKcAjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43BBC433C7;
	Fri, 26 Jan 2024 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706308224;
	bh=ZhB2CLFZs4cWO5L9WK+3b2r26D53Bd6XUC2i0Hj1CcI=;
	h=Subject:To:Cc:From:Date:From;
	b=LvwKcAjI5N/IUbqjE+7pcTYxMS0XdPquJY1xAkb1sIlWNgMycGVCvjMs3Mnbh+qDW
	 iD7frt5ul2ACLlvR05yNxU4sr7IrTQ+iFVnqU9ksUmJZwmqsX27GotKdUk5cQjjD22
	 w+8Ei28ePEf93cvuwjPjGzGy/Qg6EZ+ymvbC14RQ=
Subject: FAILED: patch "[PATCH] thermal: intel: hfi: Add syscore callbacks for system-wide PM" failed to apply to 6.7-stable tree
To: ricardo.neri-calderon@linux.intel.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:30:23 -0800
Message-ID: <2024012623-affront-italics-53d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 97566d09fd02d2ab329774bb89a2cdf2267e86d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012623-affront-italics-53d9@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

97566d09fd02 ("thermal: intel: hfi: Add syscore callbacks for system-wide PM")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 97566d09fd02d2ab329774bb89a2cdf2267e86d9 Mon Sep 17 00:00:00 2001
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 9 Jan 2024 19:07:04 -0800
Subject: [PATCH] thermal: intel: hfi: Add syscore callbacks for system-wide PM

The kernel allocates a memory buffer and provides its location to the
hardware, which uses it to update the HFI table. This allocation occurs
during boot and remains constant throughout runtime.

When resuming from hibernation, the restore kernel allocates a second
memory buffer and reprograms the HFI hardware with the new location as
part of a normal boot. The location of the second memory buffer may
differ from the one allocated by the image kernel.

When the restore kernel transfers control to the image kernel, its HFI
buffer becomes invalid, potentially leading to memory corruption if the
hardware writes to it (the hardware continues to use the buffer from the
restore kernel).

It is also possible that the hardware "forgets" the address of the memory
buffer when resuming from "deep" suspend. Memory corruption may also occur
in such a scenario.

To prevent the described memory corruption, disable HFI when preparing to
suspend or hibernate. Enable it when resuming.

Add syscore callbacks to handle the package of the boot CPU (packages of
non-boot CPUs are handled via CPU offline). Syscore ops always run on the
boot CPU. Additionally, HFI only needs to be disabled during "deep" suspend
and hibernation. Syscore ops only run in these cases.

Cc: 6.1+ <stable@vger.kernel.org> # 6.1+
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
[ rjw: Comment adjustment, subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 22445403b520..3b04c6ec4fca 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -35,7 +35,9 @@
 #include <linux/processor.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/suspend.h>
 #include <linux/string.h>
+#include <linux/syscore_ops.h>
 #include <linux/topology.h>
 #include <linux/workqueue.h>
 
@@ -571,6 +573,30 @@ static __init int hfi_parse_features(void)
 	return 0;
 }
 
+static void hfi_do_enable(void)
+{
+	/* This code runs only on the boot CPU. */
+	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
+	struct hfi_instance *hfi_instance = info->hfi_instance;
+
+	/* No locking needed. There is no concurrency with CPU online. */
+	hfi_set_hw_table(hfi_instance);
+	hfi_enable();
+}
+
+static int hfi_do_disable(void)
+{
+	/* No locking needed. There is no concurrency with CPU offline. */
+	hfi_disable();
+
+	return 0;
+}
+
+static struct syscore_ops hfi_pm_ops = {
+	.resume = hfi_do_enable,
+	.suspend = hfi_do_disable,
+};
+
 void __init intel_hfi_init(void)
 {
 	struct hfi_instance *hfi_instance;
@@ -602,6 +628,8 @@ void __init intel_hfi_init(void)
 	if (!hfi_updates_wq)
 		goto err_nomem;
 
+	register_syscore_ops(&hfi_pm_ops);
+
 	return;
 
 err_nomem:


