Return-Path: <stable+bounces-222597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGrBK4uRpWmoDgYAu9opvQ
	(envelope-from <stable+bounces-222597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:32:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 441BA1D9D0F
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B2AA302525E
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B800D3FFAB8;
	Mon,  2 Mar 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMuOsEER"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FF3FD12B
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458343; cv=none; b=KWe2IK7CS2Jb1xfbDM+fR1vHJT5Lb/pQmLqQ9jTIyHAxLt+qWzBPVINxLaG13JlXYpspHRZmXb0xXbLBkXBzwP48t8gwXY/jbh+69/6oNVCACYSjsD7I4VyR22yXjHs0tYMyhWGzxcOfhmbFR0cGVn2J9v04Yp/3zGevn8x++1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458343; c=relaxed/simple;
	bh=dyTNs9MprdyGfjoYTC7GCr6CogMkIxtooeEvuDiyWbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xe1dNOALM0x89xZz4S3Q/Z3WQEy7hC+hvjdKGGjaRlzlJ8mqt4iesKm4R3AIuyAcDME5vyhUg0X+00vmGpt5Kr+ZBYhcOeee1/Ot2JtjnOeGTeM/zBfo5OlPQtYG0RzCKQGcbLLY+3BEEely7dxtMOgd9KzzmzP+eOIUPsIRPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bMuOsEER; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65fa79f5c98so621577a12.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 05:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772458340; x=1773063140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjlHqPkPckP75emu98ViOC8jnSkyM/XQ9Lo/8u+sKmY=;
        b=bMuOsEER8VbllsSHOl9CD/v23Onq9YEZWYMod6uNwtyvCMfLy+/GQgn6IayS/6MaT2
         NRVHbzAFPvClqCs/bS/BIJblDv53Pr3aWZbq8JKslmXLswXhV7j+yFqbgXkhD/QMYnvN
         DfrbBmJ2rJ2dh6ds8thDb7JJ7McN+6PyUbxGeKVnQpNsJo8ZBcHzhiAN46v4Lfd5HUVC
         w9tDvJyNJI49HY4NiKYenvxLoWnEnQvDrMOWKDLuc8N6Yu2tz3VTk6DlidzAP+yIom5P
         4bt9ZCm0ekiAVxsoS34rLMQgY41Jqp79qjP58UiF1U8zhuSDazgSFYQVZg2zz24uiSMd
         3qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458340; x=1773063140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cjlHqPkPckP75emu98ViOC8jnSkyM/XQ9Lo/8u+sKmY=;
        b=wM0t2MSskH3ZIBJbnB0anbal+1rN8ws/uXQmSs7zynpzeuYyBC8ezIo1HcSFkEFfAI
         KPINgC30ioABVrQ6z5yqP/MvSjGUP2BPKaHZ58nbxu9IQTl3JbS/ALuBfTTPgb5gyCYx
         sZNlJNjLVGmNkCrvKA2KLLjkr4rt/ymqRcEWprI8QyoO5JBH04uv2EAtcKmvoZuR0FbC
         kjX/Q1JVwslQX07RbED35hWwuxNrY3TAXaZyF2cilXSNqEjQhK35+L1rikOfOgWxetMO
         jvYgVc8ASHsDzuZaGfbnhRQvfyMSsL5DL/gGMvkKJfL9asVZK/A8hWqDO9hFWYBRWCZq
         NMVg==
X-Forwarded-Encrypted: i=1; AJvYcCUGgfr9C+TxrRnCrOP6QSUqyYY3nTsxwSCn3IuMUDDmoS+hkaN1lq+XZId0Wd16kYF+vrVUUPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlxgCzY/Atr7MLBQCDuCw+xcJTBqC86kCyRL72oiHoiKcC+rL
	ALArDDDz9B7uwGkiDdZZCbP8HC6HBSOsm6UyRnEynyI6RG5ntDzWXkipLntmXcll66w=
X-Gm-Gg: ATEYQzz+86ELC9MEug+8H25pN+GvWGl1lfUSPGNmRa+KYvdTK9YMwyhDRE2ekH+CzXS
	D0u7QWwaSE/vRkPWlG9bhb7EaBbHjNm++O+Y+1FANVO/tlil0e2elrV2muxA8aJmfeTQ0GKgxRM
	J6RcT+2Dl61U7fDPw+E9Pw1Cim6qvrAwLPZ7/jET0wXoSzfEgL0GpYrIdSGcDlbVCmt69MkLB+w
	iaLHYBltDlBqszgUt+GI1iQYUpE77okGZQKxvyoS6hvFjjDhXMtBQiiz+Rcr+4JjGDqfjIH9veR
	3oIi5tktgqVvpyhg61Wnaw6z9nRDcrR0xDAQrZ9UMdXnLRkYhftNntgG1t2A9GtqfpkgONL38YC
	WObP+rEdx2gclQNjNmBqoYaugZ5sjQuR8/+MSfJHqCk9CAf82bQg0R5oa9B79t2ub/XzPtzBwh8
	mf6cyVu10AYTeTTp2ciqgG9LbCbnO2XxQqRgj3Z9VkJr6Mm7lzGA2O3inUUT0Xvzt6Tee4cwp0R
	yrpg7ayfBnZhovaOkaFbRwblQ==
X-Received: by 2002:a05:6402:1449:b0:658:a54c:d6f9 with SMTP id 4fb4d7f45d1cf-65fab6e90d3mr9715764a12.5.1772458339872;
        Mon, 02 Mar 2026 05:32:19 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d1c6sm3282988a12.17.2026.03.02.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:32:19 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 02 Mar 2026 13:32:05 +0000
Subject: [PATCH v3 06/11] power: supply: max17042: avoid overflow when
 determining health
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-max77759-fg-v3-6-3c5f01dbda23@linaro.org>
References: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
In-Reply-To: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222597-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: 441BA1D9D0F
X-Rspamd-Action: no action

If vmax has the default value of INT_MAX (e.g. because not specified in
DT), battery health is reported as over-voltage. This is because adding
any value to vmax (the vmax tolerance in this case) causes it to wrap
around, making it negative and smaller than the measured battery
voltage.

Avoid that by using size_add().

Fixes: edd4ab055931 ("power: max17042_battery: add HEALTH and TEMP_* properties support")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v3:
- drop a useless comment introduced in earlier versions.
---
 drivers/power/supply/max17042_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index b9277f81a25d..39091fb31711 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -201,7 +201,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto out;
 	}
 
-	if (vbatt > chip->pdata->vmax + MAX17042_VMAX_TOLERANCE) {
+	if (vbatt > size_add(chip->pdata->vmax, MAX17042_VMAX_TOLERANCE)) {
 		*health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		goto out;
 	}

-- 
2.53.0.473.g4a7958ca14-goog


