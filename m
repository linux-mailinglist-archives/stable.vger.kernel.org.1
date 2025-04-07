Return-Path: <stable+bounces-128696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF0CA7EA9F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC91888867
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EFA267B0D;
	Mon,  7 Apr 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+uui2La"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15856254AFD;
	Mon,  7 Apr 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049694; cv=none; b=XPmVgA+H95QH004BduTzdkRVoP9fOwSuexpEEp/7x6e0Cz7y404O8lF4Y4+yCJBdst5vzfFlT26PgJ1PKEX6vSkfTP6kBzKBXWnJmW1OE7YZ4FYUCbqA9f/J6zSY6qs1MNG4WJcSSZ4uc3c7PdLIVPGWg+hEuwwzFpupffOYXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049694; c=relaxed/simple;
	bh=TH8AcD+ZKVsttfULi4BtBNFHCGBtCutCNncWV1T9Nl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aZryx+iqGC3yH35qYAwveex1FfQPiCTIrJBZesbFEfs+hDF0i6ubOgYiK+bwhviFXbXub64UeamctOmZhZibhGN14aLxqBVm0NShNg1+IbOYqD70XYYn+hSRoDzBne8PO0OloeU4sxbGTt2W0tRNKWQNfxWN3Mhud3W4xf0f4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+uui2La; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA86C4CEE7;
	Mon,  7 Apr 2025 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049694;
	bh=TH8AcD+ZKVsttfULi4BtBNFHCGBtCutCNncWV1T9Nl8=;
	h=From:To:Cc:Subject:Date:From;
	b=L+uui2LaHYvqx+o6EuOaXCNqRAdpFs2UcPeGP8FnXNK0wH/6MgyHnDmzABA/tRnFA
	 1VuQzKkSzqRDpuwE0PWVZFc/BDKufB/EPulKmiy66czqsw/dPNOuJMEr/7srK4DBmz
	 ebsEdGp2IKeusqAQZrqFNXejCLncVJhRUrfupOh1gfZX7Sn8Y0akfWFKM7tZkbFMsv
	 F4CAo4tN+Yl5BLOqzjUNv4Gp29ZBfP0u0aBimGDq0Pki9LWyMJVxqg00sDpeWhWO5I
	 PWavCqhhlwD9dIAHwhDvYrPPRyZRscNC2B7nD9BuAOjfz7AaQfN4qQ1Eur1z0PM3DL
	 yzVlI0ryQIIMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@mailbox.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.tomlinson@alliedtelesis.co.nz,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/13] usb: host: max3421-hcd: Add missing spi_device_id table
Date: Mon,  7 Apr 2025 14:14:35 -0400
Message-Id: <20250407181449.3183687-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
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
index ab12d76b01fbe..8aaafba058aa9 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1955,6 +1955,12 @@ max3421_remove(struct spi_device *spi)
 	usb_put_hcd(hcd);
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
@@ -1964,6 +1970,7 @@ MODULE_DEVICE_TABLE(of, max3421_of_match_table);
 static struct spi_driver max3421_driver = {
 	.probe		= max3421_probe,
 	.remove		= max3421_remove,
+	.id_table	= max3421_spi_ids,
 	.driver		= {
 		.name	= "max3421-hcd",
 		.of_match_table = of_match_ptr(max3421_of_match_table),
-- 
2.39.5


