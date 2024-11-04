Return-Path: <stable+bounces-89654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81029BB222
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE181F216C2
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B01D5CFB;
	Mon,  4 Nov 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTPeUNQ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152501B3931;
	Mon,  4 Nov 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717626; cv=none; b=bA63E8/zJuugBAe61/O0bczZjVmIJ10O2RmcEjCazoec9ZHcCOm4/IrqpKF+H4qbZgIkYyAoZFXwlXHgxLIu9DnmrUwn9tzWTccsoDVMe2zOOMBjVuMc6ttgnPQEDPx21Ni4XXt/rnG3TK8oX+xreGMAshje1ex0zDAlJ8JCVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717626; c=relaxed/simple;
	bh=KizG53mSjVV9c+TAEcmOTJlBxB5Rta3JhTzUoOkOGsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XelFZWUAkeI2wYqvFkaiwNDBeYZ40pV7S59etjJa2ZaRcQ2eIYhcBg2gcKcyhsrUqg1EzLeUxprK3uJFwgm7ETJkeapMOnYNPTOHzG35r1b2uFvpdkY5uXIrLUY0+ddrt++pOzNayUOm8T+AGArM2SNFijAsa3jIqGG/OkFiyug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTPeUNQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76ECC4CED1;
	Mon,  4 Nov 2024 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717625;
	bh=KizG53mSjVV9c+TAEcmOTJlBxB5Rta3JhTzUoOkOGsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTPeUNQ22I6Zx4Pp3E+06BHa/OXBsa24e9vrulX9vHGzrIOYv2HWThmDNY5T4oEcq
	 4q44+BOeBLddNK0GX2yZoIxBQlWyqjwBZ6hmtLaLSoQPfD+L3jfiO3aQ4yq1WYBRcJ
	 Dyfx/mJgkaNS1dX8wFNtWx4aizsWlqqhNwOYUXGn7UXIWsZq2gslOEIKC/SpRrsSbX
	 3yAw5UvqxoS+KGtinnXT5NY7XduN6ac05vieKwskb2eTQzYg//roxFIB+75ZYr8IKl
	 8CZUWkuV8H9zCNVVHxvAgTiF0v5goYcLlpmvucNPlTtV26lNyb+WSSMUES1xlrwZLC
	 5BnlhZDUjAI7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Benjamin=20Gro=C3=9Fe?= <ste3ls@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	hayeswang@realtek.com,
	dianders@chromium.org,
	grundler@chromium.org,
	hkallweit1@gmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/11] usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 driver
Date: Mon,  4 Nov 2024 05:53:04 -0500
Message-ID: <20241104105324.97393-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105324.97393-1-sashal@kernel.org>
References: <20241104105324.97393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.115
Content-Transfer-Encoding: 8bit

From: Benjamin Große <ste3ls@gmail.com>

[ Upstream commit 94c11e852955b2eef5c4f0b36cfeae7dcf11a759 ]

This patch adds support for another Lenovo Mini dock 0x17EF:0x3098 to the
r8152 driver. The device has been tested on NixOS, hotplugging and sleep
included.

Signed-off-by: Benjamin Große <ste3ls@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241020174128.160898-1-ste3ls@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 958a02b19554d..061a7a9afad04 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9870,6 +9870,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3069) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3082) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3098) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7205) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
-- 
2.43.0


