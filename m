Return-Path: <stable+bounces-12745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E9F8371C0
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CE41F32DBE
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8835BAC1;
	Mon, 22 Jan 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fYzKeVqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F350270
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949142; cv=none; b=kBQlHqF9fpDIwSDjf1ZFLYpzB1Le2y7uFQxEEINUUxlsw4wun7oi1klXxG7K8g7SQnOeykCc0hdZcCzPBahFWdFEkkfGtE8nICv3/OHsg3JzXw1s65g/qgL88rWkGw8BrO0pzs3lyaTPROtFraUP3UIwj6cFxc80Vte1YyxH1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949142; c=relaxed/simple;
	bh=EzqsmD1o5vAS9bQryPPmt7XiJLFdw7NGAENZJKK3AKU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LI8+Kt5DLDnUvH+mXfIdVIeQRVRGEviqdHnSeHqYOqG70J1jCaQSJS9kXyy0cqN+iNtlZ7FqOvhcio3XCCCi7O9+xpscxreXyN+Avmia7pvgruK0h7Q7GRl9m5lZVbmsvyDpwMOYsh2Ck5ARqdQ4aNgNH8kOMpuRA0W3BxO320o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fYzKeVqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50597C43390;
	Mon, 22 Jan 2024 18:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705949142;
	bh=EzqsmD1o5vAS9bQryPPmt7XiJLFdw7NGAENZJKK3AKU=;
	h=Subject:To:Cc:From:Date:From;
	b=fYzKeVqkk4FPgbfGTLZDLT90NrDo2lTpUP1B+BNuxQ3yeyMchQntpCxM3T+NMBZS7
	 pY73uVlH6JP2zxhcuRei4Ev0d/2C+PUJnLaH92fX3jYZvb6K9OZdtftsR9bPG+ojLp
	 rkoZjyZOUgSLTMHjeEXfZsbBgHyXL5bMY8bdxBLo=
Subject: FAILED: patch "[PATCH] usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg" failed to apply to 5.10-stable tree
To: Frank.Li@nxp.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:45:38 -0800
Message-ID: <2024012238-borough-parameter-5f3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 40c304109e866a7dc123661a5c8ca72f6b5e14e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012238-borough-parameter-5f3f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

40c304109e86 ("usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg enabled")
1b8be5ecff26 ("usb: cdns3: fix uvc failure work since sg support enabled")
387c2b6ba197 ("usb: cdns3: gadget: fix new urb never complete if ep cancel previous requests")
fba8701baed7 ("usb: cdns3: Fixes for sparse warnings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40c304109e866a7dc123661a5c8ca72f6b5e14e0 Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Sun, 24 Dec 2023 10:38:15 -0500
Subject: [PATCH] usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg
 enabled

Supposed DMA cross 4k bounder problem should be fixed at DEV_VER_V2, but
still met problem when do ISO transfer if sg enabled.

Data pattern likes below when sg enabled, package size is 1k and mult is 2
	[UVC Header(8B) ] [data(3k - 8)] ...

The received data at offset 0xd000 will get 0xc000 data, len 0x70. Error
happen position as below pattern:
	0xd000: wrong
	0xe000: wrong
	0xf000: correct
	0x10000: wrong
	0x11000: wrong
	0x12000: correct
	...

To avoid DMA cross 4k bounder at ISO transfer, reduce burst len according
to start DMA address's alignment.

Cc:  <stable@vger.kernel.org>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20231224153816.1664687-4-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 4c6893af22dd..aeca902ab6cc 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1120,6 +1120,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	u32 togle_pcs = 1;
 	int sg_iter = 0;
 	int num_trb_req;
+	int trb_burst;
 	int num_trb;
 	int address;
 	u32 control;
@@ -1243,7 +1244,36 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			total_tdl += DIV_ROUND_UP(length,
 					       priv_ep->endpoint.maxpacket);
 
-		trb->length |= cpu_to_le32(TRB_BURST_LEN(priv_ep->trb_burst_size) |
+		trb_burst = priv_ep->trb_burst_size;
+
+		/*
+		 * Supposed DMA cross 4k bounder problem should be fixed at DEV_VER_V2, but still
+		 * met problem when do ISO transfer if sg enabled.
+		 *
+		 * Data pattern likes below when sg enabled, package size is 1k and mult is 2
+		 *       [UVC Header(8B) ] [data(3k - 8)] ...
+		 *
+		 * The received data at offset 0xd000 will get 0xc000 data, len 0x70. Error happen
+		 * as below pattern:
+		 *	0xd000: wrong
+		 *	0xe000: wrong
+		 *	0xf000: correct
+		 *	0x10000: wrong
+		 *	0x11000: wrong
+		 *	0x12000: correct
+		 *	...
+		 *
+		 * But it is still unclear about why error have not happen below 0xd000, it should
+		 * cross 4k bounder. But anyway, the below code can fix this problem.
+		 *
+		 * To avoid DMA cross 4k bounder at ISO transfer, reduce burst len according to 16.
+		 */
+		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_dev->dev_ver <= DEV_VER_V2)
+			if (ALIGN_DOWN(trb->buffer, SZ_4K) !=
+			    ALIGN_DOWN(trb->buffer + length, SZ_4K))
+				trb_burst = 16;
+
+		trb->length |= cpu_to_le32(TRB_BURST_LEN(trb_burst) |
 					TRB_LEN(length));
 		pcs = priv_ep->pcs ? TRB_CYCLE : 0;
 


