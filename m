Return-Path: <stable+bounces-249039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHBZI2zXCGqZ7gMAu9opvQ
	(envelope-from <stable+bounces-249039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 22:45:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB755DB8D
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 22:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A8430131F9
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D933793C1;
	Sat, 16 May 2026 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="ZCdoBKlP"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258193793BA
	for <stable@vger.kernel.org>; Sat, 16 May 2026 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778964320; cv=none; b=ljiCllZcDOcbATOFmAm/8xoSFPj//RgSCZ0cIbiFH/+eMZu+SyMZJ8ArnswKbB+a0lCOtTdb0cYWfaODHDlREJOXZ2vs4FgyCjURYdUPuh/yhupsuVXSMW+h+ZhmOtFlrrhkmUAmYr4DYEk71fMB9aP0ZIZzPgqZRVer8/doUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778964320; c=relaxed/simple;
	bh=thK+U+aplsDzvE5oAtB1E2JzEzfbWfLwgItKOTLlb8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poxABpnQuaf7WfWkI9JEh7BuZHirhmvLLxhNfZGB4tz/joNFb0GCoI87f1rw1x8gHE55oKeb0cuiyzz6miNEwfEcSeOOiIjIGcRxI8uDXoH1yW96nQRavYzCfEf58w2kdMyOCBzaKdsTrAgvJSeRoGcxXGu0pVuegcpMtFkipl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=ZCdoBKlP; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso4453024eec.0
        for <stable@vger.kernel.org>; Sat, 16 May 2026 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778964316; x=1779569116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN2ucZVsVYmHc/fedXjm4iB8oy6SqWjHFEKRvCBYgl8=;
        b=ZCdoBKlP2IBwldcKYmxqIQ0gAOx7ZbuEWUsF0Z7HucEx+ipTHfTctxv/bVkllEygb9
         cmx7eIbKql51eurkJcpJwXi5EAG/FaeDXpEw76qUkby2CXKx9zUtr7rePwhml/HHdMaE
         Qqe6ZUb8iQaZ96mitufci0jFLdXCiFlYzHg0l/Bpvf796fMKsjK/B70/X8Mq2c5YM1kA
         S0uf/+sAOsF1zIoxuGnGiVvYsDEoIz+PSmmxLVq7PXwvrW8wVbJnqXC0tuWUjAGk45TU
         xaIduO903BY/XERBCG4hyzwy5gydXMsEnCd4HH4esfQjNjY3mL0rvSklYvIV5IESkjCf
         GSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778964316; x=1779569116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lN2ucZVsVYmHc/fedXjm4iB8oy6SqWjHFEKRvCBYgl8=;
        b=V/OuamDyeXB3mAbU75ifdAW/x1SidzKyAwFvtZjVXnV7fE86e4XVrmg7yZGmn1aT0x
         EGfDsMzViPqbWIPFO14Yr4WvhKrtdQX2ZC8pDRgZy9qOCBA+NM4SOFckG2pWVs78Iel9
         7lCLtkxsXtUAtHfgfxzmCsPxkcDFAQSzCdeOtNDM11XQEwxwkGMWKKZZdS63gpvmZUDL
         XiGfcC3rt64mEDoeRY71w45zWULtDHpL9ZC5SHsm+oYOWTDam5n5E5yajmJAX4OT8hPv
         mKzpgT3vABeqz2t9J0mG48baM2nZ+6ltUZ5ZeXO5XUY+GJ+eZEZdwoAlxCYHySK1HOIf
         dMgg==
X-Forwarded-Encrypted: i=1; AFNElJ8EIxp2fwFMbf7F1qTNpr8Be+KN4TTtRzgkn0FXaUOEdP0Vc3e6VJN0P57XTLZQDYCxKuDPPVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr9VW6E+IOi1kf0J/hRT3gzAgZIg8pNVhxE0NNxbTrjFD7cwsh
	Lhr6udRQOlHqCUCVmmvhPXN4071vymaDk1i7/S/1IPkI+MV2S74M9g5Grq93Vc0Wph4=
X-Gm-Gg: Acq92OHlDpiwhs63n0PrX7jqbIy82HKkHJs+RG2gfglLPX6IRydE4MsfgdDUs5yBRcT
	MKzj4vz6+dl9LYidZRVHeKro+3bH260Z5BXK2hP2G8dVnBKc8veYvFsAdWtOW+QshAnNWPLyoX4
	OJUjmhflvV1vjgeEZQS8WaTSP1oLkmXCEQUq26taqD3g3ZDRQVX8+9r41LtR2sjEjGl51tD5cJ2
	nVhvxwNRW9yFkNx6uMubHky5wDueWOtJ5AfVtv69ytR5tX3DYDt/24aiSNjdZISSwugxQI3dTag
	IuxgKfzDPwpIaNvAEgmbOrKYpHfvygx5TZ9hnXDovsoUT6wgUUVChecuBYQdyls1Uyd7bKQgPzg
	aei7/2Zf4xkM2oBARy5GBQ3DgDXMzwM7Jf3B/z9amGsX9nlMyuiuzETZnxC/pr3ZfklBvbtNCz+
	qyEzqd4R3h3Dvp5tsUTBu500tKRw==
X-Received: by 2002:a05:7300:be17:b0:2d8:7302:d21 with SMTP id 5a478bee46e88-303986010e1mr4012564eec.16.1778964315801;
        Sat, 16 May 2026 13:45:15 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm10181189eec.12.2026.05.16.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 13:45:15 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Sat, 16 May 2026 13:45:06 -0700
Subject: [PATCH 1/2] hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple
 at ADM1266_PDIO_NR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-adm1266-gpio-fixes-v1-1-38d9dd39b905@nexthop.ai>
References: <20260516-adm1266-gpio-fixes-v1-0-38d9dd39b905@nexthop.ai>
In-Reply-To: <20260516-adm1266-gpio-fixes-v1-0-38d9dd39b905@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778964314; l=1733;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=thK+U+aplsDzvE5oAtB1E2JzEzfbWfLwgItKOTLlb8o=;
 b=BjxUI7bCnZQeFpZr2VOSAEtl2SLHMs+Oa3mHpajmk0LAPHOhdXEZlhdAym/1bSbWC3erZwg9R
 mT6xHQTW0CMC+SUgxRZG1FK3c7FXPaM2P+/QHUrJpOofreLG2DY6l2t
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: CAEB755DB8D
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
	TAGGED_FROM(0.00)[bounces-249039-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
so the iteration walks find_next_bit() up to 242, reading up to 27
extra unsigned-long words of whatever lives past the end of the mask
in the caller's stack.  Any incidental set bit in that range then
drives a set_bit(gpio_nr, bits) call that writes past the end of the
caller-supplied bits array too -- both out-of-bounds.

Substitute ADM1266_PDIO_NR for the constant so the scan stops at the
last real PDIO bit.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
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


