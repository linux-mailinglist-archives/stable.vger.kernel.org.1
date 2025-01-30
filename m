Return-Path: <stable+bounces-111646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91510A23022
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788BA1888AA3
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594881E98F3;
	Thu, 30 Jan 2025 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqWwqXqa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168811BD9D3;
	Thu, 30 Jan 2025 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247344; cv=none; b=iCI7z4BcLOdfdXicWEJA7FPiUvggfQQpdq5Hz3WRGt5ztMjY/TBRRBht0VVljpAwsGpFRAHS2rn1+FL4GviI5YTZTxVh/Uvl1kJ8c/zpZfzSPa755Y3Y05bklXQe1zrLQIQ7Vgleny70FwN6VXaUDb+VxC7orUDgmBCKZH8RHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247344; c=relaxed/simple;
	bh=rWfBUhBh2L7cXWId/J/YqsqhTPLf5QJuO1FkFN0xxN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnlP6Zj79l6R+yxSLtODg84aK7Knlp6qIwud7qDctLvbu6ukO5PBnVIe3hPWs8g4gHlwfCXhRrrFb2622nQLv3inRiXsrFaVTzA9+uhNa/IzlfCNpuS8i9Fxyqx7E3R6rTe2EUeuhslzk9KgpIWMw+4zJlBBMjuzzaZF/yZ/gbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WqWwqXqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957E2C4CED2;
	Thu, 30 Jan 2025 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247344;
	bh=rWfBUhBh2L7cXWId/J/YqsqhTPLf5QJuO1FkFN0xxN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqWwqXqaEqxRAeNu3liKn64Cc5OSPRW2m1ap0COxQ3+WaCPrNLelbBOYz4CVdNyuy
	 KlzThQZ2v9BfycEOtGrDyeshEXHL3XW5wYxmVvHUQHUaw0dhw+SgKKWz+6mLASmusr
	 BX2sznoHOs2IVcBHm3AyLY6Pp4NEwhIOKmoixPFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.15 19/24] USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()
Date: Thu, 30 Jan 2025 15:02:11 +0100
Message-ID: <20250130140128.061076270@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140127.295114276@linuxfoundation.org>
References: <20250130140127.295114276@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qasim Ijaz <qasdev00@gmail.com>

commit 575a5adf48b06a2980c9eeffedf699ed5534fade upstream.

This patch addresses a null-ptr-deref in qt2_process_read_urb() due to
an incorrect bounds check in the following:

       if (newport > serial->num_ports) {
               dev_err(&port->dev,
                       "%s - port change to invalid port: %i\n",
                       __func__, newport);
               break;
       }

The condition doesn't account for the valid range of the serial->port
buffer, which is from 0 to serial->num_ports - 1. When newport is equal
to serial->num_ports, the assignment of "port" in the
following code is out-of-bounds and NULL:

       serial_priv->current_port = newport;
       port = serial->port[serial_priv->current_port];

The fix checks if newport is greater than or equal to serial->num_ports
indicating it is out-of-bounds.

Reported-by: syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=506479ebf12fe435d01a
Fixes: f7a33e608d9a ("USB: serial: add quatech2 usb to serial driver")
Cc: <stable@vger.kernel.org>      # 3.5
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/quatech2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -525,7 +525,7 @@ static void qt2_process_read_urb(struct
 
 				newport = *(ch + 3);
 
-				if (newport > serial->num_ports) {
+				if (newport >= serial->num_ports) {
 					dev_err(&port->dev,
 						"%s - port change to invalid port: %i\n",
 						__func__, newport);



