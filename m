Return-Path: <stable+bounces-180970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C9CB91C8F
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 16:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E561893568
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167BA285050;
	Mon, 22 Sep 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyano.uk header.i=@cyano.uk header.b="dBhXMRCA"
X-Original-To: stable@vger.kernel.org
Received: from jupiter.guys.cyano.uk (jupiter.guys.cyano.uk [45.63.120.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85F270575;
	Mon, 22 Sep 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.63.120.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552330; cv=none; b=oj1RtcM3BLTh8UnQDc2h1viIgQercs73vqcQvXfOAz9316Bsb2h6hbvhBdGeq4qVtd56IU1mto1XD08UttEd9jq1Z5XXaBpYin9VlcbFfIdok6UrByV7tSKnpB62MInxJHu218T4U77hM4zgibQib8BTMGxVwWXtpG9cWHz1dLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552330; c=relaxed/simple;
	bh=d2mMnZSYt/0QmdgJDvPlJQuYTeSOPwcauhZznvRBvLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HdfLdC/Jdl8BUN/03ARiB10wC60ixP3Ahm8FwNeEDkSvbOeD6mDDkQ/4Phzmrqydz1fWfDW326MCzeW70fUxCNdkVgAax5xpWPi+oK4Zviu7AddOTz6TYu/hdFjDVmdd7na/pVGjoAdhvH8ZXIimSkg1cqrDifKWh1txypMJuOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cyano.uk; spf=pass smtp.mailfrom=cyano.uk; dkim=pass (2048-bit key) header.d=cyano.uk header.i=@cyano.uk header.b=dBhXMRCA; arc=none smtp.client-ip=45.63.120.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cyano.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyano.uk
From: Xinhui Yang <cyan@cyano.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyano.uk; s=dkim;
	t=1758551852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jJB3CodlCdQSfnz45CZ5KOyNJWuDIISVpH/Ds+KGYBE=;
	b=dBhXMRCAU2B1StqCmMIyux7XHP5EsuaykQFQ+SyayqI8GyO0cyf07nsaVOD3Kg6K0GMN3W
	DzhMEWNOZ0Pw3n+4qA72crZvqwGFq6Ph/RVcnBgxZ+ClFViQwQK5ouAhGn8E5xdSdoOyUV
	8c8towRjaAsVJkhxQ/17BsVEBYXeQlYNuwmI1SWKbBZj65herck+sc9HYQGq9nytSA11Vn
	4QoVmsM7KCQi7wiBq8vwIjY5/KI4i8ebyxF1sybzeG8lKMeqhLahxcDaS+NmlHeRJy963m
	bcwsA8zIw9axePe3YMG+9px6m3cljPSjS7R2ix3RpDdW+nxqsBrMaEmcnTKoag==
Authentication-Results: jupiter.guys.cyano.uk;
	auth=pass smtp.mailfrom=cyan@cyano.uk
To: linux-scsi@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Xinhui Yang <cyan@cyano.uk>,
	Oliver Neukum <oliver@neukum.org>,
	Ali Akcaagac <aliakc@web.de>,
	Jamie Lenehan <lenehan@twibble.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: dc395x: correctly discard the return value in certain reads
Date: Mon, 22 Sep 2025 22:36:19 +0800
Message-ID: <20250922143619.824129-1-cyan@cyano.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

There are certain read operations performed in this code which doesn't
really don't need its return value. Those read operations either clears
the FIFO buffer, or clears the interruption status. However, unused read
triggers compiler warnings. With CONFIG_WERROR on, these warnings get
converted into errors:

drivers/scsi/dc395x.c: In function ‘__dc395x_eh_bus_reset’:
drivers/scsi/dc395x.c:97:49: error: value computed is not used [-Werror=unused-value]
   97 | #define DC395x_read8(acb,address)               (u8)(inb(acb->io_port_base + (address)))
      |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/dc395x.c:1003:9: note: in expansion of macro ‘DC395x_read8’
 1003 |         DC395x_read8(acb, TRM_S1040_SCSI_INTSTATUS);
      |         ^~~~~~~~~~~~
drivers/scsi/dc395x.c: In function ‘data_io_transfer’:
drivers/scsi/dc395x.c:97:49: error: value computed is not used [-Werror=unused-value]
   97 | #define DC395x_read8(acb,address)               (u8)(inb(acb->io_port_base + (address)))
      |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/dc395x.c:2032:33: note: in expansion of macro ‘DC395x_read8’
 2032 |                                 DC395x_read8(acb, TRM_S1040_SCSI_FIFO);

Create a new macro DC395x_peek8() to deliberately cast the return value
to void, which tells the compiler we really don't need the return value
of such read operations.

Signed-off-by: Xinhui Yang <cyan@cyano.uk>
---
 drivers/scsi/dc395x.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 386c8359e1cc..013d0d5277d6 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -91,15 +91,21 @@
 #endif
 
 
-#define DC395x_LOCK_IO(dev,flags)		spin_lock_irqsave(((struct Scsi_Host *)dev)->host_lock, flags)
-#define DC395x_UNLOCK_IO(dev,flags)		spin_unlock_irqrestore(((struct Scsi_Host *)dev)->host_lock, flags)
+#define DC395x_LOCK_IO(dev, flags)		spin_lock_irqsave(((struct Scsi_Host *)dev)->host_lock, flags)
+#define DC395x_UNLOCK_IO(dev, flags)		spin_unlock_irqrestore(((struct Scsi_Host *)dev)->host_lock, flags)
 
-#define DC395x_read8(acb,address)		(u8)(inb(acb->io_port_base + (address)))
-#define DC395x_read16(acb,address)		(u16)(inw(acb->io_port_base + (address)))
-#define DC395x_read32(acb,address)		(u32)(inl(acb->io_port_base + (address)))
-#define DC395x_write8(acb,address,value)	outb((value), acb->io_port_base + (address))
-#define DC395x_write16(acb,address,value)	outw((value), acb->io_port_base + (address))
-#define DC395x_write32(acb,address,value)	outl((value), acb->io_port_base + (address))
+/*
+ * read operations that may trigger side effects in the hardware,
+ * but the value can or should be discarded.
+ */
+#define DC395x_peek8(acb, address)		((void)(inb(acb->io_port_base + (address))))
+/* Normal read write operations goes here. */
+#define DC395x_read8(acb, address)		((u8)    (inb(acb->io_port_base + (address))))
+#define DC395x_read16(acb, address)		((u16)   (inw(acb->io_port_base + (address))))
+#define DC395x_read32(acb, address)		((u32)   (inl(acb->io_port_base + (address))))
+#define DC395x_write8(acb, address, value)	(outb((value), acb->io_port_base + (address)))
+#define DC395x_write16(acb, address, value)	(outw((value), acb->io_port_base + (address)))
+#define DC395x_write32(acb, address, value)	(outl((value), acb->io_port_base + (address)))
 
 #define TAG_NONE 255
 
@@ -1000,7 +1006,7 @@ static int __dc395x_eh_bus_reset(struct scsi_cmnd *cmd)
 	DC395x_write8(acb, TRM_S1040_DMA_CONTROL, CLRXFIFO);
 	clear_fifo(acb, "eh_bus_reset");
 	/* Delete pending IRQ */
-	DC395x_read8(acb, TRM_S1040_SCSI_INTSTATUS);
+	DC395x_peek8(acb, TRM_S1040_SCSI_INTSTATUS);
 	set_basic_config(acb);
 
 	reset_dev_param(acb);
@@ -2029,8 +2035,8 @@ static void data_io_transfer(struct AdapterCtlBlk *acb,
 			DC395x_write8(acb, TRM_S1040_SCSI_CONFIG2,
 				      CFG2_WIDEFIFO);
 			if (io_dir & DMACMD_DIR) {
-				DC395x_read8(acb, TRM_S1040_SCSI_FIFO);
-				DC395x_read8(acb, TRM_S1040_SCSI_FIFO);
+				DC395x_peek8(acb, TRM_S1040_SCSI_FIFO);
+				DC395x_peek8(acb, TRM_S1040_SCSI_FIFO);
 			} else {
 				/* Danger, Robinson: If you find KGs
 				 * scattered over the wide disk, the driver
@@ -2044,7 +2050,7 @@ static void data_io_transfer(struct AdapterCtlBlk *acb,
 			/* Danger, Robinson: If you find a collection of Ks on your disk
 			 * something broke :-( */
 			if (io_dir & DMACMD_DIR)
-				DC395x_read8(acb, TRM_S1040_SCSI_FIFO);
+				DC395x_peek8(acb, TRM_S1040_SCSI_FIFO);
 			else
 				DC395x_write8(acb, TRM_S1040_SCSI_FIFO, 'K');
 		}
@@ -2892,7 +2898,7 @@ static void set_basic_config(struct AdapterCtlBlk *acb)
 	    DMA_FIFO_HALF_HALF | DMA_ENHANCE /*| DMA_MEM_MULTI_READ */ ;
 	DC395x_write16(acb, TRM_S1040_DMA_CONFIG, wval);
 	/* Clear pending interrupt status */
-	DC395x_read8(acb, TRM_S1040_SCSI_INTSTATUS);
+	DC395x_peek8(acb, TRM_S1040_SCSI_INTSTATUS);
 	/* Enable SCSI interrupt    */
 	DC395x_write8(acb, TRM_S1040_SCSI_INTEN, 0x7F);
 	DC395x_write8(acb, TRM_S1040_DMA_INTEN, EN_SCSIINTR | EN_DMAXFERERROR
@@ -3799,7 +3805,7 @@ static void adapter_uninit_chip(struct AdapterCtlBlk *acb)
 		reset_scsi_bus(acb);
 
 	/* clear any pending interrupt state */
-	DC395x_read8(acb, TRM_S1040_SCSI_INTSTATUS);
+	DC395x_peek8(acb, TRM_S1040_SCSI_INTSTATUS);
 }
 
 
-- 
2.51.0


