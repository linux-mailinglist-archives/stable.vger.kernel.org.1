Return-Path: <stable+bounces-172741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C0CB3303A
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCDE1B28011
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584B2D94BC;
	Sun, 24 Aug 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puKXwUMj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB71E4A4
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043610; cv=none; b=K5UO3ZJbof2n/vv1xbhmusmPFbqtW8oasm3Bcx8qnpSxNH65Wp49Whe8Mvl2yC02yaxezyoJBnoQzyZ4GfhsKHSm/uI8uw6Ph7SA6uAKpzqOzDOswyUkTeR72zoQeDsqZ/dhL0Vp9woyEXWb3HNRAGwF97sJFQ0Zx45DcCYuWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043610; c=relaxed/simple;
	bh=1XTq3+GNH+G3rGIpl4lGvSo3aFaFnrhLPRjcmUVX21g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vv9Vuk78OanLtLeyUCMxTp3Y40b7Oz+qfVo88jrBXi5ot7scQ+6QX1JoVKLn78TAsHRUZ4/3nRMMMHqQ07/YKeQrC3XJiwhNqqey2TP2Q3X3IReyFFULiZesmnXpK6CgRPZV5Pz38mAvfJH48FtobjEWc8pJfCFDEIayPbEo8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puKXwUMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88780C4CEEB;
	Sun, 24 Aug 2025 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756043610;
	bh=1XTq3+GNH+G3rGIpl4lGvSo3aFaFnrhLPRjcmUVX21g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puKXwUMj11b9aPEazcWDvyZz9AkGyiKhLZWR6G+pAuJxMFHMxWXlmJjblUkc0YydQ
	 q0q9dT+q/IAX0QflbHSIYvRvfm3IdlMzcSxdFaxuJEGfmHoaZz6SLtC9WqsUUSWgC8
	 O5mFI60NeidNJGLlfO0yNbeHtFlNydeu1lhWN3fh8M9DbCjmfa22AatbzRjYbAK1h/
	 6JodFH8zZpzRzf7+Y4NeFxwQ/V5e1LebI6b2xt0eQ/1T+VwxgRUUrM9hamqMPtfsKu
	 eAKGyD73U6FbHNloxW4d5Lp/fIkO6iA8d5XwZNKRi1oAkpJEUQYE9l/Kd2/bNo9/Qx
	 tJyN/yNBGNiTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] iio: imu: inv_icm42600: use = { } instead of memset()
Date: Sun, 24 Aug 2025 09:53:25 -0400
Message-ID: <20250824135327.2919985-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824135327.2919985-1-sashal@kernel.org>
References: <2025082314-steed-eldercare-ccf9@gregkh>
 <20250824135327.2919985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 352112e2d9aab6a156c2803ae14eb89a9fd93b7d ]

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20250611-iio-zero-init-stack-with-instead-of-memset-v1-16-ebb2d0a24302@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: dfdc31e7ccf3 ("iio: imu: inv_icm42600: change invalid data error to -EBUSY")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 5 ++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 6f44c03bbe5a..5b6b6cb996f7 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -755,7 +755,8 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_accel_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_accel_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -774,8 +775,6 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
 							st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 94f712c30608..3e9bfa73a4f3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -767,7 +767,8 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_gyro_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_gyro_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -786,8 +787,6 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
 							st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
-- 
2.50.1


