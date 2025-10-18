Return-Path: <stable+bounces-187742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B71BEC2B1
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B8644E5592
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D08634C;
	Sat, 18 Oct 2025 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxASoWbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAADDA92E
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747370; cv=none; b=WNTu140TO3rPG3bQkLXgv+8ifcsGBEe2IduOq2Kfq4A2PRUv09gPvern+JbLWqljeNJREz8XfnxsS5Psdv5whESSGHL6LRsLb/rauvNE1BkR4EusLyqIVN5s47EmrXCYe3a5hwoomfhrksMTEIF8yewY3lDHUVxV5ydHtSR1uQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747370; c=relaxed/simple;
	bh=Mc4xkfuy4abnAYTEEZEJyq6LL44a+i1TrvOp/gepJr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPsarKQ011BqpTyAIqJoghAOkLzAcv00m8nuOMcHwPfiNGfT8zhZVQE3Akc3glPaHs9dr8BlH1UsCTKv2YoA8NTv6JjXf0A7XaqoiEJwAFNaCRk6cyYTRu7QDjVatNWk3AxxcEFe7XGTVgL1JC4p5GFnx8M9IjLNGn+Kr8Qmojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxASoWbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADA4C4CEE7;
	Sat, 18 Oct 2025 00:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760747370;
	bh=Mc4xkfuy4abnAYTEEZEJyq6LL44a+i1TrvOp/gepJr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxASoWbpaWGWOs6QPh9Ow9hx4Hc7YRrnMXOAWsoouhYvggugKjpk9c2hZL+dlgZhD
	 /X8rRg6cNmf1lPVk1TDWc+35YsK+ItYDhzBjP9AdBUfoGoypNj/YfsVhQz9DqSldy2
	 l02YyNjcJMaM2CVOTsCpBInfrPlVJNxEBh6jcbLsPz/xJ8P0z/EMx7RwqSQDaDbMgC
	 1QTUP6Tudpbmi2KlKqnbGzWzHUS5cZ+JW5cYIYmMwzjCTBtTjyBjORiPkf1tXokI+E
	 Wapdhp7SV56ODJBY8B78NJExBsfJ+LJBgyXQXtoOpLPsONmomprCXwrx0awkBELVB1
	 WTKStns2qOolQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 20:29:25 -0400
Message-ID: <20251018002927.85194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101617-overbook-seventeen-a027@gregkh>
References: <2025101617-overbook-seventeen-a027@gregkh>
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
index df33333650a0d..77554f4446651 100644
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


