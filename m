Return-Path: <stable+bounces-154908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69984AE132F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28D23B2880
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE615207A20;
	Fri, 20 Jun 2025 05:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uYVNbVag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB60205519
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398146; cv=none; b=jG+UgWKYYmR8dyskEdXHCRaSGUjsQMbNIGatVhgP+kiPGpuV8E77D2tesk0/FSFKONC3pgZlmUU7wSHtJpcXIJ1dh7CLwDnaDLem/UI0BW/AjdtBYtennsnSC0KgBHzKqXLKqaI3HDo5ozqYYHlSTxaxV6snMG+VSTN7aiFnBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398146; c=relaxed/simple;
	bh=kGJQJhw41H7iWGIfJRpp3Zvg+DLHtwQqm/KY7mUE16E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fXwC+mZvi7robKSCgBvga7lr7113OT6fCloSvdMz18WZ3egoN2GmDzApBjEozmBhaKWXzXPAiSOA5YOUo/3O9NtZj4otuDucn4QZv0evhJ+lvIQXavQf27hWmLeMLN0bRAuD6vjxhn9xORvo8VvWo6hkI+9jxSm3XKDLTwo1kGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uYVNbVag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DB1C4CEE3;
	Fri, 20 Jun 2025 05:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398146;
	bh=kGJQJhw41H7iWGIfJRpp3Zvg+DLHtwQqm/KY7mUE16E=;
	h=Subject:To:Cc:From:Date:From;
	b=uYVNbVagn3h9Jgnc5e+LEBKRBWk8ODCS/03Y/ef3Q5i1InIjoa3Xgk+AXB/X+Eg7S
	 iPoh/NFz5oHNYb7W2g1RLRx+W91KN4Ju6e/xDdmnkLYszLQrcCj1VjwkX71dZOPuUK
	 N36o6T1FvYaHyVHylgCiurNYNn8TAuswbGQxmi/M=
Subject: FAILED: patch "[PATCH] s390/pci: Allow re-add of a reserved but not yet removed" failed to apply to 5.15-stable tree
To: schnelle@linux.ibm.com,gbayer@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:42:10 +0200
Message-ID: <2025062010-easter-choosing-e03b@gregkh>
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
git cherry-pick -x 4b1815a52d7eb03b3e0e6742c6728bc16a4b2d1d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062010-easter-choosing-e03b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b1815a52d7eb03b3e0e6742c6728bc16a4b2d1d Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 22 May 2025 14:13:14 +0200
Subject: [PATCH] s390/pci: Allow re-add of a reserved but not yet removed
 device

The architecture assumes that PCI functions can be removed synchronously
as PCI events are processed. This however clashes with the reference
counting of struct pci_dev which allows device drivers to hold on to a
struct pci_dev reference even as the underlying device is removed. To
bridge this gap commit 2a671f77ee49 ("s390/pci: fix use after free of
zpci_dev") keeps the struct zpci_dev in ZPCI_FN_STATE_RESERVED state
until common code releases the struct pci_dev. Only when all references
are dropped, the struct zpci_dev can be removed and freed.

Later commit a46044a92add ("s390/pci: fix zpci_zdev_put() on reserve")
moved the deletion of the struct zpci_dev from the zpci_list in
zpci_release_device() to the point where the device is reserved. This
was done to prevent handling events for a device that is already being
removed, e.g. when the platform generates both PCI event codes 0x304
and 0x308. In retrospect, deletion from the zpci_list in the release
function without holding the zpci_list_lock was also racy.

A side effect of this handling is that if the underlying device
re-appears while the struct zpci_dev is in the ZPCI_FN_STATE_RESERVED
state, the new and old instances of the struct zpci_dev and/or struct
pci_dev may clash. For example when trying to create the IOMMU sysfs
files for the new instance. In this case, re-adding the new instance is
aborted. The old instance is removed, and the device will remain absent
until the platform issues another event.

Fix this by allowing the struct zpci_dev to be brought back up right
until it is finally removed. To this end also keep the struct zpci_dev
in the zpci_list until it is finally released when all references have
been dropped.

Deletion from the zpci_list from within the release function is made
safe by using kref_put_lock() with the zpci_list_lock. This ensures that
the releasing code holds the last reference.

Cc: stable@vger.kernel.org
Fixes: a46044a92add ("s390/pci: fix zpci_zdev_put() on reserve")
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9fcc6d3180f2..4602abd0c6f1 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -70,6 +70,13 @@ EXPORT_SYMBOL_GPL(zpci_aipb);
 struct airq_iv *zpci_aif_sbv;
 EXPORT_SYMBOL_GPL(zpci_aif_sbv);
 
+void zpci_zdev_put(struct zpci_dev *zdev)
+{
+	if (!zdev)
+		return;
+	kref_put_lock(&zdev->kref, zpci_release_device, &zpci_list_lock);
+}
+
 struct zpci_dev *get_zdev_by_fid(u32 fid)
 {
 	struct zpci_dev *tmp, *zdev = NULL;
@@ -925,21 +932,20 @@ int zpci_deconfigure_device(struct zpci_dev *zdev)
  * @zdev: the zpci_dev that was reserved
  *
  * Handle the case that a given zPCI function was reserved by another system.
- * After a call to this function the zpci_dev can not be found via
- * get_zdev_by_fid() anymore but may still be accessible via existing
- * references though it will not be functional anymore.
  */
 void zpci_device_reserved(struct zpci_dev *zdev)
 {
-	/*
-	 * Remove device from zpci_list as it is going away. This also
-	 * makes sure we ignore subsequent zPCI events for this device.
-	 */
-	spin_lock(&zpci_list_lock);
-	list_del(&zdev->entry);
-	spin_unlock(&zpci_list_lock);
+	lockdep_assert_held(&zdev->state_lock);
+	/* We may declare the device reserved multiple times */
+	if (zdev->state == ZPCI_FN_STATE_RESERVED)
+		return;
 	zdev->state = ZPCI_FN_STATE_RESERVED;
 	zpci_dbg(3, "rsv fid:%x\n", zdev->fid);
+	/*
+	 * The underlying device is gone. Allow the zdev to be freed
+	 * as soon as all other references are gone by accounting for
+	 * the removal as a dropped reference.
+	 */
 	zpci_zdev_put(zdev);
 }
 
@@ -948,6 +954,12 @@ void zpci_release_device(struct kref *kref)
 	struct zpci_dev *zdev = container_of(kref, struct zpci_dev, kref);
 
 	WARN_ON(zdev->state != ZPCI_FN_STATE_RESERVED);
+	/*
+	 * We already hold zpci_list_lock thanks to kref_put_lock().
+	 * This makes sure no new reference can be taken from the list.
+	 */
+	list_del(&zdev->entry);
+	spin_unlock(&zpci_list_lock);
 
 	if (zdev->has_hp_slot)
 		zpci_exit_slot(zdev);
diff --git a/arch/s390/pci/pci_bus.h b/arch/s390/pci/pci_bus.h
index e86a9419d233..ae3d7a9159bd 100644
--- a/arch/s390/pci/pci_bus.h
+++ b/arch/s390/pci/pci_bus.h
@@ -21,11 +21,8 @@ int zpci_bus_scan_device(struct zpci_dev *zdev);
 void zpci_bus_remove_device(struct zpci_dev *zdev, bool set_error);
 
 void zpci_release_device(struct kref *kref);
-static inline void zpci_zdev_put(struct zpci_dev *zdev)
-{
-	if (zdev)
-		kref_put(&zdev->kref, zpci_release_device);
-}
+
+void zpci_zdev_put(struct zpci_dev *zdev);
 
 static inline void zpci_zdev_get(struct zpci_dev *zdev)
 {
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 7bd7721c1239..2fbee3887d13 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -335,6 +335,22 @@ static void zpci_event_hard_deconfigured(struct zpci_dev *zdev, u32 fh)
 	zdev->state = ZPCI_FN_STATE_STANDBY;
 }
 
+static void zpci_event_reappear(struct zpci_dev *zdev)
+{
+	lockdep_assert_held(&zdev->state_lock);
+	/*
+	 * The zdev is in the reserved state. This means that it was presumed to
+	 * go away but there are still undropped references. Now, the platform
+	 * announced its availability again. Bring back the lingering zdev
+	 * to standby. This is safe because we hold a temporary reference
+	 * now so that it won't go away. Account for the re-appearance of the
+	 * underlying device by incrementing the reference count.
+	 */
+	zdev->state = ZPCI_FN_STATE_STANDBY;
+	zpci_zdev_get(zdev);
+	zpci_dbg(1, "rea fid:%x, fh:%x\n", zdev->fid, zdev->fh);
+}
+
 static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 {
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
@@ -358,8 +374,10 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 				break;
 			}
 		} else {
+			if (zdev->state == ZPCI_FN_STATE_RESERVED)
+				zpci_event_reappear(zdev);
 			/* the configuration request may be stale */
-			if (zdev->state != ZPCI_FN_STATE_STANDBY)
+			else if (zdev->state != ZPCI_FN_STATE_STANDBY)
 				break;
 			zdev->state = ZPCI_FN_STATE_CONFIGURED;
 		}
@@ -375,6 +393,8 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 				break;
 			}
 		} else {
+			if (zdev->state == ZPCI_FN_STATE_RESERVED)
+				zpci_event_reappear(zdev);
 			zpci_update_fh(zdev, ccdf->fh);
 		}
 		break;


