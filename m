Return-Path: <stable+bounces-7551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE2781730D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77C1B21E1A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47B37870;
	Mon, 18 Dec 2023 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nrTHRQz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DFE3A1D0;
	Mon, 18 Dec 2023 14:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA0AC433C8;
	Mon, 18 Dec 2023 14:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908774;
	bh=LUv6+ALJ+NtGCEoQpBrw0Z7v6a+TeNNFJJ1vUTk/lLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrTHRQz+VVMyKZ9ZFwIYaU6SrbEyYUOGPB7nzb9cJn/1H3iUSqIKaXCctHwXFA3gl
	 DFpJIL6wCVXB/pXWx4IwPdfFMTPPvvGtU/U0Ueb4sUNsCQevfY/z5zhvn7N5GMjda/
	 7Xzgn27v8Bqr13P5g+Lqj63fm/5B3j7YT7vrZ4b8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kelly Kane <kelly@hawknetworks.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 04/83] r8152: add vendor/device ID pair for ASUS USB-C2500
Date: Mon, 18 Dec 2023 14:51:25 +0100
Message-ID: <20231218135049.937547552@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kelly Kane <kelly@hawknetworks.com>

[ Upstream commit 7037d95a047cd89b1f680eed253c6ab586bef1ed ]

The ASUS USB-C2500 is an RTL8156 based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Kelly Kane <kelly@hawknetworks.com>
Link: https://lore.kernel.org/r/20231203011712.6314-1-kelly@hawknetworks.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 1ad9f1b4bd92d..e64983d0898a0 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9881,6 +9881,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
+	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{}
 };
 
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 287e9d83fb8bc..33a4c146dc19c 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -30,6 +30,7 @@
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
 #define VENDOR_ID_DLINK			0x2001
+#define VENDOR_ID_ASUS			0x0b05
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
 extern u8 rtl8152_get_version(struct usb_interface *intf);
-- 
2.43.0




