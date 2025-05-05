Return-Path: <stable+bounces-139925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC0AAA254
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F597B033A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619612DA10D;
	Mon,  5 May 2025 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHLdCOoM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179882DA104;
	Mon,  5 May 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483684; cv=none; b=mGXAZetVpqq8h4CL0cFykyCbypNfJQH9LV+q9r5UgTht3YQokxMNFnMy4tpJ8Do9tfNss5HDBhJfOabTc9OiMhEi2ndvIteZjkz3zs9Elm8VNzE6+ZrkuQUaSpOGIEeea7E3Hy1U/7+t17bSVTsWn6Bzr2lLYrX++DLZsV+yXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483684; c=relaxed/simple;
	bh=4A6iHzWNOnohZZamH2T5qzWaSp4/sasUPIzHpMwtFuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQFiD+D5tbCcGmxRj549Tt6E34GiIxJ2gcTP6B7m06eoZ/L8toxuvslP2fdkJZZFKs7OqAsXI+3aNiW9JHu9gsue1bYG5cgGI/NHCkx3b1Qbgs05VkwS1jQGKmMXDtAK38VmrMlRxxCvQixuJG+zFxcljAjbFDU6jj1+Y8Cf1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHLdCOoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0DEC4CEE4;
	Mon,  5 May 2025 22:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483683;
	bh=4A6iHzWNOnohZZamH2T5qzWaSp4/sasUPIzHpMwtFuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHLdCOoMK3C4HYsEjSTeMLfR0wV+Ix0AlwWiNRBv2DLFiI+6+/6tu9R0RgW2HBy1h
	 J6rd16CkBbFsBIjfmv1EOGB28WqC3Cj3d94t0yvQtUPq45vCDrkzhvnOMkX2G6ZEw7
	 GrcLxb+3vM+pMLpAFQ4nbWu2tmOod+HzTHscaHWsZZATXgp0BBFetfvXKCJXF2m7dG
	 GPFke+UrADgbEVxDvp1GZ718jiHWYvC6Uovp2MOrF9VAfPfq88n6y8RSFXaK34ded7
	 dRowFIC0MdB4UzhdHLrXuHhIsgyuMKUEWsxX8Wm+t4njEO7dPPWDHeiBLjkPplhpqB
	 Dl9xheHj2v/yg==
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
Subject: [PATCH AUTOSEL 6.14 178/642] hwmon: (dell-smm) Increment the number of fans
Date: Mon,  5 May 2025 18:06:34 -0400
Message-Id: <20250505221419.2672473-178-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index cd00adaad1b41..79e5606e6d2f8 100644
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


