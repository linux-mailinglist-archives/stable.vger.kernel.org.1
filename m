Return-Path: <stable+bounces-174272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE8CB3627F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4D18A1A3A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A126158C;
	Tue, 26 Aug 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CdojZWuD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795E22AE5D;
	Tue, 26 Aug 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213949; cv=none; b=jdtNlJU9J8ImAxe8QfdE81g3l/Bf2wUPvGR1onIdsX0cen5WHTRWdcUcbJJqHAKybdeZAvmZKrYtV0ZmsI74pnakKv61ql/8T/cGA5XRuAnyJEPg0GlgFcxs46U1/z1s1+979sqGIurmfU7ZP/jWd49uaWFRyzCqJD1yZnBm/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213949; c=relaxed/simple;
	bh=sd1HSxeivHce7wp92uxyG7RNHxcAFaPao6D39NIpWWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9tl23U4BEWk1TCyIaTadbF8gN1pFTLPDRun2MJBLjC43RFzZ55VBnCBHfKCb3tqIbhV82vHu+hVFgUobJmE9NYZbhh6gHLD7idojF+ja9TWmZqA9M0IfLNF+bs9objt+u9H72HqkblV6BIx4j3sbAtWoSdD69BODh+1YrDtV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CdojZWuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B069FC4CEF4;
	Tue, 26 Aug 2025 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213949;
	bh=sd1HSxeivHce7wp92uxyG7RNHxcAFaPao6D39NIpWWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CdojZWuDd38RdLa1mytkc03be9cnMfXgBAX2K36+5KJR+hBwmTJnFC3zFufPHSohC
	 2+lfkeJk7yBOL58g9WsAkNYjqAMyyLd+3QypXNgu/TKq0GGScjvlKD9o7+u+xCFIN/
	 hkVExWX2s5TkoBVlAJJlxISyRZu7pyBtcSY43npU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 540/587] iio: imu: inv_icm42600: switch timestamp type from int64_t __aligned(8) to aligned_s64
Date: Tue, 26 Aug 2025 13:11:29 +0200
Message-ID: <20250826111006.752579628@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -78,7 +78,7 @@ static const struct iio_chan_spec inv_ic
 struct inv_icm42600_accel_buffer {
 	struct inv_icm42600_fifo_sensor_data accel;
 	int16_t temp;
-	int64_t timestamp __aligned(8);
+	aligned_s64 timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -78,7 +78,7 @@ static const struct iio_chan_spec inv_ic
 struct inv_icm42600_gyro_buffer {
 	struct inv_icm42600_fifo_sensor_data gyro;
 	int16_t temp;
-	int64_t timestamp __aligned(8);
+	aligned_s64 timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_GYRO_3AXIS				\



