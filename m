Return-Path: <stable+bounces-187752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C6BEC2FF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41E634EC73C
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147B1805E;
	Sat, 18 Oct 2025 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt3H5r17"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D6354AF8
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748329; cv=none; b=bIBPjVazKvgHXh1pjmlmZG3ewwv4XiYMZp3PnARfBQjqWRVVwODtLh2ZRgqVrVleM9FbgGl6wAKRQnvoLHatR3pLxdMPnUY1OycpiTKA7Qz/gMHmO3T/ydW2K3Yw0t7B54+YHxrRWKCVlEckCNrlWvrT5MrAwSoz+aEVJDu1xzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748329; c=relaxed/simple;
	bh=TG7yaM2HbT7IEV+1EfXTpn9y5OW1tWl3SbYabXI6Kio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhEcYGVcTxS0iGlSu4AZt+BXvz2v44mBVXuwGSUC+6u7zvg0XcL8tNWPT/vUzUwUjc2/+Qwyxo8DztEi0gmqvC5nnInszxwnvqjA8Ht3M1WW+8slwGnZ1/w+IWIMmjwnYtMfL2aHmqdl+l+cHoH4590LqyHs7xL2qBCA6i2jH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt3H5r17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDE7C4CEE7;
	Sat, 18 Oct 2025 00:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748328;
	bh=TG7yaM2HbT7IEV+1EfXTpn9y5OW1tWl3SbYabXI6Kio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rt3H5r17ho+E11J+kcrh1ZArtuogM+Go8QtkF1D2Lf3JCTOL8nodUGcRrRCRtiRRo
	 HLvRGg3Wf1i9MRffsG0lnTIDm/xpG5DqQcwP7Pf9sFw8Voe0JeD2Ht6Yw2x0D/Lh+O
	 VN166rkm/OW0+evVGfPvHopSoBCFRaPQaI2O2Jq6IIHzwNhB/Tq3RBTIOdPrf8HIhF
	 RR1G5zkHQpRTY+kh+OXuL/8bftKjqIziNj0SmScSg26qf3Glz4ZMvgpdg0ekGHujay
	 oT7CdCVN5O53g9SNHPAgCj8myHvk+ySOAdSb3+Q8ASTMJUYFrHbKC6Gdjcjc3wf+Pe
	 g1P7/H7SQub7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 20:45:24 -0400
Message-ID: <20251018004526.94714-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101640-mastiff-grimace-b0aa@gregkh>
References: <2025101640-mastiff-grimace-b0aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit bfb1d99d969fe3b892db30848aeebfa19d21f57f ]

Gadget function drivers often have goto-based error handling in their
bind paths, which can be bug-prone. Refactoring these paths to use
__free() scope-based cleanup is desirable, but currently blocked.

The blocker is that usb_ep_free_request(ep, req) requires two
parameters, while the __free() mechanism can only pass a pointer to the
request itself.

Store an endpoint pointer in the struct usb_request. The pointer is
populated centrally in usb_ep_alloc_request() on every successful
allocation, making the request object self-contained.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://lore.kernel.org/r/20250916-ready-v1-1-4997bf277548@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250916-ready-v1-1-4997bf277548@google.com
Stable-dep-of: 42988380ac67 ("usb: gadget: f_ecm: Refactor bind path to use __free()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/core.c | 3 +++
 include/linux/usb/gadget.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d709e24c1fd42..e3d63b8fa0f4c 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -194,6 +194,9 @@ struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
 
 	req = ep->ops->alloc_request(ep, gfp_flags);
 
+	if (req)
+		req->ep = ep;
+
 	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
 
 	return req;
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 0f28c5512fcb6..0f20794760887 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -32,6 +32,7 @@ struct usb_ep;
 
 /**
  * struct usb_request - describes one i/o request
+ * @ep: The associated endpoint set by usb_ep_alloc_request().
  * @buf: Buffer used for data.  Always provide this; some controllers
  *	only use PIO, or don't use DMA for some endpoints.
  * @dma: DMA address corresponding to 'buf'.  If you don't set this
@@ -98,6 +99,7 @@ struct usb_ep;
  */
 
 struct usb_request {
+	struct usb_ep		*ep;
 	void			*buf;
 	unsigned		length;
 	dma_addr_t		dma;
-- 
2.51.0


