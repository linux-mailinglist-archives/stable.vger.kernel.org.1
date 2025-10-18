Return-Path: <stable+bounces-187776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5ADBEC40B
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C46119A8032
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E91F8AC5;
	Sat, 18 Oct 2025 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyGBV5vD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5A178372
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752659; cv=none; b=VmFrblxphgfCNPDsNt3eX5fSgkBDoRQqs2iBHonMkyVAUK/t7CQChOGcmVkR5mUCVLCINBZHIQcLFPe2DoaaA9/rwAJ2JV2YqDWPsVVLja/AK9AmLbFPldOJKfe1zfxsLVySNSRrZrg/Juyj91IN7FLmjUID0dY7/O5uFxfu4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752659; c=relaxed/simple;
	bh=Yp6EJJVmjRPLlO2UOIWkbSE8V6O+6iHuk1vVn61EPCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koU59eYZa+7DgYxZyxDc7gKQL97cMaEY7tJ1or6eJvN3IEopZV4bM0nZjg0TE+EJ5Dwxt9CMQWf81VbnMFiZpQnsyUqjBbR2Pn0E2vZyjGvbmMcTW0ljAa1VioFj70rVqQK8M0R70o0TUmdi/TE8hQZ7vXhsUS8J0QMnTSkrpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyGBV5vD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D37C4CEE7;
	Sat, 18 Oct 2025 01:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760752658;
	bh=Yp6EJJVmjRPLlO2UOIWkbSE8V6O+6iHuk1vVn61EPCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyGBV5vDvcK+7f59D3W8IbiUcVYurTgcHBZaZBenHlWKV/1VIe7QHfazcPYmCY8R0
	 wauwTfGPE7rxyTQ44fTlstK2ZuWHTkkeLZ588LB/09ukSpVaTTjZF1ma2SrSe3vHgV
	 FubckjwnWZns0Q3sLNVAhQZdlIjLTXqTrhBekcu/wMFv7IEkCJ+bEbbkEqMH9FKfZP
	 MqaDQQRF3MObUUqZnPXkUlthO2KbB+OrdQT0Mmm4hsa0p+28xzwK4Fpi37c2xmPh5m
	 TjiRC0o4xMqqM/7UkkLGK89UsaqO+wx0hl0fuxg06zo06FDA/EsLu7R7zRIeV/PO4X
	 YlAikW2P/2jcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 21:57:33 -0400
Message-ID: <20251018015735.165734-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101630-mundane-sixties-ade4@gregkh>
References: <2025101630-mundane-sixties-ade4@gregkh>
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
Stable-dep-of: 082289414360 ("usb: gadget: f_rndis: Refactor bind path to use __free()")
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


