Return-Path: <stable+bounces-187772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6554EBEC3EF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0A814E4B8B
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0D81C84A0;
	Sat, 18 Oct 2025 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW9SeBxR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD595464F
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752181; cv=none; b=Wk2hm5w/QLWggrzrT2b6eaQK+AvcEuopzMec8vr2z5PLE3sC9HCNtMuSK+VzpSYA+VvlvuDdO7X6knT/liUPokGUM35nfgxQAlfLrjjYN40jbt6ehqYW+1sm6V3X0wTp2KvXlVKddjCh4cj2mLEOWuLCvklHF27elqF1rx7o/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752181; c=relaxed/simple;
	bh=PbMZyoeqLAyUSluWYc9LWlR8pFzeo9/GgKrtEfLKjBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUCGkvMK83sUR4id1YTPho+IPOFiBjAZuQZXvsEJoDo/gQMKj8uf3Cn1Mv/eBgwTHZ3xErWOinxyxvPEq1mSjCLs2GBHnVKnCuKU/e9Ub9arrsGKUwd9WgQtsXiEkP+PVrZe1tPABfF7HxOwBxPkgzjnNJQ2qS8Eac3yvpv1lGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW9SeBxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310DAC4CEE7;
	Sat, 18 Oct 2025 01:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760752180;
	bh=PbMZyoeqLAyUSluWYc9LWlR8pFzeo9/GgKrtEfLKjBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HW9SeBxRoog/mlGxVyq+ZZVACPi+rGD32NUyqPnNPw5lpA/CxGG8ijlUIUtz3z7vw
	 tJaLPdRSaG4papMZyKV2w3MKjexwBWA6/+6hA45Y3nVLOx0c6OAORn3cZetWTumBru
	 ubvMh+kg1ilE1jzGB7steCTEbb1afoIa+RkHs3omYKruBV7rahOS61atXYmqhpkmFM
	 KUSD1cmRoDs0o9ZpJnghPZYT/ZGf71Ta1owlpqiAHR+/w5fJFH1AYmWrKYU+LakSiy
	 GA0jyaFGrR1DolvQ8nSaudP+M5LVlcWGpNDLgsQS83QDxI4b7TpHDmeXQln6LhQCRk
	 tZO2eKe/FJyVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 21:49:35 -0400
Message-ID: <20251018014938.159273-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101600-epidemic-bleak-5192@gregkh>
References: <2025101600-epidemic-bleak-5192@gregkh>
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


