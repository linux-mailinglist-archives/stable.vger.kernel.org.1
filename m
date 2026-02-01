Return-Path: <stable+bounces-213009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD8BCiu5f2mxwgIAu9opvQ
	(envelope-from <stable+bounces-213009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 21:35:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73238C7324
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85D7930071F2
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27962C21F0;
	Sun,  1 Feb 2026 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1qjLEUB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512C26E173
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769978121; cv=none; b=lWfMS+ppXv5WYC6AewVAIe4TL49p9b3ArYoUN88CrR+fs7O6dUhzV8zl2+bNXGmLmlHDxYrLylIm2YJcw2m6nAe8TCbJXvOS8JBxu5QcP2lAWx9LlaJ2Ai7Bljt/yToOqrfvtCAm6Ard1wLWzHofHJZrJ2NSagbDc84x7s33qsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769978121; c=relaxed/simple;
	bh=5aFcpAaR/lASpDeQK/SKRvYCXntKw60Rvq8b69dCrfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LgdXzuIFTTQOFRQYSNBgHfdWHAYzgmjk5HEYZHCas0CPbhVdw+MGSpA6rYJAoJypZcdtUEL5qVw+Y+iE0/L2a0z5nIZxF5DV9h9IrFX2E7vvS2hKdXQBJ06VxU3XJMsl45gqf+D0NaHxg+j6C6HIz0rQChfY3CSQJVPDbwG2iJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1qjLEUB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso15062615e9.3
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 12:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769978118; x=1770582918; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91/0VfU3LtdVoSnFoD2Wj5KpABZ0e6Hnrwv0/nUnRaY=;
        b=d1qjLEUBpGMmNcA4iRbOdpiQ0r0e94uFb9lscngtOWjOlURwjalkY0JdrNAUz5o1hA
         HImDc0Z1NZM/XguIbd9DYh5GZ45FFhVPtGTeGG7uA/9teNxHc5XgGeSoLB5z3wBiNa/s
         qoHAUnpNf8rYClpNbZnN8kyGeugfweZlk3xXb7n2ve5sgtptecILMgqEQSs139dqgf9c
         Ow9Q2/T/KTxIILSHQaqonjCxXXyDC1CbV6weU6oJMrqyGiQPcrhGhov9R0ck+rGvELkB
         YrEl7OHIEJImiXQ+5IYoeL2DIIt6FjHrTOwKDFGIpyhCLsN7ZC9LBKVv+qpGBbTRjgY+
         pJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769978118; x=1770582918;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91/0VfU3LtdVoSnFoD2Wj5KpABZ0e6Hnrwv0/nUnRaY=;
        b=S+YLuHHbL2fsAow57LaaU5OO8yqVX+fZFsY1jk5y5LrfpURGQAHN8AwJVRghJ6oryh
         +r5Pi3bP6gYS0tlfqj5RSA9m+6lNyq+WnHmkqBEq+GQlUPx5EKEKIjvSyhxWj/6b5R1U
         NnitlK7RmRfi/Qy3fX/hz2NUnpcXmmEtoB5H8MjrZiSY02gCFYobVEKFrMytO7uCc4kx
         KG0q86fYEjT7UEimAD/AyBrjxnm8oGHeqYWjaIPA5nrf+9uieVNVCwJLsKO+jiZ9hjFs
         lYZoR1+xmqHk2sCjYiOvr61G6EaOhb8CO1fftIBDuX+0K0lI6m+uupMp1Y7oO2RMoPGT
         vNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGKkl6z5bZWT4Jjt9DZQYrEndkhyTHQZW9duZLx/xMijFgO2n9PcqbHayKpl3mPFwYRQONhPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+81RMB72umuTEoNGOtk2Fj4bKi5EHiGHX+rGib1aCCrsB8R3
	zwY2yDwM9Wtcvi9JDj4oKvCfVY/wPvvk2vIX9KmPrDYZsyMLK8cnOp3Q
X-Gm-Gg: AZuq6aIsr6v9SHVXFyfiW5Fgf0tHJKu+i8zZ62IqDI6JDEZ4QrifwNx8Hqre/V0HQ1R
	zNs44HPkcUXCsvAgGzcW9iL2uOXsyKPHVWtslwrG4qO4Gqy90ZacGKtAg9rNl2lg2rsG/4mYQqi
	I7uQqaZhrGtwPDpLLLENrTAQ9NA40tm7ber5peqK56IUpv7fme/OIV9vor/sFZPZc4ZqKdUL894
	KEJtpirkzgXcXq6AWIIhOquQZsTPPUDl5A3vlR4nt/zxn0qpDMfAsiEo9k68Xtxu1sUe2kj0RI9
	EwkgGl73FUxrtnqbbGu/YA22QWu+xER7Qnj2zqUnxlaO8t+gwETj58X/5Exd0EPNMJoEUs04nAR
	M9QCrFdzxWGJflObX+qu9gxAWsejw2iaGMS4hM4YpBprzKT9OLkdABTv6/tFEfcza2qz3OSs+ds
	BhC8As+gWTPblq/Mz5JA/+66T7N0KOMEe2AuwMnPYFdtrzVOIADQU=
X-Received: by 2002:a05:600c:310f:b0:480:1b1a:5526 with SMTP id 5b1f17b1804b1-482db46c28amr129120025e9.16.1769978118540;
        Sun, 01 Feb 2026 12:35:18 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-435e10e48a6sm37663837f8f.8.2026.02.01.12.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 12:35:17 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 01 Feb 2026 21:35:06 +0100
Subject: [PATCH] hwmon: gpio-fan: fix set_rpm() return value
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-gpio-fan-set_rpm-retval-fix-v1-1-dc39bc7693ca@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPm4f2kC/x3MQQqDMBBG4avIrB2YRGqhVylFgv6xA20MExFBv
 LvB5fcW76ACUxR6NQcZNi26pArXNjR+Q5rBOlWTF9+LF8dz1oVjSFywDpb/bFi38OOoO6MPz+i
 kg0wPqodsqPm+vz/neQGJ4KZlbQAAAA==
X-Change-ID: 20260201-gpio-fan-set_rpm-retval-fix-e6a7f103e0d5
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-213009-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73238C7324
X-Rspamd-Action: no action

The set_rpm function is used as a 'store' callback of a device attribute,
and as such it should return with the number of bytes consumed. However
since commit 0d01110e6356 ("hwmon: (gpio-fan) Add regulator support"),
the function returns with zero on success.

Due to this, the function gets called again and again whenever the user
tries to change the FAN speed by writing the desired RPM value into the
'fan1_target' sysfs attribute.

The broken behaviour can be reproduced easily. For example, the following
command never returns unless it gets terminated:

  $ echo 500 > /sys/class/hwmon/hwmon1/fan1_target
  ^C
  $

Change the code to return with the same value as the 'count' parameter
on success to indicate that all bytes from the input buffer are consumed.
The function behaved the same way prior to the offending change.

Cc: stable@vger.kernel.org
Fixes: 0d01110e6356 ("hwmon: (gpio-fan) Add regulator support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/hwmon/gpio-fan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 516c34bb61c9cfa2927d31ee6459c8306be2fb5b..d7fa021f376e39b79b6a0302377c4516f9861459 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -291,7 +291,7 @@ static ssize_t set_rpm(struct device *dev, struct device_attribute *attr,
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 	unsigned long rpm;
-	int ret = count;
+	int ret;
 
 	if (kstrtoul(buf, 10, &rpm))
 		return -EINVAL;
@@ -308,7 +308,7 @@ static ssize_t set_rpm(struct device *dev, struct device_attribute *attr,
 exit_unlock:
 	mutex_unlock(&fan_data->lock);
 
-	return ret;
+	return ret ? ret : count;
 }
 
 static DEVICE_ATTR_RW(pwm1);

---
base-commit: 1117702454262fb361869451be5b006c022eb08a
change-id: 20260201-gpio-fan-set_rpm-retval-fix-e6a7f103e0d5

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


