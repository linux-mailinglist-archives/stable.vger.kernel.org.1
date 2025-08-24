Return-Path: <stable+bounces-172723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD2B32FFC
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7E1446A0B
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D726AABE;
	Sun, 24 Aug 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVL39leC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90E63CF
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756040501; cv=none; b=KV/Fmh7BtjSxBTtUCDAppVW+ecXl6UFNP/bOiyVOWy25PGIgPy9XHJCB+JHIXL+tnVQvHBu/nV/kxOEnc4frv6NPkCsuCdyquz1njs1wij78ta2oWjvquG5VaAATq2y9pb9EVlwv4WCbfc1vqizasj1MlVRwdS4i6uPO1KFZOxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756040501; c=relaxed/simple;
	bh=BnzCzz/2KuguXT6QZmJrU3iqEp/nirNUTArB+I2EhDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYUBUMH5xd2EY/rHEtg27DSUTuW5FfrI2F4qjn8sRPF0fc2+XXnqwxsWEMTql3yDvBN6Qox3sQJ/H/L+nhQNPwHXTJKl/rMC/oBdCL8xP5/zzGQ6vqBJNkh/uLsq6hcXAbS1mqbErOu9/3hrdHOGqpr4etuH89bdaWsWdgZtPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVL39leC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2200C4CEEB;
	Sun, 24 Aug 2025 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756040500;
	bh=BnzCzz/2KuguXT6QZmJrU3iqEp/nirNUTArB+I2EhDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVL39leCR2JrGD/UyWqN3vdib80iBwtomR7e5786hPTPmCCe9oSVLrXcFoW1lRvSm
	 gytS5pArRlDOgKI3SQulB3yR99c76atrEfspkL/NDdQk0ZhgHE7ImCgAX2hK+q2STq
	 DwowiJLRULnlh27a5iFCJ+XSib0FT0cMJPvW4u8N0TK7Zi7Y8MDIPJihwh0Ui/YRRJ
	 vQ2LfZK+xXRUZ/VbB/qT9ysfKb8AYWxRmI2vTgMx8NQUGNdPjkEEQ/HAT36L1CedrL
	 2VN8Q3rErj6ULKbOxifK8totBWpKI3c0DCJLFLd2xGH3gWdncWxWCLqN9nIteJQGGD
	 MecNQq310p7Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 3/3] iio: imu: inv_icm42600: change invalid data error to -EBUSY
Date: Sun, 24 Aug 2025 09:01:36 -0400
Message-ID: <20250824130136.2747952-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824130136.2747952-1-sashal@kernel.org>
References: <2025082313-case-filtrate-5d55@gregkh>
 <20250824130136.2747952-1-sashal@kernel.org>
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
index 8b15afca498c..271a4788604a 100644
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


