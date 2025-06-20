Return-Path: <stable+bounces-154910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507F3AE132B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED02F4A29FB
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3101F09BF;
	Fri, 20 Jun 2025 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bE3Rgxtg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DB1DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398152; cv=none; b=YxmGK7hIZdUEprdIzSN4P3ne2x+0gmsjb1sL0kPFU7D6wV44lAyhBE8jy1PYhK73ev2JIqDpUZlX7pKF/dLgJ5m+0pwXnCavz6ecKmy/fIVyMS15ew1RwfpRzA2sAY4VSyM9Tj/KvnpCwT+iW6bXLBm0YNlUI8Qy4R7Xxfgycc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398152; c=relaxed/simple;
	bh=cu3yoYPYCLSSrVa5bGsXxtKF5RqGUO2OKNTxGZKIRKw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=psL10ON7Xvy+0ABn2jvAbXutPuRgf/ykjbj0tLdiE1I9R0cAifIc0osggaFGqfaSjReWS3aYLmks+l9sAJtAWpq0mPYt8XPY+79I0LbOv9aQ6Kd0OqDMgdM5yDC9U9RVy9KSfqNb0cL3v6n+51yrEDpSBP8sYMroQ8zBk0BFis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bE3Rgxtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA8CC4CEE3;
	Fri, 20 Jun 2025 05:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398152;
	bh=cu3yoYPYCLSSrVa5bGsXxtKF5RqGUO2OKNTxGZKIRKw=;
	h=Subject:To:Cc:From:Date:From;
	b=bE3RgxtgtKM6VkepGuLSo6hJpYQ80zKq9+nyrtrt6nHwA7Aeay8KquK4j3HmUXnh8
	 x0voFV1p3cKA7oEhDhbBUI9sDQBbvukUytftKd9ss2D1HYSh8o3Ef5UlQe51KLiNmC
	 KAbzjNhLgCmzuEdu7ZVT/pEPFbM7gUCJm28ZpoAc=
Subject: FAILED: patch "[PATCH] s390/pci: Serialize device addition and removal" failed to apply to 6.1-stable tree
To: schnelle@linux.ibm.com,gbayer@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:42:20 +0200
Message-ID: <2025062020-cornhusk-copy-3cd0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 774a1fa880bc949d88b5ddec9494a13be733dfa8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062020-cornhusk-copy-3cd0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 774a1fa880bc949d88b5ddec9494a13be733dfa8 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 22 May 2025 14:13:15 +0200
Subject: [PATCH] s390/pci: Serialize device addition and removal

Prior changes ensured that when zpci_release_device() is called and it
removed the zdev from the zpci_list this instance can not be found via
the zpci_list anymore even while allowing re-add of reserved devices.
This only accounts for the overall lifetime and zpci_list addition and
removal, it does not yet prevent concurrent add of a new instance for
the same underlying device. Such concurrent add would subsequently cause
issues such as attempted re-use of the same IOMMU sysfs directory and is
generally undesired.

Introduce a new zpci_add_remove_lock mutex to serialize adding a new
device with removal. Together this ensures that if a struct zpci_dev is
not found in the zpci_list it was either already removed and torn down,
or its removal and tear down is in progress with the
zpci_add_remove_lock held.

Cc: stable@vger.kernel.org
Fixes: a46044a92add ("s390/pci: fix zpci_zdev_put() on reserve")
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 4602abd0c6f1..cd6676c2d602 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -45,6 +45,7 @@
 /* list of all detected zpci devices */
 static LIST_HEAD(zpci_list);
 static DEFINE_SPINLOCK(zpci_list_lock);
+static DEFINE_MUTEX(zpci_add_remove_lock);
 
 static DECLARE_BITMAP(zpci_domain, ZPCI_DOMAIN_BITMAP_SIZE);
 static DEFINE_SPINLOCK(zpci_domain_lock);
@@ -74,7 +75,9 @@ void zpci_zdev_put(struct zpci_dev *zdev)
 {
 	if (!zdev)
 		return;
+	mutex_lock(&zpci_add_remove_lock);
 	kref_put_lock(&zdev->kref, zpci_release_device, &zpci_list_lock);
+	mutex_unlock(&zpci_add_remove_lock);
 }
 
 struct zpci_dev *get_zdev_by_fid(u32 fid)
@@ -844,6 +847,7 @@ int zpci_add_device(struct zpci_dev *zdev)
 {
 	int rc;
 
+	mutex_lock(&zpci_add_remove_lock);
 	zpci_dbg(1, "add fid:%x, fh:%x, c:%d\n", zdev->fid, zdev->fh, zdev->state);
 	rc = zpci_init_iommu(zdev);
 	if (rc)
@@ -857,12 +861,14 @@ int zpci_add_device(struct zpci_dev *zdev)
 	spin_lock(&zpci_list_lock);
 	list_add_tail(&zdev->entry, &zpci_list);
 	spin_unlock(&zpci_list_lock);
+	mutex_unlock(&zpci_add_remove_lock);
 	return 0;
 
 error_destroy_iommu:
 	zpci_destroy_iommu(zdev);
 error:
 	zpci_dbg(0, "add fid:%x, rc:%d\n", zdev->fid, rc);
+	mutex_unlock(&zpci_add_remove_lock);
 	return rc;
 }
 
@@ -953,6 +959,7 @@ void zpci_release_device(struct kref *kref)
 {
 	struct zpci_dev *zdev = container_of(kref, struct zpci_dev, kref);
 
+	lockdep_assert_held(&zpci_add_remove_lock);
 	WARN_ON(zdev->state != ZPCI_FN_STATE_RESERVED);
 	/*
 	 * We already hold zpci_list_lock thanks to kref_put_lock().


