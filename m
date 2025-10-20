Return-Path: <stable+bounces-188113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C29BF1762
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2895B188E590
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4DC3002D8;
	Mon, 20 Oct 2025 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJdggzZh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F12FB0BC
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965834; cv=none; b=E8tdOYuz1IWNSNYhJbRolUeVy6GLkc4txG6ufWq50t9/4FKd28HvQPGLAibwFEF22PCxk0YGJpphmrygMO4+haCLm7uMjM5bSTy96JqjJ8corpt5PoaZIb0S1nXCjLO/CMnhuF7ktt/r/2O1dpy8U1x2tFWTXT1rvOXIZ4K41TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965834; c=relaxed/simple;
	bh=Stt364JCrWvVqY/nwb0iM4n7Dgn7z4fZw2DxnDQ+URY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1/36amFo+rLExea5y92btG9XDbnfvoGoX36O4vMVPMKTADsGyne6g3b5ZuXpJn5BCnkvBgoyO42+IN+UNun+Wx9YJ9Ev+KSHsQYFZCKa4+LnDlkxYwIFJVFCp51z5mfYaTykwa8JqunAp2FtbTGXFR0RFUExIDapf/jeBlg814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJdggzZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EABCC4CEF9;
	Mon, 20 Oct 2025 13:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965833;
	bh=Stt364JCrWvVqY/nwb0iM4n7Dgn7z4fZw2DxnDQ+URY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJdggzZh3mOsYlsIJMezdF73avWCzPrq2Ny4hXqsFv7woSiURqvx6Uush2Jj0sHJ1
	 54Y0y/KXHEetgrgW2iR2Nc5C12fI8Oh27p+8izik1/fHAK3UNuEA1rPd4eTY6MsneL
	 sn/yZENlodQ90gGkt/gCSM0bXWZaWWmC3sA04margc36YRU9fTnSltFOg5m360G3tO
	 BHLB0+aoh6HgvkXvSLVtlypKvYqlo7Uthz274JuQkrbrHGC+xKO+xxjlSzCIKF5G7o
	 AVfBrygYJil5W4yWtgfm5Td9tKUdkzQdBCKc0vzxKhdzHPTf+WCcN28CIx90ggESK3
	 RGg+QK+dYD+WQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] iio: imu: inv_icm42600: use = { } instead of memset()
Date: Mon, 20 Oct 2025 09:10:29 -0400
Message-ID: <20251020131030.1767726-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101624-blazing-sharpener-111d@gregkh>
References: <2025101624-blazing-sharpener-111d@gregkh>
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
index a394b667a3e56..4888a4c011c6a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -749,7 +749,8 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_accel_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_accel_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -768,8 +769,6 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
 							 st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 22b7ccfa7f4f7..c67cc20223b8b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -761,7 +761,8 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_gyro_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_gyro_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -780,8 +781,6 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
 							 st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
-- 
2.51.0


