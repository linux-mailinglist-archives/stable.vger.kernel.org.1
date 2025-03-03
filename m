Return-Path: <stable+bounces-120063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207FCA4C15D
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 14:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395B916E5D1
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 13:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEDC2116ED;
	Mon,  3 Mar 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pN4BIftL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0B21128D
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007488; cv=none; b=et6BlzSixtyQK5PfH3Tzl/DoEMTk3peO3P/G5fNEmSE88at2O04sm3y/FDWpRArCEiRO76o/xV2HwnbixmKKhb4fOduOFGitWcWKJdD7C4iWFMbAexvZ5tjkrqYQ8yHEhKwfG7QxwPNZFZCCF9cM5qYAgtm7Q8jHcj/GI9GNja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007488; c=relaxed/simple;
	bh=r0ACFUP8gmClzRtzoxXd/Ng22ZxFYgefb4nyAq8SEaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z641CvWww4bhJW8lZfaZHAWqmtkSseSFfFRulOFwHHOZpbHAeZgvCYy1PnLoMoBKtK194gyBmsnOi0qFvV2Jmh3ldWQWZerzPkxR4urCzcVMteUPHsU1NklI3Ax5AZfsN4eu7QDEaA3vSCT6yHr2X6KL2QckKLtb9x4tiXqrvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pN4BIftL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2287505f8f.3
        for <stable@vger.kernel.org>; Mon, 03 Mar 2025 05:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741007485; x=1741612285; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBkIEoZc6BXsEi/Xl/zpbl5kQzqAT2D5l+fVFL9X634=;
        b=pN4BIftLkHFRfR5AiJpuj19pHI5ut4jL33Ps2somyZnfde4kwsmxWa5EWjNccUAGsx
         Aa/vUiFbOV8VpatiTYUh6iIvB36u+gDT8D7B4CalZ9xcEcr4iBDut5N1lqsCfNCDB8Xi
         elv1Lg3eEJ9NUeVlmxFAwC7Tb1Tu9nk4GJmQb7t56JLL3/Y8EWqDzABdZ0OCDqMZn67i
         +BnauNVri/z/ZjPDFShIjaZv+2JNzM2XfKWG3u34waH04tR/tYKETBogDDYqOrLUr3e6
         xhp8k+jDkInJZbIgSm8PruesGfGGWBLDEwVJZE8ZKtaZJZxWOe459VwyTFlNbH/LdBEv
         UVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007485; x=1741612285;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBkIEoZc6BXsEi/Xl/zpbl5kQzqAT2D5l+fVFL9X634=;
        b=U3PNSwaYT7+cUB8oreCRnofvFxVU2EeddH7IKTh/LcSf7/Q+vLSJ+KG8plCvV5MeIw
         yBa0QUkZxue+JPk2P+trdWnZlDyAfhGcI2lqYn69aVzgrepsEeyKzFGjIVrT3lLSkfLj
         z2dZRZRduo8CBlWEiWUtc5sZDAlzXI/HQhFF6OOKreMxu3QNJeodYvPJc1npXdVTPZGf
         JldPTqWLeoyPWJR0s/T5CBJhHR1AkHXCnTugHO1JOpxswIYk1Z5V/TE5+tsSYw0Qq+Ma
         5csA2OQSG+V6cU2e3PlnF8tuNuNVqj/89TtCKeqLPxX2YLaCc9o40OhKzEWRlcunSaWD
         vveQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkrAH8LQMSVEHqW0S55HomyH3gXLuZWwzRB2b57UBEesVeojoAnzFphYuBLThxMi5iC3qWeTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fK/wnYMUOOzPUFKIPBMmjcLuh+qmq/EAPg7AJBoao5LlJ8ZX
	q4bhrM5DY8kOlD0uKDxSf4ZPH04rlL87FFH/zJH+hhnY2i+Hx6oWdt90a0tDM54=
X-Gm-Gg: ASbGnctWTxoZTAyeV4x8cw4zumM9MUr/gznY8H+EjCjIqwAQjaVApF16KeW2y3f+JlY
	4KerEnAQnBLHhgT7Sa+FxHjyZ986/3/7ddivEfjcV2qZ1YltwhIt7+j9EwwbGUIbFwCjsaSL8z6
	NYHL6WZxdDE1ftQXWkuQ+oRybY5WxdP7w5dBCQEq6SeqoWz4bNrzrC80pWF9+kSjwgQFEBCGOnh
	wNe6Bn48UdJIvssIleFm+Xu+Dho6rAAHy/aFxmCVbI/U4PdU8R0GHoZ5j2ZgBcUalo9TpXMpnXJ
	mjQreUwNP0WKcQESBd+mh4DlDFfKlsGkZ9RrJvIB9HJOAf6u3b6dQE3CAEYAO72MoquqZbQa0rk
	=
X-Google-Smtp-Source: AGHT+IFogfy4vTLX2D880m2Emlv1b0QxLptjPdeT4ir4OaH0lDrtdJ8Ijk5zG3y61SkNW3iZImJ9Gw==
X-Received: by 2002:a5d:5f96:0:b0:38d:e3e2:27e5 with SMTP id ffacd0b85a97d-390ec7ca98fmr10768345f8f.5.1741007484699;
        Mon, 03 Mar 2025 05:11:24 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703caesm158307785e9.12.2025.03.03.05.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:11:24 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 03 Mar 2025 13:11:21 +0000
Subject: [PATCH] clk: samsung: gs101: fix synchronous external abort in
 samsung_clk_save()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-clk-suspend-fix-v1-1-c2edaf66260f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHiqxWcC/x2MSQqAMAwAvyI5G+iCWvyKeJA2alCqNCiC9O8Wj
 zMw84JQYhLoqxcS3Sx8xAK6rsCvU1wIORQGo0yjrLLo9w3lkpNiwJkfdNo3obXOdGShVGeiov/
 jMOb8AUPfVtthAAAA
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=r0ACFUP8gmClzRtzoxXd/Ng22ZxFYgefb4nyAq8SEaU=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnxap7U2WN1YaRHw7W9uRbiu+2fenuf1A5eZ5Xs
 bFL73mvclGJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ8WqewAKCRDO6LjWAjRy
 urfgD/9/FuIh/ujTyKiv8Fzda0+kpo71fe+GrwZib/NQ3obhlvSc2WG2XGPhRQqKlMOt+DkEN5R
 pkLY3fshHXDFGhS39zEkhSA7qIaltThWozUvf38use4WQqs4eriaJxl2vWe4+s2/uztjluGDzsO
 3h4ya7IYa8MwskiloUzzctUj72lrg1OatkYUBxed0T8dky1XnyAMxKJhvDO0b7pleAuVzbEaY6J
 HOpd+dJS0SoZXlir3FNdpL1Tj9AO40Bi+GtLOYFu2qoBsIpAvgfZgsWkKgudL4fatx1TyChxbIU
 WciyJusPm8nN9ZhblpHBPvx1TZBYKTqgSJH4l49LreqaSvPkll4IiVBtYdiTii3WKT/VYKpEQLm
 eS1C0DH11KnPbQGXvk9hqQk/Hvnrwy/8H0By6KghKQZ1/KmpHEIEK3SzD9iYzK6ipbaMi53ihFx
 MQ5YkGLXWljT8CAnz8WiWR+kP5Rc0ePEgX1/AH9j28xALgYmvS1oLEefx2divEis2r1ubctopys
 xXiMu4ffHKQX/TM6zqkIFpeoXMvS+S/DjCpYVPeixRCu43QIBUO2/cSWIH8ArxA8OLg3vIZyTEe
 n5W+B9NFHjIOfmXhKKZnbNo61bf2pAIkXP7TZPPB6X2Moqeo50SGuhjSusHrW7SMp9zX4j8mjvL
 eagVef8tl5/9+hg==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

EARLY_WAKEUP_SW_TRIG_*_SET and EARLY_WAKEUP_SW_TRIG_*_CLEAR
registers are only writeable. Attempting to read these registers
during samsung_clk_save() causes a synchronous external abort.

Remove these 8 registers from cmu_top_clk_regs[] array so that
system suspend gets further.

Note: the code path can be exercised using the following command:
echo mem > /sys/power/state

Fixes: 2c597bb7d66a ("clk: samsung: clk-gs101: Add cmu_top, cmu_misc and cmu_apm support")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: stable@vger.kernel.org
---
Note: to hit this clock driver issue you also need the CPU hotplug
series otherwise system fails earlier offlining CPUs
Link: https://lore.kernel.org/linux-arm-kernel/20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-0-c72978f63713@linaro.org/T/
---
 drivers/clk/samsung/clk-gs101.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 86b39edba122..08b867ae3ed9 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -382,17 +382,9 @@ static const unsigned long cmu_top_clk_regs[] __initconst = {
 	EARLY_WAKEUP_DPU_DEST,
 	EARLY_WAKEUP_CSIS_DEST,
 	EARLY_WAKEUP_SW_TRIG_APM,
-	EARLY_WAKEUP_SW_TRIG_APM_SET,
-	EARLY_WAKEUP_SW_TRIG_APM_CLEAR,
 	EARLY_WAKEUP_SW_TRIG_CLUSTER0,
-	EARLY_WAKEUP_SW_TRIG_CLUSTER0_SET,
-	EARLY_WAKEUP_SW_TRIG_CLUSTER0_CLEAR,
 	EARLY_WAKEUP_SW_TRIG_DPU,
-	EARLY_WAKEUP_SW_TRIG_DPU_SET,
-	EARLY_WAKEUP_SW_TRIG_DPU_CLEAR,
 	EARLY_WAKEUP_SW_TRIG_CSIS,
-	EARLY_WAKEUP_SW_TRIG_CSIS_SET,
-	EARLY_WAKEUP_SW_TRIG_CSIS_CLEAR,
 	CLK_CON_MUX_MUX_CLKCMU_BO_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_BUS0_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_BUS1_BUS,

---
base-commit: 480112512bd6e770fa1902d01173731d02377705
change-id: 20250303-clk-suspend-fix-81c5d63827e3

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


