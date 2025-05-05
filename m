Return-Path: <stable+bounces-141570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE5AAB776
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258F33AC5A5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9013434A3;
	Tue,  6 May 2025 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au1TIWu3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC82DBB3F;
	Mon,  5 May 2025 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486748; cv=none; b=ed5WEAHidzBCcZNIHn+G3A4MCFFHpxMkt8t0D87jrHiKcsDcEykg5F/vVjcnMrsTAo3NPKS5F+rzLluYUKWyR6wY6HwutX7ViARSxs8iqKsudqVl0DCit0v2w8fVbu5Ruzrj8Frcjg7kFznf/zpvsNThy3iKVlJUcdiqpzK1yE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486748; c=relaxed/simple;
	bh=VxwCcqEjjmFKkOmipPXouA+cBNnTqKLEv9WW2/LM5Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8OfG0glXGfDDsg0S8mWEHXzAkNU3hT9CautzR483jrG/S5lBZiIpiWqkeNxRKdNWJGTzPOLkIxXFLW8qazVPY+CnmBqQImKCdP+YhJBwVtxk18Wfju5jZA8FaABSifhPmGeQUsvV5PqgwUYYNqhZCElnxi7/5wPC1yq14Sihb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au1TIWu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112BBC4CEEE;
	Mon,  5 May 2025 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486747;
	bh=VxwCcqEjjmFKkOmipPXouA+cBNnTqKLEv9WW2/LM5Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=au1TIWu3SxQ/WeFpL0MbEVbSrAlKBtJciVmqGVVMrr43Mzx63MybgIf3amg6Yeiqc
	 vykKxGWWoQF8V9mzA96E8iw0vMhk64ePRy2pEZh8AsxL/JIpzxsGuKWIT8wo3Y55UZ
	 AVVZPbxRVm0Pc/1FEU/2JuOTCr8nxgwQzJ43b+8+3TMQSdBJvpXnxi2UWrnjg2gTJ6
	 IpnsnRBUAmOU/PpeRBNC4NHb8kfBnGjsZMN2Xz4aB3xnBKrOY98feQyPQBGoa6Mz9k
	 dGBPsSxHSOtNewT/4tbhft3rt91Sn/XDzVLTri8r/psW5ik5YyNOX6t//LvinblFQV
	 COw5iXEBbq7Cw==
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
	dianders@chromium.org,
	horms@kernel.org,
	kory.maincent@bootlin.com,
	gmazyland@gmail.com,
	ste3ls@gmail.com,
	phahn-oss@avm.de,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 181/212] r8152: add vendor/device ID pair for Dell Alienware AW1022z
Date: Mon,  5 May 2025 19:05:53 -0400
Message-Id: <20250505230624.2692522-181-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 061a7a9afad04..c2b715541989b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9880,6 +9880,7 @@ static const struct usb_device_id rtl8152_table[] = {
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


