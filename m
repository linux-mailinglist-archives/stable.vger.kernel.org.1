Return-Path: <stable+bounces-59356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150EB931742
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 16:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FBA2836D6
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CAB18F2CE;
	Mon, 15 Jul 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nF3Yowwb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D018EFFB
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055588; cv=none; b=RMlwje2GyWBX55BFwu3+vVQe8lG87nt+wEJYa3CFdHudxMc6ywXxB6vNX+CoD5gKTkNa5TfhJOer4divmXSfttvmTnxM6ODCpyEG9/toXbenIpUuKngoGEBUZYwfS/AAcK3lKDRvmOzQC5Pvos9BBY8p5v5U0B2Q4h2LWGyyAQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055588; c=relaxed/simple;
	bh=rzHANoUqXG82QQNq7zWwsJk3/CBVzuayepJXbnfYmTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XbNBD7X3AAmY9wUQHIHZel8jG63YtphCHx2I9df0w34tyKiFI0Pc55YLzt50Qw5jA9kRlyUgKP6ImuDO1WO1G5YhXS/NzHJ2oFAzEPNWes3i/2npcZvgmrQGox9R2p0t/msCaJlm8HUNp214c3wh0R3BxEyi3NjOgnjnKke8JaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nF3Yowwb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36796aee597so2674843f8f.1
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721055584; x=1721660384; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C12lGQoC4O6dCA83BitIObz0vvscmP1VuajGEBqvvq0=;
        b=nF3YowwbFlQoo78IH2LtbW0vYNg/QcsJ1ZdwEFchlq9+Xt/0TScrbRIdT/b3vnoH3V
         toj10IQK0xVWqtalCLq6lBCTKSPp93Jn0KR0RyAY2BXCOzGjEjAmteUjEIyWXHUUCP9t
         lg3GqYBCf7mtwQEL5nfaIC3jL+4+BTb8vu5fEZUboHOeJNrnxjMAp5sAc/R6shxwQiGr
         DdecaQyxE3SjG4hdb1cgeTiSthePvvDsXec22nQ48IwQr4IcR/leQRmoCMZsCK8r2vnl
         it6rWDLYVtdbGtQ+Y3B9IK6TbjPviIK8v2n+sJYH6DliAUdrA8sW7xm2J3tiOAU9MuAR
         Irsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721055584; x=1721660384;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C12lGQoC4O6dCA83BitIObz0vvscmP1VuajGEBqvvq0=;
        b=PiOF6RUnzfveiB44z2DAc6v7ShY3wrLLMODuhDKB6mlQTLlJ/3xM+iKaN8LT4fh0N0
         Dbi2VzhdPjprkZzFcFmltGFCe+EocVPlPtBV4nRJmQA7FxN1hwwPrioBCymu86g7J846
         xqC8+5ISr+2Rnx8cKAo2vTtgO/hxR326bji0tVZoN3gztUIFFK60KYcMvxi0YDDDkEe9
         nwHxA58u3YeyzLwlb7Y0iFub2/uK/EHz92+ZjONEcjhvHDURG+9xCgBz//sMCPWgNQPz
         V7RbQIuVXB1pY/Cj2zgZ9xqj3nE8Uaid5R43HwoCaXQV9deq2nKQucSipKghS54fthG1
         XV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuRkW7TC62mIjpQLzO+iBKiclrgrxVfPmg4Ak3W+2dhWf+aZb+igVPhEUuT9nXsce+iB39il26ZmzBgWcImNK5sWgoF+jX
X-Gm-Message-State: AOJu0YwPihzVR3w5b0tZWKgwMb9HV0ko76QvruXD915SYFENaJZw78Se
	Sfm3Raryh1vQtFZg+tvRNspTzipKQV6ac7DVl/jX9Sy3Qltt24Yv4gRppZt0Pj4=
X-Google-Smtp-Source: AGHT+IE5W5I4LS+aadPJhSFJp7ycTKcKABcEYy6T4uVw5x69VrvDLqCqxJv/YubQ0h6t6A8Gr3Gw8A==
X-Received: by 2002:adf:ae59:0:b0:366:f994:33c with SMTP id ffacd0b85a97d-367ceacb515mr14464668f8f.56.1721055584197;
        Mon, 15 Jul 2024 07:59:44 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368155f7891sm4373260f8f.52.2024.07.15.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:59:43 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 15 Jul 2024 15:59:55 +0100
Subject: [PATCH] clk: qcom: camcc-sc8280xp: Remove always-on GDSC
 hard-coding
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-v1-1-fadb5d9445c1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGo5lWYC/x3M0QrCMAxA0V8ZeTbQZNVOf2X40MVMA1pHq1IY+
 /cVHw8X7gpFs2mBS7dC1p8Ve6cGOnQgj5juinZrBnbsXaAjPi19KyatH2SPLiD1WGTgwdUFJb5
 EcLaqBTn4mWjqz6co0HZL1n9ot/G6bTsVVZQKegAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: dmitry.baryshkov@linaro.org, quic_skakitap@quicinc.com, 
 stable@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-13183

We have both shared_ops for the Titan Top GDSC and a hard-coded always on
whack the register and forget about it in probe().

@static struct clk_branch camcc_gdsc_clk = {}

Only one representation of the Top GDSC is required. Use the CCF
representation not the hard-coded register write.

Fixes: ff93872a9c61 ("clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC")
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # Lenovo X13s
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/camcc-sc8280xp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sc8280xp.c b/drivers/clk/qcom/camcc-sc8280xp.c
index 479964f91608..f99cd968459c 100644
--- a/drivers/clk/qcom/camcc-sc8280xp.c
+++ b/drivers/clk/qcom/camcc-sc8280xp.c
@@ -3031,19 +3031,14 @@ static int camcc_sc8280xp_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&camcc_pll6, regmap, &camcc_pll6_config);
 	clk_lucid_pll_configure(&camcc_pll7, regmap, &camcc_pll7_config);
 
-	/* Keep some clocks always-on */
-	qcom_branch_set_clk_en(regmap, 0xc1e4); /* CAMCC_GDSC_CLK */
-
 	ret = qcom_cc_really_probe(&pdev->dev, &camcc_sc8280xp_desc, regmap);
 	if (ret)
-		goto err_disable;
+		goto err_put_rpm;
 
 	pm_runtime_put(&pdev->dev);
 
 	return 0;
 
-err_disable:
-	regmap_update_bits(regmap, 0xc1e4, BIT(0), 0);
 err_put_rpm:
 	pm_runtime_put_sync(&pdev->dev);
 

---
base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
change-id: 20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-274f11b396ac

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


