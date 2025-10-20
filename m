Return-Path: <stable+bounces-188109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68987BF173B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261981888788
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC631326D;
	Mon, 20 Oct 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfl/F4yv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDF3164A1
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965745; cv=none; b=KVegJohSobOCYwkOS6C3dCtnYboVaZK+AS7e6W6ykJ9tTiXfa7AmsF1kBrtH1MYIFHo47yU9WqcxGkfWOXvU9h9QfSvAGM4uJOMsUmXJxnl3IW0YPHjY5F8QM04d/bXybEjERqIyDhBsOU/NES3uEIVJWX4sE/lSq2jAF/oij4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965745; c=relaxed/simple;
	bh=yAxGoG7ls27H8QOJW0tckqk88BcmdmzKR12ZM/98NnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJsUunaPPi+CNNssUv2IHaDlRZHAMSeFV8A1BnnZ85P4T/ZOVTWiK/dwvXWTuI20dmuTf4vq3dwbCkyjpbRFtB68C4o51CHqyeGYUvzts0Abf5y9j/UXXrrxFKXi5cmuqi6pZDJ04DWEJe+STyr+YWuh3g/KQ7mCeYC6U5bXf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfl/F4yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0201FC4CEF9;
	Mon, 20 Oct 2025 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965744;
	bh=yAxGoG7ls27H8QOJW0tckqk88BcmdmzKR12ZM/98NnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gfl/F4yvEfivlGn9K5zB26WJu+kkNFEBGN4VprvdsjryAXXUfql8niTbzrZAI6MUG
	 HvjY+KroejwRF83JajD9mAARh8HxiAv7jHH57uzcY1LXXDKLwzYSuPSo+2VG3expJY
	 sK2Lq31wmDBpVMp4et4kmnvB4km41fCH+jfX6y9y+K0bCRtJPnRCm1G3RNz9JAi7cV
	 mwBANeO3X4RFMQDxHkxtQHLQk/gUnO6x/4Pj1nogM8Eun6OTpWzHC2YewdkN06vuKk
	 R2DVNbUiEvHGbE2Wen0VtDlY5a+0iiIDByOBlQJMKHdOkZfGWGvGp9n6xXgwfYkZzi
	 4kSNMHecQepBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] iio: imu: inv_icm42600: reorganize DMA aligned buffers in structure
Date: Mon, 20 Oct 2025 09:08:59 -0400
Message-ID: <20251020130900.1766996-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101623-dry-crummiest-15b3@gregkh>
References: <2025101623-dry-crummiest-15b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit 0c122c280e78150b0c666fb69db0000cdd1d7e0a ]

Move all DMA aligned buffers together at the end of the structure.

1. Timestamp anynomous structure is not used with DMA so it doesn't
belong after __aligned(IIO_DMA_MINALIGN).
2. struct inv_icm42600_fifo contains it's own __aligned(IIO_DMA_MINALIGN)
within it at the end so it should not be after __aligned(IIO_DMA_MINALIGN)
in the outer struct either.
3. Normally 1 would have been considered a bug, but because of the extra
alignment from 2, it actually was OK, but we shouldn't be relying on such
quirks.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20250630-losd-3-inv-icm42600-add-wom-support-v6-1-5bb0c84800d9@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 466f7a2fef2a ("iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 809734e566e33..e289afcb43e3c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -126,9 +126,9 @@ struct inv_icm42600_suspended {
  *  @suspended:		suspended sensors configuration.
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
- *  @buffer:		data transfer buffer aligned for DMA.
- *  @fifo:		FIFO management structure.
  *  @timestamp:		interrupt timestamps.
+ *  @fifo:		FIFO management structure.
+ *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -142,12 +142,12 @@ struct inv_icm42600_state {
 	struct inv_icm42600_suspended suspended;
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
-	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
-	struct inv_icm42600_fifo fifo;
 	struct {
 		s64 gyro;
 		s64 accel;
 	} timestamp;
+	struct inv_icm42600_fifo fifo;
+	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
-- 
2.51.0


