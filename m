Return-Path: <stable+bounces-90397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CA9BE816
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290D12826A9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC11C1DF73E;
	Wed,  6 Nov 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XCXyHLMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810B1DF721;
	Wed,  6 Nov 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895650; cv=none; b=bg8UU0axU3RVwiaR2X0Zbl5eph2e/BN+ZJVS+6gUpGupntp9z91iM5doCmXuTnybwu069PRd2/hZOIyO2iE3WbFKLJt9G8CGkT/hFWUftFsOd33IZVVLsY3mK255aKzYo0JokaGpTwGyQtN2eos3vr7L4xGiRdeEZKjzflp+gdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895650; c=relaxed/simple;
	bh=v5F+563hjCvszJjSX5bsTAgP+sSoJIr1Yze9zURPAJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCDxh6z3vDiQlIXuXen9Hl+tnX+JlvNvV8Cj2/Jd3NNU2qMcBDXFXhPhUSbn9JhvDfclzwSGcX4P8s5j+RMC7MY/EubGRj5IOCOxVP38jfQo/iINYt5O9yhErwi40acnNtMS1eK2hFt5qHD4A/lRovglMcPP6OYkC/7mvaZLISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XCXyHLMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBFCC4CECD;
	Wed,  6 Nov 2024 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895650;
	bh=v5F+563hjCvszJjSX5bsTAgP+sSoJIr1Yze9zURPAJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCXyHLMrcQg0xxKxjBwH8qvqqjhRgPhSYgRmtWPNryiAuNF4Cfjy5x1cKxIsxObH8
	 x8E4HVYTkCr4xGCWcdT5AnyOP/lAncBV7wzI/W4I2sum9wvW4Q/a8SBD/0k0EID4qv
	 3LQSUAx0wEIDIcvaXUNrS9maHBeOBLyIRWZWX2kw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 253/350] gpio: aspeed: Add the flush write to ensure the write complete.
Date: Wed,  6 Nov 2024 13:03:01 +0100
Message-ID: <20241106120327.164205041@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Billy Tsai <billy_tsai@aspeedtech.com>

[ Upstream commit 1bb5a99e1f3fd27accb804aa0443a789161f843c ]

Performing a dummy read ensures that the register write operation is fully
completed, mitigating any potential bus delays that could otherwise impact
the frequency of bitbang usage. E.g., if the JTAG application uses GPIO to
control the JTAG pins (TCK, TMS, TDI, TDO, and TRST), and the application
sets the TCK clock to 1 MHz, the GPIO's high/low transitions will rely on
a delay function to ensure the clock frequency does not exceed 1 MHz.
However, this can lead to rapid toggling of the GPIO because the write
operation is POSTed and does not wait for a bus acknowledgment.

Fixes: 361b79119a4b ("gpio: Add Aspeed driver")
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Link: https://lore.kernel.org/r/20241008081450.1490955-2-billy_tsai@aspeedtech.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index ba1cd971d50b6..5cc80678ac352 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -407,6 +407,8 @@ static void __aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
 	gpio->dcache[GPIO_BANK(offset)] = reg;
 
 	iowrite32(reg, addr);
+	/* Flush write */
+	ioread32(addr);
 }
 
 static void aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
-- 
2.43.0




