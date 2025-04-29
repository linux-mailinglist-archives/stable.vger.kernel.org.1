Return-Path: <stable+bounces-138836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F8FAA19EC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517BE17537B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1712517A6;
	Tue, 29 Apr 2025 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P5hc3kAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E95242D73;
	Tue, 29 Apr 2025 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950504; cv=none; b=BjTOtwSjXG5QQh8Po1DkwFUY2Qttp5njdIe3sKUrcjKGaCpk/dfVCP7KIF9meKJqwZreRgo4I26tejcBuX1q/curmJJMXXO7FdGQiSyN+MvB+xZkzOSDGot0/d9+R2yka13uD5RysL2ud4XfY23xmbEKUUcMD93LfsCQr12mwdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950504; c=relaxed/simple;
	bh=J5M6KMxfUWnkmpFGYTzzJl6DMfNLJ9KDXdRvvOOAJfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJh7p60LTgUNsyIJmK1/DdJwY8VaZCou8iYy6qMcpFgdm08rZpiWnTHXFDBMBxcg2chvp5YvVDgFSgFRhEoeqF8iH4neKybTd+NoP5KIkXIrXhyPoAN5V0r1egcVVvD7GXodH3SC+NosohsAXTNttfgyWeXxLGYek1DjhjY0tRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P5hc3kAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E310C4CEE3;
	Tue, 29 Apr 2025 18:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950504;
	bh=J5M6KMxfUWnkmpFGYTzzJl6DMfNLJ9KDXdRvvOOAJfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5hc3kAaRTJkuVmR1/8bjqOgx8T5xl+dbP59NAn7I2EuRGuOQTgmwuAki2LrIGfNl
	 55zm537YqHT0VTKyPOUJ7t3XxPCZWftOdMLBKLOP3BzUy+leBgFuFEVUBwqrXL5+uW
	 tyJ8kqPRcGPEMHRoqY7HkZN/usb3t48i+nPYU1uk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 6.6 116/204] USB: wdm: add annotation
Date: Tue, 29 Apr 2025 18:43:24 +0200
Message-ID: <20250429161104.181984567@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 73e9cc1ffd3650b12c4eb059dfdafd56e725ceda upstream.

This is not understandable without a comment on endianness

Fixes: afba937e540c9 ("USB: CDC WDM driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20250401084749.175246-5-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-wdm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -909,7 +909,7 @@ static int wdm_wwan_port_tx(struct wwan_
 	req->bRequestType = (USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE);
 	req->bRequest = USB_CDC_SEND_ENCAPSULATED_COMMAND;
 	req->wValue = 0;
-	req->wIndex = desc->inum;
+	req->wIndex = desc->inum; /* already converted */
 	req->wLength = cpu_to_le16(skb->len);
 
 	skb_shinfo(skb)->destructor_arg = desc;



