Return-Path: <stable+bounces-156838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79465AE5158
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF257AD6D4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D4223708;
	Mon, 23 Jun 2025 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AbLJJtm7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90581EE7C6;
	Mon, 23 Jun 2025 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714389; cv=none; b=oQwEBp0GBfekLKMLmZTjWFPv5Ej36zcnlXeJAgPUt4/FLtF7mNNjroJtHgyj9HmnZq6G7ixQYIQolYc/BhDL+xY9wUZVj7ktUGvmZbzJgxieY86KvanWCsRIzcf3qwWBByefhrQHwL8eAQA1HhzAL956jg4Rf0xWP9dglHVTof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714389; c=relaxed/simple;
	bh=BXkF1vBGWiHUNVce7qv4P+MqIIHO/7Fz6YktGulZT7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQifnvSIJrvvbWiPPN6U+nTHgIbWTGGHTUTuRMbSLFnDuFLqaOOTtzDNVwThnqWjZnwWIK1+P3DmQXi40WP+BzIUrD7RIjIUPSCITypAqu6xlcTjlE9OwEzCk1UE5PwiF0q6jMHj2CekZIY4Xz+KJOKqXTd367DaZwy2JsGEcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AbLJJtm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF8DC4CEEA;
	Mon, 23 Jun 2025 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714389;
	bh=BXkF1vBGWiHUNVce7qv4P+MqIIHO/7Fz6YktGulZT7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AbLJJtm7hZMgfwOjjX0ahQBeVbvBBVlec60dZAZgghYzzMitv6o9AdZ61c9KeWwQs
	 Um7l2rUKpEi0pVbZqBOZgrc1kMSix5O8h4zCTgkxL1nSKhcA6xE4BPv3xMW0DGS7xY
	 Z8moSUZCf4kkcqgbaYmzV8hI3bouZPyvqu6aeirg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 203/355] net: ch9200: fix uninitialised access during mii_nway_restart
Date: Mon, 23 Jun 2025 15:06:44 +0200
Message-ID: <20250623130632.761321122@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qasim Ijaz <qasdev00@gmail.com>

commit 9ad0452c0277b816a435433cca601304cfac7c21 upstream.

In mii_nway_restart() the code attempts to call
mii->mdio_read which is ch9200_mdio_read(). ch9200_mdio_read()
utilises a local buffer called "buff", which is initialised
with control_read(). However "buff" is conditionally
initialised inside control_read():

        if (err == size) {
                memcpy(data, buf, size);
        }

If the condition of "err == size" is not met, then
"buff" remains uninitialised. Once this happens the
uninitialised "buff" is accessed and returned during
ch9200_mdio_read():

        return (buff[0] | buff[1] << 8);

The problem stems from the fact that ch9200_mdio_read()
ignores the return value of control_read(), leading to
uinit-access of "buff".

To fix this we should check the return value of
control_read() and return early on error.

Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Link: https://patch.msgid.link/20250526183607.66527-1-qasdev00@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/ch9200.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -178,6 +178,7 @@ static int ch9200_mdio_read(struct net_d
 {
 	struct usbnet *dev = netdev_priv(netdev);
 	unsigned char buff[2];
+	int ret;
 
 	netdev_dbg(netdev, "%s phy_id:%02x loc:%02x\n",
 		   __func__, phy_id, loc);
@@ -185,8 +186,10 @@ static int ch9200_mdio_read(struct net_d
 	if (phy_id != 0)
 		return -ENODEV;
 
-	control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
-		     CONTROL_TIMEOUT_MS);
+	ret = control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
+			   CONTROL_TIMEOUT_MS);
+	if (ret < 0)
+		return ret;
 
 	return (buff[0] | buff[1] << 8);
 }



