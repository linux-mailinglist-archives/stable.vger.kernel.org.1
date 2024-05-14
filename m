Return-Path: <stable+bounces-44771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA6B8C5453
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE7A284B05
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45756BFA8;
	Tue, 14 May 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="veOCPNSn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925362D60A;
	Tue, 14 May 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687129; cv=none; b=tV8ubPV9gdPEac7vqeDr109SBvFaCwfYrhb4lphcwWFcwdnt5TrxrI1hMbaSNe/v73wzQ0iXGMgkEZTK45ZDvLXhvrCXr20Xu35LKPoyfknXTDRkBEb28Y2xkoogylCwV1HSXovzYt+1Xk0ruDNkSPBNgoCKIO3wF8sqntzmz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687129; c=relaxed/simple;
	bh=wTYGmWTtDq8o1zuieOf7okJhABMi0r/WOqa68qPYI2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpVk52Nd3efgHcxrJZrzLTiy8EXuMce2B/VY0K4kZJB9zNTFyZsWtpMGK2/zPxwAj89qn1oUdpyPFHUZ1fTxmlbZBE7h4H4jkUDbUtxVi7Uk+7IVxUCF9C0VEwe9SmeTDYFjWPr2UCgHtQlJGKDJU1B+6UbKvMHp6jxi3eD/WGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=veOCPNSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF30AC2BD10;
	Tue, 14 May 2024 11:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687129;
	bh=wTYGmWTtDq8o1zuieOf7okJhABMi0r/WOqa68qPYI2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=veOCPNSnCjrUjjpZY4dN9160HowEMBOjG/g6y/hBPRsjge5pJvouOPOHv6mMQHN66
	 QUz/tFa1FiwEwDmI35EEvYCsITHLF4AXQ/VtxnlQ1fOsVpNM5BZoliXb9wVn+xR3um
	 6wck9s+8qkWDm7EOYONdt+NHzS6s2t4l10S/r2aI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Chris Wulff <chris.wulff@biamp.com>
Subject: [PATCH 5.4 75/84] usb: gadget: f_fs: Fix a race condition when processing setup packets.
Date: Tue, 14 May 2024 12:20:26 +0200
Message-ID: <20240514100954.501504042@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
References: <20240514100951.686412426@linuxfoundation.org>
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

From: Chris Wulff <Chris.Wulff@biamp.com>

commit 0aea736ddb877b93f6d2dd8cf439840d6b4970a9 upstream.

If the USB driver passes a pointer into the TRB buffer for creq, this
buffer can be overwritten with the status response as soon as the event
is queued. This can make the final check return USB_GADGET_DELAYED_STATUS
when it shouldn't. Instead use the stored wLength.

Fixes: 4d644abf2569 ("usb: gadget: f_fs: Only return delayed status when len is 0")
Cc: stable <stable@kernel.org>
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
Link: https://lore.kernel.org/r/CO1PR17MB5419BD664264A558B2395E28E1112@CO1PR17MB5419.namprd17.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3422,7 +3422,7 @@ static int ffs_func_setup(struct usb_fun
 	__ffs_event_add(ffs, FUNCTIONFS_SETUP);
 	spin_unlock_irqrestore(&ffs->ev.waitq.lock, flags);
 
-	return creq->wLength == 0 ? USB_GADGET_DELAYED_STATUS : 0;
+	return ffs->ev.setup.wLength == 0 ? USB_GADGET_DELAYED_STATUS : 0;
 }
 
 static bool ffs_func_req_match(struct usb_function *f,



