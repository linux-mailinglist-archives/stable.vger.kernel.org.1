Return-Path: <stable+bounces-38516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C728A0F02
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0071C21E99
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F78914600E;
	Thu, 11 Apr 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xLjNYpFk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA51465BE;
	Thu, 11 Apr 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830803; cv=none; b=eseStkSDwl8d5unk/Rs4C/2EIeP+8ex7XoGbbII/DEHYxyay0Hx/UBYf6rEIEumv7etCzns+36rhNlbdG2bW9q5VWQbCtF8jwXXVIyWpIiU3y21+vjD7FkFqIen/pn9lwUBYdyptfoVAiTrp9FteOyIC//sgVBmIz+xTfOIm00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830803; c=relaxed/simple;
	bh=PtrdiW0Xu3SC9/yT9+d/MNliiAYswe7NMC/lLTXfxG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGyyZq4B5PKAPWim9JFKRnCplGPKGosI/0Xq/rgGoQZIuO5+AZ+ECjf9Dlek6XV56YA5uaV06v8U5MSQr14IqnT3T0WrwyES2zOZ1sD1wj87313E6xrQPGJQAwR9Ikd5Ce6vBt97M2XbK0bD3MzdgQ/GN/v/eURodvwuFdeUGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xLjNYpFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AB5C433F1;
	Thu, 11 Apr 2024 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830803;
	bh=PtrdiW0Xu3SC9/yT9+d/MNliiAYswe7NMC/lLTXfxG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xLjNYpFkV3/+WuWICshk3a2C6ZVrAjOOaKHtIGQJ9Gm0tHL7Wj3/N1d+5vgj46i3n
	 XYqYh9j654+hRTFfTI1BzgLeUgtUf47Vv6SQBy5Getpgb9dXUOa0gRI3LxO/P/C4U5
	 YtCt5h51y8ia62a8kjrp69n8JoaIomMB16hzJ53c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Stern <stern@rowland.harvard.edu>,
	yuan linyu <yuanlinyu@hihonor.com>
Subject: [PATCH 5.4 124/215] usb: udc: remove warning when queue disabled ep
Date: Thu, 11 Apr 2024 11:55:33 +0200
Message-ID: <20240411095428.626231917@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

From: yuan linyu <yuanlinyu@hihonor.com>

commit 2a587a035214fa1b5ef598aea0b81848c5b72e5e upstream.

It is possible trigger below warning message from mass storage function,

WARNING: CPU: 6 PID: 3839 at drivers/usb/gadget/udc/core.c:294 usb_ep_queue+0x7c/0x104
pc : usb_ep_queue+0x7c/0x104
lr : fsg_main_thread+0x494/0x1b3c

Root cause is mass storage function try to queue request from main thread,
but other thread may already disable ep when function disable.

As there is no function failure in the driver, in order to avoid effort
to fix warning, change WARN_ON_ONCE() in usb_ep_queue() to pr_debug().

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable@vger.kernel.org
Signed-off-by: yuan linyu <yuanlinyu@hihonor.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20240315020144.2715575-1-yuanlinyu@hihonor.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -273,7 +273,9 @@ int usb_ep_queue(struct usb_ep *ep,
 {
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!ep->enabled && ep->address)) {
+	if (!ep->enabled && ep->address) {
+		pr_debug("USB gadget: queue request to disabled ep 0x%x (%s)\n",
+				 ep->address, ep->name);
 		ret = -ESHUTDOWN;
 		goto out;
 	}



