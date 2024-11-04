Return-Path: <stable+bounces-89626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6049BB1BC
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D60BB25C89
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E791C3054;
	Mon,  4 Nov 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM+oiIR3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0791B3955;
	Mon,  4 Nov 2024 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717485; cv=none; b=LO3hh/uFby13CSPlAFQjomw4MfIHNV/9AulPMgX99siiwLpRQH0tWyqxgxh95bMoGhT4BJ4VMvoIx1wldizHqe39J85xtmLWIqnOri1z7Rg7F7hP4cqTCXuqSR1jsVWUWMafj0dt5ON0FL823WWIhWZsUvF0P3r4BGguicC+k/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717485; c=relaxed/simple;
	bh=a22GKdlNiQ7NMMlOML5nAVa8otGDYXsbRLeBDfDNtm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbqoP37YMdf1AXz4zwGyzhTTYivTO1peFIZOTu9I+hewP950IuiuY8p1pnF/xTwcWbP8nXhEaMdfMjkkLpfQms1p1tR3ySR+qI1cfJ+Lwu2pTH97kGccfHdH7gb/arV2EwOuIIXwraVjEnPe++9VeMDWBOj7azGQ4Y2pEPOqCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM+oiIR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65511C4CED1;
	Mon,  4 Nov 2024 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717485;
	bh=a22GKdlNiQ7NMMlOML5nAVa8otGDYXsbRLeBDfDNtm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LM+oiIR301n5+/KIhzfXcVtWPEqKiPpyr/Pwc/m+//f7RI2tQOSAxLkdim0JE+MYB
	 L0diPM1boKnoGNq0bLVF2YqpYuWWQQDEkBQ7diQ/Qqos6Q63MiAdO50W2AmyeWGdnZ
	 1bDSOYZOYZyNS1SyxrRPT/zNtf7wZVccHXAwCepbFsTyNUYQwn0Vd3h9bDYLS9MEQW
	 1VwsDvPy8sn+vU0YSW2SOrkJer4CTjaHSGvWdxe4I6+fMED6mPEXWg9GoRrZO3mtDq
	 rBMWU0c5XD/1V9DfPUu8WCfRngtJE+kLuSbPLMyfvcn8tUhB9JHZ4alwSsWj1Y2LJe
	 GR6ZVDbWkllkA==
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
	gmazyland@gmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 13/21] usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 driver
Date: Mon,  4 Nov 2024 05:49:49 -0500
Message-ID: <20241104105048.96444-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
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
index a5612c799f5ef..468c739740463 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10069,6 +10069,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3069) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3082) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3098) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7205) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
-- 
2.43.0


