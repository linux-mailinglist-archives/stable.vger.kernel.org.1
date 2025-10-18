Return-Path: <stable+bounces-187788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE1BEC518
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73464EBC60
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097941F9EC0;
	Sat, 18 Oct 2025 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFwovtRD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC114146D45
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760753905; cv=none; b=ZDBxMm8M97dYnHcsO2knZyl0IKS3l/nKsPtF63fdLUh486AwX3i2KJeMzUnRiwufOO5Fd0IMn8U45XISFNsidDsPkgMJoKd9gWDtEFfzGffpGsNQbnsjneKrk7EohKMkTfngD9dxYndYu0oiBwzqB83UaRYiG2KjkPrgcEh7nmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760753905; c=relaxed/simple;
	bh=vEAfHlVub91N5flbHpvLZBu91Fta44e9cb0e6BCwXB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX8Cf7WrvWijMfU/jwktn3Cz1PdXaORLqM1RpSG3hiPGeYqe838kihqALuRXybXDcFKF3p7biyYfgmzCWhS9xuHGN4vQ9d1NQR0dRiu993peQAzb44hqjkl1r6Vqn92Xrq+ijFdtENp+Ofj7QczS0mzEK5MfKBoDO/hUyDIyN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFwovtRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CDEC4CEE7;
	Sat, 18 Oct 2025 02:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760753905;
	bh=vEAfHlVub91N5flbHpvLZBu91Fta44e9cb0e6BCwXB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFwovtRDdwi3vJTn8EbVKm7vpANHOS5VgBN5Adk17RMb0BX+gBHMhdnaKdBnda+VI
	 6dvkK7ToQdHGQO+cETq31qMMzHoT2oRMn2Aq6OZ8093e9BqNCUlNjK9XcNHZeuXA8J
	 UQZwSATNvs4eCCAwA2WOVyMdHr2XFbucBCa45T0fXUOm3PdighIF/4OvprPzDXR/Q3
	 q5Fp19WDzw2tYcmdlGv6PnWYoxdHhs8NoU9UXJcrmPP0Tq4GHciggiyosASFkCBSHI
	 j+qicBTS5CdpfZK+mFGXs7Lukk7rfJo65ffXndfUrYEduiqcOS4B+YPjKcrWOCyFlS
	 t9fjHFIIOrFhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 22:18:20 -0400
Message-ID: <20251018021822.214718-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101631-subscript-pruning-bc19@gregkh>
References: <2025101631-subscript-pruning-bc19@gregkh>
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


