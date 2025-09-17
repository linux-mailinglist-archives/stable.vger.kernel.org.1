Return-Path: <stable+bounces-180368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCDDB7F358
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796391C25E62
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B933C75E;
	Wed, 17 Sep 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGzSskIk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24733C757
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115077; cv=none; b=YcA9h2qx9urUv9oCDg8Ke0jGS8FF2q+vHd/A51EOV6I71VJdXbcJBnZhz/2cvPblAMHcOSz/Y5f0K4jow7TZxokfwa04tsKargxDR32ZmDon7jI7S60o+3FPLQnDfnxlWTy83qONYQos6q6rnggxuvALGCvhJaPxy4XwE6yadmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115077; c=relaxed/simple;
	bh=PUXt8vBXCPyub2qjx2UsCcaREbhRawZTKfh4zVu35yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVFTmpaeyVzX6SrBni2R7z6CkA7S1BxVeoQseecjCzoq1nH8N485ztIVynR1Gj1zMtYI96QWVYJYi+b4uNCo58/kkyIg1srLtkE8NT2xAF0pdrsK7B1vXocLk1oLzv6czzDuRjmesvIpNuKDPe99E5NaMHRAwJF9xE82FBZd6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGzSskIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D79C4CEF5;
	Wed, 17 Sep 2025 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115077;
	bh=PUXt8vBXCPyub2qjx2UsCcaREbhRawZTKfh4zVu35yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGzSskIknLb8jtjv1/CvsTvYraXNvz8gJaHqH4QAlQR/YM9H5fvab9GIjQ6mK0fcJ
	 tfuhxeZhN0Q5MjJTpXVCUr6Dk6rAv3BpRRlRKX0jtJ2e3vnWYcn+e60RgbNrYFhEUG
	 mLM4epuVYiyYQ0JjWJS6xUTzqW1U+vIG6AGx8ZB9vcz4C5bKbNNBeQr8lkqYvus09h
	 8tM8vkDlb9hcUaB4SkOr0S2drpZ83oVqJNCWvoovV8izMIFPhY920CXwixxYZ2qLqA
	 +ekGvU+zoSoM9GnAmgw9bIyT4dg07n9e8Y61bNVhWryiC8O6FDxrD1Via4R31D+LPv
	 W43pOo2BNcr7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	stable <stable@kernel.org>,
	Yunseong Kim <ysk@kzalloc.com>,
	syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels
Date: Wed, 17 Sep 2025 09:17:54 -0400
Message-ID: <20250917131754.542916-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917131754.542916-1-sashal@kernel.org>
References: <2025091723-stack-cargo-2b1d@gregkh>
 <20250917131754.542916-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit 8d63c83d8eb922f6c316320f50c82fa88d099bea ]

Yunseong Kim and the syzbot fuzzer both reported a problem in
RT-enabled kernels caused by the way dummy-hcd mixes interrupt
management and spin-locking.  The pattern was:

	local_irq_save(flags);
	spin_lock(&dum->lock);
	...
	spin_unlock(&dum->lock);
	...		// calls usb_gadget_giveback_request()
	local_irq_restore(flags);

The code was written this way because usb_gadget_giveback_request()
needs to be called with interrupts disabled and the private lock not
held.

While this pattern works fine in non-RT kernels, it's not good when RT
is enabled.  RT kernels handle spinlocks much like mutexes; in particular,
spin_lock() may sleep.  But sleeping is not allowed while local
interrupts are disabled.

To fix the problem, rewrite the code to conform to the pattern used
elsewhere in dummy-hcd and other UDC drivers:

	spin_lock_irqsave(&dum->lock, flags);
	...
	spin_unlock(&dum->lock);
	usb_gadget_giveback_request(...);
	spin_lock(&dum->lock);
	...
	spin_unlock_irqrestore(&dum->lock, flags);

This approach satisfies the RT requirements.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@kernel.org>
Fixes: b4dbda1a22d2 ("USB: dummy-hcd: disable interrupts during req->complete")
Reported-by: Yunseong Kim <ysk@kzalloc.com>
Closes: <https://lore.kernel.org/linux-usb/5b337389-73b9-4ee4-a83e-7e82bf5af87a@kzalloc.com/>
Reported-by: syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com
Closes: <https://lore.kernel.org/linux-usb/68ac2411.050a0220.37038e.0087.GAE@google.com/>
Tested-by: syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: stable@vger.kernel.org
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/bb192ae2-4eee-48ee-981f-3efdbbd0d8f0@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 35aec8e7fc735..da658d349c9c3 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -761,8 +761,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	if (!dum->driver)
 		return -ESHUTDOWN;
 
-	local_irq_save(flags);
-	spin_lock(&dum->lock);
+	spin_lock_irqsave(&dum->lock, flags);
 	list_for_each_entry(iter, &ep->queue, queue) {
 		if (&iter->req != _req)
 			continue;
@@ -772,15 +771,16 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 		retval = 0;
 		break;
 	}
-	spin_unlock(&dum->lock);
 
 	if (retval == 0) {
 		dev_dbg(udc_dev(dum),
 				"dequeued req %p from %s, len %d buf %p\n",
 				req, _ep->name, _req->length, _req->buf);
+		spin_unlock(&dum->lock);
 		usb_gadget_giveback_request(_ep, _req);
+		spin_lock(&dum->lock);
 	}
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dum->lock, flags);
 	return retval;
 }
 
-- 
2.51.0


