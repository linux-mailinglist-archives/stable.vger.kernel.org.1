Return-Path: <stable+bounces-97385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B064F9E2464
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C516D493
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AAD1F8AC8;
	Tue,  3 Dec 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fJqCgXPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED81DFD91;
	Tue,  3 Dec 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240332; cv=none; b=FGGM1RX2sI4S5BN/aEgWrsNhWAl3M+zFYszeuWe7it3AJDqgsup0yZlCwZ/XQmabKQi5XM6mjoTtqmur6w4F5Yr1cSnOuRIKGz6RgbKvjEdYe/3jeQwUbOoo8TK8DcuSsHOZY543s6KqlOP2jPiYZLaIc5ZUD5ESbLo9gZZmjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240332; c=relaxed/simple;
	bh=ByEpBofXjwP/wxm7st9UUvmjQJlTT2WAXHvYU094jKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBZLYg44nxctZVxB8a9ZuiujzXef6bMhVwy2xzMnaxSUWhxa9GfUQZNlebSZzWswyAOk1BWig77Xcpywnfk3zVlIwqet114Sh8aHx+vSy3E57h5LbHIlP5u0k9GHE7zsUDKWwAVp9VTwC2TOgde0h2bgZ0yWl6wkTyGlaAVQxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fJqCgXPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BDDC4CECF;
	Tue,  3 Dec 2024 15:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240332;
	bh=ByEpBofXjwP/wxm7st9UUvmjQJlTT2WAXHvYU094jKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJqCgXPIcBZ/OTYTWU42Yql0HBZJb0ItJNxycB1szujMHTp+qjuhC7vvYsDQNSjuZ
	 YfHEsS5v1hEHMUhl+M9fKSGtF80xKSeavrZOIUtYCZ/xB8fdhs2vFBSOIqp4j7/cgr
	 GRf4i8L/YSdz8YlLoaYiC9o7p7OaGbZEctXGNam4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 072/826] hwmon: (nct6775-core) Fix overflows seen when writing limit attributes
Date: Tue,  3 Dec 2024 15:36:39 +0100
Message-ID: <20241203144746.281446863@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit 57ee12b6c514146c19b6a159013b48727a012960 ]

DIV_ROUND_CLOSEST() after kstrtoul() results in an overflow if a large
number such as 18446744073709551615 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Fixes: c3963bc0a0cf ("hwmon: (nct6775) Split core and platform driver")
Message-ID: <7d5084cea33f7c0fd0578c59adfff71f93de94d9.1731375425.git.xiaopei01@kylinos.cn>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 934fed3dd5866..ee04795b98aab 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -2878,8 +2878,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0,
-			data->target_temp_mask);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, data->target_temp_mask * 1000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -2959,7 +2958,7 @@ store_temp_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit tolerance as needed */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, data->tolerance_mask);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, data->tolerance_mask * 1000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->temp_tolerance[index][nr] = val;
@@ -3085,7 +3084,7 @@ store_weight_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 255000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->weight_temp[index][nr] = val;
-- 
2.43.0




