Return-Path: <stable+bounces-249423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A6rB5u0C2q2LAUAu9opvQ
	(envelope-from <stable+bounces-249423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:53:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A2575CEF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 647F93053BAC
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 00:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36822DEA94;
	Tue, 19 May 2026 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="KDQrKJOq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4C24A047
	for <stable@vger.kernel.org>; Tue, 19 May 2026 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151955; cv=none; b=Jg8joLZgtqraVv4aa6pY+s6MR8do0aMOa1NmT90tymp3riRFG4l48+XrO0uptEuX4eBCdzZmLiy7zJEj0PFzsHR+drKckSXefL05HONzj99woBBpxmSbRQLoHxa1Pu3267IV0ET7d18GovOOfiTPUe7syRXcZxi3zsChGsTJlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151955; c=relaxed/simple;
	bh=UKwTxR23bo/8190Ma3oEAswzHLxiNKOJzcKPyM3XidY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx7yEHEOKsTNFXD+uglXgR12y+MLPy8rXzYTWnz+saz0IS2CdsVW8/u2Vi0z8zvenZmd5L7wviBGS8YgJG+aszDLA3IBd2c3xterk1m0XHZhcLHAxF7DLu9jnt1V6xD92C5hpER5THeH3VS7515ejvYSZOizHrfvkIRijZU1y1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=KDQrKJOq; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-132830d8281so11559004c88.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 17:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779151951; x=1779756751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewneUiTeW4FFURX4JgSEmHD5g9yyYbAjzLEjC7sMhRw=;
        b=KDQrKJOqDWANIBBqazkc/7Tn+rqj42Ln0vZTvIf3QMUiswXR4TAbNW1YZ4rIJOIESv
         p3Tbw6e9tHRKbgfzvmXlMs9Vru6V1YY8vzVtSMd2AYE4PEBpeGgucIzSo43ZkMrVyQn+
         C/z0/JSQTw3dWykRwUpqlhFEc4/CLEVGr+wXjj1Qg6a4bV52zonueb3Mhd5XIEOE7If4
         IbkAnPyuEEn7ruNPQwcjd+jd86JipRALBX3Yxu3BWD3/siULZxHtddtKHkrP+Ss7R356
         MXJj1dZHCrMh6luFHMFFhFGtBcYC1emEEOPfeC9cNMFo6/dA27qlpcgzSsmB3fcSb4w7
         j0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151951; x=1779756751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewneUiTeW4FFURX4JgSEmHD5g9yyYbAjzLEjC7sMhRw=;
        b=UcfRIOqxfskj24GxRcr1Ce9tkvDHZfpFDrFuaQ4bELJ2kbP8OaYFwdp4wpglk39wCK
         8e6QcxIz33yBAhcqBzMsiI/MTEm2q/com7PQOqTNVva2Tk+p7tfIjWe2bzWWucGaXxGF
         iaLraviBKBHOsYFWhwDc1SdLky0R6U9kn8UKevMYGGM/sa9NkUTWs0PTaZmd2RLWcXb3
         DN5w1iiWWmYPLf1qVVK88PdEKL+FYsIHJsIhGj4ClPPfzWsgqoCkhBwJxN78nWUUM9tB
         ds5FupwNxdFSgxTgPmvRtiGElxULOrJjMZYTxiWQjzTrUVUf6ZlYKZCxXn/m3x2ALMDA
         9Q/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/2Va+tioy4cfMxv6/aj8rKTy/YW4piy0zvascjCjCMj4okzRaykmuPYNhkeDIT0z6XBM5WbpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3oWx2+YQETIz8G8N3Q4z8Axle4qZI2bXljaCXRToXZHVSw19W
	zEf7rVUteEMufJ9g7CUjetSX4w05nh1RsT9OlqMXH1tlCYnquspGSlGHlJxVKiEmK/g=
X-Gm-Gg: Acq92OH6vfPQyK3gHJOb7JWEjHnDCCZI+0A8pVrESGISYr/1+TBfjeoxABi7UYMbl0m
	JhgUttbTViNMxhHbS0KjnqFEcCVmLz61k2XDeKYV9+h+JFaOCTHXtKtGOB73HsH9rOiybVezcJM
	ze2UKRxkcxOFi70Z0YBLG35u6epcsiP+8ACnjVCBlVOc61apguazCEI7Ff70+N1W5qMVfZ2cTro
	0euGr9mcopxocQOdG2EniTTpYmAKm2IE16flIukkcfkdKqx/rVwsG8VZev0AeRTnpx/cySE7X2e
	eLqtcdSO5AthAhfujebYAWzsiO1oStwD3aFmvC9wE8Wbor13qSEN83nUfZ7THVCECtvmi2z+0Oj
	48RBUxXEeZcl2MTtpS+aTGQowdTNWlmLCPgpf3vayO5EVStVZ/U+PiYBMI1ok6XnriCdT9nWDl7
	UKorSHoE8+MFzOU7xnL57k50Liew==
X-Received: by 2002:a05:7022:4183:b0:132:1e01:8737 with SMTP id a92af1059eb24-1350542e5a3mr8640606c88.26.1779151950688;
        Mon, 18 May 2026 17:52:30 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm22546633c88.3.2026.05.18.17.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:52:30 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 18 May 2026 17:52:25 -0700
Subject: [PATCH v3 1/8] hwmon: (pmbus/adm1266) cap PDIO scan in
 get_multiple at ADM1266_PDIO_NR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-adm1266-gpio-fixes-v3-1-e425e4f88139@nexthop.ai>
References: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
In-Reply-To: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779151949; l=1909;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=UKwTxR23bo/8190Ma3oEAswzHLxiNKOJzcKPyM3XidY=;
 b=xMhWNO55f7uVRzwHl8EIoXja68oza75rFM5LQtWDh61+3xx1p6acSL1AwhpH5fIuFDmlUhGJr
 K1cQHsXlSqTCoTjX5iLRkRb3K+kf+lgwi4Bd8npwGK39ZvPlUm6AqK9
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TAGGED_FROM(0.00)[bounces-249423-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C82A2575CEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

adm1266_gpio_get_multiple() iterates the PDIO portion of the
caller-supplied mask using

	for_each_set_bit_from(gpio_nr, mask,
			      ADM1266_GPIO_NR + ADM1266_PDIO_STATUS) {
		...
	}

where ADM1266_PDIO_STATUS is the PMBus command code (0xE9, i.e. 233),
not the number of PDIO pins.  The intended upper bound is
ADM1266_GPIO_NR + ADM1266_PDIO_NR = 25.

gpiolib hands in a mask sized for gc.ngpio (= 25 bits on this chip),
so the iteration walks find_next_bit() up to 242, reading up to 217
extra bits (a handful of unsigned-long words: four on 64-bit, seven
on 32-bit) of whatever lives past the end of the mask in the
caller's stack.  Any incidental set bit in that range then drives a
set_bit(gpio_nr, bits) call that writes past the end of the
caller-supplied bits array too -- both out-of-bounds.

Substitute ADM1266_PDIO_NR for the constant so the scan stops at the
last real PDIO bit.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index d90f8f80be8e..11f9a44f4361 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -211,7 +211,7 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	status = read_buf[0] + (read_buf[1] << 8);
 
 	*bits = 0;
-	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_STATUS) {
+	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_NR) {
 		if (test_bit(gpio_nr - ADM1266_GPIO_NR, &status))
 			set_bit(gpio_nr, bits);
 	}

-- 
2.53.0


