Return-Path: <stable+bounces-15947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400683E4EF
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4561F22DC1
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271542563C;
	Fri, 26 Jan 2024 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PiK923TZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5E25636
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307248; cv=none; b=fprSh+A2kY+jS7i3vi7+AnRHXDdiTQ395iGezCKeJ0uHXZw9BFsMqm9AhEA+WbYYqafJNM/V0M71N/N1bcTFoVmLjxRxORPzi6zkZbCIAYPHyNZgzdta/cRd41THexPYXI87r2JtFmFSH4wpo/mfUr+1/RviTonm8MKJjEIigbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307248; c=relaxed/simple;
	bh=jNDHv68fd/apLTHhd1uCYbMt6O3gb4f2Ms3M7plSmHM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tV7SPbwrNeCL0rw71cAfurVu6l3ZqTodDii3D2csH0r3rCKCmxOV3s6C1k3TDdO8tI1hYmOhsu8N2xKkST20IK/DS2Rue39qBySwyC9Lh5X00Ko1RxtAYxSKwnXq4QhnyRMvAgxvRi98ITit+JPY23AG3WJt2HXG6jRqJjM/ah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PiK923TZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A82C433B1;
	Fri, 26 Jan 2024 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706307248;
	bh=jNDHv68fd/apLTHhd1uCYbMt6O3gb4f2Ms3M7plSmHM=;
	h=Subject:To:Cc:From:Date:From;
	b=PiK923TZuLLCGeGkp+SF6Zo/h5gS+ogn8AxARU03rBo1S62vgAtOY6beT7sWA8kxQ
	 rVlHxCpTWIWJonZkjGkJ3mMiJ3MIBTsF8wdJmOZDJx31ZMSQa/gZtKqSTq95aFrzKo
	 0WMnIeUUqEgajJEjlVIR1zza5UH1yJjuynm3ru+k=
Subject: FAILED: patch "[PATCH] s390/vfio-ap: do not reset queue removed from host config" failed to apply to 6.1-stable tree
To: akrowiak@linux.ibm.com,agordeev@linux.ibm.com,jjherne@linux.ibm.com,pasic@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:14:07 -0800
Message-ID: <2024012607-barley-trickster-1bf8@gregkh>
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
git cherry-pick -x b9bd10c43456d16abd97b717446f51afb3b88411
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012607-barley-trickster-1bf8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b9bd10c43456 ("s390/vfio-ap: do not reset queue removed from host config")
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

From b9bd10c43456d16abd97b717446f51afb3b88411 Mon Sep 17 00:00:00 2001
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 15 Jan 2024 13:54:36 -0500
Subject: [PATCH] s390/vfio-ap: do not reset queue removed from host config

When a queue is unbound from the vfio_ap device driver, it is reset to
ensure its crypto data is not leaked when it is bound to another device
driver. If the queue is unbound due to the fact that the adapter or domain
was removed from the host's AP configuration, then attempting to reset it
will fail with response code 01 (APID not valid) getting returned from the
reset command. Let's ensure that the queue is assigned to the host's
configuration before resetting it.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: "Jason J. Herne" <jjherne@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: eeb386aeb5b7 ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240115185441.31526-7-akrowiak@linux.ibm.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 550c936c413d..983b3b16196c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2215,10 +2215,10 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	q = dev_get_drvdata(&apdev->device);
 	get_update_locks_for_queue(q);
 	matrix_mdev = q->matrix_mdev;
+	apid = AP_QID_CARD(q->apqn);
+	apqi = AP_QID_QUEUE(q->apqn);
 
 	if (matrix_mdev) {
-		apid = AP_QID_CARD(q->apqn);
-		apqi = AP_QID_QUEUE(q->apqn);
 		/* If the queue is assigned to the guest's AP configuration */
 		if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
 		    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
@@ -2234,8 +2234,16 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		}
 	}
 
-	vfio_ap_mdev_reset_queue(q);
-	flush_work(&q->reset_work);
+	/*
+	 * If the queue is not in the host's AP configuration, then resetting
+	 * it will fail with response code 01, (APQN not valid); so, let's make
+	 * sure it is in the host's config.
+	 */
+	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
+	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
+		vfio_ap_mdev_reset_queue(q);
+		flush_work(&q->reset_work);
+	}
 
 done:
 	if (matrix_mdev)


