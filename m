Return-Path: <stable+bounces-208178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F12D14285
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87FA43045F7D
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484B34CFCD;
	Mon, 12 Jan 2026 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="pQD7HN6w"
X-Original-To: stable@vger.kernel.org
Received: from smtp78.ord1d.emailsrvr.com (smtp78.ord1d.emailsrvr.com [184.106.54.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35012F6582
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236410; cv=none; b=T3kQAh4mAjYtC1UrCIvbDyt5eZJ/w0kXk3ff5znUf+f5Q96T/oj244twZIVpotyZQeHckgvnv7eKHUVZ0aHCb6pQEiaW3FQa9pcvYPlyTfV1ViDD+AALLQWdj4+je+Awr4qLyJMQbb7A4ZFIKtyOjPk+JIp8m4633ozMdYIPWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236410; c=relaxed/simple;
	bh=O7N2yi2NOcxWR5uM9x5rdMSt+C543cwaLFgfHUOtuzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2sJNuBUa2KBQXRpRs3dl1S+WLlHwMnWucfSAWWXxpj1kuo6ClvTZD/9Y0dYaNqoUWlboQK8xlmdeadZZvyDwETNQMOZvLJ8wBXZV4FLwRXBVOS5XfrbnUGQXDeHzAbwthYZp+Xo+rd+z7NEY9F987QhkEzBr/Q6TdWFjgPTB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=pQD7HN6w; arc=none smtp.client-ip=184.106.54.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1768235329;
	bh=O7N2yi2NOcxWR5uM9x5rdMSt+C543cwaLFgfHUOtuzY=;
	h=From:To:Subject:Date:From;
	b=pQD7HN6wILaMTR0uPd9VlJXkHk1nMBlrNCv3FOpx/2oapPfEBpTmFZkLhXLWqI2Np
	 o3DhGJD8JRlvsp7/ASBOFT8Qc+ZFRBabO/ColR9XBy0ap6fv4A0wvfCbPOOI8k9laL
	 beAEDFCc+tmQJDYjs0qk7TFQipyJxCRw5un/WB0A=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EDB81A02BC;
	Mon, 12 Jan 2026 11:28:48 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: dmm32at: serialize use of paged registers
Date: Mon, 12 Jan 2026 16:28:35 +0000
Message-ID: <20260112162835.91688-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 811417ab-859f-4141-8b86-775e1b337f7e-1-1

Some of the hardware registers of the DMM-32-AT board are multiplexed,
using the least significant two bits of the Miscellaneous Control
register to select the function of registers at offsets 12 to 15:

 00 => 8254 timer/counter registers are accessible
 01 => 8255 digital I/O registers are accessible
 10 => Reserved
 11 => Calibration registers are accessible

The interrupt service routine (`dmm32at_isr()`) clobbers the bottom two
bits of the register with value 00, which would interfere with access to
the 8255 registers by the `dm32at_8255_io()` function (used for Comedi
instruction handling on the digital I/O subdevice).

Make use of the generic Comedi device spin-lock `dev->spinlock` (which
is otherwise unused by this driver) to serialize access to the
miscellaneous control register and paged registers.

Fixes: 3c501880ac44 ("Staging: comedi: add dmm32at driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/dmm32at.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/dmm32at.c b/drivers/comedi/drivers/dmm32at.c
index 644e3b643c79..910cd24b1bed 100644
--- a/drivers/comedi/drivers/dmm32at.c
+++ b/drivers/comedi/drivers/dmm32at.c
@@ -330,6 +330,7 @@ static int dmm32at_ai_cmdtest(struct comedi_device *dev,
 
 static void dmm32at_setaitimer(struct comedi_device *dev, unsigned int nansec)
 {
+	unsigned long irq_flags;
 	unsigned char lo1, lo2, hi2;
 	unsigned short both2;
 
@@ -342,6 +343,9 @@ static void dmm32at_setaitimer(struct comedi_device *dev, unsigned int nansec)
 	/* set counter clocks to 10MHz, disable all aux dio */
 	outb(0, dev->iobase + DMM32AT_CTRDIO_CFG_REG);
 
+	/* serialize access to control register and paged registers */
+	spin_lock_irqsave(&dev->spinlock, irq_flags);
+
 	/* get access to the clock regs */
 	outb(DMM32AT_CTRL_PAGE_8254, dev->iobase + DMM32AT_CTRL_REG);
 
@@ -354,6 +358,8 @@ static void dmm32at_setaitimer(struct comedi_device *dev, unsigned int nansec)
 	outb(lo2, dev->iobase + DMM32AT_CLK2);
 	outb(hi2, dev->iobase + DMM32AT_CLK2);
 
+	spin_unlock_irqrestore(&dev->spinlock, irq_flags);
+
 	/* enable the ai conversion interrupt and the clock to start scans */
 	outb(DMM32AT_INTCLK_ADINT |
 	     DMM32AT_INTCLK_CLKEN | DMM32AT_INTCLK_CLKSEL,
@@ -363,13 +369,19 @@ static void dmm32at_setaitimer(struct comedi_device *dev, unsigned int nansec)
 static int dmm32at_ai_cmd(struct comedi_device *dev, struct comedi_subdevice *s)
 {
 	struct comedi_cmd *cmd = &s->async->cmd;
+	unsigned long irq_flags;
 	int ret;
 
 	dmm32at_ai_set_chanspec(dev, s, cmd->chanlist[0], cmd->chanlist_len);
 
+	/* serialize access to control register and paged registers */
+	spin_lock_irqsave(&dev->spinlock, irq_flags);
+
 	/* reset the interrupt just in case */
 	outb(DMM32AT_CTRL_INTRST, dev->iobase + DMM32AT_CTRL_REG);
 
+	spin_unlock_irqrestore(&dev->spinlock, irq_flags);
+
 	/*
 	 * wait for circuit to settle
 	 * we don't have the 'insn' here but it's not needed
@@ -429,8 +441,13 @@ static irqreturn_t dmm32at_isr(int irq, void *d)
 		comedi_handle_events(dev, s);
 	}
 
+	/* serialize access to control register and paged registers */
+	spin_lock(&dev->spinlock);
+
 	/* reset the interrupt */
 	outb(DMM32AT_CTRL_INTRST, dev->iobase + DMM32AT_CTRL_REG);
+
+	spin_unlock(&dev->spinlock);
 	return IRQ_HANDLED;
 }
 
@@ -481,14 +498,25 @@ static int dmm32at_ao_insn_write(struct comedi_device *dev,
 static int dmm32at_8255_io(struct comedi_device *dev,
 			   int dir, int port, int data, unsigned long regbase)
 {
+	unsigned long irq_flags;
+	int ret;
+
+	/* serialize access to control register and paged registers */
+	spin_lock_irqsave(&dev->spinlock, irq_flags);
+
 	/* get access to the DIO regs */
 	outb(DMM32AT_CTRL_PAGE_8255, dev->iobase + DMM32AT_CTRL_REG);
 
 	if (dir) {
 		outb(data, dev->iobase + regbase + port);
-		return 0;
+		ret = 0;
+	} else {
+		ret = inb(dev->iobase + regbase + port);
 	}
-	return inb(dev->iobase + regbase + port);
+
+	spin_unlock_irqrestore(&dev->spinlock, irq_flags);
+
+	return ret;
 }
 
 /* Make sure the board is there and put it to a known state */
-- 
2.51.0


