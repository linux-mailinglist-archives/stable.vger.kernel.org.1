Return-Path: <stable+bounces-172740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A0BB33039
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FED34443BE
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0830B2737E6;
	Sun, 24 Aug 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHSqWN2N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9C1E4A4
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043609; cv=none; b=bro1hP9d+U9SP3dpnGUj5C8HXoD2j/e7j/s9CtHezzrqsz146QegLsWTIEHgWWvK66LZpsMmd1y1MCxQiS7cWvuZ6/HhA4OIyDSXAOy12/SUaETSlr0PBZc5V5tdwK1fGboK4HGmeU2vn7bd7QMULKsMxvluWw+hd0WQpkJHTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043609; c=relaxed/simple;
	bh=2IT1kH465tsaUGdMXje5GjUAuBK3kLPa3WAJEWaHN8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5kBPdUPgb3bp8wTjJFwjktYUyr6MNVdFCvEl+QnRNup6CXGIKF9Cg3qwVa4RUOA8WoQCosBdwI/3jODOB1Ds7i7aiN5KhFYaUAbNDgi53j7S5Fp5xBw6vvUeNRDQXAMhbXHDH3cHIVV9M603NkKy6L2IDJ4+JEFgVBL1BpqxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHSqWN2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74E0C4CEF1;
	Sun, 24 Aug 2025 13:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756043609;
	bh=2IT1kH465tsaUGdMXje5GjUAuBK3kLPa3WAJEWaHN8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHSqWN2NAhNRjCr+C32HoM60FS4zyr3wwtznI0podpcgfSEFSUtZ6xsbpDWSJFoCK
	 r9ldbM4CSOvS/oyGMiK9vP5MKELmMDrJgFAR9X7EJidXhj679+9M9CuPSveVBaC/RZ
	 eEpdeb5gE6kUSXwgouOYJpvHs1ft+7DwjYX+q+Ela++992T68TAz8Rde3D4/2odoqv
	 DCNax1GsCkH5MTAmTXhRQnrNQKxn2+echLj/SeyVYwdhXavA+dAPB9HrJJOFiab+IC
	 elQfxkmCwWw7EZtOM8kLiXTq3tLaHiFpAzAyypWpUvSLVGdt1SpeXXjrGvbP/ypSk4
	 LkM/BqqNZnHhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] iio: imu: inv_icm42600: switch timestamp type from int64_t __aligned(8) to aligned_s64
Date: Sun, 24 Aug 2025 09:53:24 -0400
Message-ID: <20250824135327.2919985-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082314-steed-eldercare-ccf9@gregkh>
References: <2025082314-steed-eldercare-ccf9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 27e6ddf291b1c05bfcc3534e8212ed6c46447c60 ]

The vast majority of IIO drivers use aligned_s64 for the type of the
timestamp field.  It is not a bug to use int64_t and until this series
iio_push_to_buffers_with_timestamp() took and int64_t timestamp, it
is inconsistent.  This change is to remove that inconsistency and
ensure there is one obvious choice for future drivers.

Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20241215182912.481706-19-jic23@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: dfdc31e7ccf3 ("iio: imu: inv_icm42600: change invalid data error to -EBUSY")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 47720560de6e..6f44c03bbe5a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -78,7 +78,7 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 struct inv_icm42600_accel_buffer {
 	struct inv_icm42600_fifo_sensor_data accel;
 	int16_t temp;
-	int64_t timestamp __aligned(8);
+	aligned_s64 timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index d08cd6839a3a..94f712c30608 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -78,7 +78,7 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 struct inv_icm42600_gyro_buffer {
 	struct inv_icm42600_fifo_sensor_data gyro;
 	int16_t temp;
-	int64_t timestamp __aligned(8);
+	aligned_s64 timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_GYRO_3AXIS				\
-- 
2.50.1


