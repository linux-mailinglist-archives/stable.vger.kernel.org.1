Return-Path: <stable+bounces-164324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F44B0E78A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E634C3B0222
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3517C91;
	Wed, 23 Jul 2025 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwCz/5SD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2D2E36FA
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230007; cv=none; b=MBAtiaATicoWliUGORInNs0HvzVTq38GDD8wY0EZI4venZQn1qp/xrKzxWAjRZYYOxrMJYa20QzHoAO2XLLXBjL+ofZpLEQwKKAgPgeVLEDE8MVxD3mJLwEmWlfnxRBwrLJA+X3Gr7pXyNffOcFBeU6wspvMpeQWoQMSiG/Xx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230007; c=relaxed/simple;
	bh=6V4mmWbRT/CCSb9qdWkSO953dqUcj762JnaME2zVetA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjyH/3nXjc2iMSvl6q/LbEgWkDOsyrqW4hznzi4+5PKhoePpz1tCg4TeN8f28nuZIa8hsvxxU9dL3bICvBX+PTbzzslUHUJNEmHJMm0UDNlFnxbpsMIW4M3tvHbN5YinNe+zh/cQaeq0vm0gZorHdwA85kizsSwiQ6/0iGblsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwCz/5SD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E601C4CEF7;
	Wed, 23 Jul 2025 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753230007;
	bh=6V4mmWbRT/CCSb9qdWkSO953dqUcj762JnaME2zVetA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwCz/5SDTkvxfr0XTDXqf0pTi9mFIk0mtaGjfyiu5qUuVqrAB547e43V0F/y+zni1
	 zYp2u4JHWfSJgjIxSyhJ7Qtrn39xKC/Wh/snvuw4hh+SkwREzKe/wRkLLjbI92nXv8
	 Nx3mtgVPh+BIFOkhDr7EtA641xVZk0xUB7jmOFML/qxKiYjvM+S0c6IJyiG0Q6siV2
	 3b3Qf1MITQ5mN0kqRdUbMcTvtIcROMsTdRsxiBsnc60NxusQ/TxtlTeDUtrER3RugG
	 4MRftDOju0C5+lhfh7RrYXq97m1cya9h3aO76jzw49f5JNjMcA7GEDnIJeM2s4UvSi
	 5/9nzwMrlGK0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] i2c: stm32f7: use dev_err_probe upon calls of devm_request_irq
Date: Tue, 22 Jul 2025 20:19:38 -0400
Message-Id: <20250723001942.1010722-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723001942.1010722-1-sashal@kernel.org>
References: <2025072104-bacteria-resend-dcff@gregkh>
 <20250723001942.1010722-1-sashal@kernel.org>
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
index 47b7dd0dbbab7..11dd6fe9c26c7 100644
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


