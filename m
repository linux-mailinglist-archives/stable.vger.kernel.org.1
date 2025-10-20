Return-Path: <stable+bounces-188187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38370BF260E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21C63A5423
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7BD283FCF;
	Mon, 20 Oct 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvWnEZk2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080E1A00CE
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977239; cv=none; b=aFoxzgcMmTv0VHNdkXW+lpakk3LSsHD6xkTtdhUbEspHDZWu9rCmVtnErxI0y2Jc6YPOqCWzv53C3ksiwLXao7WhC5c/hyeLWmOkdl8KWrrlOA8fxkaa8NJKPauSniV7/UKBTOOwo8HoEgjm+Z0+m6NA4FkE2T2ZZ7WhsZHpUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977239; c=relaxed/simple;
	bh=Kjf/yXp+TETL5wymAGHnuLx2sBCmjzsse7HmoTS8OUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7aRWM530pUA5kNbHTle1EB/0nLy1/7e//AoqnYpBijiZQUwyzTySUxFd+JD+ZRI6idbTBU/rF4v8oYwKhnuftsxeVuaEK2nBp1V/ucLtCyugdj18obEz4w+LkNbuNRmN+dPjH0UIB4sk90AklyHIvMGHtWhHBRXA5vKvA5jdg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvWnEZk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A34C4CEF9;
	Mon, 20 Oct 2025 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977237;
	bh=Kjf/yXp+TETL5wymAGHnuLx2sBCmjzsse7HmoTS8OUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvWnEZk21BsfHHXQalYLq+8+WMMWzojDhnxZGAATciSYrXZbQeHMQFPVkrEwyiapl
	 c1dlHJHyCdh2Up8DLpVMapxPddxhpwVXhSKegI7clenzutemqhaFgX/Ovs/IUQFKIK
	 1Kr7pA+qlcf8DeyR1iXWoP4ZkWFw3FwO/7vmhLz/PKqlGFr5nW9MqOljGHXW1hLbpX
	 v+oFdTbIewViW9f8DfsXYQEWTB86hOmv5fgDyI7dRUs8QLJdj63Fq3+wUFEGj/rPbz
	 +UY/2CPiLct4DzCUQSpacw+O76uEhYvNJz43wv3If6F/zpswCmC1jaQ+hTbuaAdTi6
	 JCr0eQAvTeTQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Mon, 20 Oct 2025 12:20:31 -0400
Message-ID: <20251020162033.1836288-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101658-ajar-suggest-f20a@gregkh>
References: <2025101658-ajar-suggest-f20a@gregkh>
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
Stable-dep-of: 75a5b8d4ddd4 ("usb: gadget: f_ncm: Refactor bind path to use __free()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/core.c | 3 +++
 include/linux/usb/gadget.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d865c4677ad7c..b59b6900e7051 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -177,6 +177,9 @@ struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
 
 	req = ep->ops->alloc_request(ep, gfp_flags);
 
+	if (req)
+		req->ep = ep;
+
 	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
 
 	return req;
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e4feeaa8bab30..35dc1009a703f 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -33,6 +33,7 @@ struct usb_ep;
 
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


