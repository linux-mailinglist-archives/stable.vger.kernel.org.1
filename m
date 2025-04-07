Return-Path: <stable+bounces-128658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2AA7EA35
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49911887AC6
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4AF222562;
	Mon,  7 Apr 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3H1Aoor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A082222DA;
	Mon,  7 Apr 2025 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049619; cv=none; b=Mhsd14jUkHbAi3+m04GLj0cHonKspFh4+QFsXHKuOpqKQ6lypeybseRURwlv+nVwx9L4M9g0XixnDd/LE1uSyIZojtxNUFnA1LsWx4eUVT74ewIhgpwuJNwgV5/C9AXn7qOrn0G1/GarAoPwqVQmKJtKpjpE4mdHNwDllDnn6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049619; c=relaxed/simple;
	bh=aWnBchov1Oc4qRALKKfsxuNtvRNfxDEeevqDES1rkyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WNR0dtIfokimMc7HaS8EhHxzlNFHOKyEAjOdMNtaNMRSdWdUW2r8kKUXvGpmKyOcRDhsNzhDbYEjQCVgyFlYa0RNnfNeI2V2Z0R1krkbTdga1SCw8LVz2dealvwt3YyXxDjWV4ZdIMfqcmVlNBjo30JgU6BYZtsMiHO/ExMqoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3H1Aoor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A489DC4CEDD;
	Mon,  7 Apr 2025 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049618;
	bh=aWnBchov1Oc4qRALKKfsxuNtvRNfxDEeevqDES1rkyM=;
	h=From:To:Cc:Subject:Date:From;
	b=U3H1AoorFUG17Lu1XDG59/xNQ9N/aX1sEq+lY3QkVOkWIM3Vm5eMLQECHxNeJFh36
	 qnJWaFV9lT/Y9vWyiw1D2VveVtxs9zw9M6N9XX2U3SnCFjNEs9CTJfE4rulXIMUOrd
	 QPrQy8JfeQA7JYzLpgKYCdcd8VbmRrpgInD3hJ44yGANOeFqUP4eFueiTI4lIrIy34
	 OSbl1v/8YOA59aBVdSy+u5FssxCMWcGJ2CgWs/cs5ykFl9dyQDLOFPJdlzrOOVodHj
	 1T6XGhZA7iWHQ+nm0nA0OhAzUdZK8kTtLcXYZJB5kkQydlek0WFlQ1LnlejqbCE15Y
	 /r0tkcShHJplg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@mailbox.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.tomlinson@alliedtelesis.co.nz,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 01/22] usb: host: max3421-hcd: Add missing spi_device_id table
Date: Mon,  7 Apr 2025 14:13:11 -0400
Message-Id: <20250407181333.3182622-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
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
index 0881fdd1823e0..dcf31a592f5d1 100644
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


