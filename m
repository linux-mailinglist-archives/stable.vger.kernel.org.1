Return-Path: <stable+bounces-14365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D1838099
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB091F2CD94
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E2130E26;
	Tue, 23 Jan 2024 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZnbBXBR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480912FF73;
	Tue, 23 Jan 2024 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971813; cv=none; b=UlpHyfIauo7oe6ezqGdAzOxj1RsqnpvBhzYkZ9nEk0WTUVuIEgfmfnkeShITTAUH6mv/shOizLMCSKPs+XFuxmCWQQgjpyObadBtAcOFTSzaG8PoFjA3hy5V5Ft2AOrQRcW19LXx8IVe+KVQZzHeceiE27ZsAWBYtOTqZXYV+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971813; c=relaxed/simple;
	bh=j/eLERMyeWbArocaQY9jym0dDs8gtxW4sTDsDQenJ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wqfe5zROZiWq+Lav4bo7oDiQvP/SAP0zNakB1u+XhEdH0JqgyuwxUfRbeVI/2ggTdI1ARLGtnWxCFKdI5mdTVvxDvgG9uBfMGat5ma/YYd3RG8woP3xeC5TlKDQ52GslZepk1vkWqFiDgnV1hl++r5dfOIFyktYClNDNpRn3lmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZnbBXBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F90CC433F1;
	Tue, 23 Jan 2024 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971813;
	bh=j/eLERMyeWbArocaQY9jym0dDs8gtxW4sTDsDQenJ2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZnbBXBRHsJTiVh2BGASaM4oJ4QRpUM+cDCOUR2Q0Fudk+17TUsGHBfkhTovcZaiH
	 rDEd5RYbtCGv2m+8bMIn/et+FtlpSMB/Vq940pQyZck0QHhds7MH6IQ9J4wB0EipNw
	 drhrB08LqaHQLUNW1gXKHysnA08F9Pq5cEkBv6j8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dang Huynh <danct12@riseup.net>,
	Nikita Travkin <nikita@trvn.ru>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 237/286] leds: aw2013: Select missing dependency REGMAP_I2C
Date: Mon, 22 Jan 2024 15:59:03 -0800
Message-ID: <20240122235741.189285374@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dang Huynh <danct12@riseup.net>

[ Upstream commit 75469bb0537ad2ab0fc1fb6e534a79cfc03f3b3f ]

The AW2013 driver uses devm_regmap_init_i2c, so REGMAP_I2C needs to
be selected.

Otherwise build process may fail with:
  ld: drivers/leds/leds-aw2013.o: in function `aw2013_probe':
    leds-aw2013.c:345: undefined reference to `__devm_regmap_init_i2c'

Signed-off-by: Dang Huynh <danct12@riseup.net>
Acked-by: Nikita Travkin <nikita@trvn.ru>
Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
Link: https://lore.kernel.org/r/20231103114203.1108922-1-danct12@riseup.net
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index ad84be4f6817..03c4c5e4d35c 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -116,6 +116,7 @@ config LEDS_AS3645A
 config LEDS_AW2013
 	tristate "LED support for Awinic AW2013"
 	depends on LEDS_CLASS && I2C && OF
+	select REGMAP_I2C
 	help
 	  This option enables support for the AW2013 3-channel
 	  LED driver.
-- 
2.43.0




