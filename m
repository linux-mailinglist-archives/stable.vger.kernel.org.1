Return-Path: <stable+bounces-164643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC7B10FB1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB3F16B139
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DD32ECD1A;
	Thu, 24 Jul 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3vToVin"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2C2ECD0A
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374810; cv=none; b=iohLoH8cPa2qez5qzCVkJpUinBlE7Yu8VhRic65hC5/gL9mhnIiURC04w+KqRih+MrSOOI0CdKCA+2Z2MvM0q99XIRiFRFOFQ/gn4gHmrcsqhYDlfzWlwvw6tPGypm7s26xYIIZTmybbgFMn3A3NGf+N8i6qRc+VlmXP8Z8OhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374810; c=relaxed/simple;
	bh=iAT/3dT+1kVkkEkZxoVlDXj+4CkJYn6hn7qjY31vGRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uNUxmTAPVlRsNgt5/v3uT28S8Su00xrSt+j4tOfzO8h8ktzkyoaZb16GqvI8QB6850OqQ0sUF0Z1n57RvaPMo3ZAF2Fi1yP6j4Hkk2NbHfK29ycazRPjoakOUCfPBvALku4eOS9Oi4Q0Wa2YaiyXcrsIxcIwjBiClqeuL2LNv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3vToVin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1F3C4CEF6;
	Thu, 24 Jul 2025 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753374810;
	bh=iAT/3dT+1kVkkEkZxoVlDXj+4CkJYn6hn7qjY31vGRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3vToVin18XeKEFzZugQgV2wP6UGcn/juLo+fKsrPPcMA03HanrEhZ84Eduxfsmdv
	 a3IbBTT2ejlP1+ZmtkZJlB0hXR6DTq48IkDf+NyJZbBkFnfRYqFcQ8UBXN2yppr5pS
	 hbQ5J9/Bq2SwDxGikVh/9bRq0UrI/acUrj9HsRrK+/ZakbLaUpXY2row8ptd7v3eM8
	 qw1Cu0md270mqM9ciVpcRMXumNpJGsl20F6z5d9upcuw/tyZg88nRcjNmRwZ8hZShy
	 LfWGUrQ/y8cKVb+bqbj3OQpdIqwFt+I2yrqFG6Pa+I5KinHaP7Cz4pY3g2Ahi/1ABS
	 4isTDJKoDXwYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] iio: hid-sensor-prox: Fix incorrect OFFSET calculation
Date: Thu, 24 Jul 2025 12:33:27 -0400
Message-Id: <20250724163327.1369882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051218-opponent-tarmac-061d@gregkh>
References: <2025051218-opponent-tarmac-061d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit 79dabbd505210e41c88060806c92c052496dd61c ]

The OFFSET calculation in the prox_read_raw() was incorrectly using the
unit exponent, which is intended for SCALE calculations.

Remove the incorrect OFFSET calculation and set it to a fixed value of 0.

Cc: stable@vger.kernel.org
Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20250331055022.1149736-4-lixu.zhang@intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ adapted prox_attr array access to single structure member access ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/hid-sensor-prox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 70da928e0d168..9c6c71218cf21 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -103,8 +103,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = prox_state->scale_precision;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-				prox_state->prox_attr.unit_expo);
+		*val = 0;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-- 
2.39.5


