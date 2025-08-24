Return-Path: <stable+bounces-172743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3924B3303C
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A477744443A
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609122DAFB9;
	Sun, 24 Aug 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY+qzJ3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7A1E4A4
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043612; cv=none; b=qMWLq5dzUxdm85bk2bDE5/Tc9FlNKhew5AWOkW44tibQRxQq4iGXK2AlW1/qRy1gZKl/wBANdVaksCAvb8QdMV8KnCpoSEvfnrBgIzPz0eLwAYrwZxVmMZVrfz5CDCp/P9EdnOPIKp7HXw8256MkzNLV7on0191ZIKTA6fe4eHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043612; c=relaxed/simple;
	bh=AYCF9hYuhTNArkH9mNIM9cWddP+AHvjq10FP/H7HAlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBdhiJgQKi03AOC7xsmGriOPrf1+bJLy1K+s8SbZHTDhUqGJRTHklxMh5Uso5FbbH+L+2/CnExC62raRyAYm7NcmaTYDldUgSWWPtsOhTRHsnmCcDWNEsuDRUGEa2qeI4KJ56arfCS4Qp3v6yRFBgM1dXyqQFbsadCPgUARYgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY+qzJ3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC1CC116D0;
	Sun, 24 Aug 2025 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756043612;
	bh=AYCF9hYuhTNArkH9mNIM9cWddP+AHvjq10FP/H7HAlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EY+qzJ3WHP+5xuQekWH4BibeWMvdy9cf+ORR5MyXQAXEmv0kBoJWvCxU9Cn2hovVE
	 rGgnkIbD8iPXlb2INSNb69D6kDCtzVqRgr6u/CSUIwXUJDUAnF4uc7DXy+xKm5p6hC
	 ZpNjoSyV9stKgGaMhtF4NVM6t/gHTT0c5hkCVAUbYMJbtw5L7nS43xsWr9Wx7wsmkb
	 dEXVOC2DCIXnIRNL63WaL9IvIxvAglDiCb3bbdPluzv37X+0ilY6G3q7+WB3OArirg
	 2/tobOmcLLwsZ9MHQaINsB8fs+l8+kXt31OwF6IOavvIMFTgmTxxqOIX4lIBCQNlyC
	 sfUI433SprJvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] iio: imu: inv_icm42600: change invalid data error to -EBUSY
Date: Sun, 24 Aug 2025 09:53:27 -0400
Message-ID: <20250824135327.2919985-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824135327.2919985-1-sashal@kernel.org>
References: <2025082314-steed-eldercare-ccf9@gregkh>
 <20250824135327.2919985-1-sashal@kernel.org>
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


