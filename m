Return-Path: <stable+bounces-140719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31777AAAAE1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36831889CFB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC72836A1;
	Mon,  5 May 2025 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1lmh+zF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6883792CA;
	Mon,  5 May 2025 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486061; cv=none; b=VcMfkC7essKJuEGuynRN1N3UfaBEwVYRloSrIU+f2X9S/Xozuaw31V17hbOsNnfA3GyxXYGEw7GXnl1Ogbh9GppN0w6V2OqfZ3caHzngP4Rogz/mVuRiuOj+2T5/26PrTMn9zJ6N7aqXbdCmAPR3NAOl0d+QSL17VQn0U0p/76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486061; c=relaxed/simple;
	bh=QB5BDmNQRFBOKORRB1IUyzjlT4+1l2j7PdDoCOiaFtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1zXQGvtec9bh5QgAaf0EDeFLhnPLGOmZOnexqqAEbbhiyEH+KKfS0NIa9b88eP/E2+qha2H2ShEs5wyP0vfnY0BzUzubWAwsFR9eG81iFA/9nFkooYoceiiy3GOHpfd154xAZxbsX89QGbpGCCAc+Vug/gofAjK1nW47HoEnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1lmh+zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91BEC4CEF3;
	Mon,  5 May 2025 23:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486059;
	bh=QB5BDmNQRFBOKORRB1IUyzjlT4+1l2j7PdDoCOiaFtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g1lmh+zFvGzlc9MGZfSYRGV35eznsNGYKZ2JeWeiFxw6XsQjr4v3exkg/d/KZQhtI
	 KL2L8Ga4jRq1kzJQ5+AMCR3JrE782bePPhLPm6w0WtHCJm2nzaxuTu8lX0xC8tJxgL
	 Hdfv3NKgIa56XQ9w8BY7aLnf1iPrZXMrZr/ZAE2PCn6hAWjc1sU/qsstV8iIOAyQ4U
	 /2+61O8L9IA8DU/wBKLPNoBXDuW63UYRcn9NqhU8AdA+aX5Uh6BosA9gLvw7L6off/
	 TKiGrIKXTU3BWtQOwfdXJ5SLM5hbOxvOfglXSZMmd6zZJmP/NobTSmWxW5U5q71gcz
	 J2sKdJ8ywB26Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 132/294] hwmon: (gpio-fan) Add missing mutex locks
Date: Mon,  5 May 2025 18:53:52 -0400
Message-Id: <20250505225634.2688578-132-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index d92c536be9af7..b779240328d59 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -393,7 +393,12 @@ static int gpio_fan_set_cur_state(struct thermal_cooling_device *cdev,
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
 
@@ -489,7 +494,11 @@ MODULE_DEVICE_TABLE(of, of_gpio_fan_match);
 
 static void gpio_fan_stop(void *data)
 {
+	struct gpio_fan_data *fan_data = data;
+
+	mutex_lock(&fan_data->lock);
 	set_fan_speed(data, 0);
+	mutex_unlock(&fan_data->lock);
 }
 
 static int gpio_fan_probe(struct platform_device *pdev)
@@ -562,7 +571,9 @@ static int gpio_fan_suspend(struct device *dev)
 
 	if (fan_data->gpios) {
 		fan_data->resume_speed = fan_data->speed_index;
+		mutex_lock(&fan_data->lock);
 		set_fan_speed(fan_data, 0);
+		mutex_unlock(&fan_data->lock);
 	}
 
 	return 0;
@@ -572,8 +583,11 @@ static int gpio_fan_resume(struct device *dev)
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


