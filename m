Return-Path: <stable+bounces-249051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Bo6Dnv7CGppDgQAu9opvQ
	(envelope-from <stable+bounces-249051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:19:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E2755E3D6
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D693015476
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 23:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6273A1685;
	Sat, 16 May 2026 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="NgB2h3mR"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5739A807
	for <stable@vger.kernel.org>; Sat, 16 May 2026 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778973538; cv=none; b=cyBCtzpmkVI1p63YwSSahU941D2jF2HNVva6c4jtgVau1HmL0N2D5qEtTKpGrxBa6y44t9tKPsojSEdtvMZsl1x3LHnR9uORriuDff4vR73X64G8Ta/7kx1JpWsoswhPLbPWII1bS1HbIHuzb4l7ekRKRpxftHDIDpCzLSP0XOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778973538; c=relaxed/simple;
	bh=RfhWyhkILQ9JdmZHbT+RrfNjTCyKMG4R356hSwJe3G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7x2x+3ku/xJpn8T2jfFDkRk8O/ZKiQvW5MwiKzpz7iQVF+nN/f3q6TcdS530ZtfSbtF5Y5rbv0jEFl07SD6thB8UkM/Rqtc7nnqUWDolasSLQTIINgojyT4phubMAWGQS789WZ3JfiEHoFWM1ZpoIKcdHnkv6AYZh+2x+fiTHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=NgB2h3mR; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c19d23b19so1373645c88.0
        for <stable@vger.kernel.org>; Sat, 16 May 2026 16:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778973537; x=1779578337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAd95b7/1qRCPRUMfS/TXEKMP5bhCN7d3v6gwbzEek0=;
        b=NgB2h3mRZZWHVoyEJ8oRUwKl3uRT00zJcYf/Wrm9kp518nqyeOdKrZycL6qx7AJZlN
         nBuvMZ7kIuV65ReiVxsNPBih81NgO30TM3ZoNTwVB8nl/zKzK7KOQYfFYJVrlXpYzmD5
         vtxwx06t5xysf1BySfcxAQuIku28yGDSvmSZsXsJfsOx2wVqugRLJ7V5TbdQ8o80lZk9
         ONRz9VxjhM2Gxs+T+1KP88L2eg82LyNbOU9rQo3KULZNR4JXWJaC4xjdTm4ezyTKLrXL
         e6N9I+CZAw3HpAE5YZKPh9Iiq2XGJaoFtju95CaSIdJrMr36vk3iw55vt39MnE1IMsDn
         iZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778973537; x=1779578337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAd95b7/1qRCPRUMfS/TXEKMP5bhCN7d3v6gwbzEek0=;
        b=f6AUAySOvVF9b4fXmrRY+r0ygZmywcrrs5V8oHeXuEBRd0R1uyAIcLukrG3yEA55nn
         R6Nbc6IlLg2q1gKizFRZRuNQk9+wjgVaVqRoEqtlZdCsWtMSfjNh8PcEBV1LJ+JEJ/hX
         ncbDcg6E/2gie8eogV8MnxXt0SwDwRrLUYQGbkh/KkPscQtiijq4gFSAjl6QY1F9LmV2
         FMQ6sco3H5UN4Opst1bkN5Cgk8CBPT3cD3YCDuDXR7s7fHKR3uaXhTO0KAZ4v//ZydGv
         Oj4tnhlqJr3iHD95v6Vg1ZFQprrR/WuqfOEV+tes6gaiV+hm3neKXbr1WklkhTdlH4/0
         C1Lw==
X-Forwarded-Encrypted: i=1; AFNElJ/cne5DraAffy16o7EgvMIZ09YaUTRJ1Swz1M4mznLH/6Zj3CgroLnYBCrZsDpkvbs9JQ7gU+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfciLJpRstshTcxA17z9EiKx/qXo7IosFDAlUTmn/t/iIRMLRZ
	jmg+WxvN8Z0mf6RwTo09bxQuONAGCNp6jyKF8Fm7TsjeZjXqq0CPD49MkJIWLdqCWgg=
X-Gm-Gg: Acq92OFs4iJIoJOVCxSFLA/pLdpS+c5HfacFTbELJYVEzmOfvBohj5QjIcyecX2BKmY
	3JIJxlodYsyf0OylZJ4Ad6At1rvWn052jGt1RX61eHQpSn6hPCXiFcBLapYN98wFHYDfbDbbVYp
	APlAQko1mXISo6mcztTrQzlGYwMfE69c6MbF77MChvwdBMBUmJRoNOj7uaPunUEBNE0deZiw8yu
	43WKiExH/Aj5EQh/SJn5nXJwolr3vJ4ikCS4hStzn4wRCa1XVu8UyCz06XNJ+yflVUderniHKP7
	koL5Fo/nF5gMnvgpHV8A4y+Nvn0kUOS4tyHxXQ9uMgvriz4TwceFejWyj8rCDjBmkMx376bU6Ri
	uWSnQ3hcqAt9MYrk3Ksvm1sFx98PWDQW2762li96lrAyWGtJ+cNQcvOi4Df4Cheqy3xNc8bDoOf
	3KNK4NDFwKu6gRT2eoOHBW8Ry8YQfF3pbH0zgW
X-Received: by 2002:a05:7022:e06:b0:132:f27:5302 with SMTP id a92af1059eb24-1350440d03bmr4186170c88.3.1778973536840;
        Sat, 16 May 2026 16:18:56 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm14722254c88.2.2026.05.16.16.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 16:18:56 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Sat, 16 May 2026 16:18:48 -0700
Subject: [PATCH v2 2/5] hwmon: (pmbus/adm1266) don't clobber GPIO bits
 before PDIO read in get_multiple
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-adm1266-gpio-fixes-v2-2-801f13debcb2@nexthop.ai>
References: <20260516-adm1266-gpio-fixes-v2-0-801f13debcb2@nexthop.ai>
In-Reply-To: <20260516-adm1266-gpio-fixes-v2-0-801f13debcb2@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778973534; l=1492;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=RfhWyhkILQ9JdmZHbT+RrfNjTCyKMG4R356hSwJe3G8=;
 b=SRT6QNrMcC6JVdOXSE5bR5Pt/QkIyNsl4uxKqVxOGrqHqTKpw0GLITxsugccdGLhsMTCUu6Qd
 r/PkU5ndk+lBlRQLQPOLVgS4TsIj0wGu8s0mDgsqhiBAcdzS/+4IiP4
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: D3E2755E3D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249051-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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


