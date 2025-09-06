Return-Path: <stable+bounces-177923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0172CB4684F
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 04:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A505C0BB5
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 02:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647E79F5;
	Sat,  6 Sep 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXaqnFwu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04B1F4C92
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124849; cv=none; b=E+ss7eGzymbI/1NS5hkUjKxJyvz+DEc5xkKAmlkAyxWCfZruYRz1kV9REsigS6fT67DrsCiaXGZmddbwB7+Qisw4N+FcJY9vJqiUwFIeQep9iKe+IuF4Rf7+6mSFBjPVgkUHzfZXphVwNRpuKIEMd6pTxBrWsuKwSWR0CnXfKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124849; c=relaxed/simple;
	bh=r2kz8+fmWzwnxFDU2vVUEA7cqL+PMSh1fJRSZ96tf4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0SWoOSGRd6vaMrTXs4YP2vLf/PcDGqpLT6GG/Sl86ApmJhW4jqhhHM9hNynrcn8ZOH5JPUduhZoH9n8bMQUHu7YXTHVrT7a1Mlbx0UhwZ5uRNWvyVZffU2xsJRWY80hD0BzrCz+NqTU2VujQ5GN5o+dkv4kR0VUZoVdw8LiOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXaqnFwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA75DC4CEF1;
	Sat,  6 Sep 2025 02:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757124849;
	bh=r2kz8+fmWzwnxFDU2vVUEA7cqL+PMSh1fJRSZ96tf4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXaqnFwuge9whQfxB3p+JpE3ro7/ijUmMIeKVnrdvxwgvfFce0SrfRbeB4GPUZI+U
	 0iA1QRD9c9hCFtmYgZxasjNoV1JQrceSRnf8gw1/luWxRSl6sn/T4TWVj9XsEJmUPr
	 8kIJNgj9V+G0/b4E7sEAJYeK25ejP5aLBIWX7fEMclO9xTHKFuT65XccE7zVv8Qxpi
	 nm72woVTETBaarLFRpcdAgWkNf6nE6gr1hJo82+Gd7CYF5dpc9TaoKbqki+NBcZBcu
	 KnBe9H01R7FCV9/EbFVKttX2wCZxCnr97ebCAVHYKGpHx/BxVCFDWunjvvdNrG8UTv
	 LFGXNzib3SjEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: imu: inv_mpu6050: align buffer for timestamp
Date: Fri,  5 Sep 2025 22:14:06 -0400
Message-ID: <20250906021407.3665934-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051231-antitoxic-buffing-b701@gregkh>
References: <2025051231-antitoxic-buffing-b701@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 1d2d8524eaffc4d9a116213520d2c650e07c9cc6 ]

Align the buffer used with iio_push_to_buffers_with_timestamp() to
ensure the s64 timestamp is aligned to 8 bytes.

Fixes: 0829edc43e0a ("iio: imu: inv_mpu6050: read the full fifo when processing data")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index d4f9b5d8d28d6..ace3ce4faea73 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -52,7 +52,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	u32 fifo_period;
 	s64 timestamp;
-	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
+	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(8);
 	int int_status;
 	size_t i, nb;
 
-- 
2.50.1


