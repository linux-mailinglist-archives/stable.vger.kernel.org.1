Return-Path: <stable+bounces-81051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37102990E48
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7C81C21ED4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C431DE3D3;
	Fri,  4 Oct 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMo/usSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86B222A77;
	Fri,  4 Oct 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066577; cv=none; b=mZcpCIbXwbpLpj/IExrPWgkR+lf/SuTFwj47zIGBszFZ+6r6gh38ozNfQSC+EOQfVVj4i66LcwZrul3Uzhy0gY6F8LgDcjU9GAYqGCJH3Y9MiUroO+IAgWd1GYvoIwPJJjwwRoOlHriyuDPZrqD0tvFkcqVN8L3gI77xwJVwsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066577; c=relaxed/simple;
	bh=bu5Z0E6N2acCWjvUkk7zjgX/qKL5z4ObGIZ2Jshd3Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adal9gYx6TFNVVFM30+IsBEeYyGDpNT1dWkYUo+mtAlVDxQRxg/DUXqCd0cyBaCmPZZS8EFJEizswaqsbcbO1juidbTN9CBuY01UyJ+/Y8Rd2cyFL1AjWDXAWFQDaWHAg1f/uQbcIqfodbo3Kx2ZKSeT9RgHv6uHBe4a7zRiEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMo/usSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD07C4CEC6;
	Fri,  4 Oct 2024 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066577;
	bh=bu5Z0E6N2acCWjvUkk7zjgX/qKL5z4ObGIZ2Jshd3Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RMo/usShvkI4Ij4fXAX8QnWLXOAfyxPzpHR/JYaIrnlRse1X2Zs1zHUFzfArSkTI3
	 02RtkP3nVy9sFQ1Mxrnq6WTW6G7v9jz1eXdnzRgYgKM24AOw83RgMeK6NS9NTxi4IS
	 OO6QqVZkfNfBfX/Q7+11+iU8fg1fbL1c5oDtugNbYXXK2pqaZCf8QCBAJvJ1T5i0Hp
	 3XH6+APt5x8cCczsR4xbxSOPH1vwamFWYXjY8SlMm/69ghPknfwxzN4uvxGFev4b8E
	 r/dXk1Rpxr76hOQe6oDYlL0FcpdN73HwexNCf4g835Z1i9MjsTRp77TLxcVUFSO7uh
	 DT1D2CEH+0cBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 24/31] usb: chipidea: udc: enable suspend interrupt after usb reset
Date: Fri,  4 Oct 2024 14:28:32 -0400
Message-ID: <20241004182854.3674661-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit e4fdcc10092fb244218013bfe8ff01c55d54e8e4 ]

Currently, suspend interrupt is enabled before pullup enable operation.
This will cause a suspend interrupt assert right after pullup DP. This
suspend interrupt is meaningless, so this will ignore such interrupt
by enable it after usb reset completed.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240823073832.1702135-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index aacc37736db6e..8b6745b7588c7 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -84,7 +84,7 @@ static int hw_device_state(struct ci_hdrc *ci, u32 dma)
 		hw_write(ci, OP_ENDPTLISTADDR, ~0, dma);
 		/* interrupt, error, port change, reset, sleep/suspend */
 		hw_write(ci, OP_USBINTR, ~0,
-			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
+			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI);
 	} else {
 		hw_write(ci, OP_USBINTR, ~0, 0);
 	}
@@ -868,6 +868,7 @@ __releases(ci->lock)
 __acquires(ci->lock)
 {
 	int retval;
+	u32 intr;
 
 	spin_unlock(&ci->lock);
 	if (ci->gadget.speed != USB_SPEED_UNKNOWN)
@@ -881,6 +882,11 @@ __acquires(ci->lock)
 	if (retval)
 		goto done;
 
+	/* clear SLI */
+	hw_write(ci, OP_USBSTS, USBi_SLI, USBi_SLI);
+	intr = hw_read(ci, OP_USBINTR, ~0);
+	hw_write(ci, OP_USBINTR, ~0, intr | USBi_SLI);
+
 	ci->status = usb_ep_alloc_request(&ci->ep0in->ep, GFP_ATOMIC);
 	if (ci->status == NULL)
 		retval = -ENOMEM;
-- 
2.43.0


