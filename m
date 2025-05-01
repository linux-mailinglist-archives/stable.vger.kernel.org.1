Return-Path: <stable+bounces-139322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94428AA60E8
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA271BA50ED
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF1202C49;
	Thu,  1 May 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TWUqOo9/"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE0202976
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114579; cv=none; b=a9f642QDyW4luqH7pX9gO80zc9f4crDBqgEnrtXKA4Jy3TGTcv+KaaN+HB0Tnf+27/R5T+83xL/l9efzS5QBO0MgWgJS093CPBYOllJSPcvr355gyRNCH89Hq88GcjNj1v3zlOsYj+ZsGonl3iTKS2cEi5+8UVoprEB+HRX2cFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114579; c=relaxed/simple;
	bh=yMH76nRybYKW8R3KYSXnyDiuvyr3CSJLyXtCch8iDFs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=eghTCnvm3ePEf82CQ6RXd21bvanj6nzTUjWMPEGOgkp0vHS4Qg8FH1QftvEnieWa0Xr4LabMyreaDlleit0AS2UXkO4yexI2RBh3EiaMZSV2Qi8ohpdSVrDze3Wg4ZwqXwx4XAD2YkN45ZrH1dGBEHFBCvqGEjNMn59jv/aJQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TWUqOo9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBE4C4CEE9;
	Thu,  1 May 2025 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114579;
	bh=yMH76nRybYKW8R3KYSXnyDiuvyr3CSJLyXtCch8iDFs=;
	h=Subject:To:From:Date:From;
	b=TWUqOo9/96Rll2vL1528d0m97lc2fjOaoOVuJqKh3Ub4uvuzhY0VvOwU5fl6TIjG7
	 YFoBQmNfOLOOepERZSsVQy7+RngTPDcV7/y/QUsahPFJ+BJU23btFUhdf5jCeatb1q
	 7bIvlmZd7KvFxAKJ2wjH5paOXQsmskVWcPwnmTQc=
Subject: patch "iio: imu: inv_mpu6050: align buffer for timestamp" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:48:58 +0200
Message-ID: <2025050158-pretender-refract-946b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: inv_mpu6050: align buffer for timestamp

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 1d2d8524eaffc4d9a116213520d2c650e07c9cc6 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:39 -0500
Subject: iio: imu: inv_mpu6050: align buffer for timestamp

Align the buffer used with iio_push_to_buffers_with_timestamp() to
ensure the s64 timestamp is aligned to 8 bytes.

Fixes: 0829edc43e0a ("iio: imu: inv_mpu6050: read the full fifo when processing data")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.49.0



