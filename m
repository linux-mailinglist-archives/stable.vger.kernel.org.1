Return-Path: <stable+bounces-165519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EADEB1621F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8801AA06B7
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF002C3252;
	Wed, 30 Jul 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzwEQBAw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619EE2D9491
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884009; cv=none; b=A+38J6xmsDhBG9O8x55ABZ2cyfMeXaOc43bzN7ETEvlDwY31ldqXTUqtxlVeDE5vTw6rz3uxZggTUODiOgpfx9lXbsBQzsE4DYQfOoG12YqEXZgvy8DT7Tud6f39/2s32V9a4gG7ZGHkqqB2YdDwPXh81yJf5OHOdspAnJfETEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884009; c=relaxed/simple;
	bh=HkS7aO3hh8AmjhlSgoDdixq1Rsr94iNHFZXkV4D6E7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsCfiHpxOvYJWFBwRDfzjVN4OryaVKnTlkuR07S43OuF2CSSs2dI8u0fx6f+8LIzdj5eiH4HonntSjzMxGPYcN+fGE+fYtI+BL9WTT9hzyT2l1ktq4uA8C6nFTTEgMyBhwfYf4JakIwn7kJKs2iCemziQDP4XOjZ3H8Cy8jNRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzwEQBAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2546BC4CEF7;
	Wed, 30 Jul 2025 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753884008;
	bh=HkS7aO3hh8AmjhlSgoDdixq1Rsr94iNHFZXkV4D6E7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzwEQBAwZv1j70fYUGxvaH9VpkA5aMWTGZCI5Bz+cU4c6DqlKEUrDk6NOlm+2R9cO
	 ra35Gv0gr9b0l29BGjVQ1uRg75sH+U9wuIYNdzUkSAwvQvthzO8S0a47x21sXbk8/E
	 BNQUqqyyHznPJn3xuhu7brXg5x7pec8jRJCtEZBsOMfQclhKg/sf1lUMd/HNJR0MtY
	 NgyWVNXXi0UACtljQMPHzXJ8689EQVaZZPbcU1rsxAZYJ9/F14sYqtp781v263BiBk
	 EObQaFBnPoP+PX/leVz7bWWGN9gBmWDTWXyE2Lq5jBh9Q0syFwYQEfG6A5fQ0THIXc
	 3Fg01LTsfxHnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y v2 2/5] i2c: stm32f7: use dev_err_probe upon calls of devm_request_irq
Date: Wed, 30 Jul 2025 09:59:59 -0400
Message-Id: <20250730140002.3814528-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730140002.3814528-1-sashal@kernel.org>
References: <2025072104-bacteria-resend-dcff@gregkh>
 <20250730140002.3814528-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit a51e224c2f42417e95a3e1a672ade221bcd006ba ]

Convert error handling upon calls of devm_request_irq functions during
the probe of the driver.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 6aae87fe7f18 ("i2c: stm32f7: unmap DMA mapped buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-stm32f7.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index cd9c6ffc2e61..cb9093b43be2 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -2198,19 +2198,13 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 					stm32f7_i2c_isr_event_thread,
 					IRQF_ONESHOT,
 					pdev->name, i2c_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq event %i\n",
-			irq_event);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request irq event\n");
 
 	ret = devm_request_irq(&pdev->dev, irq_error, stm32f7_i2c_isr_error, 0,
 			       pdev->name, i2c_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq error %i\n",
-			irq_error);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request irq error\n");
 
 	setup = of_device_get_match_data(&pdev->dev);
 	if (!setup) {
-- 
2.39.5


