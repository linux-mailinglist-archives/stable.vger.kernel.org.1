Return-Path: <stable+bounces-5322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1699280CA32
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469911C20F74
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9CA3C064;
	Mon, 11 Dec 2023 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="unCBZlGA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730213BB2B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BE2C433C8;
	Mon, 11 Dec 2023 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702298984;
	bh=CRPIXwqwh1eL2CRPKBdS+k6Wlwd1TxGV4HJNaCwEg5Y=;
	h=Subject:To:Cc:From:Date:From;
	b=unCBZlGAPo/agrd55Hjrts0LhDTPb4U/xiuJ8jXlJ7p9da9VZp3sfOswMfoJqS7EI
	 Yri7mOyCgjsE2kn0JIQyOjJdUrcbEM11oucfXk4JEjOa6drvNyJK0WLw05LQDZ1TfT
	 2ZRyRb7twV9OTMZDGqGqT4WvjroMAAzFyzK7CZck=
Subject: FAILED: patch "[PATCH] devcoredump: Send uevent once devcd is ready" failed to apply to 5.15-stable tree
To: quic_mojha@quicinc.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Dec 2023 13:49:41 +0100
Message-ID: <2023121141-doormat-extortion-0954@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x af54d778a03853801d681c98c0c2a6c316ef9ca7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121141-doormat-extortion-0954@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

af54d778a038 ("devcoredump: Send uevent once devcd is ready")
01daccf74832 ("devcoredump : Serialize devcd_del work")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af54d778a03853801d681c98c0c2a6c316ef9ca7 Mon Sep 17 00:00:00 2001
From: Mukesh Ojha <quic_mojha@quicinc.com>
Date: Fri, 17 Nov 2023 20:19:32 +0530
Subject: [PATCH] devcoredump: Send uevent once devcd is ready

dev_coredumpm() creates a devcoredump device and adds it
to the core kernel framework which eventually end up
sending uevent to the user space and later creates a
symbolic link to the failed device. An application
running in userspace may be interested in this symbolic
link to get the name of the failed device.

In a issue scenario, once uevent sent to the user space
it start reading '/sys/class/devcoredump/devcdX/failing_device'
to get the actual name of the device which might not been
created and it is in its path of creation.

To fix this, suppress sending uevent till the failing device
symbolic link gets created and send uevent once symbolic
link is created successfully.

Fixes: 833c95456a70 ("device coredump: add new device coredump class")
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1700232572-25823-1-git-send-email-quic_mojha@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 91536ee05f14..7e2d1f0d903a 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -362,6 +362,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->devcd_dev.class = &devcd_class;
 
 	mutex_lock(&devcd->mutex);
+	dev_set_uevent_suppress(&devcd->devcd_dev, true);
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -376,6 +377,8 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 		              "devcoredump"))
 		dev_warn(dev, "devcoredump create_link failed\n");
 
+	dev_set_uevent_suppress(&devcd->devcd_dev, false);
+	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
 	mutex_unlock(&devcd->mutex);


