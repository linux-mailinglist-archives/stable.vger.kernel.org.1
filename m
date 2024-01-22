Return-Path: <stable+bounces-13661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D7837D4E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E351C28C7A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0BD4F208;
	Tue, 23 Jan 2024 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pBks+EdY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A105B1F2;
	Tue, 23 Jan 2024 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969883; cv=none; b=WMlTr1zry2D913+cRsgGMWHfTQX8qL9jnVMwkBV/Yf8d9ZWF91vURqlMO/EM7ikHDpY2RHQnZURChPvP/UKDNPU0TsuSp7o4fjt9qxPceD5rvLMO5SOwObnTL5GE37li2bsy7vdQWDRXBqjJhl/FQqj4Ygfn90OwZ8w2AshF+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969883; c=relaxed/simple;
	bh=38c+GkfahdgAIGOnhFh+2/ZtGuiWGseu4cidFj3Ar4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exe3RfMYGpfsq9rj1VEc9qGs8cnqqkxo19akmURZ+aHUC2fCrLgT4shk9XMsn3XviSiIPuPw/1Ef4r24Jnvr8nEDffXeTqYs0Q/BTUXu5eRqjXHnac1Cv3XV94EqJ2ls2Wc51Crn8jsySRTzoNuYu6Enyooun7Mq9wRC0y8J9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pBks+EdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638AFC43390;
	Tue, 23 Jan 2024 00:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969882;
	bh=38c+GkfahdgAIGOnhFh+2/ZtGuiWGseu4cidFj3Ar4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pBks+EdYVniykz+JINhmrhVGn/CSDme1rrS4vtQt70ElVfQMQejZfcZQMJm0Jx0R5
	 GmrBuGFbf8lCIi6zP/EO9Hn0jzvSbFFoKiytTu8gNZR8l6rhBgHBnYGsOKPRLKBIg5
	 0aAY6wBFDrW/Y4m77hvUzaBEOG0hBOc8X7oNVByY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 6.7 480/641] serial: sc16is7xx: set safe default SPI clock frequency
Date: Mon, 22 Jan 2024 15:56:24 -0800
Message-ID: <20240122235833.082696139@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit 3ef79cd1412236d884ab0c46b4d1921380807b48 upstream.

15 MHz is supported only by 76x variants.

If the SPI clock frequency is not specified, use a safe default clock value
of 4 MHz that is supported by all variants.

Also use HZ_PER_MHZ macro to improve readability.

Fixes: 2c837a8a8f9f ("sc16is7xx: spi interface is added")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-4-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -24,6 +24,7 @@
 #include <linux/tty_flip.h>
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
+#include <linux/units.h>
 #include <uapi/linux/sched/types.h>
 
 #define SC16IS7XX_NAME			"sc16is7xx"
@@ -1732,7 +1733,7 @@ static int sc16is7xx_spi_probe(struct sp
 		return dev_err_probe(&spi->dev, -EINVAL, "Unsupported SPI mode\n");
 
 	spi->mode		= spi->mode ? : SPI_MODE_0;
-	spi->max_speed_hz	= spi->max_speed_hz ? : 15000000;
+	spi->max_speed_hz	= spi->max_speed_hz ? : 4 * HZ_PER_MHZ;
 	ret = spi_setup(spi);
 	if (ret)
 		return ret;



