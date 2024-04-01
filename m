Return-Path: <stable+bounces-33912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB248939AE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A731F211E0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96613125C4;
	Mon,  1 Apr 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xY4fZ+E7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A97125AB
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964723; cv=none; b=GQAeq3jxZWkykzx9cd1gf5ahU7Q5z1gnH+enfFFy5zoweOgKgbKnUI2qEczskWqrcgTHY+ftRR9kRqMF6ZrrL2iz6viFuBJ9t+xI7AVOBK8J/8c3dYZh36g2iy4d1fRqKw+WPREsp2HXrdhmCuxnd7U/fEgKnwcRsLJL3HMBcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964723; c=relaxed/simple;
	bh=NhfUXfCwOFVcOxUsoxoYobHa8u3rRehkedmW7jpV2TA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZsQ3sSZSNsbjWA0oITd+3Y6ySAgM1UePgCEOShX1UTnfoM6v8Jj7G32RhTGrCqpinZZV5YNBfVOnVZgEtIzEbuSxB13L19GYv5T4lWaxZasCeBa6fcU7FZ9Cj9wbG2JGbqNjK7HnBeYGiL1eyJRrzdCkDTDP5wyNqkRXYwpXDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xY4fZ+E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BD0C433F1;
	Mon,  1 Apr 2024 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711964722;
	bh=NhfUXfCwOFVcOxUsoxoYobHa8u3rRehkedmW7jpV2TA=;
	h=Subject:To:Cc:From:Date:From;
	b=xY4fZ+E74zDLUS/lj1GezPHo8x/9M3nDW13I/jMalUG5Shj46ZNVTSARZOX/N32aP
	 skaiiVZaTJX10OmcxZNsbGhWoZdFrWVJAZALUOyblZyxdId5J5QvTLIBokTXTofFwf
	 WipbcgY4DEZyquhuN7uerudyySHVMb3yjmAVFWb0=
Subject: FAILED: patch "[PATCH] USB: core: Fix deadlock in port "disable" sysfs attribute" failed to apply to 5.10-stable tree
To: stern@rowland.harvard.edu,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 11:45:16 +0200
Message-ID: <2024040116-mortician-grudging-9be5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f4d1960764d8a70318b02f15203a1be2b2554ca1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040116-mortician-grudging-9be5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

f4d1960764d8 ("USB: core: Fix deadlock in port "disable" sysfs attribute")
f061f43d7418 ("usb: hub: port: add sysfs entry to switch port power")
8c67d06f3fd9 ("usb: Link the ports to the connectors they are attached to")
b8f1ba99cea5 ("usb: hub: make wait_for_connected() take an int instead of a pointer to int")
f59f93cd1d72 ("usb: hub: avoid warm port reset during USB3 disconnect")
7142452387c7 ("USB: Verify the port status when timeout happens during port suspend")
975f94c7d6c3 ("usb: core: hub: fix race condition about TRSMRCY of resume")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4d1960764d8a70318b02f15203a1be2b2554ca1 Mon Sep 17 00:00:00 2001
From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 15 Mar 2024 13:06:33 -0400
Subject: [PATCH] USB: core: Fix deadlock in port "disable" sysfs attribute

The show and store callback routines for the "disable" sysfs attribute
file in port.c acquire the device lock for the port's parent hub
device.  This can cause problems if another process has locked the hub
to remove it or change its configuration:

	Removing the hub or changing its configuration requires the
	hub interface to be removed, which requires the port device
	to be removed, and device_del() waits until all outstanding
	sysfs attribute callbacks for the ports have returned.  The
	lock can't be released until then.

	But the disable_show() or disable_store() routine can't return
	until after it has acquired the lock.

The resulting deadlock can be avoided by calling
sysfs_break_active_protection().  This will cause the sysfs core not
to wait for the attribute's callback routine to return, allowing the
removal to proceed.  The disadvantage is that after making this call,
there is no guarantee that the hub structure won't be deallocated at
any moment.  To prevent this, we have to acquire a reference to it
first by calling hub_get().

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/f7a8c135-a495-4ce6-bd49-405a45e7ea9a@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 5b5e613a11e5..686c01af03e6 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -56,11 +56,22 @@ static ssize_t disable_show(struct device *dev,
 	u16 portstatus, unused;
 	bool disabled;
 	int rc;
+	struct kernfs_node *kn;
 
+	hub_get(hub);
 	rc = usb_autopm_get_interface(intf);
 	if (rc < 0)
-		return rc;
+		goto out_hub_get;
 
+	/*
+	 * Prevent deadlock if another process is concurrently
+	 * trying to unregister hdev.
+	 */
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	if (!kn) {
+		rc = -ENODEV;
+		goto out_autopm;
+	}
 	usb_lock_device(hdev);
 	if (hub->disconnected) {
 		rc = -ENODEV;
@@ -70,9 +81,13 @@ static ssize_t disable_show(struct device *dev,
 	usb_hub_port_status(hub, port1, &portstatus, &unused);
 	disabled = !usb_port_is_power_on(hub, portstatus);
 
-out_hdev_lock:
+ out_hdev_lock:
 	usb_unlock_device(hdev);
+	sysfs_unbreak_active_protection(kn);
+ out_autopm:
 	usb_autopm_put_interface(intf);
+ out_hub_get:
+	hub_put(hub);
 
 	if (rc)
 		return rc;
@@ -90,15 +105,26 @@ static ssize_t disable_store(struct device *dev, struct device_attribute *attr,
 	int port1 = port_dev->portnum;
 	bool disabled;
 	int rc;
+	struct kernfs_node *kn;
 
 	rc = kstrtobool(buf, &disabled);
 	if (rc)
 		return rc;
 
+	hub_get(hub);
 	rc = usb_autopm_get_interface(intf);
 	if (rc < 0)
-		return rc;
+		goto out_hub_get;
 
+	/*
+	 * Prevent deadlock if another process is concurrently
+	 * trying to unregister hdev.
+	 */
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	if (!kn) {
+		rc = -ENODEV;
+		goto out_autopm;
+	}
 	usb_lock_device(hdev);
 	if (hub->disconnected) {
 		rc = -ENODEV;
@@ -119,9 +145,13 @@ static ssize_t disable_store(struct device *dev, struct device_attribute *attr,
 	if (!rc)
 		rc = count;
 
-out_hdev_lock:
+ out_hdev_lock:
 	usb_unlock_device(hdev);
+	sysfs_unbreak_active_protection(kn);
+ out_autopm:
 	usb_autopm_put_interface(intf);
+ out_hub_get:
+	hub_put(hub);
 
 	return rc;
 }


