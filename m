Return-Path: <stable+bounces-180367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5309FB7F39D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFB1188CBFA
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F63333C755;
	Wed, 17 Sep 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6qf+Mq0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EBF33C753
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115076; cv=none; b=EPUz32TZZuEaYuVjasD6MM1PLtEk8C5XMBf4iiw6LT3DlLKqCN71s1fOG+R5arjf0jqDafPK593znH8NVEXWCs5AH53SEr3OkI0OCbqW1wN7o9vvLTpDT5wsBoCl5mvuw7in4q1T0bvnlF/eq9a5b9wDWiI8Xz0nDpaUWdKF5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115076; c=relaxed/simple;
	bh=cBBJq5BJgrkZq183MMEXQzrWzTrC3vnjjDQb14fsu3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNlQ4Pxyh9bclqMmwSQrvOyWb66ypMDEvdEzOpiWr0Y7qhAQpdHpBO7BR2WQZMfqWt+n/cy+DcrJrCr5D2QGMczOg9VupLcBbfkEpFCcaOx7aKv8hZ4wWIDV05v9wt4xapsy+fR9ay50BtNHbcbw0qYESsp1Imd0IBVsqrkVMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6qf+Mq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF87DC4CEF0;
	Wed, 17 Sep 2025 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115076;
	bh=cBBJq5BJgrkZq183MMEXQzrWzTrC3vnjjDQb14fsu3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6qf+Mq0DzHDjoWn9dDHL5J/byCH3rPCGFajtS6SoAH7likPYXlFh/+VBp+xa10qX
	 eDmXvZUhfBSbX7J2l9/v1o6NNcrJBHStMSa6cNijC++LQOlFWStIqYC6Tf+9j612Jf
	 iHdLN9+jG7uLUlmvJu4tgh6+lS+y21JhZeGLh5UtpLZerDLsxpW3F9sgEWtR1SO7oP
	 BQjPzLcneJ8LbFeXXpehQNjjRMCnC07OdhB2qkEzRcKAZsxoDGIeE/qiP8JzR/NJXl
	 FPenHWQ75lHg0j2+aRj3UJvyaeZwBOiM4qzFyHYaFuYvd0B81n2u6lavzR8eerSDiM
	 Q86TV6QzA9zpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakob Koschel <jakobkoschel@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: gadget: dummy_hcd: remove usage of list iterator past the loop body
Date: Wed, 17 Sep 2025 09:17:53 -0400
Message-ID: <20250917131754.542916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091723-stack-cargo-2b1d@gregkh>
References: <2025091723-stack-cargo-2b1d@gregkh>
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
index a2d956af42a23..35aec8e7fc735 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -751,7 +751,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct dummy		*dum;
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct dummy_request	*req = NULL;
+	struct dummy_request	*req = NULL, *iter;
 
 	if (!_ep || !_req)
 		return retval;
@@ -763,13 +763,14 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
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


