Return-Path: <stable+bounces-128681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BE2A7EA9C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56D916BB0A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B0253F33;
	Mon,  7 Apr 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh0rJlDm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8721B192;
	Mon,  7 Apr 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049662; cv=none; b=qQvBQUl65Kcb/e5ZoV5fdhDSBn9f+R31oGwnXjdMU0MMj+OMVmsILBf7ul6k8DpRtI4Bysbt3VYK+rMS0uhB9a8UgOtnYaUhX3bAYieZKBzlwU820RLsOkGCwUcusSMVtFrJS2wuw8ChkaEUe1r64NKCjYdLA/KpquKNKoSoaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049662; c=relaxed/simple;
	bh=8IzQwhNTnITNU7a9AzWO4JF7R8CLHfsNu5oPkLHN5yI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGWP2FJZr2Cz9eOYnYD0j24BabTr712rj906HpXozbZD4X5iPjnHM7cIY3JTr0AxmUgsAdkc3CaL19q9ThHWoouBjcTiqVrOmAUTYoTgEeITFQiQ9xyw9dJSLx6ezZLXX7VzjgmxcXOyGKZb4/FkNRsUkOiTOvg50FKszUq3LBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh0rJlDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60337C4CEDD;
	Mon,  7 Apr 2025 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049662;
	bh=8IzQwhNTnITNU7a9AzWO4JF7R8CLHfsNu5oPkLHN5yI=;
	h=From:To:Cc:Subject:Date:From;
	b=oh0rJlDmrQVXLKI1S8/Yopsy/0DeMBU1t9zV0bPNLDZ8172RiYgZ9XXXqpnQQqqtv
	 493Vh2cIYp/poFW2k2QPADcr9Eqn3NtXkAR8AgMTSY9s2Es1t1Ow75Re+A0MVBotN3
	 cWmpoTnCH/1Uv0ih/+XOLf3VERjTYbAm1vDHRXk5JsKHpsJBQJC2nUaVath3mONzNx
	 oWi1CAxadTRDxfZGAb7F62Xyzdo6plMZAVmXp+qQhr2jgt/kzeZpDJmK7ZSplnXeov
	 DzYd9jxXwXBmdYeiCnCnC2hQfgaeQ6QjWmjgz/oJsvYxEUMGHemUKvgkQ9ojxE+SzD
	 SRkyj4xGyNtsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@mailbox.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.tomlinson@alliedtelesis.co.nz,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/15] usb: host: max3421-hcd: Add missing spi_device_id table
Date: Mon,  7 Apr 2025 14:14:01 -0400
Message-Id: <20250407181417.3183475-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
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
index a219260ad3e6c..cc1f579f02de1 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1946,6 +1946,12 @@ max3421_remove(struct spi_device *spi)
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
@@ -1955,6 +1961,7 @@ MODULE_DEVICE_TABLE(of, max3421_of_match_table);
 static struct spi_driver max3421_driver = {
 	.probe		= max3421_probe,
 	.remove		= max3421_remove,
+	.id_table	= max3421_spi_ids,
 	.driver		= {
 		.name	= "max3421-hcd",
 		.of_match_table = max3421_of_match_table,
-- 
2.39.5


