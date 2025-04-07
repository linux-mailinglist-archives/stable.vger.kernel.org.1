Return-Path: <stable+bounces-128599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4BA7E9A6
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29D2189927F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB832222DC;
	Mon,  7 Apr 2025 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W61dIT2l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA02192EC;
	Mon,  7 Apr 2025 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049463; cv=none; b=aOIY2qkphCQ/Pg4uKcjNrleBk0r8DUbkdrl/87jIjOfOJeh98+xuusHc98jJvGbOnK0wsfSUhEWTe5bin7ZBbOHZydkVkqq/F4wA5RHvMM98yIKNbyOyhrX9vLGadEHwS+oHS3Bbb5Z3hYzSk7OpZvE8VlQ5qi/1cUI/q7kJGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049463; c=relaxed/simple;
	bh=aWnBchov1Oc4qRALKKfsxuNtvRNfxDEeevqDES1rkyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1VB8zFXxTvTTkf6LZ/mEcuT0bXuXng5H1nOtO22EjY3lytrbAfUICLjjaJ6zmlb1ew/b/rh4y+GHz3gUDlYSbRulKJk0VF4aoGErLFv6+2fmZUvGhbePMTINElCohMZhshmo/rTKOZ62unIHdPpUuAqbzLE4R8hZmmusmPXSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W61dIT2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9466C4CEDD;
	Mon,  7 Apr 2025 18:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049462;
	bh=aWnBchov1Oc4qRALKKfsxuNtvRNfxDEeevqDES1rkyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W61dIT2l3z6W5uTbmuHaGO11AmCcW7qAayxhRLrAMFXAQdVqaZv0zRMLRcYIeySRZ
	 pziU92wnIAnraD605LvA1coUF0szOgYuEa/j7mqxHvpblpp4CKeitWfoSQGuXnZTDT
	 w73yT1fgWFg0SdyX7ykMjLcmq/T10ENxzNyG+P8yDSAEwuVHPdBLCtOUecpizrJsdp
	 +yjt5NnvfHdPFGqZ25pceNUcMYX8cSq9gZMpST604PCt1k7lPy4qnY//t4uGdTmKPf
	 mPp4kmrfHEmynqR/R4DqPn8ks7K4IraIlHs/VnIVBnJoCghhdnOhG9OwRx3VAIA9KW
	 pLDYpv/a6yxeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@mailbox.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.tomlinson@alliedtelesis.co.nz,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 02/31] usb: host: max3421-hcd: Add missing spi_device_id table
Date: Mon,  7 Apr 2025 14:10:18 -0400
Message-Id: <20250407181054.3177479-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
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


