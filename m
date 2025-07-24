Return-Path: <stable+bounces-164641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C05CB10FA4
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C3F3BF3C5
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849AF2EB5C5;
	Thu, 24 Jul 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi8e3o6u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647C28B4FE
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374431; cv=none; b=PRsYnonCbPWQjGXvdVpHmSq8Mh+e2CVogzMzXDVXndZvfXcukLOkhiNGZLWGx01mFu4ZWVvzhce8SLxUrbo4dAbpB7G1GfrlqeZhOOiCiFkdfZzuwaVzp+XCPxCKU0AHV/x2JKMjmkkJF1bia4qxSUTFwqAG7KE5wco3NYYtEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374431; c=relaxed/simple;
	bh=D1+hUKx5IDaq33FclriZfIM6K/rUq5bCY/BhHYrTlR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADCSQdyligOvkhEmkmID02bkAh52DLCR0A3nYpI9XTCjFCpGWCCwtJ8RlvDpkVr9oIXp/hUSG+E0GDUaWUfmKLOMzXy8MBCNYYG2IviaFJeC3euRPsxWVDdBjmBd+2BcIebHTG4xMLCNpdbUOLDc6yPmVJpdY+z3T6SL987Wf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi8e3o6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1457C4CEED;
	Thu, 24 Jul 2025 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753374430;
	bh=D1+hUKx5IDaq33FclriZfIM6K/rUq5bCY/BhHYrTlR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yi8e3o6u1TMUUpbFtnrkQfWemP9aZKWSdSicxUfNgF+pHjBFusVGEIiuS00dUiaZ7
	 /Ez4l4skl+e07V54pwLiUEjLljoEV4h0zIKSAqq9epe8Q0dI8B0cE+ZvdtnEmh/kPV
	 N/F5b4YQ/5JStAp3gJEP1uf7PeGKjECEz8C3bQ46Iv99/BXL7/GVJa0ZQM1jIoib7G
	 pehBVnsga/aqtmZwzBnIYMJtek9g04lceYRPhqr40CnRsf4eEdqZqJqn+FB16jDvLk
	 Cjs/3VSEcpBcWPdi+/TynG11roAGwsN8oTFnkJwuOiHbWAHRKXioTYzBBa9aTE/UVT
	 f8G3bn5SmZrgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: hid-sensor-prox: Fix incorrect OFFSET calculation
Date: Thu, 24 Jul 2025 12:27:07 -0400
Message-Id: <20250724162707.1368528-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051217-celestial-untimed-062b@gregkh>
References: <2025051217-celestial-untimed-062b@gregkh>
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
index f10fa2abfe725..ffd4ffbcd996e 100644
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


