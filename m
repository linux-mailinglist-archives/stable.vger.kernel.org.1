Return-Path: <stable+bounces-122318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE620A59EFA
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DFFB7A7623
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F6230BD4;
	Mon, 10 Mar 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EayJhD75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003D2253FE;
	Mon, 10 Mar 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628155; cv=none; b=FkpqP+XIocqA5XzQ2sCuhzb76XJgL2lu/0fLlqDEtz0421Bfi89aBLLRQhyGA3SPgp0rU2gee1BqIjNgOIFv2bDphTyy7x6RBbEYRWB9fekH4EtnKBZ+fu6ww2Rt6o1nQjMQ3KrkUU84JhRCojAnJeUQZSX+Rr1rrt/KFeLmgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628155; c=relaxed/simple;
	bh=iwApIHm7IfKjuXeGtVzAuZuQvfhvprKchsZ03oAc3rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neP2+Ko3TotU8FYhBvAcgPQvVyC3h84IU7YiPBCWeANxq1s0i/gw0RgDTOWwmIzMdDNPFQG4IUsRB7AiLKOSH6s5t45QzpWAcnM/Sx4k5+rXUHiZmZuncVblsiSn9ZM3CB5l2K5JFMRXirrqnt0kVsPEMJhKLHQU/MdsEACQbaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EayJhD75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1598BC4CEE5;
	Mon, 10 Mar 2025 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628155;
	bh=iwApIHm7IfKjuXeGtVzAuZuQvfhvprKchsZ03oAc3rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EayJhD75onlxnXmmC3RTNzKsZ1QPbTO2XdKAi7SuspkbkAYblw95UQciwq8i9qYnh
	 oQ5QaQ3O4iGlNtO9oG6qBlikkEO6l2VI1P34f8NaOucMUzwhHqCkCaAwyjBHoIro5T
	 pC5CtCxg6XavZoaICz8FArMUQp8zt8BXjAEXMcfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Prashanth K <prashanth.k@oss.qualcomm.com>
Subject: [PATCH 6.6 099/145] usb: gadget: u_ether: Set is_suspend flag if remote wakeup fails
Date: Mon, 10 Mar 2025 18:06:33 +0100
Message-ID: <20250310170438.757466924@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashanth K <prashanth.k@oss.qualcomm.com>

commit 17c2c87c37862c3e95b55f660681cc6e8d66660e upstream.

Currently while UDC suspends, u_ether attempts to remote wakeup
the host if there are any pending transfers. However, if remote
wakeup fails, the UDC remains suspended but the is_suspend flag
is not set. And since is_suspend flag isn't set, the subsequent
eth_start_xmit() would queue USB requests to suspended UDC.

To fix this, bail out from gether_suspend() only if remote wakeup
operation is successful.

Cc: stable <stable@kernel.org>
Fixes: 0a1af6dfa077 ("usb: gadget: f_ecm: Add suspend/resume and remote wakeup support")
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250212100840.3812153-1-prashanth.k@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_ether.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1052,8 +1052,8 @@ void gether_suspend(struct gether *link)
 		 * There is a transfer in progress. So we trigger a remote
 		 * wakeup to inform the host.
 		 */
-		ether_wakeup_host(dev->port_usb);
-		return;
+		if (!ether_wakeup_host(dev->port_usb))
+			return;
 	}
 	spin_lock_irqsave(&dev->lock, flags);
 	link->is_suspend = true;



