Return-Path: <stable+bounces-187746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6ABEC2D2
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A2C1AA5847
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F1D137750;
	Sat, 18 Oct 2025 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6/eHIZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB80288D0
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748111; cv=none; b=kAdjHofKw/y/wSMA1wMhwU+6nlbHR8OUrwXEORYAHUsEozs6cgyKqXs0B8Hb5jL1GyCLeRpdwKbbg2FgprA2XRuMp9461JI+KhGtv5gt6yuwvK0pAPl5E0anaTgNFKNVL75B08qCxFUTdsdxJYq/Y9HmpTd2nwakB8YzYex88dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748111; c=relaxed/simple;
	bh=i5C9O1IWeYXZFFfwv9mhUvJMfpU9xnGVWghkY+vz+ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3BLcyowDbzFVN9hrLLJKWRUmULDlFrdWl1PH+YScgxzshQxmiTkDyGj2mSBQlulVpt76Ihw+0fxuCIOvfssrhgO/LK20D1G7pvQol2BZ3I0WSxWJglI7+QGoryI7Og1twce+AImf74kF07ug7MFTwQcTPl1a/tY4tVw0G8nlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6/eHIZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CB2C4CEE7;
	Sat, 18 Oct 2025 00:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748111;
	bh=i5C9O1IWeYXZFFfwv9mhUvJMfpU9xnGVWghkY+vz+ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6/eHIZSw3ludoZovSh8Cn4SvqjJ/8B76eVPV/SO8luVRfwM4HyIA3RRgT09BHdCh
	 frfM9G9LeVwbqcxhCuzeXD4o360EZMAA9dtw8bLhkc4E39OpmtSAIvVqJ00GhbMhj0
	 go6dK1HUkcNZimsHZi9xXvrl3opdITb7mze8guAw21bjmtpDDyTlkOAM6NLMD9JZRW
	 tQ2JPVDWbA6AB/IvQJWyalAcEERvi99eux/psscR7/U4Q0AGRETsxKYsn2GEEd0fUN
	 RtLlE1OUYtf91AVFVAw0nIbzppeTfTpOXMcDPEcLkq2OIVpvameiAsqWnH4O26n95A
	 LEYhcIqNHjnrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] usb: gadget: Store endpoint pointer in usb_request
Date: Fri, 17 Oct 2025 20:41:46 -0400
Message-ID: <20251018004148.92008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101602-clumsily-lived-dd4b@gregkh>
References: <2025101602-clumsily-lived-dd4b@gregkh>
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


