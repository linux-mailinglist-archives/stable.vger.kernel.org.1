Return-Path: <stable+bounces-44738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C288C543F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB7283CA6
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85BB139CF1;
	Tue, 14 May 2024 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bD/dVoPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B0139599;
	Tue, 14 May 2024 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687033; cv=none; b=IM1QbOP/e9TIeJ9Cu9Ny24IMpHHUh7RFyCOrIXZ8clkWwQ+cva4pb3MZfa5sIqtLLHUjSusk7UCx7n6E05AofNID2MchFvPDKADbhGJ2PV46osJO/3SFZUgYm6ZHbbEF4MOeexckDnFGHFAiZ0zN191YnPJwnFVDRBrRTueOp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687033; c=relaxed/simple;
	bh=6gIXUQR3pohpZ23Choex8gNdDCDQd51lVLAl45tYVGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=semag3uyyrCFx7fBFZU/LwJrFPuz3MvK0Cs9he0sUsFDacZyDkKVr2OK/MgmACok31aj0PJH7rFx09ByXfR+X4icqDi3Ut7LPoQnSlVw5+vpp6VXIpAIVZNhLD/06lAZRquqA9h9PY3aIuE7KmAZGznyW96CmG93BImThqeXr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bD/dVoPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC38C2BD10;
	Tue, 14 May 2024 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687033;
	bh=6gIXUQR3pohpZ23Choex8gNdDCDQd51lVLAl45tYVGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bD/dVoPTtB9XbDoBCLEhhul36LUdhG97PN8bFFkGaMTvOiQophRa7ujOFwbiCqIDS
	 sDacfTId1XezgwQEuCUNPZz57O3VWg6DExWHH3PeIX/xTcYjvyQUyV7lJGnTIQcT0N
	 UTt3Uh32um2FdboHYaiJZNM+F8Xk6U9CUcnmfi5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adam Goldman <adamg@pobox.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 42/84] firewire: ohci: mask bus reset interrupts between ISR and bottom half
Date: Tue, 14 May 2024 12:19:53 +0200
Message-ID: <20240514100953.273253419@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
References: <20240514100951.686412426@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Goldman <adamg@pobox.com>

[ Upstream commit 752e3c53de0fa3b7d817a83050b6699b8e9c6ec9 ]

In the FireWire OHCI interrupt handler, if a bus reset interrupt has
occurred, mask bus reset interrupts until bus_reset_work has serviced and
cleared the interrupt.

Normally, we always leave bus reset interrupts masked. We infer the bus
reset from the self-ID interrupt that happens shortly thereafter. A
scenario where we unmask bus reset interrupts was introduced in 2008 in
a007bb857e0b26f5d8b73c2ff90782d9c0972620: If
OHCI_PARAM_DEBUG_BUSRESETS (8) is set in the debug parameter bitmask, we
will unmask bus reset interrupts so we can log them.

irq_handler logs the bus reset interrupt. However, we can't clear the bus
reset event flag in irq_handler, because we won't service the event until
later. irq_handler exits with the event flag still set. If the
corresponding interrupt is still unmasked, the first bus reset will
usually freeze the system due to irq_handler being called again each
time it exits. This freeze can be reproduced by loading firewire_ohci
with "modprobe firewire_ohci debug=-1" (to enable all debugging output).
Apparently there are also some cases where bus_reset_work will get called
soon enough to clear the event, and operation will continue normally.

This freeze was first reported a few months after a007bb85 was committed,
but until now it was never fixed. The debug level could safely be set
to -1 through sysfs after the module was loaded, but this would be
ineffectual in logging bus reset interrupts since they were only
unmasked during initialization.

irq_handler will now leave the event flag set but mask bus reset
interrupts, so irq_handler won't be called again and there will be no
freeze. If OHCI_PARAM_DEBUG_BUSRESETS is enabled, bus_reset_work will
unmask the interrupt after servicing the event, so future interrupts
will be caught as desired.

As a side effect to this change, OHCI_PARAM_DEBUG_BUSRESETS can now be
enabled through sysfs in addition to during initial module loading.
However, when enabled through sysfs, logging of bus reset interrupts will
be effective only starting with the second bus reset, after
bus_reset_work has executed.

Signed-off-by: Adam Goldman <adamg@pobox.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firewire/ohci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 6603f13f5de9b..2db5448c4293a 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2053,6 +2053,8 @@ static void bus_reset_work(struct work_struct *work)
 
 	ohci->generation = generation;
 	reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
+	if (param_debug & OHCI_PARAM_DEBUG_BUSRESETS)
+		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
 
 	if (ohci->quirks & QUIRK_RESET_PACKET)
 		ohci->request_generation = generation;
@@ -2119,12 +2121,14 @@ static irqreturn_t irq_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	/*
-	 * busReset and postedWriteErr must not be cleared yet
+	 * busReset and postedWriteErr events must not be cleared yet
 	 * (OHCI 1.1 clauses 7.2.3.2 and 13.2.8.1)
 	 */
 	reg_write(ohci, OHCI1394_IntEventClear,
 		  event & ~(OHCI1394_busReset | OHCI1394_postedWriteErr));
 	log_irqs(ohci, event);
+	if (event & OHCI1394_busReset)
+		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
 
 	if (event & OHCI1394_selfIDComplete)
 		queue_work(selfid_workqueue, &ohci->bus_reset_work);
-- 
2.43.0




