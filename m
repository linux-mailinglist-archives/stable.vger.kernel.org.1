Return-Path: <stable+bounces-71269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8AC96129F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A21C22D2C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF41CFEC0;
	Tue, 27 Aug 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l9enT6xD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E501C93A3;
	Tue, 27 Aug 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772654; cv=none; b=AL9A9B0OXQBRMSnp+6d0BSC/AxhNTGomPKkKbCXIbHDhCy7TRAToR1cEkeLyh98OM96ZNJFQZD8diC29ReZSajpc8TvWIOAYpohRfCSKmYD9jez4kuo50NUc9KXhkarpxlCEZTvhrSI5BsCq6FkrrJVn0HOR2olXAr73ldnRsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772654; c=relaxed/simple;
	bh=ZLYirR+SXVpRAa5vKIchJllci5tRQw4pskfLz+iTUaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2J+XBow6w5AWt/v9qQWbR1WKWMJFnhzziI1nb1lcAq61OFIbtM9E8/Glj7ziQzOHbTjjtvodGjB1I04tE98G0OFMUoJBnnk8NtQGwOe+eNT+hS1F86K6gt863CP1A6PwbT7YVadV6REOgYVOX61yu8em+93gJQrZUDew8xSFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l9enT6xD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BB5C4DDE4;
	Tue, 27 Aug 2024 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772654;
	bh=ZLYirR+SXVpRAa5vKIchJllci5tRQw4pskfLz+iTUaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9enT6xD0iLaerjjM2Ywslei6fGDotQ32oE97Ul1J2zfdmnF3PaXyYWvRXwV7tsqS
	 8xZEz79TyVR9Mnmxq56wPuri5b1sgIohgyU/CFPTRfJ0t9l8HKjKn2gTX27u2tK+aI
	 DWakl1zwn4DK2xVU/lQhhgyYRHp/JDwDpXqExNLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH 6.1 280/321] Revert "usb: gadget: uvc: cleanup request when not in correct state"
Date: Tue, 27 Aug 2024 16:39:48 +0200
Message-ID: <20240827143848.908791719@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit dddc00f255415b826190cfbaa5d6dbc87cd9ded1 upstream.

This reverts commit 52a39f2cf62bb5430ad1f54cd522dbfdab1d71ba.

Based on review comments, it was applied too soon and needs more work.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20231005081716.GA13853@pendragon.ideasonboard.com
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/uvc_video.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -259,12 +259,6 @@ uvc_video_complete(struct usb_ep *ep, st
 	struct uvc_device *uvc = video->uvc;
 	unsigned long flags;
 
-	if (uvc->state == UVC_STATE_CONNECTED) {
-		usb_ep_free_request(video->ep, ureq->req);
-		ureq->req = NULL;
-		return;
-	}
-
 	switch (req->status) {
 	case 0:
 		break;



