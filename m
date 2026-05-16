Return-Path: <stable+bounces-249040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIhtGoTXCGqZ7gMAu9opvQ
	(envelope-from <stable+bounces-249040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 22:45:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C919855DBBA
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 22:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B78301BA74
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E288378833;
	Sat, 16 May 2026 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="ZcgUXt5p"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB535E1D9
	for <stable@vger.kernel.org>; Sat, 16 May 2026 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778964322; cv=none; b=mL2d/2k420h88XPeb4IXYO/9NNZmMpg+poVKRpG2JwxesvKE/bVWLUKeI7zwiSIr3re53BWA2MB8dyU7W7ncUcUmkRG0vaHM86RhXJ/n+6JpBYHrOLG0xA2g9BPfX5XFGWl62GCoavQOvjlhMpr4NSO+gYMTHoZ+FZk7ei0K5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778964322; c=relaxed/simple;
	bh=RfhWyhkILQ9JdmZHbT+RrfNjTCyKMG4R356hSwJe3G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/u2MxU+wGkQ8VOkeu3HqC01jx2+xQ0bByojUze1JgFEFu4TMYqdvffk1KMZRVTsJV33ohwQ/nlKUIZLanzS728QEue+4vZdTXeOLk8Fq6xXRXRa+R0Xw5ZqCbS4N8F1BEBc4IEbO7234Z/F7oOoHqcZv+bk2MB3yLM3/lDN3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=ZcgUXt5p; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso445970eec.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778964317; x=1779569117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAd95b7/1qRCPRUMfS/TXEKMP5bhCN7d3v6gwbzEek0=;
        b=ZcgUXt5pkLED9dRjEbySF2v7MT+6DaSl7KSguC6Rq8CKXdld+Hk9wtpT5Xs9sCajnU
         TBZP29I0Jmii0ka7JaM4NrRjS2ToJM533aGIR/lp+6KomRGR/AxwN5Tek16pesydCkTM
         jnSTaKuEC3siK2oBXZjVMqEJ3PFO3W2IlAW+Xk5Oqbzl+SKaIlzsDwNgHhNL0BqMHHym
         LcV5lYR3oXKY5UkBNqpe62U9RZCZ3u1qQOYTcFPhfOrDTuwPXKNBX3WGzWz1EWeH3lBH
         ee5Ugz8iaiWC/wC39QDzxIOy7so6xm/sAC2irVGuTDCrqKk+4CSrtCd7PMNH+rnVM+wy
         h6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778964317; x=1779569117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAd95b7/1qRCPRUMfS/TXEKMP5bhCN7d3v6gwbzEek0=;
        b=diZYQawSwyD3/EUi5KOvXOVFyZ2tFD35pwU6EYuTQ4RvK+qW4OlYAhz8+jpWftvlNd
         NF6wkqjMqaaM1gV5Ch3mA3ajx+ul/ll2idZS5Zc1XF26RdYH5sAmf8Ug07VHRmNqaEC0
         ktRpXoZs5fvEa99gVQgBWfRLUdLxNAAXVludSD+lvoHSSJwKdLT+SyaD9Bj1Emr1FXVN
         8T4XJpNnHMNbWtG0nR13EL0kMGRzUmuRl2yHllgco/R6qX5kxhfH3AJ+IIVhZMZOsUNL
         9p/4nSL+ZUEv0d/TmVxC0l7uaj48Sr1Q1qBh3A/eOuK16z/2wo+jol49WKh7lsfN3j/2
         8DKg==
X-Forwarded-Encrypted: i=1; AFNElJ++SCvn/szwxjpnlw33t23zovT/jhPWJFFPgfKXwDrKUbsIS7idyDFD2+htBFLr8snurUk+cYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycrYEdJHyiNUlEWhMRTP+mzj6/vxtScIcNFMRwgG6af022+Eh1
	zvyj73zF1SQZ+dd9ONclJb1maQKGy3YLlw1E4z8sm8sJ77B4fZjVM33U4pEniePEn6s=
X-Gm-Gg: Acq92OFeQvq8kOqGhlpypYFJvJ6LwDRhz66JwTmCTsCdKf1OSku8JDZrcr+UGuG1Fnb
	sdlnWK6KgUKAfx9gcEjJWcTTOZ4V3GAeQUdW1iAuWdVk6FP9V21/p1qscuIzzSIcojgf6zeop6i
	jj+xaqs0k0KUaQpDM1AVGu45Z3Kk0vB61HQfFek0OcNvPjNyTknk9kxQCAzmIHe/seJE7ouE7HS
	CuqhgUCREUgYJmmHLnSO0UPTqKYHuixbt6YXmc0WYWhk1MxCAzoRfDKZgvxPzisorLYhlZPEAZQ
	poWSNe5cmfEE9pNMjhmyHXYCSTPSYnQr8Dlt0xiwEumOJrlXSzebQyxq/N0oB1mQ4SGsLhtvxI+
	OxEXp9CKNlX4ikclwPfEipdtg/OYTUzvbAPlrpBDuJN8kQB1Qixhnz7w29S+6XkRK3f6gud18rA
	/pDso6g4rlrIBBezXFD+IsAUqwEYcMDbaXb9YheDslP9A2lU8=
X-Received: by 2002:a05:7300:5786:b0:2f4:d190:37bf with SMTP id 5a478bee46e88-30261e7524emr5925773eec.16.1778964316535;
        Sat, 16 May 2026 13:45:16 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm10181189eec.12.2026.05.16.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 13:45:16 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Sat, 16 May 2026 13:45:07 -0700
Subject: [PATCH 2/2] hwmon: (pmbus/adm1266) don't clobber GPIO bits before
 PDIO read in get_multiple
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-adm1266-gpio-fixes-v1-2-38d9dd39b905@nexthop.ai>
References: <20260516-adm1266-gpio-fixes-v1-0-38d9dd39b905@nexthop.ai>
In-Reply-To: <20260516-adm1266-gpio-fixes-v1-0-38d9dd39b905@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778964314; l=1492;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=RfhWyhkILQ9JdmZHbT+RrfNjTCyKMG4R356hSwJe3G8=;
 b=w7SBG8WKVytyc0UPa0IqJNBMBW0tyJp01IO5+hbO9NQmQBlE6iXe90w1vbz3ZaaylqfT9gY4u
 YEdqDozT+oCAAJQBxYRgvdBEZB0qsql1Lf0Al0oe+SSsx08B+L0eayD
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: C919855DBBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249040-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

adm1266_gpio_get_multiple() zeroes *bits before the GPIO_STATUS loop
and then a second time before the PDIO_STATUS loop:

	*bits = 0;
	for_each_set_bit(gpio_nr, mask, ADM1266_GPIO_NR) {
		...
		set_bit(gpio_nr, bits);
	}

	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS, ...);
	...
	*bits = 0;
	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_NR) {
		...
		set_bit(gpio_nr, bits);
	}

The second *bits = 0 throws away every GPIO bit the first loop just
populated, so callers asking for any combination of GPIO and PDIO
pins always see the GPIO portion of the returned bits as zero.

Drop the redundant second assignment so both halves of the result
survive.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/hwmon/pmbus/adm1266.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 11f9a44f4361..4dd67c02b412 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -210,7 +210,6 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
-	*bits = 0;
 	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_NR) {
 		if (test_bit(gpio_nr - ADM1266_GPIO_NR, &status))
 			set_bit(gpio_nr, bits);

-- 
2.53.0


