Return-Path: <stable+bounces-164323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE61B0E789
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805673AFCE4
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFCE156CA;
	Wed, 23 Jul 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZucBmosW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7872E36FA
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230006; cv=none; b=SAKhnrEUKTUSlM+Gks6p/Hm0a9Eoz96zc6Nmh9NwXIVjCgkfcHr92VZ86Pv8bozV7nFobjq45KOK+vc9G51oSEqCAxRjBj0SQKiFESbtu4Yd0rP7wkJt4DxcOwNuLU68rDATE6q75PxOl3c8w67HlIPeJbkMIT9crIi+IcYsUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230006; c=relaxed/simple;
	bh=Blj+L6Tbr25f5hfZlFi1HJzZO3citsHJiHDZXZlobIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tuwzLLbmQPdKYK+lkI5oTLMMR5WS0Ijs5upDgsN3h+ZPVexZW8DXxRMs0OND7TEAcqAiWdi5ADv172ypWsPlF4L/w6VBv5sq4PfwbF+VAbmxtBpsMSQ/F6pGsW4EF7jnN87hmTtjmswdbVxBKkebhnp8m7p/Dqo6ZO/pOgTvF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZucBmosW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630D7C4CEEB;
	Wed, 23 Jul 2025 00:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753230005;
	bh=Blj+L6Tbr25f5hfZlFi1HJzZO3citsHJiHDZXZlobIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZucBmosW+F/hl64ulUpsxy/5H5i+qVxiMYNYj4agfvgMZ0kZfTfmzMEJXvpI+3jME
	 yZIf9w2rcrBMRcrTXV73zEKforGUSEbkhjYVLhnIEh15GlmK+e8GBRSXmLWKHLhMav
	 TZkU8K/wh2LrlVTkr2b60l4CfxHfH8n5ZGFVa2JuJ7SFm7QC9b/SXbXVPN3c1s0WEm
	 GnsCi5nlj7yAk6kOlDcXr8Buw3uKpUDeEV7u+j92nGqdTTmVSwcJQkXS288bOfYo3/
	 +LBUpHrqxtPSMJYN8AnsTjphC7rTL+9Vjif+gWefbEfbhl64rEGQj/SFv+JT9uaMuv
	 3X4nUSuIHD4uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/6] i2c: stm32f7: Use devm_clk_get_enabled()
Date: Tue, 22 Jul 2025 20:19:37 -0400
Message-Id: <20250723001942.1010722-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072104-bacteria-resend-dcff@gregkh>
References: <2025072104-bacteria-resend-dcff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andi Shyti <andi.shyti@kernel.org>

[ Upstream commit 7ba2b17a87466e1410ae0ccc94d8eb381de177c2 ]

Replace the pair of functions, devm_clk_get() and
clk_prepare_enable(), with a single function
devm_clk_get_enabled().

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 6aae87fe7f18 ("i2c: stm32f7: unmap DMA mapped buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-stm32f7.c | 37 +++++++++++---------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index b4f10ff31102b..47b7dd0dbbab7 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -2177,23 +2177,16 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	i2c_dev->wakeup_src = of_property_read_bool(pdev->dev.of_node,
 						    "wakeup-source");
 
-	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
+	i2c_dev->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(i2c_dev->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2c_dev->clk),
-				     "Failed to get controller clock\n");
-
-	ret = clk_prepare_enable(i2c_dev->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to prepare_enable clock\n");
-		return ret;
-	}
+				     "Failed to enable controller clock\n");
 
 	rst = devm_reset_control_get(&pdev->dev, NULL);
-	if (IS_ERR(rst)) {
-		ret = dev_err_probe(&pdev->dev, PTR_ERR(rst),
-				    "Error: Missing reset ctrl\n");
-		goto clk_free;
-	}
+	if (IS_ERR(rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
+				     "Error: Missing reset ctrl\n");
+
 	reset_control_assert(rst);
 	udelay(2);
 	reset_control_deassert(rst);
@@ -2208,7 +2201,7 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq event %i\n",
 			irq_event);
-		goto clk_free;
+		return ret;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq_error, stm32f7_i2c_isr_error, 0,
@@ -2216,29 +2209,28 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq error %i\n",
 			irq_error);
-		goto clk_free;
+		return ret;
 	}
 
 	setup = of_device_get_match_data(&pdev->dev);
 	if (!setup) {
 		dev_err(&pdev->dev, "Can't get device data\n");
-		ret = -ENODEV;
-		goto clk_free;
+		return -ENODEV;
 	}
 	i2c_dev->setup = *setup;
 
 	ret = stm32f7_i2c_setup_timing(i2c_dev, &i2c_dev->setup);
 	if (ret)
-		goto clk_free;
+		return ret;
 
 	/* Setup Fast mode plus if necessary */
 	if (i2c_dev->bus_rate > I2C_MAX_FAST_MODE_FREQ) {
 		ret = stm32f7_i2c_setup_fm_plus_bits(pdev, i2c_dev);
 		if (ret)
-			goto clk_free;
+			return ret;
 		ret = stm32f7_i2c_write_fm_plus_bits(i2c_dev, true);
 		if (ret)
-			goto clk_free;
+			return ret;
 	}
 
 	adap = &i2c_dev->adap;
@@ -2349,9 +2341,6 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 fmp_clear:
 	stm32f7_i2c_write_fm_plus_bits(i2c_dev, false);
 
-clk_free:
-	clk_disable_unprepare(i2c_dev->clk);
-
 	return ret;
 }
 
@@ -2385,8 +2374,6 @@ static void stm32f7_i2c_remove(struct platform_device *pdev)
 	}
 
 	stm32f7_i2c_write_fm_plus_bits(i2c_dev, false);
-
-	clk_disable_unprepare(i2c_dev->clk);
 }
 
 static int __maybe_unused stm32f7_i2c_runtime_suspend(struct device *dev)
-- 
2.39.5


