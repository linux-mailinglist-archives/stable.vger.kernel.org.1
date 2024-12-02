Return-Path: <stable+bounces-95974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D69DFF7E
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9631E280C96
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A751FCF41;
	Mon,  2 Dec 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qgNQPV1T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545251FC0E5
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137164; cv=none; b=W9uKKtwOTNTLyHnhpmLObphdrE5Jy+4/j17aXcoZTu2DrqmfX4H/ziC0b14fVqMlaAZsuf/NyqrjAAy9ooUtXvSVh6NhuAJAyvcGC0zd6PgxIdVuvJD7AAjBdTGdnChvmSSVqN20RaOPh3IkXTfqQy4goTXq0pAT2lYhT7ZDdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137164; c=relaxed/simple;
	bh=8xU2YcsuYuZRdWgsiG8hu7m2QkusJoRzskvFlObvA1M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oP91oYoQqJRHLc+pbFC/OBlVy/SMnavTg+/adGSfydy/y7xbd8GDY8aWRwoj7YVUpZucBsgYAwD2UvoZU09bFZ0TwfPsNrNcVS3zktEtGqxinvZaFSAOlHM/CU28WeSNIjQZdILVDRyFM+lvh2eM2TRJZSmcPWQElX4iDi6Lf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qgNQPV1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D52C4CED1;
	Mon,  2 Dec 2024 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733137163;
	bh=8xU2YcsuYuZRdWgsiG8hu7m2QkusJoRzskvFlObvA1M=;
	h=Subject:To:Cc:From:Date:From;
	b=qgNQPV1TauUvy8o2DCg1Hk0Rqpe7wGZ8MepAJEiSOraSeihaYI/DQPU4UT7K3vIi7
	 JQMb8RYsHdKsYO2PaKybI9PkfQYFi9ltWQy/0aB8hqOdEFo3MNz6r/xue2Wu+Gjzxg
	 QyHza9JNs6ki2mpCudptqgvDp5KGJHzfFJaaUIww=
Subject: FAILED: patch "[PATCH] xen: Fix the issue of resource not being properly released in" failed to apply to 5.4-stable tree
To: chenqiuji666@gmail.com,jgross@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 11:59:20 +0100
Message-ID: <2024120220-amuck-esophagus-6542@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x afc545da381ba0c651b2658966ac737032676f01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120220-amuck-esophagus-6542@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From afc545da381ba0c651b2658966ac737032676f01 Mon Sep 17 00:00:00 2001
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Tue, 5 Nov 2024 21:09:19 +0800
Subject: [PATCH] xen: Fix the issue of resource not being properly released in
 xenbus_dev_probe()

This patch fixes an issue in the function xenbus_dev_probe(). In the
xenbus_dev_probe() function, within the if (err) branch at line 313, the
program incorrectly returns err directly without releasing the resources
allocated by err = drv->probe(dev, id). As the return value is non-zero,
the upper layers assume the processing logic has failed. However, the probe
operation was performed earlier without a corresponding remove operation.
Since the probe actually allocates resources, failing to perform the remove
operation could lead to problems.

To fix this issue, we followed the resource release logic of the
xenbus_dev_remove() function by adding a new block fail_remove before the
fail_put block. After entering the branch if (err) at line 313, the
function will use a goto statement to jump to the fail_remove block,
ensuring that the previously acquired resources are correctly released,
thus preventing the reference count leak.

This bug was identified by an experimental static analysis tool developed
by our team. The tool specializes in analyzing reference count operations
and detecting potential issues where resources are not properly managed.
In this case, the tool flagged the missing release operation as a
potential problem, which led to the development of this patch.

Fixes: 4bac07c993d0 ("xen: add the Xenbus sysfs and virtual device hotplug driver")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Message-ID: <20241105130919.4621-1-chenqiuji666@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 9f097f1f4a4c..6d32ffb01136 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -313,7 +313,7 @@ int xenbus_dev_probe(struct device *_dev)
 	if (err) {
 		dev_warn(&dev->dev, "watch_otherend on %s failed.\n",
 		       dev->nodename);
-		return err;
+		goto fail_remove;
 	}
 
 	dev->spurious_threshold = 1;
@@ -322,6 +322,12 @@ int xenbus_dev_probe(struct device *_dev)
 			 dev->nodename);
 
 	return 0;
+fail_remove:
+	if (drv->remove) {
+		down(&dev->reclaim_sem);
+		drv->remove(dev);
+		up(&dev->reclaim_sem);
+	}
 fail_put:
 	module_put(drv->driver.owner);
 fail:


