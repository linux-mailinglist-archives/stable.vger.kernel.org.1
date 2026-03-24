Return-Path: <stable+bounces-230144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDnpAgF4wmlsdQQAu9opvQ
	(envelope-from <stable+bounces-230144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:39:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A89FE307709
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DFE8301A785
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6678A3F0750;
	Tue, 24 Mar 2026 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="jMczJ74f"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D953EFD24
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352319; cv=none; b=U1Xw/WOfsLmczOPwMX97J15l2r1zqf0B8RxrJaI8p/4ReJRV/1tC3KKZ7C3MNmXlV4e7c6kmce1EXcZg10fZhbVVJSkNmST91WdV4dK5LXUoS8Ratw3mbIz9V23nJLE1DI1/oQ43jSKw8fcIHEZvKpfTML5TSLd01x2s5TOfTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352319; c=relaxed/simple;
	bh=0GDlOYezmKEXCru71ex6Z77WQ5tS0GByeoQbXgUi37g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QT/qWNzV8JxziEml0TRDRld2tuJsP8Mw4uyOxIgzdfaIUwdnHGVvQbH+EQgwlI9gZWPYw8FScRuWcYM+9E12SlL/vfKD6/7wz0CGMriXxJmeaJydIiVxiVi+GED35UyVjP9Isx0bEooqX+bLH5Wy2dHPBqCR3eCh0n4cpLIJSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=jMczJ74f; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so1476302f8f.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352316; x=1774957116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=jMczJ74f+p4Oa2Xl9eCmCm+k+OyS0x73hIZG1wfmP9dexw91n6Q4UQojcvn8q8x9BS
         yPndZW+lCvh19+8phFYkA43uYe4xhTnU5VzIXE6ieZEGMnkxQclMsIgita0rofjLE53x
         OQoCseDmpaRVXomJTqTTNjS4X9Eq3O99YX37lyTC4MjkLb4QEr4MvW/t9jTacIGiSXTL
         iOhwqZvAGxBkxIxo7hPSArFTvfu+m1MFAkDlo48ehA2M2rDbMU7Kdk6VSBxlbCmlaeuO
         QSUQPHwZTFU0/UzY6G7gVKeg0M9BKMTY4jcOHkYC9T+iFh2ugqaqAknRh7QIzspmVIcU
         3Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352316; x=1774957116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=WBQZGGqWRsUAr43+USMdFDYrS9SmTLYuVtJIF+/fEy5rK+D0UGChBvvkgirPdEcsqI
         lAIRTjem9scNH4oYwFpSkKSH4s2GfDUKiUTfWtOM3VLmFLlrwSzOhXcNsZu2+4ELj1i0
         KNCYOMLvu2NxsiDaZkkhVW5/b9sGv8XPJgg96+RpbQtBRXEDcHW3fuDpn+nX6TxXRkjU
         h9KfVdC22Jg0COUXmbmJWnRUARCjwvJQSu2hCXLQH11p/yF5TAr8Lkf0YKHhKu7aBUa5
         v/2N3Zhg1yhTA39OynqZk9Ady3ixsTi5cNcQIlzmVcSwGbY9SKQFPQapB/QmiHLF4diC
         tegQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg0F/qZhz2BDc30YS19BHGcc47f7dh5MaJ1Oe0q7RnHDjdMdNeU9Q5r1PjalUUY79agr5cYRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzsAzstTG37PfUMMj5MiwwAqGjxiFFGg4Xm2azskBU3hdmyedR
	dpWuwroX6OJmQbi/AVhxT8b8sJkp99cg8BLJ8cNf+lgahX97v+C7gWpIXCz/Y30672s=
X-Gm-Gg: ATEYQzxdadVxkeJb1vi4OROXrNLZIjp/AEWGvr+bpllrNKN9FlkD7G80p1gzcLlBh2N
	BfDJh0xRZQLSRPxDa2cR3GaBqd40ZTwBGCPdIi/ns63lUPL2U0NVCTBjVmODKHJmbdKt786O4wk
	GZ4IGru/dOa7YikPzNU6Xz/6bVET4P8GkW8kAOJ5jZRGyfbNMgrJ72PSIzr3FTb1FmOlfOAURVE
	QDerHhQELfbDJ489AoY6De/i3p5bNpErx051ZFYHZFrPHQ7fLmv9V2NQparRTOiwZvjkH966hLT
	ij4bNrasQzsP15j488fPLl53AFSlg3uhyyIldOZSDEdstJMw3WcbxrZRJlkNGRoJn7XxZv+kqoG
	P/ztjOw5qnRzQf823AU8CQ2uleDIcN8aQbG/nyIz3g1Lm5Z5OrjjJnX2BW08jXwQZP2+TFPzbDJ
	ABr79aG5IOfO18aWYNvOqr6itKJL6WCtfb2zg1wy2HzfO3pCTpdedpPPXT67I3VA6WWQv+T4USA
	2sw/ixsktcxddIV
X-Received: by 2002:a05:600c:8707:b0:487:338:b4df with SMTP id 5b1f17b1804b1-4870338b5d9mr166015045e9.15.1774352316223;
        Tue, 24 Mar 2026 04:38:36 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:35 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 15:38:10 +0400
Subject: [PATCH v5 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-bq25792-v5-5-0a2eb58cf11d@flipper.net>
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
In-Reply-To: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=alchark@flipper.net;
 h=from:subject:message-id; bh=0GDlOYezmKEXCru71ex6Z77WQ5tS0GByeoQbXgUi37g=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl/7QnLhoeT0m79ifgX1brk/cd7ONeq7DRZmddc2t
 Px9d4nvYMdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ioY6xjxMDFKQBTfbWA4Q/PDdWI70vfPcuWmeP/5HqS3YPrLy5+XT3BXWdv5LpwxY2rGRmu+7m
 tLdlxpXbxwp4ZaX9eHGh8vlLFeaK2zxvGDL55309yAQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230144-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,flipper.net:dkim,flipper.net:email,flipper.net:mid]
X-Rspamd-Queue-Id: A89FE307709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The minimal system voltage (VSYSMIN) is meant to protect the battery from
dangerous over-discharge. When the device tree provides a value for the
minimum design voltage of the battery, the user should not be allowed to
set a lower VSYSMIN, as that would defeat the purpose of this protection.

Flip the clamping logic when setting VSYSMIN to ensure that battery design
voltage is respected.

Cc: stable@vger.kernel.org
Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 02c7d8b61e82..7ca4ae610902 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -128,9 +128,8 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
  * @vsys: voltage value to set in uV.
  *
  * This function takes a requested minimum system voltage value, clamps
- * it between the minimum supported value by the charger and a user
- * defined minimum system value, and then writes the value to the
- * appropriate register.
+ * it between the user defined minimum system value and the maximum supported
+ * value by the charger, and then writes the value to the appropriate register.
  *
  * Return: Returns 0 on success or error if an error occurs.
  */
@@ -139,7 +138,7 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
 	unsigned int reg;
 	int vsys_min = pdata->vsys_min;
 
-	vsys = clamp(vsys, BQ25703_MINVSYS_MIN_UV, vsys_min);
+	vsys = clamp(vsys, vsys_min, BQ25703_MINVSYS_MAX_UV);
 	reg = ((vsys - BQ25703_MINVSYS_MIN_UV) / BQ25703_MINVSYS_STEP_UV);
 	reg = FIELD_PREP(BQ25703_MINVSYS_MASK, reg);
 

-- 
2.52.0


