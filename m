Return-Path: <stable+bounces-7601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 023CF81734A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE78B248D4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC95498B7;
	Mon, 18 Dec 2023 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+nYMo2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E0498B2;
	Mon, 18 Dec 2023 14:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A5FC433C8;
	Mon, 18 Dec 2023 14:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908902;
	bh=1EPl7KYBv8xzkiUS2vSecwoYLBUQ2dwUi0C24RIKcLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+nYMo2U7/ptLQBPfwwyWI6yhAavtyQAn4Bx7Mgs/KV2bxuAzFP37yZWNAn2hdQiB
	 r8hHaNrePH9Ax5o0n8F/H4C3AFkAB8DDThJn9Fn2xwg6WqcffdEEtEhxCMj5EEf6Mf
	 8kcpriexwD3HTnGv9dK+qgeCdkCkveXSgTdX6LUo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roy Luo <royluo@google.com>
Subject: [PATCH 5.15 76/83] USB: gadget: core: adjust uevent timing on gadget unbind
Date: Mon, 18 Dec 2023 14:52:37 +0100
Message-ID: <20231218135053.089427745@linuxfoundation.org>
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

From: Roy Luo <royluo@google.com>

commit 73ea73affe8622bdf292de898da869d441da6a9d upstream.

The KOBJ_CHANGE uevent is sent before gadget unbind is actually
executed, resulting in inaccurate uevent emitted at incorrect timing
(the uevent would have USB_UDC_DRIVER variable set while it would
soon be removed).
Move the KOBJ_CHANGE uevent to the end of the unbind function so that
uevent is sent only after the change has been made.

Fixes: 2ccea03a8f7e ("usb: gadget: introduce UDC Class")
Cc: stable@vger.kernel.org
Signed-off-by: Roy Luo <royluo@google.com>
Link: https://lore.kernel.org/r/20231128221756.2591158-1-royluo@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1451,8 +1451,6 @@ static void usb_gadget_remove_driver(str
 	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
 			udc->driver->function);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-
 	usb_gadget_disconnect(udc->gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (udc->gadget->irq)
@@ -1462,6 +1460,8 @@ static void usb_gadget_remove_driver(str
 
 	udc->driver = NULL;
 	udc->gadget->dev.driver = NULL;
+
+	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 }
 
 /**



