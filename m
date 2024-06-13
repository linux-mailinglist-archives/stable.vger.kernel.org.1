Return-Path: <stable+bounces-50938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9732B906D82
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A231F27CC5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27F514885D;
	Thu, 13 Jun 2024 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HfBIa5z/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5F145A10;
	Thu, 13 Jun 2024 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279829; cv=none; b=kl5UbUU1yYk9fMfyWdNdSB7GdFMwQjYCKl4VYPUXAym3b0H29Fzz70iepZtJX21bSW/rlg9nz/WU8U6GWqHhzzzppc6JGaIdR6/gGAK1YC7EMska6vmlAj2ie/duUXskGTrnciZ+BhAxhWk2w8xvo01Yo6prtgJCNC7HiCHDWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279829; c=relaxed/simple;
	bh=b7XRYAywD4vceHy3kldzUhivW3d77L1EJnfTnVkyvpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTtYZUz06/EmRcajhNnojKQP8ZJrYYF0PzDegoljnXSRWYD9yQ2Fu30H6xQvsfvtGR8EieKYSiW1XMSXy0Ph1hQ8LgxWHTqU2HK7kp17RCcju25042AdRV14U3U8gpmpJ0VK6Bh7a+Bicbjq5AZ6CPeLD//GDMxVYpQ+FEyMqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HfBIa5z/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A686C2BBFC;
	Thu, 13 Jun 2024 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279829;
	bh=b7XRYAywD4vceHy3kldzUhivW3d77L1EJnfTnVkyvpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HfBIa5z/uhnFFzx08L/rmiin5jXD9xBoKC2DII9hgYBcNL7zkrLRxxdto2UbA9Uy1
	 hdQrjYzgkKnPwDkI3kHAEjKrumuUZ+my0UF0aXskciYCRsx/VizQJ6F9r0/JlHoCDb
	 WNGJs2XLtHp+0qVQwPp7H64xS2pATdw3plYcq44I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Christian Lamparter <chunkeey@gmail.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
Subject: [PATCH 5.4 049/202] wifi: carl9170: add a proper sanity check for endpoints
Date: Thu, 13 Jun 2024 13:32:27 +0200
Message-ID: <20240613113229.666759259@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit b6dd09b3dac89b45d1ea3e3bd035a3859c0369a0 ]

Syzkaller reports [1] hitting a warning which is caused by presence
of a wrong endpoint type at the URB sumbitting stage. While there
was a check for a specific 4th endpoint, since it can switch types
between bulk and interrupt, other endpoints are trusted implicitly.
Similar warning is triggered in a couple of other syzbot issues [2].

Fix the issue by doing a comprehensive check of all endpoints
taking into account difference between high- and full-speed
configuration.

[1] Syzkaller report:
...
WARNING: CPU: 0 PID: 4721 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
...
Call Trace:
 <TASK>
 carl9170_usb_send_rx_irq_urb+0x273/0x340 drivers/net/wireless/ath/carl9170/usb.c:504
 carl9170_usb_init_device drivers/net/wireless/ath/carl9170/usb.c:939 [inline]
 carl9170_usb_firmware_finish drivers/net/wireless/ath/carl9170/usb.c:999 [inline]
 carl9170_usb_firmware_step2+0x175/0x240 drivers/net/wireless/ath/carl9170/usb.c:1028
 request_firmware_work_func+0x130/0x240 drivers/base/firmware_loader/main.c:1107
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

[2] Related syzkaller crashes:
Link: https://syzkaller.appspot.com/bug?extid=e394db78ae0b0032cb4d
Link: https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1

Reported-and-tested-by: syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Acked-By: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240422183355.3785-1-n.zhandarovich@fintech.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/carl9170/usb.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index 486957a04bd18..98fdfa84b0a9a 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -1069,6 +1069,38 @@ static int carl9170_usb_probe(struct usb_interface *intf,
 			ar->usb_ep_cmd_is_bulk = true;
 	}
 
+	/* Verify that all expected endpoints are present */
+	if (ar->usb_ep_cmd_is_bulk) {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			err = -ENODEV;
+	} else {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			err = -ENODEV;
+	}
+
+	if (err) {
+		carl9170_free(ar);
+		return err;
+	}
+
 	usb_set_intfdata(intf, ar);
 	SET_IEEE80211_DEV(ar->hw, &intf->dev);
 
-- 
2.43.0




