Return-Path: <stable+bounces-141102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593B1AAB155
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219BC4A1BD9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C9297B92;
	Tue,  6 May 2025 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDjIenEc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933829AB1A;
	Mon,  5 May 2025 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485055; cv=none; b=VCqnSILg4umso3+snNONrDEQVopG1kYyyYGYB1NghJnEPw+FR9j4AclEZgwZhyXxvH8Iy8fKL5SAiO3myJ0JKKViM8XVbLw2GmtatqMQ+XCkfSRpebV6EsW0qXTltbr9NH3qQdyxAxmBHhM22/9vHCBOOH3I2ZnYvg7d/ZvYlzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485055; c=relaxed/simple;
	bh=D7eXuyELba5Og2esZH36Lvj9LlUf/dCO03XC8wf+1jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLIhbgiB/KLOdfrs3mF+hrCAdqX4MnW2x6W5Y6lJ8lJXNP9/Yv6dyIHTWWsN8N3P0LXb5SsDMtDGFI9Q8+yF4IaJnDuHp/pyde7+SVlg0i9j5JPawpXbIIquigu7zSwSOuctRKU0++ufh79wRFShY0cQYN5JE/qrv/whN8zk5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDjIenEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D8AC4CEE4;
	Mon,  5 May 2025 22:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485054;
	bh=D7eXuyELba5Og2esZH36Lvj9LlUf/dCO03XC8wf+1jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDjIenEc7+SddyqzYhSNLo1Ilcu5Cdjhhj2lHqU0XydVJK5Ehettu/5kZ0LFUyDv4
	 bof/WZVsX6ab7cQ5YlQ2aSpoxw0bhReRuBaPx05fjLtyOq062yOUAFebUyNgFqrf0b
	 tJINE/2ILRlsps9zn9JIZaGqdArfaa8nZxUsZA55esEew+P5/Wykqb+XbWjEfvOowa
	 uUoAm/B7Ol8S3L3es2mNe12jSe7PyeOGMF24hk1fMzZzl4JN2dIDVXUH5d/sePUDUC
	 BhG7P60PzBiN3gPs3RUrHPEcNaKdr0sSE9HGbKrqXWv6jWxZnpYGKsksLappEb52UE
	 YtR8eRBKILNHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	corbet@lwn.net,
	pali@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 144/486] hwmon: (dell-smm) Increment the number of fans
Date: Mon,  5 May 2025 18:33:40 -0400
Message-Id: <20250505223922.2682012-144-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Kurt Borja <kuurtb@gmail.com>

[ Upstream commit dbcfcb239b3b452ef8782842c36fb17dd1b9092f ]

Some Alienware laptops that support the SMM interface, may have up to 4
fans.

Tested on an Alienware x15 r1.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250304055249.51940-2-kuurtb@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/hwmon/dell-smm-hwmon.rst | 14 +++++++-------
 drivers/hwmon/dell-smm-hwmon.c         |  5 ++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
index 74905675d71f9..5a4edb6565cf9 100644
--- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -32,12 +32,12 @@ Temperature sensors and fans can be queried and set via the standard
 =============================== ======= =======================================
 Name				Perm	Description
 =============================== ======= =======================================
-fan[1-3]_input                  RO      Fan speed in RPM.
-fan[1-3]_label                  RO      Fan label.
-fan[1-3]_min                    RO      Minimal Fan speed in RPM
-fan[1-3]_max                    RO      Maximal Fan speed in RPM
-fan[1-3]_target                 RO      Expected Fan speed in RPM
-pwm[1-3]                        RW      Control the fan PWM duty-cycle.
+fan[1-4]_input                  RO      Fan speed in RPM.
+fan[1-4]_label                  RO      Fan label.
+fan[1-4]_min                    RO      Minimal Fan speed in RPM
+fan[1-4]_max                    RO      Maximal Fan speed in RPM
+fan[1-4]_target                 RO      Expected Fan speed in RPM
+pwm[1-4]                        RW      Control the fan PWM duty-cycle.
 pwm1_enable                     WO      Enable or disable automatic BIOS fan
                                         control (not supported on all laptops,
                                         see below for details).
@@ -93,7 +93,7 @@ Again, when you find new codes, we'd be happy to have your patches!
 ---------------------------
 
 The driver also exports the fans as thermal cooling devices with
-``type`` set to ``dell-smm-fan[1-3]``. This allows for easy fan control
+``type`` set to ``dell-smm-fan[1-4]``. This allows for easy fan control
 using one of the thermal governors.
 
 Module parameters
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index f5bdf842040e6..b043fbd15c9da 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -73,7 +73,7 @@
 #define DELL_SMM_LEGACY_EXECUTE	0x1
 
 #define DELL_SMM_NO_TEMP	10
-#define DELL_SMM_NO_FANS	3
+#define DELL_SMM_NO_FANS	4
 
 struct smm_regs {
 	unsigned int eax;
@@ -1074,11 +1074,14 @@ static const struct hwmon_channel_info * const dell_smm_info[] = {
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
 			   HWMON_F_TARGET,
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
+			   HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
 			   HWMON_F_TARGET
 			   ),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
 			   HWMON_PWM_INPUT
 			   ),
 	NULL
-- 
2.39.5


