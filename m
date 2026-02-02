Return-Path: <stable+bounces-213076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OYfBozLgGl3AgMAu9opvQ
	(envelope-from <stable+bounces-213076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:06:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BDCEAA4
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 304B43054CBE
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ABA379999;
	Mon,  2 Feb 2026 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBrXaunx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A614AD0D
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047952; cv=none; b=Jl+d/MNU1vfltQaNUsciSl9W+/sD7utPSBWDo7LG0vG2/WJpmOwJwVUTWN45/qDgItBVE282vsqCm5ueY6+eiXa3plBgB8fSGPyDX1/AULyfKJ0HufW44/RHCx7SX0/EkwEFEBRvCiR3GtytGYh++U0e+E27Qa3dVw7VkK0B5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047952; c=relaxed/simple;
	bh=kARCeaAKhDeIKKAlMz1UbawFMFAokaEWYZvZ6sB7T4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GLl346nFil5VGG+B+oNBGfxcayXD0oDy2WUHbNhM72O5t2aTyDZE9gc7GthRciq/JExxAmaGZJyyas8xhUaJDcUt1VillfY0ICxB8BF47r7JX9vGHN2ussnz41PXR7JiRIe+ynOXhaE0fuT07ljJ0SA3ojV9LA9HghuNuZhq6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBrXaunx; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43590777e22so2902416f8f.3
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 07:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770047949; x=1770652749; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZZm7iyAn8JIl9dQI6HiLl2VItdwuhdut+41offwFMw=;
        b=ZBrXaunxXywOGHZplQrwYyDCxtTARGDcrWmRVOJwHk7ZUQC8Br/bXkpHBMr7wxk8gy
         YnyxfSRHkvbYzYHY4ZJcCdsL8ezoGpze2TLiCjWbyF2Qyp/q5wrqPwcbzqqkYO7BGhCB
         pFDXiNLdH1oDPZz8h2/s/067IMAGMXMsX4ShoUzzj0xcZHWVJk4kvisAqze9iL7TM30S
         hk+gORVMwzHLRMvwy/9YqFp5SVqs4zkwUe/OilTiHur71DljQ915BLNRqJLE8mQjl5J6
         gjdf2HtNMrM+wql2vCss3SBPjNOvGktDS7/4Oa+i6xYRGtP1H0ufzchnct0IB6XQ7+AW
         f8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770047949; x=1770652749;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZZm7iyAn8JIl9dQI6HiLl2VItdwuhdut+41offwFMw=;
        b=bggAkxDwb2KUuZPW7DXdE+Xs5dS67Uj52EKtXT+W5aiz0bAJRongxsSlLuhu+1nyub
         zfYX1AaRoxDdlUAYaYC4OoZSQYNXlf7k+aHu8LFgMLlpAv8Fz0XyIDtPrXebcrPaFHIP
         Tcsas0XnYRU/QY14drqg6baxggDg3mFHmw8EmaBD8tXGlwDiiG9JpdKx6Ya32bVgzNym
         iZYBSVt9wlUks4/IKqrQjkoqCeGkmFS18vV/CiRdxKD/nUqnV/14Vc3qcEC0faoFkFRH
         8fxlOP/gcrv/CQBpNTdNOO/d/CMIoWLoVEgftbk8mL+r95nv6KUktpKm3mUjCZWzHn38
         FlXw==
X-Forwarded-Encrypted: i=1; AJvYcCVFeevzgtQC1iA7sFZ9B4/A0oP3f6ywsdp1BRk+FaRBZA3e01PFndcvT/D/j+qycOOjyAXa8wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNBSUE6jor+tsN9CSaS3CpWw28i5dGYCkMWSBT4Br2aMN6iVN
	pZ5koHkBqXKyjZGUON+upaclHiV/CFwrSymClwWLWw3cF5M3zCSsY6Xl
X-Gm-Gg: AZuq6aJG76XqiragGGdzUPef538YNrRoz8Zryad4mRHg3CAj8ltBgnbl2CAZjMT/BSi
	+gCJGwmuOcmycgdjeBuSZ0+7lqfUHRrFrzLopPK6fxxnqkkgcM2Z6LOw/Wuac1je4Q4NHBn74Hd
	44Zk7ijmaNRH88wUkWJxMqBKpF4FR1LmDwUp6rc62agoG0VpO23+v3a61GpmnuPLmOqEYwNWEq+
	syqDsdqLEUMxuF3c95C8Ta2VQM05iaI0qaaKj7cjcnTJxXxyDXtZX1UhycRxieN5O89mBxlt5F5
	LhW1Ij0lmvNfzBsa+GUtDlojSownlOx4Q1i0NcYr2tYyJar2+8zOmlYi/MeYtjtEeoz0l3nuuS2
	LZH4ob8d19ia0AjOmTQquVp0uyzXaSEUdPONF9UilLQsmn4d6+3t+mWVPXoMAy9G0TNZAMgTrKR
	yVuqn+r5WJL6IjSOaZtoqn3TRyNqSzGMlYXaubQeILKis5KhBf2O8=
X-Received: by 2002:a05:6000:26c3:b0:435:b7b9:afe5 with SMTP id ffacd0b85a97d-435f3a66f53mr16112258f8f.1.1770047949225;
        Mon, 02 Feb 2026 07:59:09 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-435e131ce64sm46708334f8f.26.2026.02.02.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:59:08 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 02 Feb 2026 16:58:57 +0100
Subject: [PATCH] hwmon: gpio-fan: allow to stop FANs when CONFIG_PM is
 disabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-gpio-fan-stop-fix-v1-1-c7853183d93d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMDJgGkC/x2MQQqAMAwEv1JyNqC1FPQr4qFoqrm0pRERin83e
 BmYgd0GQpVJYDYNKt0snJPK0BnYzpAOQt7VwfbW9wo8CmeMIaFcuWDkByeKbrM+TKN3oLtSSfP
 /uazv+wF5VnkcYwAAAA==
X-Change-ID: 20260202-gpio-fan-stop-fix-9ef4c26a9364
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-213076-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 888BDCEAA4
X-Rspamd-Action: no action

When CONFIG_PM is disabled, the GPIO controlled FANs can't be stopped by
using the sysfs attributes since commit 0d01110e6356 ("hwmon: (gpio-fan)
Add regulator support").

Using either the 'pwm1' or the 'fan1_target' attribute fails the same way:

  $ echo 0 > /sys/class/hwmon/hwmon1/pwm1
  ash: write error: Function not implemented
  $ echo 0 > /sys/class/hwmon/hwmon1/fan1_target
  ash: write error: Function not implemented

Both commands were working flawlessly before the mentioned commit.

The issue happens because pm_runtime_put_sync() returns with -ENOSYS
when CONFIG_PM is disabled, and the set_fan_speed() function handles
this as an error.

In order to restore the previous behaviour, change the error check in
the set_fan_speed() function to ignore the -ENOSYS error code.

Cc: stable@vger.kernel.org
Fixes: 0d01110e6356 ("hwmon: (gpio-fan) Add regulator support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/hwmon/gpio-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 516c34bb61c9cfa2927d31ee6459c8306be2fb5b..37645e9141dc7034fd440afed695af57829ec900 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -148,7 +148,7 @@ static int set_fan_speed(struct gpio_fan_data *fan_data, int speed_index)
 		int ret;
 
 		ret = pm_runtime_put_sync(fan_data->dev);
-		if (ret < 0)
+		if (ret < 0 && ret != -ENOSYS)
 			return ret;
 	}
 

---
base-commit: 1117702454262fb361869451be5b006c022eb08a
change-id: 20260202-gpio-fan-stop-fix-9ef4c26a9364

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


