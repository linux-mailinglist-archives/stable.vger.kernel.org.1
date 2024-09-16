Return-Path: <stable+bounces-76406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A062797A193
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10EC1C226A2
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01F1553A7;
	Mon, 16 Sep 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XaVDMCA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5D154BFB;
	Mon, 16 Sep 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488501; cv=none; b=hQdB4OA6wTZq2iuR1vYWTWQms7zFELOJZmi44ryS7OdazDlrrDDL0IVB8FkUN8RMD6NSr79INNGEh6NKCFQPRPJ9I+JklsN5pYZIz5ifBBUDX1RR/WISUGuV4IXP8EjiUDsOchl4+my8oqMFOdYwO29ftMLqyBuUwh+7iEU9g4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488501; c=relaxed/simple;
	bh=MLVhKtJCHRhI8d034OKM0b2aN1Bb4jcLGUBbclH/z5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9SYHEt4lWTzAUBW4pZbXrmJos0AvqhXh5aMj5fj/6H+v94muyEXanvImVESfki1jsRFC8N/UeXxIkYhEkXg2KKU7UPJQeGZ3D97U6Se3WxeBEeqz6FVYrXycfdl7KYgVKGS01DqjAV6dHzBiQ0NA5sLTDdl3ryWApNmnwVfVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XaVDMCA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B824AC4CEC4;
	Mon, 16 Sep 2024 12:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488501;
	bh=MLVhKtJCHRhI8d034OKM0b2aN1Bb4jcLGUBbclH/z5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaVDMCA+5zl8n5IGVXSojvBlnAAA4mlgosjwLBJRf4nmLtpeCJhMZFTtW73r1koNC
	 gZ8FG8GSJJiMhyTUE+R2X+QemSA10ZxfhjB2HA+gjqjbbhJ33rcVBGmHW0W1LynpJs
	 r4B83+Pvt0fhq6Rhir1o4wrqBx9V61Vp5PtWug0k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Foster Snowhill <forst@pen.gy>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 14/91] usbnet: ipheth: do not stop RX on failing RX callback
Date: Mon, 16 Sep 2024 13:43:50 +0200
Message-ID: <20240916114224.999248924@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
References: <20240916114224.509743970@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Foster Snowhill <forst@pen.gy>

[ Upstream commit 74efed51e0a4d62f998f806c307778b47fc73395 ]

RX callbacks can fail for multiple reasons:

* Payload too short
* Payload formatted incorrecly (e.g. bad NCM framing)
* Lack of memory

None of these should cause the driver to seize up.

Make such failures non-critical and continue processing further
incoming URBs.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index f04c7bf79665..cdc72559790a 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -308,7 +308,6 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 	if (retval != 0) {
 		dev_err(&dev->intf->dev, "%s: callback retval: %d\n",
 			__func__, retval);
-		return;
 	}
 
 rx_submit:
-- 
2.43.0




