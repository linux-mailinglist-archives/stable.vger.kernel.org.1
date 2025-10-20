Return-Path: <stable+bounces-188115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D11EBF1768
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E5054E6B3D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C175311978;
	Mon, 20 Oct 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP/1FDr0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA862FB0BC
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965878; cv=none; b=nhQlJoO8+xUqsQBo+JNV6kSpCvutkLe2tCwxUk2e2vH5iIQQJmp7Ns84O30DGZCqV/pg6tfAZN4dmu5EdDxdxCroofR8fzDqWBBR9fSqNEWBVaWN5W15+26saXoLlP1rzuBTabyR6UdIfuryzbNbWBCSbPVBwg83S6TdQ+wOP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965878; c=relaxed/simple;
	bh=ccdNYNXodL97Du09LzUSo9/NO5Ll1AFOU1vSrteeIuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgLOfbEDq+CKMR2Uo+uCeRi7ZH/XL8a0iWHNtwzmQHBQfO0HySNA2eFnTQZcr4aMpLWbjUjNJaBC0f9QRT2Gq33KN9XQvgVEkXHhTafj/WT8R7wYS0a+IH+ustwx2wAlqQ3e0idymv6SNcD5YdF2ocj1SdRVW7J2EBXn3U9AQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP/1FDr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A7EC4CEF9;
	Mon, 20 Oct 2025 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965877;
	bh=ccdNYNXodL97Du09LzUSo9/NO5Ll1AFOU1vSrteeIuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZP/1FDr0g0xKi6nL2gASZ+aGIHZy5jPKk8xGuW9yl/OHwXBSj11BTTcN3p/qmMJWg
	 nKTdOEucezSzSepINCGEIArs5UoJd9xYQr/VG2p5Z+R1sYJVjxFeWM+gJnKDK8t8/x
	 dOzeiS7pYfTID9sKIC4NV1Or2KMVtfyx1Hul9+iEErwbVarZretscxUIg3QB592BPr
	 8Qa97PfdDYssyYKc7J20uaCgk9H7uiZHJjZAUtcbQddgrrO55DqUZQSADT+YfU14fl
	 MOZFjDIUn4VH+i6cXY2CMGSnnxmopoyJU877oLHh9VDcwAfLjCZws3fp3EJtIFZjWK
	 UKrsw9S7czrIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] iio: imu: inv_icm42600: use = { } instead of memset()
Date: Mon, 20 Oct 2025 09:11:13 -0400
Message-ID: <20251020131114.1768095-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101624-legacy-gab-3e94@gregkh>
References: <2025101624-legacy-gab-3e94@gregkh>
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
Stable-dep-of: 466f7a2fef2a ("iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 5 ++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index cef76c1c40f36..134f3aa591456 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -751,7 +751,8 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_accel_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_accel_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -770,8 +771,6 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
 							 st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 608d07115a36e..d20209302711c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -762,7 +762,8 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_gyro_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_gyro_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -781,8 +782,6 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
 							 st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
-- 
2.51.0


