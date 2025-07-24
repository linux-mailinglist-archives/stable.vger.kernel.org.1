Return-Path: <stable+bounces-164644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BEAB10FCF
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11091D013E9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229C91E9B22;
	Thu, 24 Jul 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9SUFpXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FC34CF5
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375181; cv=none; b=P0ZYNCvT68SVrv61B4thNFLKqTQxPfWaauROvlu+k6oLKfkgTay7ohbCHerCR6EKuYCNsM8zjKcP+kL+XyHAyCeH1ETSAbP4MgaaMNt5iE6oVJ2EtNcxvlFXqzU77VUblwUcktqDmRan9qpeY9F9HFyghLT2M59u0UpT2nUTNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375181; c=relaxed/simple;
	bh=L6UA8W/KXNFMkZbDiAhYpJEOBR/AuJEXHQhs0AKl6Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aIm1/L36jmY2UjlUIknW4o/ZWPOHzp77VwvBri3Gqf1/tPJFN/iR/VexONBJ1nUrpdb5SneI3tYGhHQ1QnMATWeEg43QEnoBIRgptq+12Tt9r1K8Agx0Nf6fUjBwqEMmrlIviq+n/S1oua4HKojE5SaoD2gtC94/gkHlLmKRdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9SUFpXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67538C4CEED;
	Thu, 24 Jul 2025 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753375181;
	bh=L6UA8W/KXNFMkZbDiAhYpJEOBR/AuJEXHQhs0AKl6Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9SUFpXmWsgbc/K/gs3WIDuD+Os2hA6SEqJwZ2F6MY23todtnr+BwRGi0h2aUk2MJ
	 0KNUj0pjRLLVpl6cDZASDzYkgjxkGaXcrGCgSwwYef14PdvbNsRF/+seU1D6AmZg/i
	 NMUyEPRG4zNA3SnkA/hI//5C7cxrVElLWgSK+cNiNvql0OfIi5tC4wG+ivEuC5OVMZ
	 niroCnkXc/wWwa3elusU38vkvKwJPqA+p08mmyZfHBxmpBn2yQwbEiyudiXjFt3fXF
	 FUgeGM5tnVeY3+8rkGgoguc4Aq5faGVmSPGw8RcuKoKUh4S0/I577Z29MshlTmaDnU
	 c/Z4sx8QoMpAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: hid-sensor-prox: Fix incorrect OFFSET calculation
Date: Thu, 24 Jul 2025 12:39:37 -0400
Message-Id: <20250724163937.1390174-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051218-levitator-october-5d50@gregkh>
References: <2025051218-levitator-october-5d50@gregkh>
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
index e9e00ce0c6d4d..9109e5d2de36b 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -101,8 +101,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
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


