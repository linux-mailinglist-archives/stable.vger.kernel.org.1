Return-Path: <stable+bounces-187769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636DBEC36B
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 223394E26E3
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89A1CBEB9;
	Sat, 18 Oct 2025 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzVXQSgl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8AD14B08A
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760750611; cv=none; b=DXkbm0oUZt/Z79dzb+bogApy+QSQVSs9u7rKKmzaIzwFfXqM6Tk6tI1CUKHi44zYgsgUm4elLZ5DPx3Ue0uKDkE6tb9Nb/LBBLxLvzy6al/dV2dFWEtjrj3JPolesPv/5UsEWoCiTFE1oefcZzVNUQ0bUzMFI7Ry+CMdd+zhvHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760750611; c=relaxed/simple;
	bh=h9FkXLm7fpf8LAEAEa5BCLMuZOQFmGW8b9JU0hMj4r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM1mqSViwiibdrSkpHVLl7nUz8NTDay8JxsLWoUxhn3G9V1Ug78XZ7BUAAIAVx5hmOoS1P3TSPWHUL3ko44VQg8VSBJKC4V+5sSl6aoppyBEyEalCs41o0fPLImKwe4UqXG3Ez1FVKeArXfbuhvQ9wmv7uwpS2OdrvKyPsqZb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzVXQSgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD92C4CEE7;
	Sat, 18 Oct 2025 01:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760750611;
	bh=h9FkXLm7fpf8LAEAEa5BCLMuZOQFmGW8b9JU0hMj4r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzVXQSgljG44Xngc6kDkC+23yUBB3FRW4XFFJuZ8VRwmgyvL9f90gdiGy3oGxDa0d
	 sg3e4rM4v6cuVrWhXxujPXG2LOTJ34pKwdFKrqolHAiHG4fepZNvweOgnDTfc0ss0O
	 umKFo7pXe6GSMag6nKGJc32drN6R16bHfJfRZbXy9xVQVG0JnQaFOda59euob1yVA5
	 CwjBPeZk5QA+k9mgN3Y3vf2X8ZU4fQftcfB/SN8yNk8P/nBc1FAsvwLjempcwjWdQE
	 l83kmgAli0aOfrlLhsCgy92bvpOMyEf19hL7Gto7ooOczg7nCvF0tXIGNI7hc8eRxe
	 uSLrhYPgiREcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 21:23:26 -0400
Message-ID: <20251018012328.141282-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101615-womb-deskbound-19cd@gregkh>
References: <2025101615-womb-deskbound-19cd@gregkh>
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
index 5adb6e831126a..d98da3c44ff5e 100644
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
index 705b76f8dddb2..9a4d800cdc1e3 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -31,6 +31,7 @@ struct usb_ep;
 
 /**
  * struct usb_request - describes one i/o request
+ * @ep: The associated endpoint set by usb_ep_alloc_request().
  * @buf: Buffer used for data.  Always provide this; some controllers
  *	only use PIO, or don't use DMA for some endpoints.
  * @dma: DMA address corresponding to 'buf'.  If you don't set this
@@ -96,6 +97,7 @@ struct usb_ep;
  */
 
 struct usb_request {
+	struct usb_ep		*ep;
 	void			*buf;
 	unsigned		length;
 	dma_addr_t		dma;
-- 
2.51.0


