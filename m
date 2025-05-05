Return-Path: <stable+bounces-141658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879E8AAB520
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23E87AF6C8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFB0498CB3;
	Tue,  6 May 2025 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7W0THAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE2284B50;
	Mon,  5 May 2025 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487057; cv=none; b=A1CiFsZx2dKkU6I5NV4vtJwrwxeY7HCy/W99EMl3cQjvkdSaoGFDk50qB5sP4gWSkhuTHMGuiKs/T/XNkfVZfyfHo0tVV42QY6QgMDUhW4aekQPFmYNCQe4jhu6WYlxOh6bAz3VxKInvnZOdbm4U8VKSJwU8EKaUJaBhqCxd0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487057; c=relaxed/simple;
	bh=+jOy/rUkDGwAENDvYuJBQ7AgNkyldxwU7QFdHWuSleA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtgRzUn9WoQrKZNT8NW9yXo+AfoeKiCMpDI5MfXsjMK+q9DZnLfDXjNe16us3JRBI1nbVOfA6hbQBN0amNQWsjGP5sn7KcJgO945x//LPHfhIp5vArqeYZh/z6S7hS+fu46yoq4ydDob49MkM5Fh8fD/ypqs1kf8vnAoXaQWEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7W0THAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51085C4CEE4;
	Mon,  5 May 2025 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487057;
	bh=+jOy/rUkDGwAENDvYuJBQ7AgNkyldxwU7QFdHWuSleA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7W0THAsIKgx4vW0UqGc2UzkhoGY5hGXKycEPjJn0fdj8U9ppHipIW0COT3ktIGUN
	 jxpkeNFDh9JzSWEwEXGcbH/j5Ssoy25KFe5Enw9vVCZpAs7s4sRT1SrMiSsbLfAow8
	 kMzyY5q+W9etZadtkAe96B8+25YjSPcvdWY7MJT4rpc5NsvXhLOVCUv28NcWcocrn8
	 jQGaJr4vil7rhJXmXyZXkPqs3zsdSswuVuwl68X8uKMB+1pu8BSAlZgtuGnHrQ5cRP
	 3aVldpf7j6wthyAVqaW7M4KUsL3RpIIffBG2w+Hc0hmkfv9JiPhpEBsAKkOukPJUlc
	 qCYFAJA5GvQdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	hayeswang@realtek.com,
	horms@kernel.org,
	dianders@chromium.org,
	gmazyland@gmail.com,
	phahn-oss@avm.de,
	ste3ls@gmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 130/153] r8152: add vendor/device ID pair for Dell Alienware AW1022z
Date: Mon,  5 May 2025 19:12:57 -0400
Message-Id: <20250505231320.2695319-130-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit 848b09d53d923b4caee5491f57a5c5b22d81febc ]

The Dell AW1022z is an RTL8156B based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Link: https://patch.msgid.link/20250206224033.980115-1-olek2@wp.pl
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index abf4a488075ef..6cde3d262d415 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9853,6 +9853,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
+	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{}
 };
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 33a4c146dc19c..2ca60828f28bb 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -30,6 +30,7 @@
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
 #define VENDOR_ID_DLINK			0x2001
+#define VENDOR_ID_DELL			0x413c
 #define VENDOR_ID_ASUS			0x0b05
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
-- 
2.39.5


