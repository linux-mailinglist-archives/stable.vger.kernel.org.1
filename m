Return-Path: <stable+bounces-172750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B7B33072
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 16:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFF9188DAEA
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C902D7387;
	Sun, 24 Aug 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU931ZQc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE122B8BE
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756046679; cv=none; b=oFvos4A+RRcaAmLlhA9mSkRr9y8mqquU3lPhi8J1Rlm7cfS2J+AS9ZQh6PlRozJcT8v8/IiqHcel5xOdznvajvn3EdI2hcGTP7oIE7BXu7Hi8ZGVQKmIK8xjQ+RW78kx0Qz/jZhf5sgbJg+iSOTYkoG0Iq9ODEgBbi78YiOSHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756046679; c=relaxed/simple;
	bh=xr8yoJnCqK8XTgilfNmdiGE8Gn6IGFLEQ4OQw/l6TG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rG2bIjy1sXKBMnuz66I9Zey751TNMF63/gMepsb/NSGMd8kRZwFyWCF6zI+oanatuQAPR0yiTQAK6XsdXalLWC7GA8xgiDzaWOoHqGPuFIQJ0SkdsNW+KcQThyzwmX4iaQ4NVUj0S0ReYJhYCiRSn3aM4GuvHANibHFpHBmFWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU931ZQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E304C4CEEB;
	Sun, 24 Aug 2025 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756046679;
	bh=xr8yoJnCqK8XTgilfNmdiGE8Gn6IGFLEQ4OQw/l6TG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YU931ZQcuP+6xfJZF3C5cmlZLy/Qy/2T8+w8OhkP16Hcw/emOa+uv/sh+ETB4Pnwf
	 gIUlPLZspN08KxlumA+LSt6SOe6STe2OeIi9hOcnCHXj1XJU3jwfYR0mKIjaX1ajxO
	 AHbuBEtPKQQ+olx7jDn0vkLB+ERlOp1HBYpBz8TjY5QFmx5RcvTGYLJHdDmfdS88lr
	 P5CDE3kM5Wdk9z8pTPMSZ+ptp3My4nO4CwoweSxFinTkbxakx9lAYfTYhhI9NR4faB
	 Ec0Nuogel6wF3at35DAh0BrKxSVdP++KTsVwtcJ7AeD++G3een5uOsC11Mq2iW64GT
	 nN/vpalHOS0tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: imu: inv_icm42600: change invalid data error to -EBUSY
Date: Sun, 24 Aug 2025 10:44:36 -0400
Message-ID: <20250824144436.3167804-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082314-whoops-dandy-d7b1@gregkh>
References: <2025082314-whoops-dandy-d7b1@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 91f0f381082b..8926b48d7661 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -32,8 +32,12 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, int16_t *temp)
 		goto exit;
 
 	*temp = (int16_t)be16_to_cpup(raw);
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


