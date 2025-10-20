Return-Path: <stable+bounces-188183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A2BF25F3
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AEE4624D5
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346BF279798;
	Mon, 20 Oct 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQyqWeAl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862F1F875A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977185; cv=none; b=HoJ46g2ffVA34s7dInCLieoYycgiP8C7BCK2c1lAxCA/z7Jvw0fYfZMwhC7zSEKpVo38H+DHhKhby4MoWX1HthbecqX82q1R394Q8T4Q1osyx7mLTo+fSKb8gZURST1R8vIliiDsHZI/T5PszZSHaW48491jn5FSe3d8vgOWJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977185; c=relaxed/simple;
	bh=qTTbB5kIrVVchEgwMnPPJ54SgqHLNUUJFf2BBpAkVZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtCr/JJQ4FW+VwGdaGWJTo/5BpkNa1OrUCn4QXXmVcKtFXMxvOOxDQtZRBvKXxTd/hms+3NuycGaNT0wNhDgcxeoZhIm4rwYPlpwJICVqOCA2lDE3VKXkOrF+8KJ0aKMSkLYER625F14M41eS2yfxsHEC8DYxzr+mdhggjXA/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQyqWeAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAFEC4CEFE;
	Mon, 20 Oct 2025 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977184;
	bh=qTTbB5kIrVVchEgwMnPPJ54SgqHLNUUJFf2BBpAkVZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQyqWeAlPvmrpOYFspu78sBObMf3u+82ry87HYdbGOQPqcU/Iy9czjg/cuRBMEtwz
	 q+BWvvnrjKLB2GKX2dHgnr641qyc0PVmaSzYbi8YLaTKIH+uQKcpjJkCTf2RM3Xrei
	 6CcEGGmR9NX7LyITVxtmfmTtweBnFhvqSkWZ+M6NFbGTIW0smE22bnuz3KV7W9BGxm
	 ZftT+Kqns1QTEos+/Fgvj5Bf43MYeZMGvCS4fnF2NLRgOim5Wj5x4b2+Z6yVt1K+0J
	 dnsQwFrwrp4iTx3wuD0kx6QlNkiSxKstCUQrMblFai+FlnYuAS1L/5wxWSA5e9aTih
	 KI1XrAK5asiWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Mon, 20 Oct 2025 12:19:40 -0400
Message-ID: <20251020161942.1835894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101616-unhappily-flatware-0bd2@gregkh>
References: <2025101616-unhappily-flatware-0bd2@gregkh>
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


