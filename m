Return-Path: <stable+bounces-164627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3719B10E7E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A2C17DD1E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB082E9EA7;
	Thu, 24 Jul 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzSrGuPE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6E2D5423
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370366; cv=none; b=qMpv/b1TNuYX1S8ez1xArW1wINILL8KdTqTWcoG4Qd2icj5cikKsPH5wTphrCjas7kLwf44MnNK+PX9NsG4SagF8W8nXy/F1rYCurEYeGF+XGBp4kggei7Y7zzhyRZlqSl8F4RatfIAiTqVvcfpWwLrNoutNeflh/G+doyuOT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370366; c=relaxed/simple;
	bh=AADdCl40B37wDfclhQh6Rt+yiUaVSUOkBQxheJ3jQZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhW3/zAIYZesuPP1LHA7UMmeYvisXOd/fjZsFGbOEof4Gl6gVmz9jhFVFC4hdu3x+RTc+nAQREOuZOKslIL1FR97ImUxfc0oJsIAfkaXtNAgpWLm1pItMXV9EniQynL7Bfxr4kc/NaeZHZzZqsIQ2behBcyBIy1WKTrrl2KsEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzSrGuPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11362C4CEED;
	Thu, 24 Jul 2025 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370366;
	bh=AADdCl40B37wDfclhQh6Rt+yiUaVSUOkBQxheJ3jQZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzSrGuPE6doNQP4lM2XwE3RNl147zvB+5y7wYiJQKbLZ//tipCU2UyVndr/5EdZQQ
	 VHZSerXPAro+vkjmmng7b9TGKPntVsOE6iJ88NFrFe6Pls/SWE3gAjREESciGymVEd
	 mk3+Bu7a9XSappy3x+dGC5YA9VhTUYeADugWIa+grWucDvm1WIvSxpPnJ+AgDcwAZ3
	 kwFpd47IQRQ1bRqzSmjJAsnlB2l631yykljjyr5X7JbuB2TaN30xW0e59UTQqSUpiB
	 919INgiv/K/JD5OEuVo/BgJwjZHYFUcgqCTAbXtL+IePQtmXgXjHnpqJWsLvLBDUDh
	 8zVQCiAvyrEhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: hid-sensor-prox: Fix incorrect OFFSET calculation
Date: Thu, 24 Jul 2025 11:19:22 -0400
Message-Id: <20250724151922.1365648-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051216-fantasy-preschool-858d@gregkh>
References: <2025051216-fantasy-preschool-858d@gregkh>
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
index 26c481d2998c1..ba8e898969df7 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -102,8 +102,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
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


