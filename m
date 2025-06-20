Return-Path: <stable+bounces-154912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DD4AE132E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4D619E1286
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A611F09BF;
	Fri, 20 Jun 2025 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cDkKvkYD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC31DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398159; cv=none; b=lp/XGaWGUG42bbTeWXa6VVKWEf51W0ZDZFLf+t8HRIIqJuyQrbZGzaEQig4OvILA6ei2gH2Uw+NZGQnoRPq1hoMIv0GuXs1i3X0k2D2wOrnhCVrK0cvhyKDxYsMWyCYgerBlFWshGVRmE0pu/3XCieDDdOVx1gelXBLk642MYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398159; c=relaxed/simple;
	bh=l7MLVsQ1aAR9jniJrRBky0OdE14935LGf883BbKBBVQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XHeH/hJVJl16LuHg86FBf7+2scbUwi1S1YLPJ0qoRfvmiviub6DoZTn5CE5qckh67i9o9IptOgvgInxeNgcxgc27uHoH/u7ng9B8sJCuoYvyHqW2i4FrH0Gw8jLmfJcTVM6GxQ5E/K3Xk4BdnNOlvhacCMYwCrj/E/8XXCd2xEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cDkKvkYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9281AC4CEE3;
	Fri, 20 Jun 2025 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398159;
	bh=l7MLVsQ1aAR9jniJrRBky0OdE14935LGf883BbKBBVQ=;
	h=Subject:To:Cc:From:Date:From;
	b=cDkKvkYD/3xKKmtnP6qjMJKROYcuEczGDGrkfszk2CI+UbaDznWUhrQzSaA9ZhAGT
	 emlIXlD6MgmUySO2An/5OJtrMFA2a4Mx7rGX356SkW1uXUtZvKPCPXjWZWibgb9dXo
	 dGzsK5/XHCGfLx318UyD3JwYfTnW/ss36DuDdrSo=
Subject: FAILED: patch "[PATCH] s390/pci: Serialize device addition and removal" failed to apply to 5.15-stable tree
To: schnelle@linux.ibm.com,gbayer@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:42:21 +0200
Message-ID: <2025062021-uneasily-garbage-7a12@gregkh>
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
git cherry-pick -x 774a1fa880bc949d88b5ddec9494a13be733dfa8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062021-uneasily-garbage-7a12@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


