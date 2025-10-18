Return-Path: <stable+bounces-187736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF0BEC278
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3BA406BA0
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456A4C6C;
	Sat, 18 Oct 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2wXNDSR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B581388
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746671; cv=none; b=NCutl3ExBgLl/rmEdJt0tPSamLqFD6rswDxRNZCbf8XRH0uT2AQOCm9J7XgPslBHF4HCB8WlxMuuuGvc+Lgwm0fKuw08DbPmE84LcYthlevADxp/I34Fe2qd0JV/wzTwseSDeia1Y50yE5K53H1M7tn2K0VN8vTIWC2jpLXfbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746671; c=relaxed/simple;
	bh=zurltcHcTc2VU2gNbm8UpGDeqEDpbu/27mRlCw7uvl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEsHynUrCjkJr5za/rkORI7OtlRkz3pPOojCfPuWZfPpsrEmoHeRlbVuoEmrIe9vWHuBgSdnBWlhzk3R5+rIDekHK4D9gvUYy4WdARPbjL3lzIas5CfvsEtN6Y1uzdpm6BaoDkxtA6IdUnoMmZfcGVGpqOqkcuGagfqJmkDX0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2wXNDSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D376C4CEE7;
	Sat, 18 Oct 2025 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760746670;
	bh=zurltcHcTc2VU2gNbm8UpGDeqEDpbu/27mRlCw7uvl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2wXNDSRhrjI2peTi5FyUB9FRUuxWdLfd6yU50Ic8xisyMtzskmgkQwtI23HcbZ63
	 VOS1GX/imi7VWeW47+SFYDrAcuxRZzXFul8aDqmHLe+DtMJ05hLWCW/6W3S08HbdKA
	 ERXn3iUmBa5WSFd5anBxGEuvsyg3VU4+B6no5UfShHTAG2fQFyW7PFamqUEIVSgX2T
	 Wod2y3niP/PD9SVhW0mfClRmtp5tbX79SKBLIydu4G8TsfkW2QBSUr2mIvoCQ4RAOh
	 Rw+QvedI1DDJKvweTiWsXQlhZ/UjA8AgVwAihC+jt2RKg1+Wl5emb4Hg6YbLwMmPov
	 yAwOqLXN59uEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 20:17:46 -0400
Message-ID: <20251018001748.76008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101617-yield-come-49f4@gregkh>
References: <2025101617-yield-come-49f4@gregkh>
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


