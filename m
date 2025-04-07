Return-Path: <stable+bounces-128718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE3A7EAE1
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB367A45D7
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D435026AA8F;
	Mon,  7 Apr 2025 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZzJx7kh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB292550C8;
	Mon,  7 Apr 2025 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049741; cv=none; b=HO2ndch1i8ofcTFd5rCo8NqAgEB9atWCZ0lgpGOcO5uIiWgs7vYeqKALbuujXccKRLFVuDBzYmt0fV08LCW1F9g9vdvIiLG01KpCLm7ZWUCDrLzuy5gOdzB24TvEClRGStE7arq7ENhxvR2sTLz5/xpPXUoN/VghHVZL5cbFoY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049741; c=relaxed/simple;
	bh=DI7Ikjnz7qphhOm+1QNPRAjBorGDkMix9z/wDK3t8A8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DjU/j94wPILtIFNsQJKCjAZsX17tfd33u2FS1CpC+CjZMq0y8F+ITWDS2ZVIjvqWdNzijPK/ev3pOlb9fO4qUewPn8ezfgqO4KQPTdgi6nATkWTyVruH3kHnfHpIv/D/pGpgxjwjcYapBWFoSUBCdXfkc/GNsmonuSTzWlLUFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZzJx7kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F86CC4CEDD;
	Mon,  7 Apr 2025 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049741;
	bh=DI7Ikjnz7qphhOm+1QNPRAjBorGDkMix9z/wDK3t8A8=;
	h=From:To:Cc:Subject:Date:From;
	b=RZzJx7khFJF+UER0IYc2H05MxbPM21V6Ni5h0/26HjXZ3B/236tce4zHify2Ui5n1
	 v9WQJZ9nEE7c/eB4T0Ofg24Rfkt8ayK3ulltgMHeDPRmDrCalbFj601lOXLKryhkUB
	 7sLgFtjHLJk3kaM7wiZ8/Xk5Ds+oOF/d5P3cPpuWWBB3jIc7JmbVVkjIm/PM1lAzTk
	 4hsZNa4MlboxrXF4U7DkWy21IYaIIUzrotdJZtuo2dgIKD2L+5rSoAtaxX1w3CG6nZ
	 M733lnanS42GIGUagEyKhceLckBC7ka05bxpkD4VGxVcjwPXRf8zQ/QWj3ilB+OdUT
	 dhMKzZwIiFfaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@mailbox.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.tomlinson@alliedtelesis.co.nz,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/4] usb: host: max3421-hcd: Add missing spi_device_id table
Date: Mon,  7 Apr 2025 14:15:31 -0400
Message-Id: <20250407181536.3183979-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@mailbox.org>

[ Upstream commit 41d5e3806cf589f658f92c75195095df0b66f66a ]

"maxim,max3421" DT compatible is missing its SPI device ID entry, not
allowing module autoloading and leading to the following message:
 "SPI driver max3421-hcd has no spi_device_id for maxim,max3421"

Fix this by adding the spi_device_id table.

Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
Link: https://lore.kernel.org/r/20250128195114.56321-1-alexander.stein@mailbox.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/max3421-hcd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 44a35629d68c6..db1b73486e90b 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1956,6 +1956,12 @@ max3421_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id max3421_spi_ids[] = {
+	{ "max3421" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, max3421_spi_ids);
+
 static const struct of_device_id max3421_of_match_table[] = {
 	{ .compatible = "maxim,max3421", },
 	{},
@@ -1965,6 +1971,7 @@ MODULE_DEVICE_TABLE(of, max3421_of_match_table);
 static struct spi_driver max3421_driver = {
 	.probe		= max3421_probe,
 	.remove		= max3421_remove,
+	.id_table	= max3421_spi_ids,
 	.driver		= {
 		.name	= "max3421-hcd",
 		.of_match_table = of_match_ptr(max3421_of_match_table),
-- 
2.39.5


