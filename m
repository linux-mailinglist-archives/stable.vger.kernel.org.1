Return-Path: <stable+bounces-143200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE4AB3476
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E7316E033
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927925F96E;
	Mon, 12 May 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zfGdyKIo"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852B25EFAA
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044286; cv=none; b=l7x/MrVLm/sVt+Jgp7iBhat9oyPsvnCEXJ6aFWLOOaIPseJ9HDemUgKEPgtDPJMlSlJ/7B1ZZljuHX26nckqqK2qmUJcOIuUtwexFG2Ha4GhNOQgec87zOlRamt7sIrLjutRf3a/iwG7X87GqzlnBO3iChRG1JPiR26emIyt9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044286; c=relaxed/simple;
	bh=pEh/B0gp0Ly1liDbsxG2c3O7gUYFNNxHGQj2VH6lmFY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mx2o6dx2EpPdm3tVMmBs74l5CXd8tz1siOKLtXpQSt+1U/xX1zZm+pUsBz9itVgD/Nq+xs9thUbGyfQOe0j6jjy/ODG0JD+mWXHxCAmUjHCq5sTPBHGtWtMOSDmAMPQAEUQFP1OBtWgqWMEYBshA9wSpllZvds2Enfz762H+n2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zfGdyKIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B990CC4CEEF;
	Mon, 12 May 2025 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044284;
	bh=pEh/B0gp0Ly1liDbsxG2c3O7gUYFNNxHGQj2VH6lmFY=;
	h=Subject:To:Cc:From:Date:From;
	b=zfGdyKIoDsQD83cLb5BURy66CaY2oC+pyXj7ma/RBlJV6PthvwHB1bhKvvzuc/qIn
	 Cl2DzxGZMhgpCi+JBEUY7AkLsGPnPvc5CzVvBsFvb4sAD4s+WbBKz7gKUwJDVb9EzN
	 RBNrE1XvaaXZMlcRFErcqHgiq1BtQH7vFebW4vEs=
Subject: FAILED: patch "[PATCH] iio: imu: inv_mpu6050: align buffer for timestamp" failed to apply to 6.6-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:04:31 +0200
Message-ID: <2025051231-antitoxic-buffing-b701@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1d2d8524eaffc4d9a116213520d2c650e07c9cc6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051231-antitoxic-buffing-b701@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1d2d8524eaffc4d9a116213520d2c650e07c9cc6 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:39 -0500
Subject: [PATCH] iio: imu: inv_mpu6050: align buffer for timestamp

Align the buffer used with iio_push_to_buffers_with_timestamp() to
ensure the s64 timestamp is aligned to 8 bytes.

Fixes: 0829edc43e0a ("iio: imu: inv_mpu6050: read the full fifo when processing data")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 3d3b27f28c9d..273196e647a2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -50,7 +50,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	u32 fifo_period;
 	s64 timestamp;
-	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
+	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(8);
 	size_t i, nb;
 
 	mutex_lock(&st->lock);


