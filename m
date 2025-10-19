Return-Path: <stable+bounces-187885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50ABEE432
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66A99349B97
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4872E542C;
	Sun, 19 Oct 2025 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNVTj0qu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B562E2EEF
	for <stable@vger.kernel.org>; Sun, 19 Oct 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875096; cv=none; b=HKg5587GYZE4gkXk1qs+byFI3yqPdVyOUCyby462KSAg3fdTOd+dcSUFHQ6EGJTNsfI2ZhYqwHql+jEInrDkqCaEGhg9O4i8PDhGcfp5D83Uj3taufrOHVwNQhfq7+O4pAMPRMNChdAH26Naxrk8gQHCtCX5ZfscVozCdmmfCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875096; c=relaxed/simple;
	bh=YyFZf2MxBfslh8YsWIwiyoY9E62ZnsfGAzspR1mZchU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ajJp+rzDmiyAlLImkkfnM3hZYoVv1afBtndadSMhkk1aVXL4K9ytsfnw+Fo0Gkoqk+mubmLWdu7/9lxRhntXHs88bhZXFxQ2tF/Fuiwsk3WaIFm4FpSLuu80T2HZ8tl49ivToEPFVulQ1RypJ7lQY8n+0IqA+M9v6OQpjltwh70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oNVTj0qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF123C4CEE7;
	Sun, 19 Oct 2025 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760875096;
	bh=YyFZf2MxBfslh8YsWIwiyoY9E62ZnsfGAzspR1mZchU=;
	h=Subject:To:Cc:From:Date:From;
	b=oNVTj0quqWbfkZfm6tIsSLWPO1ul9MqJG800gLZO23+CQ4Mm2Wu0iSwyjL8PCWQO7
	 +KivP7+tr9ktDoQM+Ck9K/j3ckoftMOEEB6uJmEu2lMvK1jJn9CDhAvh1SCICuR2Q/
	 FalHNu6Di3ape4Hcw9Y+EGw8xXadNJVvGeFDSWck=
Subject: FAILED: patch "[PATCH] s390/cio: Update purge function to unregister the unused" failed to apply to 5.15-stable tree
To: vneethv@linux.ibm.com,hca@linux.ibm.com,oberpar@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 19 Oct 2025 13:58:05 +0200
Message-ID: <2025101905-depress-banjo-bc7e@gregkh>
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
git cherry-pick -x 9daa5a8795865f9a3c93d8d1066785b07ded6073
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101905-depress-banjo-bc7e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9daa5a8795865f9a3c93d8d1066785b07ded6073 Mon Sep 17 00:00:00 2001
From: Vineeth Vijayan <vneethv@linux.ibm.com>
Date: Wed, 1 Oct 2025 15:38:17 +0200
Subject: [PATCH] s390/cio: Update purge function to unregister the unused
 subchannels

Starting with 'commit 2297791c92d0 ("s390/cio: dont unregister
subchannel from child-drivers")', cio no longer unregisters
subchannels when the attached device is invalid or unavailable.

As an unintended side-effect, the cio_ignore purge function no longer
removes subchannels for devices on the cio_ignore list if no CCW device
is attached. This situation occurs when a CCW device is non-operational
or unavailable

To ensure the same outcome of the purge function as when the
current cio_ignore list had been active during boot, update the purge
function to remove I/O subchannels without working CCW devices if the
associated device number is found on the cio_ignore list.

Fixes: 2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")
Suggested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index fb2c07cb4d3d..4b2dae6eb376 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1316,23 +1316,34 @@ void ccw_device_schedule_recovery(void)
 	spin_unlock_irqrestore(&recovery_lock, flags);
 }
 
-static int purge_fn(struct device *dev, void *data)
+static int purge_fn(struct subchannel *sch, void *data)
 {
-	struct ccw_device *cdev = to_ccwdev(dev);
-	struct ccw_dev_id *id = &cdev->private->dev_id;
-	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_device *cdev;
 
-	spin_lock_irq(cdev->ccwlock);
-	if (is_blacklisted(id->ssid, id->devno) &&
-	    (cdev->private->state == DEV_STATE_OFFLINE) &&
-	    (atomic_cmpxchg(&cdev->private->onoff, 0, 1) == 0)) {
-		CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", id->ssid,
-			      id->devno);
+	spin_lock_irq(&sch->lock);
+	if (sch->st != SUBCHANNEL_TYPE_IO || !sch->schib.pmcw.dnv)
+		goto unlock;
+
+	if (!is_blacklisted(sch->schid.ssid, sch->schib.pmcw.dev))
+		goto unlock;
+
+	cdev = sch_get_cdev(sch);
+	if (cdev) {
+		if (cdev->private->state != DEV_STATE_OFFLINE)
+			goto unlock;
+
+		if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
+			goto unlock;
 		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
-		css_sched_sch_todo(sch, SCH_TODO_UNREG);
 		atomic_set(&cdev->private->onoff, 0);
 	}
-	spin_unlock_irq(cdev->ccwlock);
+
+	css_sched_sch_todo(sch, SCH_TODO_UNREG);
+	CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x%s\n", sch->schid.ssid,
+		      sch->schib.pmcw.dev, cdev ? "" : " (no cdev)");
+
+unlock:
+	spin_unlock_irq(&sch->lock);
 	/* Abort loop in case of pending signal. */
 	if (signal_pending(current))
 		return -EINTR;
@@ -1348,7 +1359,7 @@ static int purge_fn(struct device *dev, void *data)
 int ccw_purge_blacklisted(void)
 {
 	CIO_MSG_EVENT(2, "ccw: purging blacklisted devices\n");
-	bus_for_each_dev(&ccw_bus_type, NULL, NULL, purge_fn);
+	for_each_subchannel_staged(purge_fn, NULL, NULL);
 	return 0;
 }
 


