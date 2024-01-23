Return-Path: <stable+bounces-13551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A39837C8D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B74E1C2890D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E633097;
	Tue, 23 Jan 2024 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ljp3KzNJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFF135A5D;
	Tue, 23 Jan 2024 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969669; cv=none; b=Fbdvls/TtqXfzsQNlFBbAMc2ov70pB50Ic1LOfgoSTQknjd1KDaKnSHgpbEShzvyxIeGr3Gwguu41MnLjTRJXHDeMzj4kqdJgd5u4CLo0rdlCR/XJmSr8HEMXtMH5Urz1jZ9U3617c4kNeEPOo60M8cPhGq9L61nJ5FWiiOXeoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969669; c=relaxed/simple;
	bh=5a78W5Im1W2+xc+sAQv41tfzSwvuMVqpejVftvB82gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkHjzaCZ9daLkAuhAfT0UuR/22CmWAQwStkYOur3c/Ek5XBftMdD11JQ1ahVtLaSNC1YiMnyhQSuVxmS5vPRVhZE1hpf9g49f5j0TKFNqKXiQ/jMnxaYIfcMc7KcN35/0HLtR9Sl9/Y1l5SZ1J45FLueVmRpXwMoj0iAQpczDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ljp3KzNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69986C433C7;
	Tue, 23 Jan 2024 00:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969669;
	bh=5a78W5Im1W2+xc+sAQv41tfzSwvuMVqpejVftvB82gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ljp3KzNJaAC6s/9UKZazpIjKNXB5RqysffceznpyJRl70GUCB8ComOMTrFqzYid3+
	 jGrLpyg5pYAJ1TGxjp11NsvKLlDd2xQPwxgnnF1uGUKYBCKQHVgkaohpS2ie8yyLBr
	 tL5xE/47FHuXksDf3x31DmHEkm8M4Z+cOUyEzEkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 6.7 393/641] Revert "usb: gadget: f_uvc: change endpoint allocation in uvc_function_bind()"
Date: Mon, 22 Jan 2024 15:54:57 -0800
Message-ID: <20240122235830.254702478@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Li <Frank.Li@nxp.com>

commit 895ee5aefb7e24203de5dffae7ce9a02d78fa3d1 upstream.

This reverts commit 3c5b006f3ee800b4bd9ed37b3a8f271b8560126e.

gadget_is_{super|dual}speed() API check UDC controller capitblity. It
should pass down highest speed endpoint descriptor to UDC controller. So
UDC controller driver can reserve enough resource at check_config(),
especially mult and maxburst. So UDC driver (such as cdns3) can know need
at least (mult + 1) * (maxburst + 1) * wMaxPacketSize internal memory for
this uvc functions.

Cc:  <stable@vger.kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20231224153816.1664687-5-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_uvc.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -722,13 +722,29 @@ uvc_function_bind(struct usb_configurati
 	}
 	uvc->enable_interrupt_ep = opts->enable_interrupt_ep;
 
-	ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
+	/*
+	 * gadget_is_{super|dual}speed() API check UDC controller capitblity. It should pass down
+	 * highest speed endpoint descriptor to UDC controller. So UDC controller driver can reserve
+	 * enough resource at check_config(), especially mult and maxburst. So UDC driver (such as
+	 * cdns3) can know need at least (mult + 1) * (maxburst + 1) * wMaxPacketSize internal
+	 * memory for this uvc functions. This is the only straightforward method to resolve the UDC
+	 * resource allocation issue in the current gadget framework.
+	 */
+	if (gadget_is_superspeed(c->cdev->gadget))
+		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_ss_streaming_ep,
+					  &uvc_ss_streaming_comp);
+	else if (gadget_is_dualspeed(cdev->gadget))
+		ep = usb_ep_autoconfig(cdev->gadget, &uvc_hs_streaming_ep);
+	else
+		ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
+
 	if (!ep) {
 		uvcg_info(f, "Unable to allocate streaming EP\n");
 		goto error;
 	}
 	uvc->video.ep = ep;
 
+	uvc_fs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 



