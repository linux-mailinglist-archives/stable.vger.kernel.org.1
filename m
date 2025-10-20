Return-Path: <stable+bounces-188112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F2BF1750
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84D944F50D8
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50AA30DD2F;
	Mon, 20 Oct 2025 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ+4/46c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEE2F83DF
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965784; cv=none; b=c+TJz3jgTOZTMsq4BOF+2KxtMlqNwuCO8aG1W3L9FKDSGjb/EZtzKB7YVdoufzNLv1ZKAhrJQ9mtfAM8t2iXITAqiDpE7HuXNogXMZyZVzEh7CKAiyAbfOYinIUaHCok7B62N27F6LLNwIwxaOP6hGm9umqTZIwOILeJZUaLfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965784; c=relaxed/simple;
	bh=w6C7x6wTV/Apo9RBTnJdxy1Qp1wUONocVYfrwqlHzr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MctvB3vYRwDswd1iQp0yFm2WnF0w0kyF9FSC0rTzjdaLJ9T76t3v/H2WbRMZRsYvUGPOWzT/nkNVvKGKB0fjG6ro1NEI4AdZl1eUsVceYAV4O/H8XquTVXxOqEELEHbfKW8cRXElrBpIx0bl4HabanCFglNQxXsfWQJpHx1MENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ+4/46c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797D0C4CEF9;
	Mon, 20 Oct 2025 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965784;
	bh=w6C7x6wTV/Apo9RBTnJdxy1Qp1wUONocVYfrwqlHzr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQ+4/46c1yUvwvf+Rz07rt7dBCjdEDq3ZLzNw0eTVXNYu28mz/ZGaUN5IoA2h0OHx
	 wbQ6B52L4nvAAUcSSiGyWCXM4TLjAuwATfcTAgLLdG33+KA22Yay0Wsh1nK2V57krb
	 FS+JWSVlerf0HbIUkWGq8IFw44+YxY/IL6atPGpfe5c+QROGcSxJ1cv3NUjvTjpaI7
	 9X2oJk2k9m8EG+XWEQYH0UkndBFEaXORxqbpY/p1KiDVf/57AfhnrmDdvn+eDAqkgw
	 5CMLmmgwoktXDwMCYj0G7rcg0105S9pKAorvikiP4ECjF6TXigDlpmIvM8HMjOZao7
	 qeN4O+ZxxgpXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
Date: Mon, 20 Oct 2025 09:09:40 -0400
Message-ID: <20251020130940.1767272-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020130940.1767272-1-sashal@kernel.org>
References: <2025101623-clarify-manhood-adaa@gregkh>
 <20251020130940.1767272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Nyekjaer <sean@geanix.com>

[ Upstream commit 466f7a2fef2a4e426f809f79845a1ec1aeb558f4 ]

Do as in suspend, skip resume configuration steps if the device is already
pm_runtime suspended. This avoids reconfiguring a device that is already
in the correct low-power state and ensures that pm_runtime handles the
power state transitions properly.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250901-icm42pmreg-v3-3-ef1336246960@geanix.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ adjusted context for suspend/resume functions lacking APEX/wakeup support ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index f955c3d01fef9..cee9dee004a31 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -680,17 +680,15 @@ EXPORT_SYMBOL_GPL(inv_icm42600_core_probe);
 static int __maybe_unused inv_icm42600_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
 	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
-	if (pm_runtime_suspended(dev)) {
-		ret = 0;
+	if (pm_runtime_suspended(dev))
 		goto out_unlock;
-	}
 
 	/* disable FIFO data streaming */
 	if (st->fifo.on) {
@@ -722,10 +720,13 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct inv_icm42600_timestamp *gyro_ts = iio_priv(st->indio_gyro);
 	struct inv_icm42600_timestamp *accel_ts = iio_priv(st->indio_accel);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
+	if (pm_runtime_suspended(dev))
+		goto out_unlock;
+
 	ret = inv_icm42600_enable_regulator_vddio(st);
 	if (ret)
 		goto out_unlock;
-- 
2.51.0


