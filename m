Return-Path: <stable+bounces-34673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEB1894052
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E70B1C2156A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8046B9F;
	Mon,  1 Apr 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SVShhMrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EEC129;
	Mon,  1 Apr 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988911; cv=none; b=PSM2kUgFM/IzmaTQDNjhzNOKKKSMmm6AcPxYNfrrtSGG6lPyeTzhky87mwHmDfzDApQCr+ZD6j8xDmbF3eaaL76Ss7ij0HGws7NZlOj7eHlSEWIX1mgIAMrh+fLU58Dp60YNFEa0oqiFyzntlvz7Re5r/m64Ntsa5l1PJBZhW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988911; c=relaxed/simple;
	bh=E/GtYUNN3Vj1FFMul7R37PvXEC5P811f0OgPHzxfb2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+0DZxEmSJcb/Juco9UbkULDqu9ogpJ/UEC43DzlSZ37/Lz7SL435j/u/qX+Q6oqsr1obLg+t4WasEfEER1AsfpiMzCDRDIRGFl46SAsPOlycoIZlh5IYHZ1Kyk96zvAkcO4R8cON/8HmLqrUs5ywpWy9NJrRj6FejhOwC2aNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SVShhMrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE979C433F1;
	Mon,  1 Apr 2024 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988911;
	bh=E/GtYUNN3Vj1FFMul7R37PvXEC5P811f0OgPHzxfb2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVShhMrAhor5VGvCtl0UvNRR4QYjAp4QzoRC3Qse1Nf/l/Rjcnp8IZ7n+dbwBfp9i
	 lguwc8PwqdYTxRXjEdg27OdMxH1x8/HJ/A6kxhpPXQsn/uCh1URxe5uBLuaD8UNNPo
	 GCa76lrpp5/ic51EqFdpYHvuqdpRUDMM8GjM7vfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.7 287/432] iio: imu: inv_mpu6050: fix FIFO parsing when empty
Date: Mon,  1 Apr 2024 17:44:34 +0200
Message-ID: <20240401152601.731738278@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

commit 60caa8b33bd682a9ed99d1fc3f91d74e1acc9922 upstream.

Now that we are reading the full FIFO in the interrupt handler,
it is possible to have an emply FIFO since we are still receiving
1 interrupt per data. Handle correctly this case instead of having
an error causing a reset of the FIFO.

Fixes: 0829edc43e0a ("iio: imu: inv_mpu6050: read the full fifo when processing data")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://lore.kernel.org/r/20240219154825.90656-1-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -109,6 +109,8 @@ irqreturn_t inv_mpu6050_read_fifo(int ir
 	/* compute and process only all complete datum */
 	nb = fifo_count / bytes_per_datum;
 	fifo_count = nb * bytes_per_datum;
+	if (nb == 0)
+		goto end_session;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
 	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);



