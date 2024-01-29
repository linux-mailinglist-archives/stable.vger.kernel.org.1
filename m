Return-Path: <stable+bounces-16488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C2840D2D
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B561C229FA
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD24615A49E;
	Mon, 29 Jan 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kefLOomY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948C15A494;
	Mon, 29 Jan 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548057; cv=none; b=hUbcX0VRH0p7DIdYRSOgoTJ0uf+7TURiAXbg5ytCfg9c8tBeIX+mgDOwJomefkx5fYDzhYLRNTRMaW1xrpU267Qd5h7UC02ywjBxyjlQZxzjjM3mMpHkaMh7l8eHQklysiuLawimyCEMPSo/Qwl/CQeYWNL6MORk5iDSV5XK4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548057; c=relaxed/simple;
	bh=Pz+qex2lmoLe09komb/iYYHySp3iCfZ/FxAm+UN7+u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pzjt7nQLgiJEqimx/RvjmdDIYUoAR7a0sTM/3pWLwgotmmwkK0xl+DNDqxfZ3q+A74Wm7sZg6VyNHEkPpRG9wbSvBylf46uM6clrWpFj2f67iCe6KMuGHkccXMbc52HbqTpZt2DJ0vZmvQDmgkRBZFE7fS6gZ5w+gPWx6bQ0vBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kefLOomY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A7DC43330;
	Mon, 29 Jan 2024 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548056;
	bh=Pz+qex2lmoLe09komb/iYYHySp3iCfZ/FxAm+UN7+u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kefLOomYBUKZSxXAHrCTJTs3idduv4FxG7vkDSYzGyNMpEvyLhaQqYq6E0p7pDnFc
	 pmCZr6CPfjz8GVdSJEg3+l///GnoyLsjIx7lF6Mmrj2XfBPLn1+X6oX7M4dvY4ka+B
	 nv9a/Nq5r1fbspMFNS0kYwH07wQfnQyVi/ah9Cis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.7 036/346] s390/vfio-ap: always filter entire AP matrix
Date: Mon, 29 Jan 2024 09:01:07 -0800
Message-ID: <20240129170017.448266165@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Krowiak <akrowiak@linux.ibm.com>

commit 850fb7fa8c684a4c6bf0e4b6978f4ddcc5d43d11 upstream.

The vfio_ap_mdev_filter_matrix function is called whenever a new adapter or
domain is assigned to the mdev. The purpose of the function is to update
the guest's AP configuration by filtering the matrix of adapters and
domains assigned to the mdev. When an adapter or domain is assigned, only
the APQNs associated with the APID of the new adapter or APQI of the new
domain are inspected. If an APQN does not reference a queue device bound to
the vfio_ap device driver, then it's APID will be filtered from the mdev's
matrix when updating the guest's AP configuration.

Inspecting only the APID of the new adapter or APQI of the new domain will
result in passing AP queues through to a guest that are not bound to the
vfio_ap device driver under certain circumstances. Consider the following:

guest's AP configuration (all also assigned to the mdev's matrix):
14.0004
14.0005
14.0006
16.0004
16.0005
16.0006

unassign domain 4
unbind queue 16.0005
assign domain 4

When domain 4 is re-assigned, since only domain 4 will be inspected, the
APQNs that will be examined will be:
14.0004
16.0004

Since both of those APQNs reference queue devices that are bound to the
vfio_ap device driver, nothing will get filtered from the mdev's matrix
when updating the guest's AP configuration. Consequently, queue 16.0005
will get passed through despite not being bound to the driver. This
violates the linux device model requirement that a guest shall only be
given access to devices bound to the device driver facilitating their
pass-through.

To resolve this problem, every adapter and domain assigned to the mdev will
be inspected when filtering the mdev's matrix.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240115185441.31526-2-akrowiak@linux.ibm.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/vfio_ap_ops.c |   57 +++++++++++---------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -671,8 +671,7 @@ static bool vfio_ap_mdev_filter_cdoms(st
  * Return: a boolean value indicating whether the KVM guest's APCB was changed
  *	   by the filtering or not.
  */
-static bool vfio_ap_mdev_filter_matrix(unsigned long *apm, unsigned long *aqm,
-				       struct ap_matrix_mdev *matrix_mdev)
+static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 {
 	unsigned long apid, apqi, apqn;
 	DECLARE_BITMAP(prev_shadow_apm, AP_DEVICES);
@@ -693,8 +692,8 @@ static bool vfio_ap_mdev_filter_matrix(u
 	bitmap_and(matrix_mdev->shadow_apcb.aqm, matrix_mdev->matrix.aqm,
 		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
 
-	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
-		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
 			/*
 			 * If the APQN is not bound to the vfio_ap device
 			 * driver, then we can't assign it to the guest's
@@ -959,7 +958,6 @@ static ssize_t assign_adapter_store(stru
 {
 	int ret;
 	unsigned long apid;
-	DECLARE_BITMAP(apm_delta, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -988,11 +986,8 @@ static ssize_t assign_adapter_store(stru
 	}
 
 	vfio_ap_mdev_link_adapter(matrix_mdev, apid);
-	memset(apm_delta, 0, sizeof(apm_delta));
-	set_bit_inv(apid, apm_delta);
 
-	if (vfio_ap_mdev_filter_matrix(apm_delta,
-				       matrix_mdev->matrix.aqm, matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	ret = count;
@@ -1168,7 +1163,6 @@ static ssize_t assign_domain_store(struc
 {
 	int ret;
 	unsigned long apqi;
-	DECLARE_BITMAP(aqm_delta, AP_DOMAINS);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -1197,11 +1191,8 @@ static ssize_t assign_domain_store(struc
 	}
 
 	vfio_ap_mdev_link_domain(matrix_mdev, apqi);
-	memset(aqm_delta, 0, sizeof(aqm_delta));
-	set_bit_inv(apqi, aqm_delta);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev->matrix.apm, aqm_delta,
-				       matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	ret = count;
@@ -2092,9 +2083,7 @@ int vfio_ap_mdev_probe_queue(struct ap_d
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
 
-		if (vfio_ap_mdev_filter_matrix(matrix_mdev->matrix.apm,
-					       matrix_mdev->matrix.aqm,
-					       matrix_mdev))
+		if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 	dev_set_drvdata(&apdev->device, q);
@@ -2444,34 +2433,22 @@ void vfio_ap_on_cfg_changed(struct ap_co
 
 static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 {
-	bool do_hotplug = false;
-	int filter_domains = 0;
-	int filter_adapters = 0;
-	DECLARE_BITMAP(apm, AP_DEVICES);
-	DECLARE_BITMAP(aqm, AP_DOMAINS);
+	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
 	mutex_lock(&matrix_mdev->kvm->lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
 
-	filter_adapters = bitmap_and(apm, matrix_mdev->matrix.apm,
-				     matrix_mdev->apm_add, AP_DEVICES);
-	filter_domains = bitmap_and(aqm, matrix_mdev->matrix.aqm,
-				    matrix_mdev->aqm_add, AP_DOMAINS);
-
-	if (filter_adapters && filter_domains)
-		do_hotplug |= vfio_ap_mdev_filter_matrix(apm, aqm, matrix_mdev);
-	else if (filter_adapters)
-		do_hotplug |=
-			vfio_ap_mdev_filter_matrix(apm,
-						   matrix_mdev->shadow_apcb.aqm,
-						   matrix_mdev);
-	else
-		do_hotplug |=
-			vfio_ap_mdev_filter_matrix(matrix_mdev->shadow_apcb.apm,
-						   aqm, matrix_mdev);
+	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
+					    matrix_mdev->apm_add, AP_DEVICES);
+	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
+					   matrix_mdev->aqm_add, AP_DOMAINS);
+	filter_cdoms = bitmap_intersects(matrix_mdev->matrix.adm,
+					 matrix_mdev->adm_add, AP_DOMAINS);
+
+	if (filter_adapters || filter_domains)
+		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev);
 
-	if (bitmap_intersects(matrix_mdev->matrix.adm, matrix_mdev->adm_add,
-			      AP_DOMAINS))
+	if (filter_cdoms)
 		do_hotplug |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
 
 	if (do_hotplug)



