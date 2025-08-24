Return-Path: <stable+bounces-172734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84BBB3302E
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046A84425F5
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C002DC331;
	Sun, 24 Aug 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru889kl2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A092D7382
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756042748; cv=none; b=GuIX1O/P1amSVZAsksc06FI9PztcXOYajD+qq8jBVIrZT0FVdQXXn8xGYIlmYB+h3+m8ZMITIbWFP2q+4eR6b6zi4wJiJgF98gH0kr8uZZtdFqE/utStaOZsS9jCUEUPNRDnoSUgrbuSRjSH6jcMl6ECZJgKeOWIYOfEEiPueTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756042748; c=relaxed/simple;
	bh=AYCF9hYuhTNArkH9mNIM9cWddP+AHvjq10FP/H7HAlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OumK3py5gb47rgbtpOUEjSMQO+1fL/89gn3GeOMwirILnXIFAPBcXEgCs9i25jfUUNZBTfROkfHXIn5tcU96O4PkPa7HXFQkHfrXg7akjk7NuSfixAgKWxUzCNtomU8F1lc3qxd3JZVyjnqJYpVLTJk/ii5TlqV/kdPH4SPfBss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru889kl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F212AC116C6;
	Sun, 24 Aug 2025 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756042748;
	bh=AYCF9hYuhTNArkH9mNIM9cWddP+AHvjq10FP/H7HAlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ru889kl2PoOFhaKvhjAc+otQtdLz16VZA6XxyTvoNOkz2a76CJpqex6Oe87i7D3iG
	 Q3mwGBBzNnxBS2m4HDgZgJhCq2+OVayHG11BkT9sAPtN5WjO+cwPvZeCDHsUd3J7oc
	 x9a0VIq34p4Kj0Uzrufc9vBnMEXCF63UXM5ZKjh+bS6cGfpPsECwhIzBmSVke+vkw5
	 ZNUOVq0kxIjMb8g/vVFvZQGX+yWsxzV2YttBYuH+9yVA2ZG793twafMCI6I258hrJI
	 +2tpYl+Nv2mmukc0UFekusIU05WCrO6hfaSRgS9ooSL1jZH8aHRAVVjkj6ndIf4vtb
	 VRMpThXUgN5QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] iio: imu: inv_icm42600: change invalid data error to -EBUSY
Date: Sun, 24 Aug 2025 09:39:03 -0400
Message-ID: <20250824133904.2896884-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824133904.2896884-1-sashal@kernel.org>
References: <2025082313-lubricant-traction-2a78@gregkh>
 <20250824133904.2896884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit dfdc31e7ccf3ac1d5ec01d5120c71e14745e3dd8 ]

Temperature sensor returns the temperature of the mechanical parts
of the chip. If both accel and gyro are off, the temperature sensor is
also automatically turned off and returns invalid data.

In this case, returning -EBUSY error code is better then -EINVAL and
indicates userspace that it needs to retry reading temperature in
another context.

Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor support")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250808-inv-icm42600-change-temperature-error-code-v1-1-986fbf63b77d@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 295f220eab04..51430b4f5e51 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -32,8 +32,12 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
 		goto exit;
 
 	*temp = (s16)be16_to_cpup(raw);
+	/*
+	 * Temperature data is invalid if both accel and gyro are off.
+	 * Return -EBUSY in this case.
+	 */
 	if (*temp == INV_ICM42600_DATA_INVALID)
-		ret = -EINVAL;
+		ret = -EBUSY;
 
 exit:
 	mutex_unlock(&st->lock);
-- 
2.50.1


