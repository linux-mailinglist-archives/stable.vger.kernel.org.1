Return-Path: <stable+bounces-94489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515F89D466C
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 05:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1861F2152F
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 04:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B02136671;
	Thu, 21 Nov 2024 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN/wpvuF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE82446A1
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732161640; cv=none; b=p1SNRDFYq+jKzwOnDg7ojWKGMFFb2/OqyxgC1WZCCkpQvc49Yg427+33ZCCpVSxoDkD5HyGaHUOAYrfzB6Q0nQ+lq0q2s5YqTAylg94tZeIpy2fpv49WwHk/Au5yZY7AhKQmNxcFkydz8tpRvhoh5YryBaFf8bOexlh135FVfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732161640; c=relaxed/simple;
	bh=5FQgbK9NwshJ0eD+ddM5dxlK3GwyuKgFzqQBjCn7Tv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLXD7K3/F/+MVw8c0XX6UaGmzQz/rRadED0fqfl6PIv2tTqgn3HVJqK9ZftNfMuBo5J9nEonN1tN5NOrrhTQeYme7X3q9oHQmBGFAz0IP0/4bbpo4bWxEA23QXy6I3L3VZ/tF3cSnB8yHkN6dW00a4qQf4SHlodpxk8RuaRTAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN/wpvuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F05FC4CECC;
	Thu, 21 Nov 2024 04:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732161638;
	bh=5FQgbK9NwshJ0eD+ddM5dxlK3GwyuKgFzqQBjCn7Tv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iN/wpvuF25f9nX9EfCP0122M7z9kFxjDbjuLK49Bb8U9Ud1IbzS4SXTxaLIb6jehM
	 DDqrKj9Iwg/Uw+IqlvMheLePqdTUj6xz7mN9DdIQ9zp4D0tcnb7szh1AMKpX6c6VHp
	 KPfcrVruB4khi0WMXJIIeZFiqwagmor0WJZqI1Ky2YHgispnhnC9I+/5tbXYIr9eVq
	 DLA09nmwtmhqm1rtjfRklG7/DUUXMV+Ogm+W0zqnxl822Et2fcP7t4DrOYJAHvUaiD
	 1hFJmrMSsLaPwg+/xGSCukc6Jkgj8cmzNoP2MHXX+a3BzSCQAPzZ8HezQcEytX+Tv/
	 Dr91lPhPY0nxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] i2c: lpi2c: Avoid calling clk_get_rate during transfer
Date: Wed, 20 Nov 2024 22:27:01 -0500
Message-ID: <20241120221943-de0fdb59652c360b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241121032751.3225795-1-bin.lan.cn@windriver.com>
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
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-20 22:14:04.767206166 -0500
+++ /tmp/tmp.dfA5216Jw0	2024-11-20 22:14:04.757393564 -0500
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
| stable/linux-6.6.y        |  Success    |  Success   |

