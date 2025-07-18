Return-Path: <stable+bounces-163402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5AAB0AB04
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 22:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C4DAA4B06
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 20:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65121A436;
	Fri, 18 Jul 2025 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="ebVMBZ+m"
X-Original-To: stable@vger.kernel.org
Received: from mace.gateworks.com (mace.gateworks.com [174.136.5.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9A11712;
	Fri, 18 Jul 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.136.5.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752869928; cv=none; b=DyaJ9+g7r4FMWivugbeWzCsFCVem2E5dF+5bUEr14QVdIrZycQNQ8yH2EiGFVXoqZSqNopKrn/T81h3p8h+d/Wcf/ODJjIDjsxux4FfvH9K2Jq1CaPvz8okLEbv6b3RqfYwEg0hyWJ7jZDbwCdG8I/Mh0KfVN1f3NCeRbWyDgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752869928; c=relaxed/simple;
	bh=33/BNh7Nc4NFJrUbX8P6X/yoW8tk1NwIk2hOUkZN2lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJiFUNBbWAiYCjNOtb8qv5AMcVcAVWCypY4h3MOCxqLE5Mfj4BBe146895HakOnKTwDOYfudZT1S2tFzlToyCS4vt9xfW3arupfYq74uW0eJ+f+dk2NZWHJKCq9PlaEmlVNiQwif95P33kwGdfgH6pOn6HVFBdGdwZ+Snmd03Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=ebVMBZ+m; arc=none smtp.client-ip=174.136.5.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gateworks.com; s=gwtrack; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=txiNjIfadBZ8TvDS8U+kB99ooME0U4CCdiENzeCPlpg=; b=ebVMBZ+mymU4AKD70hv2nRPdib
	0VBt2A8pQrGvQ2gESj9c8/FN5/DKo1Rfj9uVfXwDJUZzA5lwRQcFiLtkLteOwiwKc0lRblLyDvmuN
	N/WDycYr0giAqOb9nfWz6Q3hPzh3zDG+ZhO97yX+Fkxtt/rkviyTZ02uSWBJGWHQGzz2ZhU83CP3T
	7LcieoCqIV0dcENA5JGQZPqa97heZiduOOIrAkASGfX7NPC7xnwXT2Crq3heXm2FZIYcHPTewzuID
	c8YXeeEs8o1U16FcBXD7e1t+3Wlhn2QOb55nPaxCdVASWtn73AOAWU5My7IyXbl2jr2P2HLBTG1Fx
	BsjTs74Q==;
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=chewbacca.pdc.gateworks.com)
	by mace.gateworks.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1ucrIK-00Gddx-Sw;
	Fri, 18 Jul 2025 20:03:01 +0000
Received: by chewbacca.pdc.gateworks.com (Postfix, from userid 1154)
	id AF1953083874; Fri, 18 Jul 2025 13:03:00 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] hwmon: (gsc-hwmon) fix fan pwm setpoint show functions
Date: Fri, 18 Jul 2025 13:02:59 -0700
Message-Id: <20250718200259.1840792-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux hwmon sysfs API values for pwmX_auto_pointY_pwm represent an
integer value between 0 (0%) to 255 (100%) and the pwmX_auto_pointY_temp
represent millidegrees Celcius.

Commit a6d80df47ee2 ("hwmon: (gsc-hwmon) fix fan pwm temperature
scaling") properly addressed the incorrect scaling in the
pwm_auto_point_temp_store implementation but erroneously scaled
the pwm_auto_point_pwm_show (pwm value) instead of the
pwm_auto_point_temp_show (temp value) resulting in:
 # cat /sys/class/hwmon/hwmon0/pwm1_auto_point6_pwm
 25500
 # cat /sys/class/hwmon/hwmon0/pwm1_auto_point6_temp
 4500

Fix the scaling of these attributes:
 # cat /sys/class/hwmon/hwmon0/pwm1_auto_point6_pwm
 255
 # cat /sys/class/hwmon/hwmon0/pwm1_auto_point6_temp
 45000

Fixes: a6d80df47ee2 ("hwmon: (gsc-hwmon) fix fan pwm temperature scaling")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/hwmon/gsc-hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index 0f9af82cebec..105b9f9dbec3 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -64,7 +64,7 @@ static ssize_t pwm_auto_point_temp_show(struct device *dev,
 		return ret;
 
 	ret = regs[0] | regs[1] << 8;
-	return sprintf(buf, "%d\n", ret * 10);
+	return sprintf(buf, "%d\n", ret * 100);
 }
 
 static ssize_t pwm_auto_point_temp_store(struct device *dev,
@@ -99,7 +99,7 @@ static ssize_t pwm_auto_point_pwm_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 
-	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)));
+	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)) / 100);
 }
 
 static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm_auto_point_pwm, 0);
-- 
2.34.1


