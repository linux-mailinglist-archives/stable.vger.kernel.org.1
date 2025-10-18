Return-Path: <stable+bounces-187759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDC3BEC317
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EED628212
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03371A9F97;
	Sat, 18 Oct 2025 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2FOyZlz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E951A8412
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748759; cv=none; b=OYBgNaLdVV0gbFWoHpJN51cVEOAvk7VUR/ayuhRduX/wGlgiG8jyO+tlnS4HW14a2lPWvk1JZ2xkdyiqJJWqGy/KSAMjVPwdpFOG6PiBtDhgT5LwapD8tal/yl3trALSzEOE+Hce+i2lDKVumGwODi7FD//cUBDRKNn4ch/+rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748759; c=relaxed/simple;
	bh=kG/7phsqgBPzKM1uUbWvH6hgWMhWtf3TH9qHABg41iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rn3wXzBuTx4jRYlcMvwkqTTTvwGBL+Ey+xJ7duyZxsASS3N7nnGbVWisUYNZbEHoWW5E0YgLtdNTyWQH4j0AdwHW6dhq3pbUjLaHi44e8SJ7gjGGKlGKgTHaQg1gzHh5aTUMsa2zqVZWHbD7Cu2d8+8N6LwofksTp7r7Ii/XmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2FOyZlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF79C4CEE7;
	Sat, 18 Oct 2025 00:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748759;
	bh=kG/7phsqgBPzKM1uUbWvH6hgWMhWtf3TH9qHABg41iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2FOyZlzRhUbOaAqejnr3536/zykthldmtJz2/56FqKrQWr4fq1snGqzH2fhQKKD4
	 fvOA+AzzG1TCR6jJ1AkeFguIXqmTBDym9GrpTCVMpcVrsYV3QTNPN1ka+Q5/L4O0C1
	 i6CJVvAZKVNJESUAiLIuF/ABV8c3BQ4uyFy2xEhrMWfAvHwqCEJAojqCtMunGajO9H
	 EL/M/aDvfK/YDtghPqolve0HJ9ljeun1Mh4xxbhL7VyrpG1nDVga+QGIcnCy+4+yoA
	 dpYpSmC/XnVzQIt6OOuwDMqf80OPPGwSPCMwAxpqhbPfwH9RkjwmjzgF60kBlD5L5q
	 v73ZebNYIKKig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 20:52:34 -0400
Message-ID: <20251018005236.98052-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101641-spousal-accuracy-d282@gregkh>
References: <2025101641-spousal-accuracy-d282@gregkh>
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


