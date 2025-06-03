Return-Path: <stable+bounces-150725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA95ACCA6E
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F42C3A49B6
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A4A23C8A8;
	Tue,  3 Jun 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P273XMMX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7323C513
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965406; cv=none; b=ZWtp+5CNpPs5m6pY3XydU9I5yQ29qAPX3p6CMHUVCXP9T92zJVfLEG6Ktlf3qYXi+7qXaf2La19E6ylqj8gsrU092xtNDKXRl0NdSlhiSUeSGi9oKr4HOCpgeHXtqGbN9rkeGq7Ql9Hx+9RBKy+TI/+/tTA9VMnAaM6Rrt7D0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965406; c=relaxed/simple;
	bh=0/e960cM7qU9YBT+WAzc6pA7trJpgvnwKErk9+qJgkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNDFlE+gUsoT0TlQNyxZlO8miWyJ7aBbi7cjr9pnNPlSfBWjxio+PNFo/DTyuKtpIy+rL4/ubhtooeEc5vyeotutV7D2UOMWBdQV2i2xuh8RXECrWusemtGwGZwEIbnWF0K8Hj13rGYOKEgOpTfplVKYxklqP/C45SAbml1CLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P273XMMX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad51ba0af48so1196953466b.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748965402; x=1749570202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyDAynqsG9jh+cOOc7N5aPAGPcSiqWcSOwtimCSGBpI=;
        b=P273XMMXui2BrL1K6VjKCIGVjjh6KLBxKfhhkLbaZp/N1uNeBoV1jOmiHj2gNVDAgA
         hUofkBnL1GFtogzuwpl0tCI2x3RVOIi7Y//DUPfsrWbaeC/Fhs9mnC7RPTM274NKwn/3
         k/s5I0sdIG35osdAbJmw0oSDeKblNv1CtUyshgihH7qs+q83YxyMbLLCKpWI/81IyCNC
         jQiW4diZ3US7nFyrf8rYGZwBKBaMoUrNQ0l3NlcXp9NAV+zL8OHxfvZ0UM5fKfDbi1zL
         raC0E8jusvu5/asvSPPyQJlNyp+JlnBiVpmL3NPxm58oemcTtxttS7K9f74W4viYdLFC
         hiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965402; x=1749570202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyDAynqsG9jh+cOOc7N5aPAGPcSiqWcSOwtimCSGBpI=;
        b=PRE80ikLYyqysvywHKxifxhzJ36wnjPJp05KYdNqWWMUWJBXrQM9mSOt/6zVljK3HK
         Mi/r7LalGrkbM3bg70TNU9IbhpGU3Zu0nGm76E1gkIoy0OBlw50bu78LK3j+c3aYtcT2
         nMo1eB8MmarAvwmDfyvqJw6YLsYXm4D637/X0PCIzDM1pgDUrrN7X+/TI3ITWNvU9tUx
         KJYheHe/7pYUfBil4GBjI/WqOY7uYUm4kdxrLLtjnXCDLNP5nhV70+ki7IBKoL8MoA0p
         NWTB3GokoRhyxrZFJqRMebnUAOlg78vyuzHcF9pd8LQMHaQNrJANe1Dc9intSeKZcofx
         x+uw==
X-Forwarded-Encrypted: i=1; AJvYcCWrW3dV3/SClmNuwwijv9xH6cSoAxdHXxT7Y0cXhKahtU2UhnlCXF1/fl8hT6+zg9VLESYUohk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVLW3coKW9KZAHWv//nVgyWZNRAX+ZZk6xw6Hgs00PMIDLvzG
	1B1DWfG79xiQGAxBSRjZoKF+AAXFdzh1swN3bNe30Lqa8XRI7SjYVYrC+ByyPdoVpxA=
X-Gm-Gg: ASbGncsI4wXc5QA7OErutTsbKG3K/hZcq3wpbexTxaRp4q8TVB2qeLeoY4ZBhdktywM
	rUXwT3ydZGZJxvcWMLXCOME8+XmJmqYz9I0wKA/y3M0GxjXjzraETy0VcNmQtPzxUSJQbJYb1tg
	wEPP1Vewlanw4r1vO/4UKiU7CpWUMFcOU/7Buj+jM4wvZEf7pMzegB/uhcd5yokms6ewYiWNYyr
	1szmh3arKsOaGayze0AjG+QY1uTdRUDVZCDi8dY8eSLpVrVHeZ8yjeHU0UZHTSQ3GSQ9C/kw8pc
	ts+jDu07Fujo8nRCeMJAzMSjhBhshNCTgjldabv8D++ESFxLQhZ/Zu4BwRaufDU7voXg04J/WGf
	6yEGWiCh17LTAreJjwZxSy4EEi2VQcYUAlTA=
X-Google-Smtp-Source: AGHT+IHaS+y52wFsPfn/BGos8YaLrH6Wz7Z3gAJ7jHqi4eOsbjUUHHFwYuM6LlBkTlFWjROGBuJiGw==
X-Received: by 2002:a17:906:f5a3:b0:ad8:959c:c567 with SMTP id a640c23a62f3a-adde66652d6mr315927366b.10.1748965402049;
        Tue, 03 Jun 2025 08:43:22 -0700 (PDT)
Received: from puffmais.c.googlers.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82de9bsm959277166b.47.2025.06.03.08.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:43:21 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Jun 2025 16:43:20 +0100
Subject: [PATCH 2/3] clk: samsung: gs101: fix alternate mout_hsi0_usb20_ref
 parent clock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250603-samsung-clk-fixes-v1-2-49daf1ff4592@linaro.org>
References: <20250603-samsung-clk-fixes-v1-0-49daf1ff4592@linaro.org>
In-Reply-To: <20250603-samsung-clk-fixes-v1-0-49daf1ff4592@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

The alternate parent clock for this mux is mout_pll_usb, not the pll
itself.

Fixes: 1891e4d48755 ("clk: samsung: gs101: add support for cmu_hsi0")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 12ee416375ef31deed5f45ea6aaec05fde260dc5..70b26db9b95ad0b376d23f637c7683fbc8c8c600 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -2129,7 +2129,7 @@ PNAME(mout_hsi0_usbdpdbg_user_p)	= { "oscclk",
 					    "dout_cmu_hsi0_usbdpdbg" };
 PNAME(mout_hsi0_bus_p)			= { "mout_hsi0_bus_user",
 					    "mout_hsi0_alt_user" };
-PNAME(mout_hsi0_usb20_ref_p)		= { "fout_usb_pll",
+PNAME(mout_hsi0_usb20_ref_p)		= { "mout_pll_usb",
 					    "mout_hsi0_tcxo_user" };
 PNAME(mout_hsi0_usb31drd_p)		= { "fout_usb_pll",
 					    "mout_hsi0_usb31drd_user",

-- 
2.49.0.1204.g71687c7c1d-goog


