Return-Path: <stable+bounces-172731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D69DDB3302B
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931AA2046BD
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793C258CF0;
	Sun, 24 Aug 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRARoYyH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974492D7BF
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756042746; cv=none; b=AmM6+KCkjPoxJoYjflWm9Z9JPFpS+wpr+IR+vmqR0ZHJF9Gb8jXDdvQPU6TJdq4exAchQCyoLMy3+t8eg4jNGjNCAckrc71B0UEZLhrgujsv6VmWX0pSVYnVKA3TMhZZTGWWt/3h7D5Br72I4Cb5Wb3X2NQuJWR/iEw8EHlaJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756042746; c=relaxed/simple;
	bh=2l9QnAJ4OzIXCZNfvI49tPnjdDJ2zHDCAj//TmvlFp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUYW3YWDW+lSFgnVFnScv50DVpgEVLsrsO/cBvisFUbxpD+L6f7JuHVMHne2dIrHzK38ggte41Jv+o5zt6YkUEv2rvrzbxAvzReTplD+Q6Pv8ybi5/R03rgntl7izatMiO6ZtX/EaLnIyQX4XRxtHDpBBDNWqsvthzXa7Lm0898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRARoYyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862DAC4CEEB;
	Sun, 24 Aug 2025 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756042746;
	bh=2l9QnAJ4OzIXCZNfvI49tPnjdDJ2zHDCAj//TmvlFp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRARoYyHbq4nVYjWv04Tj6tkzVzM7U0tiC57hEMrXo+sZikpwkvXhfCOfk+PMykAy
	 iD5V2kN/ZQ4mjwQgoMTKahxyWX6r/jHmHIKHxp8SWJtHQLppTRRmFLc7GvnfBUwp2C
	 WKj75ftmii8DUlUC8PVqmnXXZ+dW5AAIykL3e9nO2RHBwSWML71PzoTLK3EocKJijT
	 LhI1VzmSaUbWV32Gf9BhfSJFvAJ6HYV9BHzB8u0zq5eUGYQ5Y2pfEdBRIBCtMvTZcg
	 SOEU6biGK6vjUlRkaJnSwup/kwQQdgTyT6lMo/UbLprGpcQEdDaCWWz5HPG5SqncsV
	 +yNl+ox8VRWSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] iio: imu: inv_icm42600: switch timestamp type from int64_t __aligned(8) to aligned_s64
Date: Sun, 24 Aug 2025 09:39:00 -0400
Message-ID: <20250824133904.2896884-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082313-lubricant-traction-2a78@gregkh>
References: <2025082313-lubricant-traction-2a78@gregkh>
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
index 7968aa27f9fd..388520ec60b5 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -178,7 +178,7 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 struct inv_icm42600_accel_buffer {
 	struct inv_icm42600_fifo_sensor_data accel;
 	int16_t temp;
-	int64_t timestamp __aligned(8);
+	aligned_s64 timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index c6bb68bf5e14..591ed78a55bb 100644
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


