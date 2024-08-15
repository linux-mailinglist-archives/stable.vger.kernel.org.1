Return-Path: <stable+bounces-67880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6388952F8D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3F61C246C4
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E2F1A00E7;
	Thu, 15 Aug 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b537Rupf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A518D639;
	Thu, 15 Aug 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728811; cv=none; b=jswLxxyjMt07Qi1W+PHC46s82UBKzmXL7kkQ12Es/gh0KUQcKmj40XB8JN4MfNiOoILngF+jY0/PWAooCIX/ly89nlG7aKKWNu5uZ2dSUQXpEH9y3fiRxAo6Ua4wEts2TFjQ0Zx06Vb4rZNkFnG0EaCr56BXJ7MXYAVt7lwMuRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728811; c=relaxed/simple;
	bh=Jv9CwtcIeDfFCgw6cPrNziVoveckCwTXl6g1x0jdHbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uz4bCh1kfRAux7/2D0r1GQCkmSCh5XXs2KAydqukiuvKFo1//JRUNNSo50ebHJR1pwj09MPC1C688DZGvLKmxETaHQp9wPv8WBViyaNmxWxHJo8oBFbIRXORkNTiJIhU2No3bqLXciorK8iypF8syLmd3hysYZ2HecFiUvayqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b537Rupf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C34C4AF0F;
	Thu, 15 Aug 2024 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728811;
	bh=Jv9CwtcIeDfFCgw6cPrNziVoveckCwTXl6g1x0jdHbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b537RupfXBT5eLdvXzx95gz4ZtCNY0fc81xzg5KOJNpw31seTBvLxVY2J0U1nSnRw
	 1tTae3EI+MEqiPWR5SHQngEcjaMYroCE31b/D+9Bedwy8mNBqA356/+cATLMPNvKGa
	 f4UoFpDtQ4/h5y3qfsNp3MxIKT8ofGWxga48RkEQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Perches <joe@perches.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 110/196] parport: Convert printk(KERN_<LEVEL> to pr_<level>(
Date: Thu, 15 Aug 2024 15:23:47 +0200
Message-ID: <20240815131856.289651196@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Perches <joe@perches.com>

[ Upstream commit decf26f6ec25dac868782dc1751623a87d147831 ]

Use the more common kernel style.

Miscellanea:

o Coalesce formats
o Realign arguments

Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Link: https://lore.kernel.org/r/20200403134325.11523-2-sudipm.mukherjee@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ab11dac93d2d ("dev/parport: fix the array out-of-bounds risk")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/parport/daisy.c          |   6 +-
 drivers/parport/ieee1284.c       |   4 +-
 drivers/parport/ieee1284_ops.c   |   3 +-
 drivers/parport/parport_amiga.c  |   2 +-
 drivers/parport/parport_atari.c  |   2 +-
 drivers/parport/parport_cs.c     |   6 +-
 drivers/parport/parport_gsc.c    |   7 +-
 drivers/parport/parport_ip32.c   |  25 ++---
 drivers/parport/parport_mfc3.c   |   2 +-
 drivers/parport/parport_pc.c     | 166 +++++++++++++------------------
 drivers/parport/parport_sunbpp.c |   2 +-
 drivers/parport/probe.c          |   7 +-
 drivers/parport/share.c          |  24 ++---
 13 files changed, 110 insertions(+), 146 deletions(-)

diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index 5484a46dafda8..465acebd64380 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -109,8 +109,7 @@ int parport_daisy_init(struct parport *port)
 	    ((num_ports = num_mux_ports(port)) == 2 || num_ports == 4)) {
 		/* Leave original as port zero. */
 		port->muxport = 0;
-		printk(KERN_INFO
-			"%s: 1st (default) port of %d-way multiplexor\n",
+		pr_info("%s: 1st (default) port of %d-way multiplexor\n",
 			port->name, num_ports);
 		for (i = 1; i < num_ports; i++) {
 			/* Clone the port. */
@@ -123,8 +122,7 @@ int parport_daisy_init(struct parport *port)
 				continue;
 			}
 
-			printk(KERN_INFO
-				"%s: %d%s port of %d-way multiplexor on %s\n",
+			pr_info("%s: %d%s port of %d-way multiplexor on %s\n",
 				extra->name, i + 1, th[i + 1], num_ports,
 				port->name);
 
diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index f12b9da692551..d0d36c29ae56e 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -329,7 +329,7 @@ int parport_negotiate (struct parport *port, int mode)
 #ifndef CONFIG_PARPORT_1284
 	if (mode == IEEE1284_MODE_COMPAT)
 		return 0;
-	printk (KERN_ERR "parport: IEEE1284 not supported in this kernel\n");
+	pr_err("parport: IEEE1284 not supported in this kernel\n");
 	return -1;
 #else
 	int m = mode & ~IEEE1284_ADDR;
@@ -694,7 +694,7 @@ ssize_t parport_write (struct parport *port, const void *buffer, size_t len)
 ssize_t parport_read (struct parport *port, void *buffer, size_t len)
 {
 #ifndef CONFIG_PARPORT_1284
-	printk (KERN_ERR "parport: IEEE1284 not supported in this kernel\n");
+	pr_err("parport: IEEE1284 not supported in this kernel\n");
 	return -ENODEV;
 #else
 	int mode = port->physport->ieee1284.mode;
diff --git a/drivers/parport/ieee1284_ops.c b/drivers/parport/ieee1284_ops.c
index 75daa16f38b7f..58ec484c73058 100644
--- a/drivers/parport/ieee1284_ops.c
+++ b/drivers/parport/ieee1284_ops.c
@@ -599,8 +599,7 @@ size_t parport_ieee1284_ecp_read_data (struct parport *port,
 			DPRINTK (KERN_DEBUG "ECP read timed out at 45\n");
 
 			if (command)
-				printk (KERN_WARNING
-					"%s: command ignored (%02x)\n",
+				pr_warn("%s: command ignored (%02x)\n",
 					port->name, byte);
 
 			break;
diff --git a/drivers/parport/parport_amiga.c b/drivers/parport/parport_amiga.c
index 9c68f2aec4ff7..75779725f6384 100644
--- a/drivers/parport/parport_amiga.c
+++ b/drivers/parport/parport_amiga.c
@@ -211,7 +211,7 @@ static int __init amiga_parallel_probe(struct platform_device *pdev)
 	if (err)
 		goto out_irq;
 
-	printk(KERN_INFO "%s: Amiga built-in port using irq\n", p->name);
+	pr_info("%s: Amiga built-in port using irq\n", p->name);
 	/* XXX: set operating mode */
 	parport_announce_port(p);
 
diff --git a/drivers/parport/parport_atari.c b/drivers/parport/parport_atari.c
index 9fbf6ccd54de7..2f8c7f6617d71 100644
--- a/drivers/parport/parport_atari.c
+++ b/drivers/parport/parport_atari.c
@@ -199,7 +199,7 @@ static int __init parport_atari_init(void)
 		}
 
 		this_port = p;
-		printk(KERN_INFO "%s: Atari built-in port using irq\n", p->name);
+		pr_info("%s: Atari built-in port using irq\n", p->name);
 		parport_announce_port (p);
 
 		return 0;
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index e9b52e4a4648f..755207ca155f0 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -142,10 +142,8 @@ static int parport_config(struct pcmcia_device *link)
 			      link->irq, PARPORT_DMA_NONE,
 			      &link->dev, IRQF_SHARED);
     if (p == NULL) {
-	printk(KERN_NOTICE "parport_cs: parport_pc_probe_port() at "
-	       "0x%3x, irq %u failed\n",
-	       (unsigned int) link->resource[0]->start,
-	       link->irq);
+	    pr_notice("parport_cs: parport_pc_probe_port() at 0x%3x, irq %u failed\n",
+		      (unsigned int)link->resource[0]->start, link->irq);
 	goto failed;
     }
 
diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index 190c0a7a1c526..7e2dd330831cf 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -287,7 +287,7 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 	p->size = (p->modes & PARPORT_MODE_EPP)?8:3;
 	p->private_data = priv;
 
-	printk(KERN_INFO "%s: PC-style at 0x%lx", p->name, p->base);
+	pr_info("%s: PC-style at 0x%lx", p->name, p->base);
 	p->irq = irq;
 	if (p->irq == PARPORT_IRQ_AUTO) {
 		p->irq = PARPORT_IRQ_NONE;
@@ -320,8 +320,7 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 	if (p->irq != PARPORT_IRQ_NONE) {
 		if (request_irq (p->irq, parport_irq_handler,
 				 0, p->name, p)) {
-			printk (KERN_WARNING "%s: irq %d in use, "
-				"resorting to polled operation\n",
+			pr_warn("%s: irq %d in use, resorting to polled operation\n",
 				p->name, p->irq);
 			p->irq = PARPORT_IRQ_NONE;
 			p->dma = PARPORT_DMA_NONE;
@@ -352,7 +351,7 @@ static int __init parport_init_chip(struct parisc_device *dev)
 	unsigned long port;
 
 	if (!dev->irq) {
-		printk(KERN_WARNING "IRQ not found for parallel device at 0x%llx\n",
+		pr_warn("IRQ not found for parallel device at 0x%llx\n",
 			(unsigned long long)dev->hpa.start);
 		return -ENODEV;
 	}
diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index 62873070f988e..c92523b6a3cb9 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -1348,9 +1348,8 @@ static unsigned int parport_ip32_fwp_wait_interrupt(struct parport *p)
 			ecr = parport_ip32_read_econtrol(p);
 			if ((ecr & ECR_F_EMPTY) && !(ecr & ECR_SERVINTR)
 			    && !lost_interrupt) {
-				printk(KERN_WARNING PPIP32
-				       "%s: lost interrupt in %s\n",
-				       p->name, __func__);
+				pr_warn(PPIP32 "%s: lost interrupt in %s\n",
+					p->name, __func__);
 				lost_interrupt = 1;
 			}
 		}
@@ -1654,8 +1653,8 @@ static size_t parport_ip32_compat_write_data(struct parport *p,
 				       DSR_nBUSY | DSR_nFAULT)) {
 		/* Avoid to flood the logs */
 		if (ready_before)
-			printk(KERN_INFO PPIP32 "%s: not ready in %s\n",
-			       p->name, __func__);
+			pr_info(PPIP32 "%s: not ready in %s\n",
+				p->name, __func__);
 		ready_before = 0;
 		goto stop;
 	}
@@ -1735,8 +1734,8 @@ static size_t parport_ip32_ecp_write_data(struct parport *p,
 				       DSR_nBUSY | DSR_nFAULT)) {
 		/* Avoid to flood the logs */
 		if (ready_before)
-			printk(KERN_INFO PPIP32 "%s: not ready in %s\n",
-			       p->name, __func__);
+			pr_info(PPIP32 "%s: not ready in %s\n",
+				p->name, __func__);
 		ready_before = 0;
 		goto stop;
 	}
@@ -2075,8 +2074,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 	p->modes |= PARPORT_MODE_TRISTATE;
 
 	if (!parport_ip32_fifo_supported(p)) {
-		printk(KERN_WARNING PPIP32
-		       "%s: error: FIFO disabled\n", p->name);
+		pr_warn(PPIP32 "%s: error: FIFO disabled\n", p->name);
 		/* Disable hardware modes depending on a working FIFO. */
 		features &= ~PARPORT_IP32_ENABLE_SPP;
 		features &= ~PARPORT_IP32_ENABLE_ECP;
@@ -2088,8 +2086,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 	if (features & PARPORT_IP32_ENABLE_IRQ) {
 		int irq = MACEISA_PARALLEL_IRQ;
 		if (request_irq(irq, parport_ip32_interrupt, 0, p->name, p)) {
-			printk(KERN_WARNING PPIP32
-			       "%s: error: IRQ disabled\n", p->name);
+			pr_warn(PPIP32 "%s: error: IRQ disabled\n", p->name);
 			/* DMA cannot work without interrupts. */
 			features &= ~PARPORT_IP32_ENABLE_DMA;
 		} else {
@@ -2102,8 +2099,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 	/* Allocate DMA resources */
 	if (features & PARPORT_IP32_ENABLE_DMA) {
 		if (parport_ip32_dma_register())
-			printk(KERN_WARNING PPIP32
-			       "%s: error: DMA disabled\n", p->name);
+			pr_warn(PPIP32 "%s: error: DMA disabled\n", p->name);
 		else {
 			pr_probe(p, "DMA support enabled\n");
 			p->dma = 0; /* arbitrary value != PARPORT_DMA_NONE */
@@ -2145,8 +2141,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 	parport_ip32_dump_state(p, "end init", 0);
 
 	/* Print out what we found */
-	printk(KERN_INFO "%s: SGI IP32 at 0x%lx (0x%lx)",
-	       p->name, p->base, p->base_hi);
+	pr_info("%s: SGI IP32 at 0x%lx (0x%lx)", p->name, p->base, p->base_hi);
 	if (p->irq != PARPORT_IRQ_NONE)
 		printk(", irq %d", p->irq);
 	printk(" [");
diff --git a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
index 7f4be0e484c74..378b6bce3ae70 100644
--- a/drivers/parport/parport_mfc3.c
+++ b/drivers/parport/parport_mfc3.c
@@ -324,7 +324,7 @@ static int __init parport_mfc3_init(void)
 		p->dev = &z->dev;
 
 		this_port[pias++] = p;
-		printk(KERN_INFO "%s: Multiface III port using irq\n", p->name);
+		pr_info("%s: Multiface III port using irq\n", p->name);
 		/* XXX: set operating mode */
 
 		p->private_data = (void *)piabase;
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 1f9908b1d9d6c..2bc5593b76067 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -981,28 +981,24 @@ static void show_parconfig_smsc37c669(int io, int key)
 	outb(0xaa, io);
 
 	if (verbose_probing) {
-		printk(KERN_INFO
-			"SMSC 37c669 LPT Config: cr_1=0x%02x, 4=0x%02x, "
-			"A=0x%2x, 23=0x%02x, 26=0x%02x, 27=0x%02x\n",
+		pr_info("SMSC 37c669 LPT Config: cr_1=0x%02x, 4=0x%02x, A=0x%2x, 23=0x%02x, 26=0x%02x, 27=0x%02x\n",
 			cr1, cr4, cra, cr23, cr26, cr27);
 
 		/* The documentation calls DMA and IRQ-Lines by letters, so
 		   the board maker can/will wire them
 		   appropriately/randomly...  G=reserved H=IDE-irq, */
-		printk(KERN_INFO
-	"SMSC LPT Config: io=0x%04x, irq=%c, dma=%c, fifo threshold=%d\n",
-				cr23 * 4,
-				(cr27 & 0x0f) ? 'A' - 1 + (cr27 & 0x0f) : '-',
-				(cr26 & 0x0f) ? 'A' - 1 + (cr26 & 0x0f) : '-',
-				cra & 0x0f);
-		printk(KERN_INFO "SMSC LPT Config: enabled=%s power=%s\n",
-		       (cr23 * 4 >= 0x100) ? "yes" : "no",
-		       (cr1 & 4) ? "yes" : "no");
-		printk(KERN_INFO
-			"SMSC LPT Config: Port mode=%s, EPP version =%s\n",
-				(cr1 & 0x08) ? "Standard mode only (SPP)"
-					      : modes[cr4 & 0x03],
-				(cr4 & 0x40) ? "1.7" : "1.9");
+		pr_info("SMSC LPT Config: io=0x%04x, irq=%c, dma=%c, fifo threshold=%d\n",
+			cr23 * 4,
+			(cr27 & 0x0f) ? 'A' - 1 + (cr27 & 0x0f) : '-',
+			(cr26 & 0x0f) ? 'A' - 1 + (cr26 & 0x0f) : '-',
+			cra & 0x0f);
+		pr_info("SMSC LPT Config: enabled=%s power=%s\n",
+			(cr23 * 4 >= 0x100) ? "yes" : "no",
+			(cr1 & 4) ? "yes" : "no");
+		pr_info("SMSC LPT Config: Port mode=%s, EPP version =%s\n",
+			(cr1 & 0x08) ? "Standard mode only (SPP)"
+			: modes[cr4 & 0x03],
+			(cr4 & 0x40) ? "1.7" : "1.9");
 	}
 
 	/* Heuristics !  BIOS setup for this mainboard device limits
@@ -1012,7 +1008,7 @@ static void show_parconfig_smsc37c669(int io, int key)
 	if (cr23 * 4 >= 0x100) { /* if active */
 		s = find_free_superio();
 		if (s == NULL)
-			printk(KERN_INFO "Super-IO: too many chips!\n");
+			pr_info("Super-IO: too many chips!\n");
 		else {
 			int d;
 			switch (cr23 * 4) {
@@ -1077,26 +1073,24 @@ static void show_parconfig_winbond(int io, int key)
 	outb(0xaa, io);
 
 	if (verbose_probing) {
-		printk(KERN_INFO
-    "Winbond LPT Config: cr_30=%02x 60,61=%02x%02x 70=%02x 74=%02x, f0=%02x\n",
-					cr30, cr60, cr61, cr70, cr74, crf0);
-		printk(KERN_INFO "Winbond LPT Config: active=%s, io=0x%02x%02x irq=%d, ",
-		       (cr30 & 0x01) ? "yes" : "no", cr60, cr61, cr70 & 0x0f);
+		pr_info("Winbond LPT Config: cr_30=%02x 60,61=%02x%02x 70=%02x 74=%02x, f0=%02x\n",
+			cr30, cr60, cr61, cr70, cr74, crf0);
+		pr_info("Winbond LPT Config: active=%s, io=0x%02x%02x irq=%d, ",
+			(cr30 & 0x01) ? "yes" : "no", cr60, cr61, cr70 & 0x0f);
 		if ((cr74 & 0x07) > 3)
 			pr_cont("dma=none\n");
 		else
 			pr_cont("dma=%d\n", cr74 & 0x07);
-		printk(KERN_INFO
-		    "Winbond LPT Config: irqtype=%s, ECP fifo threshold=%d\n",
-					irqtypes[crf0>>7], (crf0>>3)&0x0f);
-		printk(KERN_INFO "Winbond LPT Config: Port mode=%s\n",
-					modes[crf0 & 0x07]);
+		pr_info("Winbond LPT Config: irqtype=%s, ECP fifo threshold=%d\n",
+			irqtypes[crf0 >> 7], (crf0 >> 3) & 0x0f);
+		pr_info("Winbond LPT Config: Port mode=%s\n",
+			modes[crf0 & 0x07]);
 	}
 
 	if (cr30 & 0x01) { /* the settings can be interrogated later ... */
 		s = find_free_superio();
 		if (s == NULL)
-			printk(KERN_INFO "Super-IO: too many chips!\n");
+			pr_info("Super-IO: too many chips!\n");
 		else {
 			s->io = (cr60 << 8) | cr61;
 			s->irq = cr70 & 0x0f;
@@ -1150,9 +1144,8 @@ static void decode_winbond(int efer, int key, int devid, int devrev, int oldid)
 		progif = 0;
 
 	if (verbose_probing)
-		printk(KERN_INFO "Winbond chip at EFER=0x%x key=0x%02x "
-		       "devid=%02x devrev=%02x oldid=%02x type=%s\n",
-		       efer, key, devid, devrev, oldid, type);
+		pr_info("Winbond chip at EFER=0x%x key=0x%02x devid=%02x devrev=%02x oldid=%02x type=%s\n",
+			efer, key, devid, devrev, oldid, type);
 
 	if (progif == 2)
 		show_parconfig_winbond(efer, key);
@@ -1183,9 +1176,8 @@ static void decode_smsc(int efer, int key, int devid, int devrev)
 		type = "37c666GT";
 
 	if (verbose_probing)
-		printk(KERN_INFO "SMSC chip at EFER=0x%x "
-		       "key=0x%02x devid=%02x devrev=%02x type=%s\n",
-		       efer, key, devid, devrev, type);
+		pr_info("SMSC chip at EFER=0x%x key=0x%02x devid=%02x devrev=%02x type=%s\n",
+			efer, key, devid, devrev, type);
 
 	if (func)
 		func(efer, key);
@@ -1357,7 +1349,7 @@ static void detect_and_report_it87(void)
 	dev |= inb(0x2f);
 	if (dev == 0x8712 || dev == 0x8705 || dev == 0x8715 ||
 	    dev == 0x8716 || dev == 0x8718 || dev == 0x8726) {
-		printk(KERN_INFO "IT%04X SuperIO detected.\n", dev);
+		pr_info("IT%04X SuperIO detected\n", dev);
 		outb(0x07, 0x2E);	/* Parallel Port */
 		outb(0x03, 0x2F);
 		outb(0xF0, 0x2E);	/* BOOT 0x80 off */
@@ -1444,8 +1436,8 @@ static int parport_SPP_supported(struct parport *pb)
 	if (user_specified)
 		/* That didn't work, but the user thinks there's a
 		 * port here. */
-		printk(KERN_INFO "parport 0x%lx (WARNING): CTR: "
-			"wrote 0x%02x, read 0x%02x\n", pb->base, w, r);
+		pr_info("parport 0x%lx (WARNING): CTR: wrote 0x%02x, read 0x%02x\n",
+			pb->base, w, r);
 
 	/* Try the data register.  The data lines aren't tri-stated at
 	 * this stage, so we expect back what we wrote. */
@@ -1463,10 +1455,9 @@ static int parport_SPP_supported(struct parport *pb)
 	if (user_specified) {
 		/* Didn't work, but the user is convinced this is the
 		 * place. */
-		printk(KERN_INFO "parport 0x%lx (WARNING): DATA: "
-			"wrote 0x%02x, read 0x%02x\n", pb->base, w, r);
-		printk(KERN_INFO "parport 0x%lx: You gave this address, "
-			"but there is probably no parallel port there!\n",
+		pr_info("parport 0x%lx (WARNING): DATA: wrote 0x%02x, read 0x%02x\n",
+			pb->base, w, r);
+		pr_info("parport 0x%lx: You gave this address, but there is probably no parallel port there!\n",
 			pb->base);
 	}
 
@@ -1641,7 +1632,7 @@ static int parport_ECP_supported(struct parport *pb)
 
 	if (i <= priv->fifo_depth) {
 		if (verbose_probing)
-			printk(KERN_INFO "0x%lx: readIntrThreshold is %d\n",
+			pr_info("0x%lx: readIntrThreshold is %d\n",
 				pb->base, i);
 	} else
 		/* Number of bytes we can read if we get an interrupt. */
@@ -1656,17 +1647,14 @@ static int parport_ECP_supported(struct parport *pb)
 	switch (pword) {
 	case 0:
 		pword = 2;
-		printk(KERN_WARNING "0x%lx: Unsupported pword size!\n",
-			pb->base);
+		pr_warn("0x%lx: Unsupported pword size!\n", pb->base);
 		break;
 	case 2:
 		pword = 4;
-		printk(KERN_WARNING "0x%lx: Unsupported pword size!\n",
-			pb->base);
+		pr_warn("0x%lx: Unsupported pword size!\n", pb->base);
 		break;
 	default:
-		printk(KERN_WARNING "0x%lx: Unknown implementation ID\n",
-			pb->base);
+		pr_warn("0x%lx: Unknown implementation ID\n", pb->base);
 		/* Fall through - Assume 1 */
 	case 1:
 		pword = 1;
@@ -2106,9 +2094,9 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 
 	p->size = (p->modes & PARPORT_MODE_EPP) ? 8 : 3;
 
-	printk(KERN_INFO "%s: PC-style at 0x%lx", p->name, p->base);
+	pr_info("%s: PC-style at 0x%lx", p->name, p->base);
 	if (p->base_hi && priv->ecr)
-		printk(KERN_CONT " (0x%lx)", p->base_hi);
+		pr_cont(" (0x%lx)", p->base_hi);
 	if (p->irq == PARPORT_IRQ_AUTO) {
 		p->irq = PARPORT_IRQ_NONE;
 		parport_irq_probe(p);
@@ -2119,7 +2107,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 		p->irq = PARPORT_IRQ_NONE;
 	}
 	if (p->irq != PARPORT_IRQ_NONE) {
-		printk(KERN_CONT ", irq %d", p->irq);
+		pr_cont(", irq %d", p->irq);
 		priv->ctr_writable |= 0x10;
 
 		if (p->dma == PARPORT_DMA_AUTO) {
@@ -2143,21 +2131,21 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 		/* p->ops->ecp_read_data = parport_pc_ecp_read_block_pio; */
 #endif /* IEEE 1284 support */
 		if (p->dma != PARPORT_DMA_NONE) {
-			printk(KERN_CONT ", dma %d", p->dma);
+			pr_cont(", dma %d", p->dma);
 			p->modes |= PARPORT_MODE_DMA;
 		} else
-			printk(KERN_CONT ", using FIFO");
+			pr_cont(", using FIFO");
 	} else
 		/* We can't use the DMA channel after all. */
 		p->dma = PARPORT_DMA_NONE;
 #endif /* Allowed to use FIFO/DMA */
 
-	printk(KERN_CONT " [");
+	pr_cont(" [");
 
 #define printmode(x) \
 	{\
 		if (p->modes & PARPORT_MODE_##x) {\
-			printk(KERN_CONT "%s%s", f ? "," : "", #x);\
+			pr_cont("%s%s", f ? "," : "", #x);	\
 			f++;\
 		} \
 	}
@@ -2173,11 +2161,11 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 	}
 #undef printmode
 #ifndef CONFIG_PARPORT_1284
-	printk(KERN_CONT "(,...)");
+	pr_cont("(,...)");
 #endif /* CONFIG_PARPORT_1284 */
-	printk(KERN_CONT "]\n");
+	pr_cont("]\n");
 	if (probedirq != PARPORT_IRQ_NONE)
-		printk(KERN_INFO "%s: irq %d detected\n", p->name, probedirq);
+		pr_info("%s: irq %d detected\n", p->name, probedirq);
 
 	/* If No ECP release the ports grabbed above. */
 	if (ECR_res && (p->modes & PARPORT_MODE_ECP) == 0) {
@@ -2192,8 +2180,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 	if (p->irq != PARPORT_IRQ_NONE) {
 		if (request_irq(p->irq, parport_irq_handler,
 				 irqflags, p->name, p)) {
-			printk(KERN_WARNING "%s: irq %d in use, "
-				"resorting to polled operation\n",
+			pr_warn("%s: irq %d in use, resorting to polled operation\n",
 				p->name, p->irq);
 			p->irq = PARPORT_IRQ_NONE;
 			p->dma = PARPORT_DMA_NONE;
@@ -2203,8 +2190,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 #ifdef HAS_DMA
 		if (p->dma != PARPORT_DMA_NONE) {
 			if (request_dma(p->dma, p->name)) {
-				printk(KERN_WARNING "%s: dma %d in use, "
-					"resorting to PIO operation\n",
+				pr_warn("%s: dma %d in use, resorting to PIO operation\n",
 					p->name, p->dma);
 				p->dma = PARPORT_DMA_NONE;
 			} else {
@@ -2214,9 +2200,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 						       &priv->dma_handle,
 						       GFP_KERNEL);
 				if (!priv->dma_buf) {
-					printk(KERN_WARNING "%s: "
-						"cannot get buffer for DMA, "
-						"resorting to PIO operation\n",
+					pr_warn("%s: cannot get buffer for DMA, resorting to PIO operation\n",
 						p->name);
 					free_dma(p->dma);
 					p->dma = PARPORT_DMA_NONE;
@@ -2329,7 +2313,7 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 		}
 	}
 	if (i >= 5) {
-		printk(KERN_INFO "parport_pc: cannot find ITE8872 INTA\n");
+		pr_info("parport_pc: cannot find ITE8872 INTA\n");
 		return 0;
 	}
 
@@ -2338,29 +2322,28 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 
 	switch (type) {
 	case 0x2:
-		printk(KERN_INFO "parport_pc: ITE8871 found (1P)\n");
+		pr_info("parport_pc: ITE8871 found (1P)\n");
 		ite8872set = 0x64200000;
 		break;
 	case 0xa:
-		printk(KERN_INFO "parport_pc: ITE8875 found (1P)\n");
+		pr_info("parport_pc: ITE8875 found (1P)\n");
 		ite8872set = 0x64200000;
 		break;
 	case 0xe:
-		printk(KERN_INFO "parport_pc: ITE8872 found (2S1P)\n");
+		pr_info("parport_pc: ITE8872 found (2S1P)\n");
 		ite8872set = 0x64e00000;
 		break;
 	case 0x6:
-		printk(KERN_INFO "parport_pc: ITE8873 found (1S)\n");
+		pr_info("parport_pc: ITE8873 found (1S)\n");
 		release_region(inta_addr[i], 32);
 		return 0;
 	case 0x8:
-		printk(KERN_INFO "parport_pc: ITE8874 found (2S)\n");
+		pr_info("parport_pc: ITE8874 found (2S)\n");
 		release_region(inta_addr[i], 32);
 		return 0;
 	default:
-		printk(KERN_INFO "parport_pc: unknown ITE887x\n");
-		printk(KERN_INFO "parport_pc: please mail 'lspci -nvv' "
-			"output to Rich.Liu@ite.com.tw\n");
+		pr_info("parport_pc: unknown ITE887x\n");
+		pr_info("parport_pc: please mail 'lspci -nvv' output to Rich.Liu@ite.com.tw\n");
 		release_region(inta_addr[i], 32);
 		return 0;
 	}
@@ -2395,9 +2378,8 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	release_region(inta_addr[i], 32);
 	if (parport_pc_probe_port(ite8872_lpt, ite8872_lpthi,
 				   irq, PARPORT_DMA_NONE, &pdev->dev, 0)) {
-		printk(KERN_INFO
-			"parport_pc: ITE 8872 parallel port: io=0x%X",
-								ite8872_lpt);
+		pr_info("parport_pc: ITE 8872 parallel port: io=0x%X",
+			ite8872_lpt);
 		if (irq != PARPORT_IRQ_NONE)
 			pr_cont(", irq=%d", irq);
 		pr_cont("\n");
@@ -2524,7 +2506,7 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	pci_write_config_byte(pdev, via->via_pci_superio_config_reg, tmp);
 
 	if (siofunc == VIA_FUNCTION_PARPORT_DISABLE) {
-		printk(KERN_INFO "parport_pc: VIA parallel port disabled in BIOS\n");
+		pr_info("parport_pc: VIA parallel port disabled in BIOS\n");
 		return 0;
 	}
 
@@ -2557,9 +2539,8 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	case 0x278:
 		port2 = 0x678; break;
 	default:
-		printk(KERN_INFO
-			"parport_pc: Weird VIA parport base 0x%X, ignoring\n",
-									port1);
+		pr_info("parport_pc: Weird VIA parport base 0x%X, ignoring\n",
+			port1);
 		return 0;
 	}
 
@@ -2578,8 +2559,7 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 
 	/* finally, do the probe with values obtained */
 	if (parport_pc_probe_port(port1, port2, irq, dma, &pdev->dev, 0)) {
-		printk(KERN_INFO
-			"parport_pc: VIA parallel port: io=0x%X", port1);
+		pr_info("parport_pc: VIA parallel port: io=0x%X", port1);
 		if (irq != PARPORT_IRQ_NONE)
 			pr_cont(", irq=%d", irq);
 		if (dma != PARPORT_DMA_NONE)
@@ -2588,7 +2568,7 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 		return 1;
 	}
 
-	printk(KERN_WARNING "parport_pc: Strange, can't probe VIA parallel port: io=0x%X, irq=%d, dma=%d\n",
+	pr_warn("parport_pc: Strange, can't probe VIA parallel port: io=0x%X, irq=%d, dma=%d\n",
 		port1, irq, dma);
 	return 0;
 }
@@ -3131,7 +3111,7 @@ static int __init parport_parse_param(const char *s, int *val,
 		if (ep != s)
 			*val = r;
 		else {
-			printk(KERN_ERR "parport: bad specifier `%s'\n", s);
+			pr_err("parport: bad specifier `%s'\n", s);
 			return -1;
 		}
 	}
@@ -3221,10 +3201,7 @@ static int __init parse_parport_params(void)
 				irqval[0] = val;
 				break;
 			default:
-				printk(KERN_WARNING
-					"parport_pc: irq specified "
-					"without base address.  Use 'io=' "
-					"to specify one\n");
+				pr_warn("parport_pc: irq specified without base address.  Use 'io=' to specify one\n");
 			}
 
 		if (dma[0] && !parport_parse_dma(dma[0], &val))
@@ -3234,10 +3211,7 @@ static int __init parse_parport_params(void)
 				dmaval[0] = val;
 				break;
 			default:
-				printk(KERN_WARNING
-					"parport_pc: dma specified "
-					"without base address.  Use 'io=' "
-					"to specify one\n");
+				pr_warn("parport_pc: dma specified without base address.  Use 'io=' to specify one\n");
 			}
 	}
 	return 0;
@@ -3276,12 +3250,12 @@ static int __init parport_setup(char *str)
 
 	val = simple_strtoul(str, &endptr, 0);
 	if (endptr == str) {
-		printk(KERN_WARNING "parport=%s not understood\n", str);
+		pr_warn("parport=%s not understood\n", str);
 		return 1;
 	}
 
 	if (parport_setup_ptr == PARPORT_PC_MAX_PORTS) {
-		printk(KERN_ERR "parport=%s ignored, too many ports\n", str);
+		pr_err("parport=%s ignored, too many ports\n", str);
 		return 1;
 	}
 
diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 8de329546b822..77671b7ad421e 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -313,7 +313,7 @@ static int bpp_probe(struct platform_device *op)
 	value_tcr &= ~P_TCR_DIR;
 	sbus_writeb(value_tcr, &regs->p_tcr);
 
-	printk(KERN_INFO "%s: sunbpp at 0x%lx\n", p->name, p->base);
+	pr_info("%s: sunbpp at 0x%lx\n", p->name, p->base);
 
 	dev_set_drvdata(&op->dev, p);
 
diff --git a/drivers/parport/probe.c b/drivers/parport/probe.c
index e035174ba205d..650206c71875b 100644
--- a/drivers/parport/probe.c
+++ b/drivers/parport/probe.c
@@ -38,7 +38,7 @@ static void pretty_print(struct parport *port, int device)
 {
 	struct parport_device_info *info = &port->probe_info[device + 1];
 
-	printk(KERN_INFO "%s", port->name);
+	pr_info("%s", port->name);
 
 	if (device >= 0)
 		printk (" (addr %d)", device);
@@ -58,7 +58,7 @@ static void parse_data(struct parport *port, int device, char *str)
 	struct parport_device_info *info = &port->probe_info[device + 1];
 
 	if (!txt) {
-		printk(KERN_WARNING "%s probe: memory squeeze\n", port->name);
+		pr_warn("%s probe: memory squeeze\n", port->name);
 		return;
 	}
 	strcpy(txt, str);
@@ -98,7 +98,8 @@ static void parse_data(struct parport *port, int device, char *str)
 						goto rock_on;
 					}
 				}
-				printk(KERN_WARNING "%s probe: warning, class '%s' not understood.\n", port->name, sep);
+				pr_warn("%s probe: warning, class '%s' not understood\n",
+					port->name, sep);
 				info->class = PARPORT_CLASS_OTHER;
 			} else if (!strcmp(p, "CMD") ||
 				   !strcmp(p, "COMMAND SET")) {
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 15c81cffd2de2..fc2930fb9bee1 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -555,8 +555,8 @@ void parport_announce_port(struct parport *port)
 #endif
 
 	if (!port->dev)
-		printk(KERN_WARNING "%s: fix this legacy no-device port driver!\n",
-		       port->name);
+		pr_warn("%s: fix this legacy no-device port driver!\n",
+			port->name);
 
 	parport_proc_register(port);
 	mutex_lock(&registration_lock);
@@ -728,7 +728,8 @@ parport_register_device(struct parport *port, const char *name,
 
 	if (flags & PARPORT_DEV_LURK) {
 		if (!pf || !kf) {
-			printk(KERN_INFO "%s: refused to register lurking device (%s) without callbacks\n", port->name, name);
+			pr_info("%s: refused to register lurking device (%s) without callbacks\n",
+				port->name, name);
 			return NULL;
 		}
 	}
@@ -997,7 +998,7 @@ void parport_unregister_device(struct pardevice *dev)
 
 #ifdef PARPORT_PARANOID
 	if (!dev) {
-		printk(KERN_ERR "parport_unregister_device: passed NULL\n");
+		pr_err("%s: passed NULL\n", __func__);
 		return;
 	}
 #endif
@@ -1138,8 +1139,7 @@ int parport_claim(struct pardevice *dev)
 	unsigned long flags;
 
 	if (port->cad == dev) {
-		printk(KERN_INFO "%s: %s already owner\n",
-		       dev->port->name,dev->name);
+		pr_info("%s: %s already owner\n", dev->port->name, dev->name);
 		return 0;
 	}
 
@@ -1159,9 +1159,8 @@ int parport_claim(struct pardevice *dev)
 			 * I think we'll actually deadlock rather than
 			 * get here, but just in case..
 			 */
-			printk(KERN_WARNING
-			       "%s: %s released port when preempted!\n",
-			       port->name, oldcad->name);
+			pr_warn("%s: %s released port when preempted!\n",
+				port->name, oldcad->name);
 			if (port->cad)
 				goto blocked;
 		}
@@ -1321,8 +1320,8 @@ void parport_release(struct pardevice *dev)
 	write_lock_irqsave(&port->cad_lock, flags);
 	if (port->cad != dev) {
 		write_unlock_irqrestore(&port->cad_lock, flags);
-		printk(KERN_WARNING "%s: %s tried to release parport when not owner\n",
-		       port->name, dev->name);
+		pr_warn("%s: %s tried to release parport when not owner\n",
+			port->name, dev->name);
 		return;
 	}
 
@@ -1362,7 +1361,8 @@ void parport_release(struct pardevice *dev)
 			if (dev->port->cad) /* racy but no matter */
 				return;
 		} else {
-			printk(KERN_ERR "%s: don't know how to wake %s\n", port->name, pd->name);
+			pr_err("%s: don't know how to wake %s\n",
+			       port->name, pd->name);
 		}
 	}
 
-- 
2.43.0




