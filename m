Return-Path: <stable+bounces-95975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98499DFF80
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758D4162125
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096301FCCFE;
	Mon,  2 Dec 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0WV/NTNL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE71C9DD8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137172; cv=none; b=EISQxWzkU4+6VU+Di0ARTOSzHDqm58o4bs7PqkRwOQN0YSrr+klzbyzuHlejTcU4LvdONkQ9psYGvHNNc8gZO74508yfdxXleMO5yGhvM87vOn+eB5K7A9S2e41eXJPDESQLQxVLtpBLDlfcZFEGa87nQ6yaSmN43xuRiMxif/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137172; c=relaxed/simple;
	bh=Bt1caY8DxhgwK2S/uP3m3trQ77rT/OWEKs3bWuc3knU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W6PWWAne22reyMW44DzqFPp2aTEVYriEFtqAOFzMui3ua/XmnlLQJfinuwdlJBs3rzKFHaQbYGBbYdJHaWwn8v8SOuUKNYsSwGAU68XOVnpAW0ptNnm8F2ZdhR0rUaEp8Gg57L6Z7oyWS/RJC4ASK7HfoeiRanDivUbzt0G0dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0WV/NTNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B21C4CED1;
	Mon,  2 Dec 2024 10:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733137172;
	bh=Bt1caY8DxhgwK2S/uP3m3trQ77rT/OWEKs3bWuc3knU=;
	h=Subject:To:Cc:From:Date:From;
	b=0WV/NTNL5Pvth8ZQHV2etesqQgWkuXmKRNIrRoEUc4iXmeqYKAVEqzpSkH9u+D9pm
	 u5H5f0AmW6AiO/Nx7GZ4qhb2xYrYBczyYTK0ecQ/p9HPM47RPyTYa+yf9YnYtWeokt
	 jvTE8pXgLtLOykcp157uNT6dq4RcqdDR6Ovg4S9c=
Subject: FAILED: patch "[PATCH] xen: Fix the issue of resource not being properly released in" failed to apply to 4.19-stable tree
To: chenqiuji666@gmail.com,jgross@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 11:59:21 +0100
Message-ID: <2024120221-serving-certainly-75b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x afc545da381ba0c651b2658966ac737032676f01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120221-serving-certainly-75b1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


