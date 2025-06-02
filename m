Return-Path: <stable+bounces-149161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E192DACB14C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BB4404047
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C59D226CE1;
	Mon,  2 Jun 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V0FBLmvA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD3224B10;
	Mon,  2 Jun 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873089; cv=none; b=I3GqsvRk3fMnmB/bDA2jIu9t75IMPgC3dzIEwddEVEYkzcagLL+wSHe/8mRoQJSXzQzACGoM13ZnRgBls2giUKMxBqggGkRgCE2vImT1NVZA32sTTEZopInnE6UiBoTcJHXqwE6Zm3VVhKNARzq3AmOKMLgCwG1Eu632UscB82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873089; c=relaxed/simple;
	bh=PShgzisZFSOnxu/EE6vJ6pVrbuvUQFHuvX6RSYuT8jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJVVCZJJVjeQnUPgDumVYkKPWzWZmkDnpyL3Hg7q0tjrk1iKjc3vL065PguozM0ZwlzKc/dlCA0Rh/3rhteFkLkfUBH84pvfK5ohcXjmkMiyL26vb0SQe0gqR60z3cqErs1DbsHo//A5eH/ljGUOwLbD1OGIFzDiBAKlXl6wjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V0FBLmvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9C7C4CEEB;
	Mon,  2 Jun 2025 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873089;
	bh=PShgzisZFSOnxu/EE6vJ6pVrbuvUQFHuvX6RSYuT8jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0FBLmvAq4N+Vo4ctphBUxp417dh+x0g0EuLSxJn1UYsHYuLVShuquQhHYbF3eyxU
	 r9IRTGRtDc5tYxx/hvx+u1cWAvMnXjIcicx+qDhvGoCrtDOgGlz92iIUBjqL0Ii+jr
	 SvpfkOUKA9VZTF+99kJ90Pj+dMZKL0A00iqERkOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anthony Krowiak <akrowiak@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 034/444] s390/vfio-ap: Fix no AP queue sharing allowed message written to kernel log
Date: Mon,  2 Jun 2025 15:41:38 +0200
Message-ID: <20250602134342.297004065@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anthony Krowiak <akrowiak@linux.ibm.com>

[ Upstream commit d33d729afcc8ad2148d99f9bc499b33fd0c0d73b ]

An erroneous message is written to the kernel log when either of the
following actions are taken by a user:

1. Assign an adapter or domain to a vfio_ap mediated device via its sysfs
   assign_adapter or assign_domain attributes that would result in one or
   more AP queues being assigned that are already assigned to a different
   mediated device. Sharing of queues between mdevs is not allowed.

2. Reserve an adapter or domain for the host device driver via the AP bus
   driver's sysfs apmask or aqmask attribute that would result in providing
   host access to an AP queue that is in use by a vfio_ap mediated device.
   Reserving a queue for a host driver that is in use by an mdev is not
   allowed.

In both cases, the assignment will return an error; however, a message like
the following is written to the kernel log:

vfio_ap_mdev e1839397-51a0-4e3c-91e0-c3b9c3d3047d: Userspace may not
re-assign queue 00.0028 already assigned to \
e1839397-51a0-4e3c-91e0-c3b9c3d3047d

Notice the mdev reporting the error is the same as the mdev identified
in the message as the one to which the queue is being assigned.
It is perfectly okay to assign a queue to an mdev to which it is
already assigned; the assignment is simply ignored by the vfio_ap device
driver.

This patch logs more descriptive and accurate messages for both 1 and 2
above to the kernel log:

Example for 1:
vfio_ap_mdev 0fe903a0-a323-44db-9daf-134c68627d61: Userspace may not assign
queue 00.0033 to mdev: already assigned to \
62177883-f1bb-47f0-914d-32a22e3a8804

Example for 2:
vfio_ap_mdev 62177883-f1bb-47f0-914d-32a22e3a8804: Can not reserve queue
00.0033 for host driver: in use by mdev

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Link: https://lore.kernel.org/r/20250311103304.1539188-1-akrowiak@linux.ibm.com
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 72 ++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index d6ea2fd4c2a02..d4151f519e8b2 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -834,48 +834,66 @@ static void vfio_ap_mdev_remove(struct mdev_device *mdev)
 	vfio_put_device(&matrix_mdev->vdev);
 }
 
-#define MDEV_SHARING_ERR "Userspace may not re-assign queue %02lx.%04lx " \
-			 "already assigned to %s"
+#define MDEV_SHARING_ERR "Userspace may not assign queue %02lx.%04lx to mdev: already assigned to %s"
 
-static void vfio_ap_mdev_log_sharing_err(struct ap_matrix_mdev *matrix_mdev,
-					 unsigned long *apm,
-					 unsigned long *aqm)
+#define MDEV_IN_USE_ERR "Can not reserve queue %02lx.%04lx for host driver: in use by mdev"
+
+static void vfio_ap_mdev_log_sharing_err(struct ap_matrix_mdev *assignee,
+					 struct ap_matrix_mdev *assigned_to,
+					 unsigned long *apm, unsigned long *aqm)
 {
 	unsigned long apid, apqi;
-	const struct device *dev = mdev_dev(matrix_mdev->mdev);
-	const char *mdev_name = dev_name(dev);
 
-	for_each_set_bit_inv(apid, apm, AP_DEVICES)
+	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+			dev_warn(mdev_dev(assignee->mdev), MDEV_SHARING_ERR,
+				 apid, apqi, dev_name(mdev_dev(assigned_to->mdev)));
+		}
+	}
+}
+
+static void vfio_ap_mdev_log_in_use_err(struct ap_matrix_mdev *assignee,
+					unsigned long *apm, unsigned long *aqm)
+{
+	unsigned long apid, apqi;
+
+	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
 		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS)
-			dev_warn(dev, MDEV_SHARING_ERR, apid, apqi, mdev_name);
+			dev_warn(mdev_dev(assignee->mdev), MDEV_IN_USE_ERR, apid, apqi);
+	}
 }
 
 /**
  * vfio_ap_mdev_verify_no_sharing - verify APQNs are not shared by matrix mdevs
  *
+ * @assignee: the matrix mdev to which @mdev_apm and @mdev_aqm are being
+ *	      assigned; or, NULL if this function was called by the AP bus
+ *	      driver in_use callback to verify none of the APQNs being reserved
+ *	      for the host device driver are in use by a vfio_ap mediated device
  * @mdev_apm: mask indicating the APIDs of the APQNs to be verified
  * @mdev_aqm: mask indicating the APQIs of the APQNs to be verified
  *
- * Verifies that each APQN derived from the Cartesian product of a bitmap of
- * AP adapter IDs and AP queue indexes is not configured for any matrix
- * mediated device. AP queue sharing is not allowed.
+ * Verifies that each APQN derived from the Cartesian product of APIDs
+ * represented by the bits set in @mdev_apm and the APQIs of the bits set in
+ * @mdev_aqm is not assigned to a mediated device other than the mdev to which
+ * the APQN is being assigned (@assignee). AP queue sharing is not allowed.
  *
  * Return: 0 if the APQNs are not shared; otherwise return -EADDRINUSE.
  */
-static int vfio_ap_mdev_verify_no_sharing(unsigned long *mdev_apm,
+static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *assignee,
+					  unsigned long *mdev_apm,
 					  unsigned long *mdev_aqm)
 {
-	struct ap_matrix_mdev *matrix_mdev;
+	struct ap_matrix_mdev *assigned_to;
 	DECLARE_BITMAP(apm, AP_DEVICES);
 	DECLARE_BITMAP(aqm, AP_DOMAINS);
 
-	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+	list_for_each_entry(assigned_to, &matrix_dev->mdev_list, node) {
 		/*
-		 * If the input apm and aqm are fields of the matrix_mdev
-		 * object, then move on to the next matrix_mdev.
+		 * If the mdev to which the mdev_apm and mdev_aqm is being
+		 * assigned is the same as the mdev being verified
 		 */
-		if (mdev_apm == matrix_mdev->matrix.apm &&
-		    mdev_aqm == matrix_mdev->matrix.aqm)
+		if (assignee == assigned_to)
 			continue;
 
 		memset(apm, 0, sizeof(apm));
@@ -885,15 +903,16 @@ static int vfio_ap_mdev_verify_no_sharing(unsigned long *mdev_apm,
 		 * We work on full longs, as we can only exclude the leftover
 		 * bits in non-inverse order. The leftover is all zeros.
 		 */
-		if (!bitmap_and(apm, mdev_apm, matrix_mdev->matrix.apm,
-				AP_DEVICES))
+		if (!bitmap_and(apm, mdev_apm, assigned_to->matrix.apm,	AP_DEVICES))
 			continue;
 
-		if (!bitmap_and(aqm, mdev_aqm, matrix_mdev->matrix.aqm,
-				AP_DOMAINS))
+		if (!bitmap_and(aqm, mdev_aqm, assigned_to->matrix.aqm,	AP_DOMAINS))
 			continue;
 
-		vfio_ap_mdev_log_sharing_err(matrix_mdev, apm, aqm);
+		if (assignee)
+			vfio_ap_mdev_log_sharing_err(assignee, assigned_to, apm, aqm);
+		else
+			vfio_ap_mdev_log_in_use_err(assigned_to, apm, aqm);
 
 		return -EADDRINUSE;
 	}
@@ -922,7 +941,8 @@ static int vfio_ap_mdev_validate_masks(struct ap_matrix_mdev *matrix_mdev)
 					       matrix_mdev->matrix.aqm))
 		return -EADDRNOTAVAIL;
 
-	return vfio_ap_mdev_verify_no_sharing(matrix_mdev->matrix.apm,
+	return vfio_ap_mdev_verify_no_sharing(matrix_mdev,
+					      matrix_mdev->matrix.apm,
 					      matrix_mdev->matrix.aqm);
 }
 
@@ -2271,7 +2291,7 @@ int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
 
 	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
-	ret = vfio_ap_mdev_verify_no_sharing(apm, aqm);
+	ret = vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	mutex_unlock(&matrix_dev->guests_lock);
 
-- 
2.39.5




