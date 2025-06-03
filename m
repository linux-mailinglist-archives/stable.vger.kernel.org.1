Return-Path: <stable+bounces-150726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF31ACCA70
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FCA7A23C4
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB923ED74;
	Tue,  3 Jun 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxutIJ/d"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75B23C8A0
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965407; cv=none; b=U/PkJoZ6QHVF0CNg08QG+lO20UDA22ktoFvYLmrCRNuMEKw/AEdIZdkwXJLWWOP3p/gR3hPK8HMnCw+lr7iWJYe3+I0qwUdGYOqaChZ0gFMXzaT9ogHXvcKxeSTgb5BmTtSjC+vUtBI9CPfn3RoVIvdn0SHETI0W6oXaQrL2h4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965407; c=relaxed/simple;
	bh=EkPTYV1qpD5I8FZtfNjsSjTt+gP3LGJ+qju8+Sz9SVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIjFHgINECyGwQs+LZVeKd35rUb6e9OhI+PNXEMO/pDzPxMmPjSseYEApwhPqbC67mUfZYyc67lOL5PSTELivJPj0Sfxie3mliYDK6FvzJYQ+CEZb0SX1t8v+sJmwtjGEoXgDq03mVPZ2QlnsswAV5SUN0W3kl20zxxZf//95Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BxutIJ/d; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adb2bb25105so922936566b.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748965403; x=1749570203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIaiXwYKVn8R6QIWY00MiAnh81IbvOV/xhrE7RJnhkc=;
        b=BxutIJ/dVVDkhqTn+rJvrPb7YRQGvrzcANNN2JEvBYp4hUy0g9iZUXtuYKAgKeU0hb
         hq/jB6ehs+43rPfuWyv8aBOEtaUc83xRYBmYjAYjjElXC0s9PJx6PKWDvfgir7W12cEr
         8YxxBrcPIn9pWBb70sPeC5iw6VLEBUuwY+u4i46Z8bLWiCziydrlMQqalyL6N6E8a/By
         B/Fzk9iPHtpZIf2N8+K7q/WNZtDq6eZLGGRa1lV5HQ482Oq2Ix6a+nnTZTB3FsjGrei2
         oV+qhtAPDgyj4/oaTQbQdEK4DYP/KRjVjBz6sH7oGJvgO+yaNvanYQQXxP/elG9xj6ta
         gSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965403; x=1749570203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIaiXwYKVn8R6QIWY00MiAnh81IbvOV/xhrE7RJnhkc=;
        b=MY7pBAo5sFJVDAkDbIE/fOpr5TEux+2Rp+DwAbGH2HPiWFI6B+dETSv+XokNmlxAVC
         y+qAqdb0x3Z5iJAdi+gE9lrNLYZjoBoo/uTXeaJ20hqWZv5q+T2ZIqlAp1M5HXrPqNbo
         avztD963hoaCin51ABcQQcOMd8Et6o6yZTuvDwBsJ5AUGwcV/+67LZIyJWzzR51rOFSF
         qUjc8v2n6RSkLwSqPUlejU8Bfjsc5LsMiAn8dlSgBtztKj0kfEmIuKKcsEZeoxK/s208
         rte76tmVIBj6++CcuoG5Mwsda27BQRISYKKFT1zYSTZ6Xv24+082gBingZ2eP36NeFGr
         rdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJfRd4odZywYjU8SV9ZecwAOJoPdXol96AdxIn2j2nKgRt7F/Gtl6jEuTAMOv0tjJA7Hn60eY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ttp3lz7CYW/XYOrqHSdP9hMok5T+uUh3UMeC0qk9f63fsRhE
	MCV5TUBBcJ+HRikIphTXCWr8EzxHvz8H4iglSjjDhxVTgfntyjBc/jBuiSRTzOtmVzM=
X-Gm-Gg: ASbGnctCVkbDFZ3e0AEXgdokSJ8VMpz6Rr/FhCMLFz61yPH3PX670jrlpVDKMfQ8dGg
	Pt59fJ2fO9t+KOHh83M7k8p98uwa/0TfDaGbXw2HIndBCOnO+9K/j6mJ1p+5KJZvIsmjT3nbdxN
	PVvELV/0bxNs045RNhtmPkz8U3iXMSS2FxkA+qb9f+5VcvvNGLw+YBJif161ONjW+A5h/UZgLH0
	U2ZCf0zkNzvzcxqrfS70k9rahJPm3MJ4EHb82aLIQEvM5W+zPX7suEwUIBVIfOOTGOGWCv/QJ4z
	1n67fIjUV4kzE3CU+HHNUwbZNOMuCZJLP/2noNM4BsiX/73RxQNnu/WTHSgB1aZyssUGxiZxuZD
	DdMBs5lUjA/ib50g0DDrO8bFOOz1lrOUcIK0=
X-Google-Smtp-Source: AGHT+IHuYQHqV4Udvsmxd2a4zxZaKbBte+8oMefdUwG0LYe9b8Y64CtnGXRSZ5iS6KwNcCvJD1IEPw==
X-Received: by 2002:a17:907:db03:b0:ad2:28be:9a16 with SMTP id a640c23a62f3a-adb36c117ffmr1500580166b.51.1748965402578;
        Tue, 03 Jun 2025 08:43:22 -0700 (PDT)
Received: from puffmais.c.googlers.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82de9bsm959277166b.47.2025.06.03.08.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:43:22 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Jun 2025 16:43:21 +0100
Subject: [PATCH 3/3] clk: samsung: exynos850: fix a comment
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250603-samsung-clk-fixes-v1-3-49daf1ff4592@linaro.org>
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

The code below the updated comment is for CMU_CPUCL1, not CMU_CPUCL0.

Fixes: dedf87341ad6 ("clk: samsung: exynos850: Add CMU_CPUCL0 and CMU_CPUCL1")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index cf7e08cca78e04e496703b565881bf64dcf979c8..56f27697c76b13276831b151db28074387293077 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -1360,7 +1360,7 @@ static const unsigned long cpucl1_clk_regs[] __initconst = {
 	CLK_CON_GAT_GATE_CLK_CPUCL1_CPU,
 };
 
-/* List of parent clocks for Muxes in CMU_CPUCL0 */
+/* List of parent clocks for Muxes in CMU_CPUCL1 */
 PNAME(mout_pll_cpucl1_p)		 = { "oscclk", "fout_cpucl1_pll" };
 PNAME(mout_cpucl1_switch_user_p)	 = { "oscclk", "dout_cpucl1_switch" };
 PNAME(mout_cpucl1_dbg_user_p)		 = { "oscclk", "dout_cpucl1_dbg" };

-- 
2.49.0.1204.g71687c7c1d-goog


