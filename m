Return-Path: <stable+bounces-5992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D30C280D835
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5D01F21393
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BDB5102A;
	Mon, 11 Dec 2023 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J/g9yAXy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44EFC06;
	Mon, 11 Dec 2023 18:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5C1C433C8;
	Mon, 11 Dec 2023 18:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320220;
	bh=N6b5Q0FyZEcbNPEiNxnqb0bX2DI1AUdMvr6SeS9mfVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/g9yAXyC8sWXUutabgg3E7/8BDR9D3R3CLaKPb7nd3fDHjtP25BXfz2qJ1v8hs8t
	 bdSZNq+GJ12ZUgwYAG0k0nY19T4XRmcddEHVjtiyHm2Ze5aGHMy9jWM03lye8rdVcU
	 rr39gj4c2kJJM0f/e4rupBGeLjJ/5KBQxh34Juws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Aladyshev <aladyshev22@gmail.com>
Subject: [PATCH 5.4 48/67] usb: gadget: f_hid: fix report descriptor allocation
Date: Mon, 11 Dec 2023 19:22:32 +0100
Message-ID: <20231211182017.062545116@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
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

From: Konstantin Aladyshev <aladyshev22@gmail.com>

commit 61890dc28f7d9e9aac8a9471302613824c22fae4 upstream.

The commit 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs
cdev") has introduced a bug that leads to hid device corruption after
the replug operation.
Reverse device managed memory allocation for the report descriptor
to fix the issue.

Tested:
This change was tested on the AMD EthanolX CRB server with the BMC
based on the OpenBMC distribution. The BMC provides KVM functionality
via the USB gadget device:
- before: KVM page refresh results in a broken USB device,
- after: KVM page refresh works without any issues.

Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
Cc: stable@vger.kernel.org
Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
Link: https://lore.kernel.org/r/20231206080744.253-2-aladyshev22@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_hid.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -88,6 +88,7 @@ static void hidg_release(struct device *
 {
 	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
 
+	kfree(hidg->report_desc);
 	kfree(hidg->set_report_buf);
 	kfree(hidg);
 }
@@ -1293,9 +1294,9 @@ static struct usb_function *hidg_alloc(s
 	hidg->report_length = opts->report_length;
 	hidg->report_desc_length = opts->report_desc_length;
 	if (opts->report_desc) {
-		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
-						 opts->report_desc_length,
-						 GFP_KERNEL);
+		hidg->report_desc = kmemdup(opts->report_desc,
+					    opts->report_desc_length,
+					    GFP_KERNEL);
 		if (!hidg->report_desc) {
 			put_device(&hidg->dev);
 			--opts->refcnt;



