Return-Path: <stable+bounces-17822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC3084803D
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F7FB2977B
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553EF101C2;
	Sat,  3 Feb 2024 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="icJjqBQ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F01107B4;
	Sat,  3 Feb 2024 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933339; cv=none; b=onG18UthIsGm56i+UtGfUmfOvOfW7mANHsbnth74K1iHHgLWHngOyF2dd92ODTE0uJAECLBgIxykfgrJtzeGvtcddlJBPhXkP6XVz7uYy48mLKIPUlYYJsW1cUVjlEQ5e5GNbNoc5sf4K/qDUKeDp3EgskPug83mDbf0OkTuBR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933339; c=relaxed/simple;
	bh=c0xbOHAPLxXTXIlqej5iN4ROxZiR2o2PzC413CFGZsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ua0bOFrktN7PWALPTqgFKw9OmIW8SBYJB9K5mO1T8hhIy7USAqEjbuAli5ntYq7twx/K5hS0V8TWnuVJ6Ck6U7Lqtuz7SoJu2v6hFuGqYUXKYSN17pxpaWO+bbsYcKmf9t4hwrpEVNAipNG1OTPjLrTBBm8ySwYxyXTNYgXX8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=icJjqBQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3A3C433C7;
	Sat,  3 Feb 2024 04:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933337;
	bh=c0xbOHAPLxXTXIlqej5iN4ROxZiR2o2PzC413CFGZsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icJjqBQ+lanAJLea5Fkk4y0EoAp5pqebKXg5Oq7R8mxtGf1PLU7Pc35OqMQyy6Yqz
	 1H/NbR4GJrJciMvdnMgvtWVbBwsaIEygRPVI9FRNTWcU9QnLTRdGED5rujfn97rG6P
	 hLQdUf7t9rurZ60Xfcg8bxYOxaszewBg9gDCznqo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 036/219] s390/vfio-ap: fix sysfs status attribute for AP queue devices
Date: Fri,  2 Feb 2024 20:03:29 -0800
Message-ID: <20240203035321.491781337@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Krowiak <akrowiak@linux.ibm.com>

[ Upstream commit a0d8f4eeb7c4ffaee21702bcc91a09b3988c5b7a ]

The 'status' attribute for AP queue devices bound to the vfio_ap device
driver displays incorrect status when the mediated device is attached to a
guest, but the queue device is not passed through. In the current
implementation, the status displayed is 'in_use' which is not correct; it
should be 'assigned'. This can happen if one of the queue devices
associated with a given adapter is not bound to the vfio_ap device driver.
For example:

Queues listed in /sys/bus/ap/drivers/vfio_ap:
14.0005
14.0006
14.000d
16.0006
16.000d

Queues listed in /sys/devices/vfio_ap/matrix/$UUID/matrix
14.0005
14.0006
14.000d
16.0005
16.0006
16.000d

Queues listed in /sys/devices/vfio_ap/matrix/$UUID/guest_matrix
14.0005
14.0006
14.000d

The reason no queues for adapter 0x16 are listed in the guest_matrix is
because queue 16.0005 is not bound to the vfio_ap device driver, so no
queue associated with the adapter is passed through to the guest;
therefore, each queue device for adapter 0x16 should display 'assigned'
instead of 'in_use', because those queues are not in use by a guest, but
only assigned to the mediated device.

Let's check the AP configuration for the guest to determine whether a
queue device is passed through before displaying a status of 'in_use'.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Harald Freudenberger <freude@linux.ibm.com>
Link: https://lore.kernel.org/r/20231108201135.351419-1-akrowiak@linux.ibm.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0659aa2863ab..86a8bd532489 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1742,6 +1742,7 @@ static ssize_t status_show(struct device *dev,
 {
 	ssize_t nchars = 0;
 	struct vfio_ap_queue *q;
+	unsigned long apid, apqi;
 	struct ap_matrix_mdev *matrix_mdev;
 	struct ap_device *apdev = to_ap_dev(dev);
 
@@ -1749,8 +1750,21 @@ static ssize_t status_show(struct device *dev,
 	q = dev_get_drvdata(&apdev->device);
 	matrix_mdev = vfio_ap_mdev_for_queue(q);
 
+	/* If the queue is assigned to the matrix mediated device, then
+	 * determine whether it is passed through to a guest; otherwise,
+	 * indicate that it is unassigned.
+	 */
 	if (matrix_mdev) {
-		if (matrix_mdev->kvm)
+		apid = AP_QID_CARD(q->apqn);
+		apqi = AP_QID_QUEUE(q->apqn);
+		/*
+		 * If the queue is passed through to the guest, then indicate
+		 * that it is in use; otherwise, indicate that it is
+		 * merely assigned to a matrix mediated device.
+		 */
+		if (matrix_mdev->kvm &&
+		    test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
+		    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
 			nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
 					   AP_QUEUE_IN_USE);
 		else
-- 
2.43.0




