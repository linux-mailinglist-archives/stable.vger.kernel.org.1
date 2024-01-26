Return-Path: <stable+bounces-15946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E68183E4EB
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C7DB2422B
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7733924A1D;
	Fri, 26 Jan 2024 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oDxZ9GVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BFC25558
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307237; cv=none; b=jGsvmq5I708B+E3TuM+KJUiAXj+WntQaHIEvYFQccwukC3Kmx04B+ei95GWznQwLox77Qp2OrixfgbVkdPET16Jv9JPdChLLWCCKbLUZLEgZPyx4PutGswEq1xrUnjFP7oLG0Hy9+9ra396+Un8gUwTG5KeX+/JF45ZYHd6kVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307237; c=relaxed/simple;
	bh=fYdqVo8+aOkMeXBhPOinoC1qX4S/p0D2edVsBtErqo0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BgmQQ0zZRMQ/G2/VmGzMj88IO2g1+/X/c9BSrDTbbQTGCmCby4Bgoj3XnxjHUAmi97FtLuC3yM94HHEAT1Dp7Z1X7eF5HITfrwfrfORkMxWXP4qhX2tLykaxkomXB1v+HtA21L0jAs/YlWrOZQPzlo3Zaq2qyuvJD0EMndm6E1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oDxZ9GVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE225C43399;
	Fri, 26 Jan 2024 22:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706307237;
	bh=fYdqVo8+aOkMeXBhPOinoC1qX4S/p0D2edVsBtErqo0=;
	h=Subject:To:Cc:From:Date:From;
	b=oDxZ9GVA14m7TxCSVk7BjJGPoSKmiMq6bFCrblNNc1rrVDoZhUPGLcNnJ3YAkfc33
	 7YNyAcgHZLf50Wy6GvKBsm5mWOpURncuzrD/QnAnWoAhyWIjyqrpE85iiL5OrOkuwz
	 ysxCXzI1UkefQTzt7MhNazbo/TwdOTtwIdz9lNQ0=
Subject: FAILED: patch "[PATCH] s390/vfio-ap: reset queues associated with adapter for queue" failed to apply to 6.1-stable tree
To: akrowiak@linux.ibm.com,agordeev@linux.ibm.com,pasic@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:13:56 -0800
Message-ID: <2024012656-cider-favorable-b52e@gregkh>
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
git cherry-pick -x f009cfa466558b7dfe97f167ba1875d6f9ea4c07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012656-cider-favorable-b52e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f009cfa46655 ("s390/vfio-ap: reset queues associated with adapter for queue unbound from driver")
f848cba767e5 ("s390/vfio-ap: reset queues filtered from the guest's AP config")
774d10196e64 ("s390/vfio-ap: let on_scan_complete() callback filter matrix and update guest's APCB")
850fb7fa8c68 ("s390/vfio-ap: always filter entire AP matrix")
9261f0438835 ("s390/vfio-ap: use work struct to verify queue reset")
62aab082e999 ("s390/vfio-ap: store entire AP queue status word with the queue object")
dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
c51f8c6bb5c8 ("s390/vfio-ap: allow deconfigured queue to be passed through to a guest")
411b0109daa5 ("s390/vfio-ap: wait for response code 05 to clear on queue reset")
7aa7b2a80cb7 ("s390/vfio-ap: clean up irq resources if possible")
680b7ddd7e2a ("s390/vfio-ap: no need to check the 'E' and 'I' bits in APQSW after TAPQ")
4bdf3c3956d8 ("s390/ap: provide F bit parameter for ap_rapq() and ap_zapq()")
7cb7636a1ac1 ("s390/vfio_ap: increase max wait time for reset verification")
51d4d9877087 ("s390/vfio_ap: fix handling of error response codes")
5a42b348adf9 ("s390/vfio_ap: verify ZAPQ completion after return of response code zero")
3ba41768105c ("s390/vfio_ap: use TAPQ to verify reset in progress completes")
0daf9878a799 ("s390/vfio_ap: check TAPQ response code when waiting for queue reset")
62414d901c3a ("s390/vfio-ap: verify reset complete in separate function")
08866d34c709 ("s390/vfio-ap: fix an error handling path in vfio_ap_mdev_probe_queue()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f009cfa466558b7dfe97f167ba1875d6f9ea4c07 Mon Sep 17 00:00:00 2001
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 15 Jan 2024 13:54:35 -0500
Subject: [PATCH] s390/vfio-ap: reset queues associated with adapter for queue
 unbound from driver

When a queue is unbound from the vfio_ap device driver, if that queue is
assigned to a guest's AP configuration, its associated adapter is removed
because queues are defined to a guest via a matrix of adapters and
domains; so, it is not possible to remove a single queue.

If an adapter is removed from the guest's AP configuration, all associated
queues must be reset to prevent leaking crypto data should any of them be
assigned to a different guest or device driver. The one caveat is that if
the queue is being removed because the adapter or domain has been removed
from the host's AP configuration, then an attempt to reset the queue will
fail with response code 01, AP-queue number not valid; so resetting these
queues should be skipped.

Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Fixes: 09d31ff78793 ("s390/vfio-ap: hot plug/unplug of AP devices when probed/removed")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240115185441.31526-6-akrowiak@linux.ibm.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44cd29aace8e..550c936c413d 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -939,45 +939,45 @@ static void vfio_ap_mdev_link_adapter(struct ap_matrix_mdev *matrix_mdev,
 				       AP_MKQID(apid, apqi));
 }
 
+static void collect_queues_to_reset(struct ap_matrix_mdev *matrix_mdev,
+				    unsigned long apid,
+				    struct list_head *qlist)
+{
+	struct vfio_ap_queue *q;
+	unsigned long  apqi;
+
+	for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS) {
+		q = vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi));
+		if (q)
+			list_add_tail(&q->reset_qnode, qlist);
+	}
+}
+
+static void reset_queues_for_apid(struct ap_matrix_mdev *matrix_mdev,
+				  unsigned long apid)
+{
+	struct list_head qlist;
+
+	INIT_LIST_HEAD(&qlist);
+	collect_queues_to_reset(matrix_mdev, apid, &qlist);
+	vfio_ap_mdev_reset_qlist(&qlist);
+}
+
 static int reset_queues_for_apids(struct ap_matrix_mdev *matrix_mdev,
 				  unsigned long *apm_reset)
 {
-	struct vfio_ap_queue *q, *tmpq;
 	struct list_head qlist;
-	unsigned long apid, apqi;
-	int apqn, ret = 0;
+	unsigned long apid;
 
 	if (bitmap_empty(apm_reset, AP_DEVICES))
 		return 0;
 
 	INIT_LIST_HEAD(&qlist);
 
-	for_each_set_bit_inv(apid, apm_reset, AP_DEVICES) {
-		for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm,
-				     AP_DOMAINS) {
-			/*
-			 * If the domain is not in the host's AP configuration,
-			 * then resetting it will fail with response code 01
-			 * (APQN not valid).
-			 */
-			if (!test_bit_inv(apqi,
-					  (unsigned long *)matrix_dev->info.aqm))
-				continue;
-
-			apqn = AP_MKQID(apid, apqi);
-			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
-
-			if (q)
-				list_add_tail(&q->reset_qnode, &qlist);
-		}
-	}
+	for_each_set_bit_inv(apid, apm_reset, AP_DEVICES)
+		collect_queues_to_reset(matrix_mdev, apid, &qlist);
 
-	ret = vfio_ap_mdev_reset_qlist(&qlist);
-
-	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode)
-		list_del(&q->reset_qnode);
-
-	return ret;
+	return vfio_ap_mdev_reset_qlist(&qlist);
 }
 
 /**
@@ -2217,24 +2217,30 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	matrix_mdev = q->matrix_mdev;
 
 	if (matrix_mdev) {
-		vfio_ap_unlink_queue_fr_mdev(q);
-
 		apid = AP_QID_CARD(q->apqn);
 		apqi = AP_QID_QUEUE(q->apqn);
-
-		/*
-		 * If the queue is assigned to the guest's APCB, then remove
-		 * the adapter's APID from the APCB and hot it into the guest.
-		 */
+		/* If the queue is assigned to the guest's AP configuration */
 		if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
 		    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
+			/*
+			 * Since the queues are defined via a matrix of adapters
+			 * and domains, it is not possible to hot unplug a
+			 * single queue; so, let's unplug the adapter.
+			 */
 			clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
 			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+			reset_queues_for_apid(matrix_mdev, apid);
+			goto done;
 		}
 	}
 
 	vfio_ap_mdev_reset_queue(q);
 	flush_work(&q->reset_work);
+
+done:
+	if (matrix_mdev)
+		vfio_ap_unlink_queue_fr_mdev(q);
+
 	dev_set_drvdata(&apdev->device, NULL);
 	kfree(q);
 	release_update_locks_for_mdev(matrix_mdev);


