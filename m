Return-Path: <stable+bounces-141070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3766FAAB062
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1B61BA0E79
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A6B30D782;
	Mon,  5 May 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yly7OgeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517C3BC91A;
	Mon,  5 May 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487380; cv=none; b=bbvhSzEMN8MPDp9noouTTtI9pY4GfXRwF5b8NnjrGMPXNqOSxUs54rtBnGcRXUCdfBn/PsiyNixvPqtRteDOffDgERC/mgKVEL42lBn6Bt7STV3ObjtGHDrwJcEwnasTztnBjqneXDS8OkS04e4B1r915IapsxOXcHu0Lum5Rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487380; c=relaxed/simple;
	bh=CSJhOkzkiduu5ndm2PmYWC0q7Oa4idlGlQu8exG6sBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GrSQ9V39oDaOaLtdpOGW+IaoTqgW9MI9Vd4y24j9P74I/AJRXaInZ50+ZjAlL1BBWep2FboeNaxnBgfCcZo9WRKmx5SKDLsjsrHelruN65ClzfY0rK9pmoGCfth+GbriZ7PmYMbgiq5zaoo233naG1bopVbR7j3NAfej2d5kyg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yly7OgeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96017C4CEEE;
	Mon,  5 May 2025 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487379;
	bh=CSJhOkzkiduu5ndm2PmYWC0q7Oa4idlGlQu8exG6sBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yly7OgeCOhKTY/nRmIOz74JX5CncuXyFK9LaL5ZZ5LvIqA9/ZgUdSQC2rvlsHGcNe
	 weLOvZEO/XsLDkAZmDlNFHSkBPUogb2/IXXtFKd2deqtJJHe/Yb59MUlqeKzal93pa
	 MFmqws87bHOk91FbAaC/JDvnwCJeWbQEQJBIrk7cKN50t04EUj1Q0SmnKo+f9Kq+CQ
	 5er6gWOhP1cPW/PWqPosYTAHAKvKzWwMxJ5Ru82qCMscG+HURDjEjfcocVBe/MTyP9
	 Wu6Gcr0g6fqDyEsp3Xr8L0AqIpwrTG4AYKjTa8dFcJtSjrZDmhOF/YcwfXDj6qE6jZ
	 gGKJKq0eEwS+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 38/79] hwmon: (gpio-fan) Add missing mutex locks
Date: Mon,  5 May 2025 19:21:10 -0400
Message-Id: <20250505232151.2698893-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 9fee7d19bab635f89223cc40dfd2c8797fdc4988 ]

set_fan_speed() is expected to be called with fan_data->lock being locked.
Add locking for proper synchronization.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/20250210145934.761280-3-alexander.stein@ew.tq-group.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/gpio-fan.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index d96e435cc42b1..e0b3917dfe6f9 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -394,7 +394,12 @@ static int gpio_fan_set_cur_state(struct thermal_cooling_device *cdev,
 	if (state >= fan_data->num_speed)
 		return -EINVAL;
 
+	mutex_lock(&fan_data->lock);
+
 	set_fan_speed(fan_data, state);
+
+	mutex_unlock(&fan_data->lock);
+
 	return 0;
 }
 
@@ -490,7 +495,11 @@ MODULE_DEVICE_TABLE(of, of_gpio_fan_match);
 
 static void gpio_fan_stop(void *data)
 {
+	struct gpio_fan_data *fan_data = data;
+
+	mutex_lock(&fan_data->lock);
 	set_fan_speed(data, 0);
+	mutex_unlock(&fan_data->lock);
 }
 
 static int gpio_fan_probe(struct platform_device *pdev)
@@ -564,7 +573,9 @@ static int gpio_fan_suspend(struct device *dev)
 
 	if (fan_data->gpios) {
 		fan_data->resume_speed = fan_data->speed_index;
+		mutex_lock(&fan_data->lock);
 		set_fan_speed(fan_data, 0);
+		mutex_unlock(&fan_data->lock);
 	}
 
 	return 0;
@@ -574,8 +585,11 @@ static int gpio_fan_resume(struct device *dev)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 
-	if (fan_data->gpios)
+	if (fan_data->gpios) {
+		mutex_lock(&fan_data->lock);
 		set_fan_speed(fan_data, fan_data->resume_speed);
+		mutex_unlock(&fan_data->lock);
+	}
 
 	return 0;
 }
-- 
2.39.5


