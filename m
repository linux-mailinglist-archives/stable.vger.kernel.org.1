Return-Path: <stable+bounces-85784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5AE99E913
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4EA1C20BC6
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E898B1EC00A;
	Tue, 15 Oct 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8gNRFtK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63591EBA1F;
	Tue, 15 Oct 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994289; cv=none; b=nSM+6tL/7QjDYH9ieezZCO4hBFmQEyRhL0Pa9X9KL9ZaernPdoeGNmXNQSn0/8WzwBJb91DE7qJcxWUu1BnZ24kpWkB20BfjLdyTfzi3ZmSFpwKUph2nl90ju9u2V3pEeQI7FZo7C2DVp7PatWNMYWV8+NCavmMEPquBTbweyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994289; c=relaxed/simple;
	bh=dLsYNV4nRpe8gAEZbux2Tzy3VqBkV0u/mNEm8sj+aSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me8v7rERCzN84lQ4ijoGzCM6rZ9aCwfJa2Tx2VejdXpsvRK95FbyFn6430IV3M5zw6Nr7h3kSnk/L+PsDOxAatoJopjxbPxk3XAECospJA0BJzkuUVpAVWbN6uLR5cNuxTIXr2EIOSstXTZ+pRRFCLwWqguiSgdgexhz3x9doDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M8gNRFtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9F2C4CEC6;
	Tue, 15 Oct 2024 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728994289;
	bh=dLsYNV4nRpe8gAEZbux2Tzy3VqBkV0u/mNEm8sj+aSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8gNRFtKs2C5JYnoT6t6p0P09E7ZVIta9AaGcufH3z9Z4oQEIL5jNQKyTE+Nl5Zmh
	 YDtIdxo9YnQPro0iJiOfWnlpu4wNjrQGj1IRb4+BFZKKI5r39i73a2eN3az7i7KIJw
	 8FTyk+dTNMQ90OwsaofgjuYBf1Jcz5s4Hmr85vHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 662/691] hwmon: (adm9240) Add missing dependency on REGMAP_I2C
Date: Tue, 15 Oct 2024 13:30:10 +0200
Message-ID: <20241015112506.602539776@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit 14849a2ec175bb8a2280ce20efe002bb19f1e274 ]

This driver requires REGMAP_I2C to be selected in order to get access to
regmap_config and devm_regmap_init_i2c. Add the missing dependency.

Fixes: df885d912f67 ("hwmon: (adm9240) Convert to regmap")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Message-ID: <20241002-hwmon-select-regmap-v1-1-548d03268934@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7bc81da4ee2ef..f73a4ae2022e9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -165,6 +165,7 @@ config SENSORS_ADM9240
 	tristate "Analog Devices ADM9240 and compatibles"
 	depends on I2C
 	select HWMON_VID
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Analog Devices ADM9240,
 	  Dallas DS1780, National Semiconductor LM81 sensor chips.
-- 
2.43.0




