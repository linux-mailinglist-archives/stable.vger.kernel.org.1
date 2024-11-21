Return-Path: <stable+bounces-94488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7479D466A
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 05:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F441F22734
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 04:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A313BACC;
	Thu, 21 Nov 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/MljClQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98A78C9C
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732161634; cv=none; b=Mgf3yIgR4OUnM1ppP+7GgsEaQwrF+V5n4ia0KJ7oBWfwBJja4mArgzFHxkrG6wvH1QKxf/EEODT9GRZUy6AugqU+jBQ5wFXc3vkkBeLSx8+8y1dReSEAkUHCcI6y3L+dg3PemRwvbr4kWcqIkkdV98Z+EZlTXG8gvfFCPKUfMjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732161634; c=relaxed/simple;
	bh=J20lVkWioZAE+nAlBTN5B7wP5upJvuRcMEHFreqwjZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkKd5Dw9jS5RUdhFIAGQYfT7ljzVbgK9uhxR17tGb1ccxD4ykPYpmjHvzVw9Zpne3LV1BDbY+ewK7srXkG9woU10coxLC6wzgK3eWNy2JPB0JDGZhnU0fn9doQPxUSpicQGFp18qYKq3/bhF/YCFw97+EPGQzayPW/0i7NfzDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/MljClQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B937C4CECC;
	Thu, 21 Nov 2024 04:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732161633;
	bh=J20lVkWioZAE+nAlBTN5B7wP5upJvuRcMEHFreqwjZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/MljClQIu1GHwAQ6ldwRp0oU1//7PsnBSUJ8jeDvSAjoorIDcs+uVcLl1skaadJt
	 YmYLbzuNffNYli+lwgN5H8+3RA+L09MixO7G4mW2S8ic362iWIqLI43Ho4R1sx4U91
	 ndc8N5ObR5EsyGE9E8UNX2TpDqbsvafm/3fmGsir/BSYFMwS43Ah/r9qdvFAlctjJ5
	 coo7gWsfpRdCmoef6i0DTn8dmlANomAzJ8GzC4VhvQm1XyUpKnpIiD4HgZ8z475kmO
	 WVyWELRgRoezV9UuSt7Ry1PwG3rtW7nXm+uIUL4+oKZ82M5JKoNQZs3G1RTO1xMnKK
	 LlKTmzbuyxakw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] i2c: lpi2c: Avoid calling clk_get_rate during transfer
Date: Wed, 20 Nov 2024 22:26:57 -0500
Message-ID: <20241120222607-5c2e675390173b75@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241121031715.3223129-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 4268254a39484fc11ba991ae148bacbe75d9cc0a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Alexander Stein <alexander.stein@ew.tq-group.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-20 22:19:46.512390713 -0500
+++ /tmp/tmp.iHtz9hU7o1	2024-11-20 22:19:46.508471414 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 4268254a39484fc11ba991ae148bacbe75d9cc0a ]
+
 Instead of repeatedly calling clk_get_rate for each transfer, lock
 the clock rate and cache the value.
 A deadlock has been observed while adding tlv320aic32x4 audio codec to
@@ -9,12 +11,14 @@
 Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
 Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
+[ Resolve minor conflicts to fix CVE-2024-40965 ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- drivers/i2c/busses/i2c-imx-lpi2c.c | 19 ++++++++++++++++---
- 1 file changed, 16 insertions(+), 3 deletions(-)
+ drivers/i2c/busses/i2c-imx-lpi2c.c | 10 +++++++---
+ 1 file changed, 7 insertions(+), 3 deletions(-)
 
 diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
-index 6d72e4e126dde..36e8f6196a87b 100644
+index 678b30e90492..5d4f04a3c6d3 100644
 --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
 +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
 @@ -99,6 +99,7 @@ struct lpi2c_imx_struct {
@@ -25,7 +29,7 @@
  	unsigned int		msglen;
  	unsigned int		delivered;
  	unsigned int		block_data;
-@@ -212,9 +213,7 @@ static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
+@@ -207,9 +208,7 @@ static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
  
  	lpi2c_imx_set_mode(lpi2c_imx);
  
@@ -36,19 +40,10 @@
  
  	if (lpi2c_imx->mode == HS || lpi2c_imx->mode == ULTRA_FAST)
  		filt = 0;
-@@ -611,6 +610,20 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
+@@ -590,6 +589,11 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
  	if (ret)
  		return ret;
  
-+	/*
-+	 * Lock the parent clock rate to avoid getting parent clock upon
-+	 * each transfer
-+	 */
-+	ret = devm_clk_rate_exclusive_get(&pdev->dev, lpi2c_imx->clks[0].clk);
-+	if (ret)
-+		return dev_err_probe(&pdev->dev, ret,
-+				     "can't lock I2C peripheral clock rate\n");
-+
 +	lpi2c_imx->rate_per = clk_get_rate(lpi2c_imx->clks[0].clk);
 +	if (!lpi2c_imx->rate_per)
 +		return dev_err_probe(&pdev->dev, -EINVAL,
@@ -57,3 +52,6 @@
  	pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
  	pm_runtime_use_autosuspend(&pdev->dev);
  	pm_runtime_get_noresume(&pdev->dev);
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.11.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

