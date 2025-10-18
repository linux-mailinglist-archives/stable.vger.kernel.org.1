Return-Path: <stable+bounces-187749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF0BEC2D5
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4587B1AA5894
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACE6199FAC;
	Sat, 18 Oct 2025 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsHQAiaH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF77288D0
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748115; cv=none; b=jPt1969Wmu3B7dK7O9Oxd2yHTfyTw2Rpz99eDb9e02N5LoXfq323nLVfUBtqP1Fo+GW+KhG0RYRSZvi+LYkGLZiMM+vHmKfrhikxq+wRK7bJH+6QMQKhqmx0fjQojcIDjG+fC9aM0qCSdu7D6f90EhtzWOKIG2DXkGPMr7/FLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748115; c=relaxed/simple;
	bh=lvcacVYo2WaQLmqkVq3Bgs0cZ+laRg620m0cwbcP4jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHCTzzaywS9liCgUjkdenR2U/W5T43E6o3A/W0OA+5stUZoTXRYzGwTpOSXoViBTCf8GhJnoPJxNJ8nRo+XnAuZcr81mpV9YSLwEwRzj0UCfq349+gNoHJgF0eqH6/qIjjlqFOjhgIzggTo0oVu3rERnCbUSmLRr78UvFOkdeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsHQAiaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16C5C4CEE7;
	Sat, 18 Oct 2025 00:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748115;
	bh=lvcacVYo2WaQLmqkVq3Bgs0cZ+laRg620m0cwbcP4jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsHQAiaHRw4Hh3xi619B7beQSeC33AeJfKXIGcrl6yyHKeEJUiNX2wth/JW7x/efW
	 /D+RGbo89wcCr8Lz6RdsHovXPiF+WNoZHa3FYN46I0mCGPd5lkiLOjUFcljdUpO4An
	 CNIscSbQpH4Vih+haP+Ofy1rlSTfryICIblkxc5AuXcop82eTpYo5AioQoOk29w65P
	 LxXn6tapPRZnEYWiB/4nIUBuhqakxyzzfaINb5hG8+uyurmmT6/+TDHeMU6xiuSpG4
	 CK6/jkFNjbuyyku318V5rxqicZ6VCRGcng8xwZD4z5Lm/IsTgDs/iug9acdz284dHE
	 jIDhj3bsdq0Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 20:41:50 -0400
Message-ID: <20251018004152.92074-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101618-margarita-stunt-1be5@gregkh>
References: <2025101618-margarita-stunt-1be5@gregkh>
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
Stable-dep-of: 47b2116e54b4 ("usb: gadget: f_acm: Refactor bind path to use __free()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/core.c | 3 +++
 include/linux/usb/gadget.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index a4120a25428e5..25bbb7a440ce2 100644
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
index 75bda0783395a..7bd39747026e4 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -32,6 +32,7 @@ struct usb_ep;
 
 /**
  * struct usb_request - describes one i/o request
+ * @ep: The associated endpoint set by usb_ep_alloc_request().
  * @buf: Buffer used for data.  Always provide this; some controllers
  *	only use PIO, or don't use DMA for some endpoints.
  * @dma: DMA address corresponding to 'buf'.  If you don't set this
@@ -97,6 +98,7 @@ struct usb_ep;
  */
 
 struct usb_request {
+	struct usb_ep		*ep;
 	void			*buf;
 	unsigned		length;
 	dma_addr_t		dma;
-- 
2.51.0


