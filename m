Return-Path: <stable+bounces-7168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C024B81713E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BB41F232AA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883971D127;
	Mon, 18 Dec 2023 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rEkyWzOj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A7129EE3;
	Mon, 18 Dec 2023 13:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C48C433C7;
	Mon, 18 Dec 2023 13:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907744;
	bh=aKQWx+PeWCtgFCURuQZ9zuMRKkggmNpcP+F/G2NL/IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEkyWzOjueGMbWC1oawZr9Z+VPaCyi7iu74f9iPovmnbgSHKxAq8K82IpDJmBusmV
	 xK5oRXLlgpdLYnYVeumMy3nnKZkfGrvdbQkLPTGuOmmwEHn5HwNcdlVszrUGeZzkpH
	 9CjH578CPDxvyMHBWFiectuHLoGG1ZP73HuG7TcY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antonio Napolitano <anton@polit.no>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/106] r8152: add vendor/device ID pair for D-Link DUB-E250
Date: Mon, 18 Dec 2023 14:50:17 +0100
Message-ID: <20231218135055.164334542@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antonio Napolitano <anton@polit.no>

[ Upstream commit 72f93a3136ee18fd59fa6579f84c07e93424681e ]

The D-Link DUB-E250 is an RTL8156 based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Antonio Napolitano <anton@polit.no>
Link: https://lore.kernel.org/r/CV200KJEEUPC.WPKAHXCQJ05I@mercurius
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 7037d95a047c ("r8152: add vendor/device ID pair for ASUS USB-C2500")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 1e53f43573ec2..09d2f3bdb0647 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9907,6 +9907,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
+	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
 	{}
 };
 
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 20d88b1defc30..287e9d83fb8bc 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -29,6 +29,7 @@
 #define VENDOR_ID_LINKSYS		0x13b1
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
+#define VENDOR_ID_DLINK			0x2001
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
 extern u8 rtl8152_get_version(struct usb_interface *intf);
-- 
2.43.0




