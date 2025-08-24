Return-Path: <stable+bounces-172751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876A7B3312D
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 17:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EBA172D56
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89489269811;
	Sun, 24 Aug 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8EzpwKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B323C8D5
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756049127; cv=none; b=CPmwUIEUdn9BVRogYilPRn/qkR2c2mIF26+nAOsHhEuLldET6cJgaBl3Bf4TVOO36Ad4ImnaoSo2Wq/yZ3gmIWkoGNNBKGJGDM6SGm4NTEABpv+GEy9VuQEZNcRpYKEyFp0Eh27xqG6keKEBfyyUxIARfIHQNtSKqtHBYS9msFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756049127; c=relaxed/simple;
	bh=xr8yoJnCqK8XTgilfNmdiGE8Gn6IGFLEQ4OQw/l6TG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9UUOMZkD2QCzJvq2+2B2WV7WSH+KB52wGhfB7QXXuKjICj0oom1mKWQaERQFi5FppExxKtVKuzhoIAFSTxblirHgKnGq7XqWSjLKB0anI+0FITdu8XqYXKOHlt2kStl2ofj5io3YhPTGdlDQpdU42EP/12Md+T+ks/zuHJkIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8EzpwKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15193C4CEEB;
	Sun, 24 Aug 2025 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756049126;
	bh=xr8yoJnCqK8XTgilfNmdiGE8Gn6IGFLEQ4OQw/l6TG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8EzpwKUsNyNxPBF8YCNW0XUJt2V1RYIiUMa4wAcHSEWNhr9NKqrQCePjM8msk5pu
	 vlPRtiONDh6etybmkSZYccFNN5xufPcvU0fDNqMapcZ1c3aYeExlwUGSs29Uyy4wrA
	 AvJFXxIrcEAVNw9jN30Hb8KarsbCIRAiS/5ilRieobD790svCLwkxXbKUZ9D5NRdAZ
	 REv4ksDGnI83TcmOu/eSS0nZ7vqQiyHf5yvav8yZMKc/OCHYYKoJm+AJfq/vKrRNCH
	 reA8F14T8N06QxmwVqs7K4rc7x+Pm9swXxEu1olAkx0Ojtvk/4LeNocsE/9btjzXeV
	 aipZ0nGgvb9Sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: imu: inv_icm42600: change invalid data error to -EBUSY
Date: Sun, 24 Aug 2025 11:25:24 -0400
Message-ID: <20250824152524.3328278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082315-repeater-prefix-b627@gregkh>
References: <2025082315-repeater-prefix-b627@gregkh>
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


