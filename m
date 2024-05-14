Return-Path: <stable+bounces-44076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2355F8C511D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690011F21E8F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8CF12DD9F;
	Tue, 14 May 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GmrANcii"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487004F60D;
	Tue, 14 May 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684076; cv=none; b=gq4mBBifju8LfIPC4a7ZpDGb44xjebuqtgIj/HU7E+Pu73YyXCtBQM5sfHEkuTdgkktXdvOX6SjlYDp2yWLKRLQ47/S2eUndOt4iBJxKoxcRdmxHsXHESc2bAo0s61fsuVjpgZf4M+AjgIwSlvWa65eJdlJy5Os38fttpUeBWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684076; c=relaxed/simple;
	bh=Xb9nRJSjtngjcr9/aNyEhAwiMUTWJrpos07yBdfBpBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRkCzTCWYDKYx4ETKEYUzL5S7kUwiwcRKfxzpCsqmMhPNhnaRmGrD0UEk5mkntJTZ3EyNshnNS7H8jSAOcpgG2dzhg5lzQp/RGYVNcp9oKe8JVIk4AMjV62SF3cy8ucb2Kr51eCvRP8DD9mMZ6oLXKlsiI0cuc508DpBMMFrm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GmrANcii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EF0C32786;
	Tue, 14 May 2024 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684075;
	bh=Xb9nRJSjtngjcr9/aNyEhAwiMUTWJrpos07yBdfBpBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GmrANciiZlYuPmR+ZJhqAqRkLi5qwY3FUpw/SQn5fEfxKPt9YWtlXxLmkGRWK/vT/
	 nNnVUoIsvGXdJhcd2EYQhoA2u3MV/8v/8Twrq905CMraWczaXzLLeQrPbrNvN1KV9l
	 w+ACSGXaOW1ah8EOm69Eg4qF8JtGWf2GF8ZWe4II=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.8 321/336] spi: microchip-core-qspi: fix setting spi bus clock rate
Date: Tue, 14 May 2024 12:18:45 +0200
Message-ID: <20240514101050.742198778@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conor Dooley <conor.dooley@microchip.com>

commit ef13561d2b163ac0ae6befa53bca58a26dc3320b upstream.

Before ORing the new clock rate with the control register value read
from the hardware, the existing clock rate needs to be masked off as
otherwise the existing value will interfere with the new one.

CC: stable@vger.kernel.org
Fixes: 8596124c4c1b ("spi: microchip-core-qspi: Add support for microchip fpga qspi controllers")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/20240508-fox-unpiloted-b97e1535627b@spud
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-microchip-core-qspi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -283,6 +283,7 @@ static int mchp_coreqspi_setup_clock(str
 	}
 
 	control = readl_relaxed(qspi->regs + REG_CONTROL);
+	control &= ~CONTROL_CLKRATE_MASK;
 	control |= baud_rate_val << CONTROL_CLKRATE_SHIFT;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
 	control = readl_relaxed(qspi->regs + REG_CONTROL);



