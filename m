Return-Path: <stable+bounces-128722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2268A7EB01
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6277A3323
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2009125525E;
	Mon,  7 Apr 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSdHkMuI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1C21ADC4;
	Mon,  7 Apr 2025 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049754; cv=none; b=fK2EVpYB3rWfheME2yAfNUQ/SVyVwE+09aBN0fOGTwouLD2KghP4kTjKyQ2wO/EglEOPGe6ySyK+XZ3ie3NQPTpld8uzvS4oE+d6MZV51DVmH3+21rmr5xeJ7k4KrS6rMNFwpT5uw6R0uc8jBDdflRZkJv9RFwpDvngvTnf7tzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049754; c=relaxed/simple;
	bh=JLqHkqQPeOxveqhfH++FK6yYdvY/BEz54iOYag6Pzxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BbggKvwEKbbzs3/EKVyEvqThVjz9niert/jpso+5AOJj8u6/L1QEnPFgqFk8nAHYaBvkcr0PwCJ/+udGxopCcoONCA+AgtsXm/LRE25BmXpq4oU9DPn/AANkUh+xELirWPBIah019Bve1V8SWas8CCmCMOIU4PriuNVKq+ls/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSdHkMuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2BAC4CEDD;
	Mon,  7 Apr 2025 18:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049754;
	bh=JLqHkqQPeOxveqhfH++FK6yYdvY/BEz54iOYag6Pzxw=;
	h=From:To:Cc:Subject:Date:From;
	b=gSdHkMuIXu+1pf8PCFfdLu8pT0MHu899PoaJijlH9OMgJNPHE+KzQNgEn56JXxSpO
	 S9UEbhT9oRW+gV0Ix+7DnveI6YcR3HuR2yDmjaAYJCjj6ZHZavBsULr8c4nBzRBN2Y
	 x6hryKo769uczzO3SMDr/FZboPSe29gK/5Cucx/dj3PgDNJm6rQjhSpleE1opbM6ej
	 vG7kYyF/lRx67ATkNPRB3TeK4iFu6e/yVP8vpJySBpF76C6zPNeMHDtR+cDwaaBUjY
	 +4Dve+GxI1d0tXd7b3nDJRHd4k6nsxH00Ndgxok9bD9EtTmlFvhbUoJCSBsZYTM3jx
	 curWgfCx//R/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@mailbox.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.tomlinson@alliedtelesis.co.nz,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/3] usb: host: max3421-hcd: Add missing spi_device_id table
Date: Mon,  7 Apr 2025 14:15:46 -0400
Message-Id: <20250407181550.3184047-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 0a5e0e6449826..5a21777197e95 100644
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


