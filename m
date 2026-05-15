Return-Path: <stable+bounces-248932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBthIDabB2r/9wIAu9opvQ
	(envelope-from <stable+bounces-248932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:16:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8486558AF0
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A4033038C50
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B03F44C6;
	Fri, 15 May 2026 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="k1DBY4R1"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C33F076E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883127; cv=none; b=of7D5strWTJKrbvrIjCaiVQtJ/goahOYeTFLEUHnqFOWfQu+LcMoMwwFI5vDNw95d66nZp7xUcpF71y1H8Ahjl1eY8cPc/fYBGsdTymlSb3/NjUcizfI8tBeP87shbxyE6/GMW7nJPZxdRVj7sQWLe3Wh+gODfiP3LqGwqvKl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883127; c=relaxed/simple;
	bh=+I0xhDp4SpUwbzVVvV+VuUoAZCghaJHfoyGjcmblC9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2/6U+YZktJgpXvhI9yFOrgH3GYT0WXHKVLdKj5mbcIdkCrwevLYt9k6WYmGIea2G5jetXLRJJrGAR1gK3rU1SsjI8rgYD8XL3U2CD+nPgKQnP8LSgu4ctXbVyYH5QghX4Wg9fgdD6ViRArrwfETBGvCllUdcC2XCh6W3XrpSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=k1DBY4R1; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso179361eec.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778883124; x=1779487924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bfjoVc2ZTz8zNHb4moDa0nNqdOodwiu4sj42S3RCu4=;
        b=k1DBY4R1A4jUigR/l1ua3hyy6reD7u4N3M5OZx4Xjz3ride/Zn0AUaUOQYxYsQBlGY
         jdIi5zPuu7eEtLwiBqq+jSfH8dgcb8DjnB6cx0HXgS5fzzWVqJ9GBlhbz/kWpCz7KK+W
         tCDoyGWVMuA7FF8wLBnC0Ss7i0EOgdWh0P0AP/S6vfL6uZgAzlicwoCPlfe1Oh+KDgzk
         Hs9mKieDj1+sFyJ0eFbrS7c6r6MPvsRHI5avBK+ZxqIDiK2Zjv0cQWLSDgYKp6S8jSVS
         HmaDb94oOi5GBNWirrSS0Jqf5L5BnZ8x77LXt8lj20KEPoi7geugd9Muiklsj0dYkBhh
         TwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883124; x=1779487924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bfjoVc2ZTz8zNHb4moDa0nNqdOodwiu4sj42S3RCu4=;
        b=MbeW+fBHjWpEZjlAslpOWPI4z7f5w7y8uzJwWoFY1z2g9OY9cka3hYDs27V41HK/qB
         woIHiB082lmD7B+w2qYv4No4EnbnNUjumITtSs0DB4l2+5MsHD0MNRGEq6quUQXC/4Kx
         pjFrFmJjjCxYOUk702F6RwHgNwPWkxeWBxlDqlg1Clz71nYwT1Sbl+zBFgk6K2EIq6o2
         3uGFjMc6E+sIP/UNLp1wXtU08JAhQ14yrn1eerAZYciMWJwVDsA3tHg03vanuIF99dQx
         +XgrWGxMvLqS2EbrlvtkRmX3LjmMt7A9Bc1kc30Cze9vXpJ8+hZIw13EXUhYd3K1rQCq
         phiw==
X-Forwarded-Encrypted: i=1; AFNElJ+klq4gTdJpf4WAo4csTN4qJGxNKr3IWr6+Cs+MysJ+fyR4NPvvcaSb/T6MVSNrRX461AFYw94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7CHgBDSQiW9XE/+GV81haaph+rT/sPhZsXWSAa4szfmIkfF7
	HUumFi1HMCkgOq1EHt4iaCBJxIlqK8E3bkTpl5qYkstUqaBtIGM4YI5QnaV6YvZZI+A=
X-Gm-Gg: Acq92OF8zIm4AsE11bWwHSWWDImH6MUBADOC3JI2KIYqj5VomnPYZ8WTShAlEhrzTnb
	A5jUK1YvaKCunzo62PkL0XO4QG1jN3/i/VKsvGpmbim1+YZAhqTxZDfVzsz2l+/l/1S9rDo7TbB
	RST/Oue5IKFdpe3Xand/EYwj/0xDPuUzJJjyQKmxLh9+0EkFMMb1v7wCi3OryjWOMkgoNZQqw6p
	Zl+rTAjmvlSNNjr6icw2SvzYPHGz7wiyaEUO1gvFyQPAJsfUnp3dkCWXitFVHUP1BY4eVWswwLP
	SWiCMMvjNiBYbusWGjsYj3Hi1CNLEuFPnE0vCurEYqs8iDAqi+ok5EI3JXg1E9G4PJWKtpXPm30
	8rgk88bnMCbX/kbHhHjSy/ykS8dmOuarUTGhCf57MEsv5uV94BUIWmFxV8iBE03IMbbII/NPHLR
	6VUfsr6UfuAJB1bWBA5EcXulKoJFzFb8eo5QLy
X-Received: by 2002:a05:7300:f193:b0:2df:7882:1cf3 with SMTP id 5a478bee46e88-3025eaafc91mr5186644eec.2.1778883124281;
        Fri, 15 May 2026 15:12:04 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm9626315eec.5.2026.05.15.15.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:12:03 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Fri, 15 May 2026 15:11:47 -0700
Subject: [PATCH 1/5] hwmon: (pmbus/adm1266) seed timestamp from the
 real-time clock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-adm1266-fixes-v1-1-1c1ea1349cfe@nexthop.ai>
References: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
In-Reply-To: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778883122; l=1424;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=+I0xhDp4SpUwbzVVvV+VuUoAZCghaJHfoyGjcmblC9o=;
 b=o73nMyBiu8rsMOWD3agOF7Ur1lWSxqpwjd1nw0RRSHnPxVRuX4azpL6+vHSE6K0ZX8PU5iSla
 PzFKl00eeRnD8r/zEL1C8y/SvMJHCj86t0Rqp9moGxxCfWoXQb8TR1f
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: D8486558AF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TAGGED_FROM(0.00)[bounces-248932-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim]
X-Rspamd-Action: no action

adm1266_set_rtc() seeds the chip's SET_RTC register from
ktime_get_seconds(), which returns CLOCK_MONOTONIC -- i.e. seconds
since the host last booted, not seconds since the Unix epoch.

The chip stamps that value into every blackbox record it captures.
Userspace reading those timestamps back expects wall-clock seconds:
that's what the SET_RTC frame layout documents (datasheet Rev. D,
Table 84) and what every other consumer of "seconds since epoch"
assumes.  Seeding from CLOCK_MONOTONIC gives blackbox records a
timestamp that is only meaningful within a single boot of the host
and silently resets to small values on every reboot.

Switch to ktime_get_real_seconds() so the seed matches what the
register is documented to hold.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/hwmon/pmbus/adm1266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index d90f8f80be8e..a86666c73a5e 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -432,7 +432,7 @@ static int adm1266_set_rtc(struct adm1266_data *data)
 	char write_buf[6];
 	int i;
 
-	kt = ktime_get_seconds();
+	kt = ktime_get_real_seconds();
 
 	memset(write_buf, 0, sizeof(write_buf));
 

-- 
2.53.0


