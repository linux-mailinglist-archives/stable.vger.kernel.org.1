Return-Path: <stable+bounces-3446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C37FF5B0
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FFC1C20FC5
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0618649F9C;
	Thu, 30 Nov 2023 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QjfLS5Hx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C4482CA;
	Thu, 30 Nov 2023 16:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F9EC433C8;
	Thu, 30 Nov 2023 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361852;
	bh=oWVdYbn9gvG90DeaHZ56JIFbclHb3d7dRpaFILZOlDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjfLS5HxKvcPvCnob4IDkcoT7QFNNtTDGjj4IgzVL1TOAFP6qLATKQoO8SWqWllKX
	 of6aLzDgRPtwA7YBRuv9zM+HdW5owVgTRu38wOoKcC++rjQLDLSTOQBKkZM3VBb/bM
	 9UEij7czWAc6aDYFviPa7LrYYIcDP4fRyeqTFFJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pawel Laszczak <pawell@cadence.com>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.1 72/82] usb: cdnsp: Fix deadlock issue during using NCM gadget
Date: Thu, 30 Nov 2023 16:22:43 +0000
Message-ID: <20231130162138.265368899@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Laszczak <pawell@cadence.com>

commit 58f2fcb3a845fcbbad2f3196bb37d744e0506250 upstream.

The interrupt service routine registered for the gadget is a primary
handler which mask the interrupt source and a threaded handler which
handles the source of the interrupt. Since the threaded handler is
voluntary threaded, the IRQ-core does not disable bottom halves before
invoke the handler like it does for the forced-threaded handler.

Due to changes in networking it became visible that a network gadget's
completions handler may schedule a softirq which remains unprocessed.
The gadget's completion handler is usually invoked either in hard-IRQ or
soft-IRQ context. In this context it is enough to just raise the softirq
because the softirq itself will be handled once that context is left.
In the case of the voluntary threaded handler, there is nothing that
will process pending softirqs. Which means it remain queued until
another random interrupt (on this CPU) fires and handles it on its exit
path or another thread locks and unlocks a lock with the bh suffix.
Worst case is that the CPU goes idle and the NOHZ complains about
unhandled softirqs.

Disable bottom halves before acquiring the lock (and disabling
interrupts) and enable them after dropping the lock. This ensures that
any pending softirqs will handled right away.

cc: stable@vger.kernel.org
Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20231108093125.224963-1-pawell@cadence.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdnsp-ring.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -1522,6 +1522,7 @@ irqreturn_t cdnsp_thread_irq_handler(int
 	unsigned long flags;
 	int counter = 0;
 
+	local_bh_disable();
 	spin_lock_irqsave(&pdev->lock, flags);
 
 	if (pdev->cdnsp_state & (CDNSP_STATE_HALTED | CDNSP_STATE_DYING)) {
@@ -1534,6 +1535,7 @@ irqreturn_t cdnsp_thread_irq_handler(int
 			cdnsp_died(pdev);
 
 		spin_unlock_irqrestore(&pdev->lock, flags);
+		local_bh_enable();
 		return IRQ_HANDLED;
 	}
 
@@ -1550,6 +1552,7 @@ irqreturn_t cdnsp_thread_irq_handler(int
 	cdnsp_update_erst_dequeue(pdev, event_ring_deq, 1);
 
 	spin_unlock_irqrestore(&pdev->lock, flags);
+	local_bh_enable();
 
 	return IRQ_HANDLED;
 }



