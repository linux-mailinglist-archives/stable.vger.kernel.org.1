Return-Path: <stable+bounces-182222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE1BAD5E1
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253A77A4E09
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A41F03C5;
	Tue, 30 Sep 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PbjgMh8E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841FB199939;
	Tue, 30 Sep 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244243; cv=none; b=LGEx6tse4nXweAmuNMDD+WiO4Qg5EoGaFz/WnNJ3OAZuVh7+yrzlznerKieqvFpOIPvw2265KA851xu0CcwZ3gPgpLp38j89CB7NRlqe3qdcrvOofH9qaEmpybjCWU+rzU8yaLh3n0aM8mgi1TU2HXgiMN8dKJquOac+xIHxuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244243; c=relaxed/simple;
	bh=ZD2z8/EvdxbXSetYeboL+XPwacGtP9i/yzavsbqozhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKDWoax2QF5cuPtMZUctIA7+5CJobHby2K1PNDDLBbwK4Seij+QnsAv9aNIfPTssXoeG9b2FWNa6T04CouagQDRSRmZ9+8LvC2Dd3HHOUK48cpGk/okymyR0bOSOULs8jMSeVd1BcdZ2ggmfGJ4KzKLyA4CItj2oH6i6KXPh1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PbjgMh8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67BFC4CEF0;
	Tue, 30 Sep 2025 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244243;
	bh=ZD2z8/EvdxbXSetYeboL+XPwacGtP9i/yzavsbqozhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PbjgMh8E7WQebNzELOvGkOtw1LNov9X1KQ2Qd1tmRNrASbST8YZSkeX/PShHy+9Iq
	 H2+86TTB6mdXKGENRPSV1VWnqxEYcMIY5DcQM7j4+ad5PLQv9WpkPVtP0A/Tvo7xTj
	 YhqJ1FD81aFy33hmfEeHMR5/9C/KTsuFYndR398Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakob Koschel <jakobkoschel@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 070/122] usb: gadget: dummy_hcd: remove usage of list iterator past the loop body
Date: Tue, 30 Sep 2025 16:46:41 +0200
Message-ID: <20250930143825.866264672@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
References: <20250930143822.939301999@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -749,7 +749,7 @@ static int dummy_dequeue(struct usb_ep *
 	struct dummy		*dum;
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct dummy_request	*req = NULL;
+	struct dummy_request	*req = NULL, *iter;
 
 	if (!_ep || !_req)
 		return retval;
@@ -761,13 +761,14 @@ static int dummy_dequeue(struct usb_ep *
 
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
 



