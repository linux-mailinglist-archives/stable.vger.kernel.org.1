Return-Path: <stable+bounces-128710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28B9A7EB0C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA181443980
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFFF2690F9;
	Mon,  7 Apr 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwfrx+L/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B092236F0;
	Mon,  7 Apr 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049721; cv=none; b=h6kPdn4rCfrTLjlo8xuSIBDbnH7NKlrKAMLQZG5z5qBxu3hSd3V9xSevCluXq3JD9QNm+AkAKF0jDVTM8dlKqZQJxjjDGwk/ANueovL1mPPYvOMnInnv7bSmTP+kf4P8bN5SxUS97yGISnSlTlddhS/gSiH/3UEVdVkkrhNMUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049721; c=relaxed/simple;
	bh=tgQT/fBkRIsvHEjKratjydCq/3tv6iRd2tWQmUIzM2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHQrpHDUgZ1aDRqODGa79atgwrMwitlCdFNUmr+DUUL/eMmuPb1tR0rHB6vj0re/SYp3vG24raSeV23V+gr2yWbQU5a6iTG8lJ7s1qxNf0HkQY2Jmnm9HrRpfkHYMsFwygP4l2LF3014qq9ZlDoc2GaIn93mGGToR+K1WRZFCJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwfrx+L/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE38C4CEDD;
	Mon,  7 Apr 2025 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049721;
	bh=tgQT/fBkRIsvHEjKratjydCq/3tv6iRd2tWQmUIzM2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=nwfrx+L/HK/xTvOCSU9qi6fSsLJRgD6Ze3x3WLc+gpN7R1/QwBJHkPoa82IddKYr/
	 1nBK2c1rrCf0EZWC1hYFo8/q7se4cJukReNdEqvPlUv+Td7RCpivdjXTCoZxUYqJz7
	 bYuo+CxLDUgEifm/e2E0d/B8mxt04ZJV7pNqMl5J1avCFx1UxMVw3qNNR5B1yGZ6fa
	 QyF/4ruFE/sq9og0GOsx2Fl+lmxMDHwFENTksLf3ONIT98BX3SarNi1HZvJv7dmaLa
	 YIngf7seqPrKLwOY/IQ9ZT3LBV1/PtU9UTV62l/7M8sMjrmeQjyFUW9eWIPY7Q143t
	 9aPKsV5DKKZKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@mailbox.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.tomlinson@alliedtelesis.co.nz,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/8] usb: host: max3421-hcd: Add missing spi_device_id table
Date: Mon,  7 Apr 2025 14:15:07 -0400
Message-Id: <20250407181516.3183864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 6d95b90683bc8..37a5914f79871 100644
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


