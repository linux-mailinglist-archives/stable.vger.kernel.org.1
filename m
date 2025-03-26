Return-Path: <stable+bounces-126703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16DBA7163D
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 13:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114A87A519C
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFCF1E1DE5;
	Wed, 26 Mar 2025 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7mlnSxa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44631E1DE0
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990885; cv=none; b=X8brUS5OXryY4rAcIXCxcHwt3O17mJdWzAIEZSWBsw94Cv57x0YwmJ/jywJJoZKSJIm1dNXueDqvO1prZf+6ZQZ2IH6JGhRqoNM23rcVwHLDMufyx5QlcP9zcd23jUR0jXrR9qTxq9iWuTEErK1tLYqBNsbQsItFtZTHPq+twWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990885; c=relaxed/simple;
	bh=jjnSTG3I90Mn5Ca9Xyv++q9P6Z4yvrzjERBIMNIYWYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DIiOL5XM2MDzPhcUn46YoSG+5UQ3C0l3VN8zVi4aPQFO+hAL0gDBq66hKma+1cnTDxk63R6RX7Sw9Cox7Z+/tnN1NgsesrzZx06UsTcVw3RgxRQ+Rd9VJBLVPnvCldNSfI3VuvGwDJTMjY08/VuyK6SZADFaluVBpCpPtuQi72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7mlnSxa; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaecf50578eso1217141966b.2
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742990882; x=1743595682; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EOvw4ltGt39X6cSYI+P/xxRhDM+qmj120OFm+7gNRo=;
        b=b7mlnSxacG68Yn+Zs3UdGrkbG3EXspdbFsoFxpILRuE109HxFjaaUvjlDsZAPvZpxL
         9yPtCF7AITdD3DEwz/V08f+7QVex/xwXrbN7mf5yIQRz2ILabI+EFPJ7ZXw+++XQpzVw
         x0j4jVH4jxQQH0JwvRNf+NBEwvPd/hmGVNKs7NAjrgPNgjiGFOQf/FLpIb2GBl6wwbru
         e+yEzpPdjaprSk8pYbGFAv84sAPlO1w3zplKw9RKD/UGQFoN6TtNWlEevvFBobitftDU
         WcYW/O7/kmT9qr52UQvHyc2ELtssW7XNZCBSWTbFWkTm8K+Kc8i53BBZjyDsNBiEzlcp
         g1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742990882; x=1743595682;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EOvw4ltGt39X6cSYI+P/xxRhDM+qmj120OFm+7gNRo=;
        b=mfHEa7KeZYj6eh2nK6B7RW8MECfiBmOjnpcoAwlEBRctUmGOQNwtqPnylmQQQ9TcZu
         B7pRMwv6m91TxQ8ljBsOg/TBBSLWFm1f6jm5VO9D8oE+Cs8DC477R2BMbD0MFFIWv98l
         Geh4IlO/uT23iokS979Krl04dlaIVNocFTG+XqdgRCp9h21ZvmVpmQnRYxLCcHpWCSR+
         LF79QpVD44bLnety+KXU42hM0giqnTLL3lo8H8a2D9pCsXfp530sL3kRD2SG1Cf1pZPm
         6CymYhMqN7iZqnMKWwX+LCAQVeK3pvEDnNSo9hbCuYutNE30GBMfvG9O1q3bSXb+7TwB
         kLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8AUD23dusBYCoKEiThf+2OGKe+65aB+lT4elaNdDsHq0Wj0M37vr3cGMSIoiQ7yBcrJR76mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/YjfCilBqQZZbyWSfYlre5C3mxbD9EKouGy1+mUag01BBKUl8
	oDSVNiUDdTnkk75Y0YUfHm5q29yx1HpXPsV43gC8uD790QV2KGIiSku8v+xSXpA=
X-Gm-Gg: ASbGncsuoETGJYBOAqQ32x3dbuK2QGiDYSSFwHC5bO8zI/NZ/vGxomxMAoGtk9lGpLK
	jal+4t2n7SbahRA9AnnHLdQizgLRljEF2x1cBUYyy4YTXR0CLVF8Uu0+Ycjqcm+rWJ+pzxkfXli
	b2hwpGJvN5JzvHsQL33YUQd67kpan2ZU0fxxLQHxo811MEG+NJEmfXlnNzmNsDgMf4PHADbAsN5
	cZkUj3cljWE3850qfUwsk1TiIx6ZPmHj+4om2qtm/pH3PIdX+kFV5gfwI3tjxZraw87j4h614ED
	opSLSZsqjJdCTPYXwW6KgoRnKoVdfqyf4QWNKTk7v/Msfroztj1WQMsiXUAoR3gpAfFO4y4o6+y
	cyBU7+IRu0xRt6Rz1UO4FP+8K+MfiO7wIC/ZdTYY=
X-Google-Smtp-Source: AGHT+IFpDQ47OkR0lnhRuhDWvB2zczsji7a4MYoKTE4Oj7Ls7vmFXhE9PL8k1vAEh0QTa7oPWlII7w==
X-Received: by 2002:a17:907:9694:b0:ac4:5ff:cef6 with SMTP id a640c23a62f3a-ac405ffd0f5mr1438770566b.31.1742990881985;
        Wed, 26 Mar 2025 05:08:01 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6ef561e4csm59334466b.119.2025.03.26.05.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:08:01 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Mar 2025 12:08:00 +0000
Subject: [PATCH] clk: s2mps11: initialise clk_hw_onecell_data::num before
 accessing ::hws[] in probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-s2mps11-ubsan-v1-1-fcc6fce5c8a9@linaro.org>
X-B4-Tracking: v=1; b=H4sIACDu42cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMz3WKj3IJiQ0Pd0qTixDzdZEsDS3OLVPOkZAMTJaCegqLUtMwKsHn
 RsbW1AHqshmBfAAAA
X-Change-ID: 20250326-s2mps11-ubsan-c90978e7bc04
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-hardening@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

With UBSAN enabled, we're getting the following trace:

    UBSAN: array-index-out-of-bounds in .../drivers/clk/clk-s2mps11.c:186:3
    index 0 is out of range for type 'struct clk_hw *[] __counted_by(num)' (aka 'struct clk_hw *[]')

This is because commit f316cdff8d67 ("clk: Annotate struct
clk_hw_onecell_data with __counted_by") annotated the hws member of
that struct with __counted_by, which informs the bounds sanitizer about
the number of elements in hws, so that it can warn when hws is accessed
out of bounds.

As noted in that change, the __counted_by member must be initialised
with the number of elements before the first array access happens,
otherwise there will be a warning from each access prior to the
initialisation because the number of elements is zero. This occurs in
s2mps11_clk_probe() due to ::num being assigned after ::hws access.

Move the assignment to satisfy the requirement of assign-before-access.

Cc: stable@vger.kernel.org
Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/clk-s2mps11.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 014db6386624071e173b5b940466301d2596400a..8ddf3a9a53dfd5bb52a05a3e02788a357ea77ad3 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -137,6 +137,8 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
+	clk_data->num = S2MPS11_CLKS_NUM;
+
 	switch (hwid) {
 	case S2MPS11X:
 		s2mps11_reg = S2MPS11_REG_RTC_CTRL;
@@ -186,7 +188,6 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 		clk_data->hws[i] = &s2mps11_clks[i].hw;
 	}
 
-	clk_data->num = S2MPS11_CLKS_NUM;
 	of_clk_add_hw_provider(s2mps11_clks->clk_np, of_clk_hw_onecell_get,
 			       clk_data);
 

---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250326-s2mps11-ubsan-c90978e7bc04

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


