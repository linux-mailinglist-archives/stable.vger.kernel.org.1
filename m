Return-Path: <stable+bounces-254581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKrRHazsFmr7wwcAu9opvQ
	(envelope-from <stable+bounces-254581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:07:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1427D5E4A4A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65F6A3019553
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A3409E1B;
	Wed, 27 May 2026 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Zyj0V6xi"
X-Original-To: stable@vger.kernel.org
Received: from smtp65.iad3b.emailsrvr.com (smtp65.iad3b.emailsrvr.com [146.20.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CA40B6C9
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887214; cv=none; b=KOwGTKe5oOVavlGk9OCaEw7tpoD2wkhLF7f1IiUbhlBHPjxx6V+pNd7UG59xKybxmQk+AGjnQ0G08AoBvbFIZFHXfuiIh3xy3w+spa0lF+k9Wc9DZhbY/bTIRFcPqjvw7X5ujxJXSO4B9SMn2Go/U0JKvWZISHuNHw6ILIaotGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887214; c=relaxed/simple;
	bh=XvqSSkYUSUBy9N4/ud1egmd04WkJ0kBiBaR7K6fQUU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbveoPMxyZyckmm8cQWPZMr6d8LXqaw0KmFVeTQNPfYBRMw4PYiQewHF3BQwYhZlfuqWazcKCCRgluE2y198SZGPLzmuPMh/pqt0h6pDzH5nXtjkSwd+l3g8L4N2AcCx6yRrcQ2WgW00EGrmLz04Zb9+QLWwE4yM6ZtLnGLkcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Zyj0V6xi; arc=none smtp.client-ip=146.20.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1779886277;
	bh=XvqSSkYUSUBy9N4/ud1egmd04WkJ0kBiBaR7K6fQUU4=;
	h=From:To:Subject:Date:From;
	b=Zyj0V6xizLwSTqtlEk3dzxJ6iteSZdozsonPDBstJGs6Oye1grmIylu87cMZY0/uB
	 gjX9nNOABDmympiiy1Pj/kX6gV+1b/XhB2aiuPXNZKUBCUFTDbUxlaXlNpxH939MeN
	 q3SRZW/UvyjyGMOvbjjrBCH4VSuguKjrvvWUYz6I=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 087AC202B2;
	Wed, 27 May 2026 08:51:16 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	syzbot+f24c3d5d316011bacc70@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] comedi: comedi_parport: deal with premature interrupt
Date: Wed, 27 May 2026 13:51:03 +0100
Message-ID: <20260527125104.96596-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 749361a5-45d2-4ce0-9db5-435fda4ae986-1-1
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mev.co.uk,none];
	R_DKIM_ALLOW(-0.20)[mev.co.uk:s=20221208-6x11dpa4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254581-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abbotti@mev.co.uk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mev.co.uk:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f24c3d5d316011bacc70];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Queue-Id: 1427D5E4A4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Syzbot reported a general protection fault in
`comedi_get_is_subdevice_running()`, which was called from the interrupt
handler `parport_interrupt()` in the "comedi_parport" driver, but it
does not currently have a C reproducer for the problem.  It's
probably due to a premature interrupt for one of two reasons:

1. The driver sets up the interrupt handler before the comedi subdevices
   used by the interrupt handler have been allocated, but does not
   disable the interrupt in the parallel port's CTRL register first.
2. The driver uses a user-supplied I/O port base address which Syzbot
   would have supplied, but it might not be backed by real parallel port
   hardware.

Change the initialization order in the driver's comedi "attach" handler
(`parport_attach()`) so that the hardware registers are initialized
before the interrupt handler is requested.  This should prevent
premature interrupts occurring for real hardware.

Also add a test to the interrupt handler to ensure the comedi device is
fully attached and return early if it isn't.

Fixes: 241ab6ad7108e ("Staging: comedi: add comedi_parport driver")
Reported-by: syzbot+f24c3d5d316011bacc70@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/comedi_parport.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_parport.c b/drivers/comedi/drivers/comedi_parport.c
index 2604680d86c4a..57ee3f9dfba26 100644
--- a/drivers/comedi/drivers/comedi_parport.c
+++ b/drivers/comedi/drivers/comedi_parport.c
@@ -211,6 +211,13 @@ static irqreturn_t parport_interrupt(int irq, void *d)
 	unsigned int ctrl;
 	unsigned short val = 0;
 
+	/*
+	 * Check device is fully attached.  Device interrupts should have
+	 * been disabled, but do this in case of bad hardware.
+	 */
+	if (!dev->attached)
+		return IRQ_NONE;
+
 	ctrl = inb(dev->iobase + PARPORT_CTRL_REG);
 	if (!(ctrl & PARPORT_CTRL_IRQ_ENA))
 		return IRQ_NONE;
@@ -233,6 +240,9 @@ static int parport_attach(struct comedi_device *dev,
 	if (ret)
 		return ret;
 
+	outb(0, dev->iobase + PARPORT_DATA_REG);
+	outb(0, dev->iobase + PARPORT_CTRL_REG);
+
 	if (it->options[1]) {
 		ret = request_irq(it->options[1], parport_interrupt, 0,
 				  dev->board_name, dev);
@@ -288,9 +298,6 @@ static int parport_attach(struct comedi_device *dev,
 		s->cancel	= parport_intr_cancel;
 	}
 
-	outb(0, dev->iobase + PARPORT_DATA_REG);
-	outb(0, dev->iobase + PARPORT_CTRL_REG);
-
 	return 0;
 }
 
-- 
2.53.0


