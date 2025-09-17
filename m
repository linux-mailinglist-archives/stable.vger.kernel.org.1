Return-Path: <stable+bounces-180373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92373B7F5B3
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B3116B947
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D033C76E;
	Wed, 17 Sep 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrwsQjkA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7994086A
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115545; cv=none; b=mTj+pPXxhRBo4ZeCICutxr99N1qR/HNuzFHBn0C77FV8IT3IWaApVe9IUd/dqjMLzy1ScVEB8YG7UyiYmhUnhWkDC46mV18rejqRYjxZpgVO6R05vvDFWBUhb2NjODnIpyZx5ZbpGBcxkKIFRLMJOw2Gjg+0OFHCs7qrrmdrmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115545; c=relaxed/simple;
	bh=1ldiO499pMclqD7aUH8fhVsuBI92oc5n/Zz8t64KQk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvCv+t+nH1y5fkqRrDSpdGrOP56tw2/uyq4MY+KyRSe/0w4kHH04kBzLXkUdYmN5mpdiTUStPiTdIQodHbw/T2P11joSLdqhPV5v+bHsKsMt4Wb0z0vmd9/LOIh7DOaXHE0rYxwRRZYSpT/4zKV324G9gI+W3P0h5YPyWBkasCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrwsQjkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C215CC4CEF0;
	Wed, 17 Sep 2025 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115545;
	bh=1ldiO499pMclqD7aUH8fhVsuBI92oc5n/Zz8t64KQk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrwsQjkAGE5dGfEYccc76sXhKamH1T4LRdgK8vCjs2hAyGQ1emI9zbrUr6ITlVhVw
	 k+wKSCUlOh2wTNJENEGGu5rQZDsZireh7MBdguOecPJGpekG8NEeD/Eqnm9gnE1zKT
	 b56JzHw/MZcyWKwVZPDnC2BeSakH3LT7B3oLmRNxn8uC+ojRTqZZRTjbzp5IOgyE76
	 ySA8iVbDw76YWMtb7cU8yID8wmRIOvcXAE8MjHD0vl15Wr/xlj5wuqgCUX9X5Iu5nT
	 Cdkqm2DgIytxXMYmY0LRdGKrlOaS4iRMc7Le3dcFj+SNTQESscoLuZKmOcm6AlRH60
	 LxreO7ilzlyYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakob Koschel <jakobkoschel@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] usb: gadget: dummy_hcd: remove usage of list iterator past the loop body
Date: Wed, 17 Sep 2025 09:25:42 -0400
Message-ID: <20250917132543.548029-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091724-unrivaled-crystal-942a@gregkh>
References: <2025091724-unrivaled-crystal-942a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakob Koschel <jakobkoschel@gmail.com>

[ Upstream commit 7975f080d3557725160a878b1a64339043ba3d91 ]

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Link: https://lore.kernel.org/r/20220308171818.384491-26-jakobkoschel@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8d63c83d8eb9 ("USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 92d01ddaee0d4..7ed83241cf69d 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -749,7 +749,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct dummy		*dum;
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct dummy_request	*req = NULL;
+	struct dummy_request	*req = NULL, *iter;
 
 	if (!_ep || !_req)
 		return retval;
@@ -761,13 +761,14 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	local_irq_save(flags);
 	spin_lock(&dum->lock);
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
-			list_del_init(&req->queue);
-			_req->status = -ECONNRESET;
-			retval = 0;
-			break;
-		}
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != _req)
+			continue;
+		list_del_init(&iter->queue);
+		_req->status = -ECONNRESET;
+		req = iter;
+		retval = 0;
+		break;
 	}
 	spin_unlock(&dum->lock);
 
-- 
2.51.0


