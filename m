Return-Path: <stable+bounces-180977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FFAB91ED5
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B9F1904B2C
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604062E2DF3;
	Mon, 22 Sep 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyano.uk header.i=@cyano.uk header.b="tUOuC2v+"
X-Original-To: stable@vger.kernel.org
Received: from jupiter.guys.cyano.uk (jupiter.guys.cyano.uk [45.63.120.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59B2E2EF0;
	Mon, 22 Sep 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.63.120.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554900; cv=none; b=hmdy7Jxn3hnhEng2uRqyfPPbmpCelbQO6gTo5lzocn9ptXglXlfK1nspNzCozrUHVpwl6B1lN9rgMkBcyD1infH5GwBA+FIlUcygoiuJuvhz9hLgH4GrjQuob6b79Hnc6iLGfedpAl6K6eNrLHJQAOqg+4voFIGNkvLLpS8fEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554900; c=relaxed/simple;
	bh=XHSCUTanGtCRbEHdPAn8oxyZAecdpBrHzSnvSqDFdgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S/EXi59Sb2uUtA77fDHXZNTwRbq8ZL4f7oujDspSPSN8tonoHHBJo0ohhz0Q3Bwh5VWZz0qs5RfKtsR6cBbn/EjWTXRgrs62XI8eHrPF+HYKKH2f7WRPl4b8l2WvUVsQKE0zJFSK7ZujIuMsJFAISlQrEbUUWk2uqEOVSuPr+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cyano.uk; spf=pass smtp.mailfrom=cyano.uk; dkim=pass (2048-bit key) header.d=cyano.uk header.i=@cyano.uk header.b=tUOuC2v+; arc=none smtp.client-ip=45.63.120.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cyano.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyano.uk
From: Xinhui Yang <cyan@cyano.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyano.uk; s=dkim;
	t=1758554895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5+VQLc5Bk8KM/HhHN/dIMbUbv2CwDDwUBSUL5xfEoFY=;
	b=tUOuC2v+Hrrb6aaaVi1PVtgfHwXsYwHXSRhm/5UCL89BBnTa7X+V1OodQHq8Zicsno4G+y
	2gnO9uc2SpOruokkL0YPD4lXv69uaHPlWEq4E0mGvNdSH+n+oIDg1wgqQqiVuV9CP6qptH
	8AYeM7Lb6SemnY87WeMJ4gOiDjGUOCjzpponP402SGJd4IV6xzs5LAydh1RV2X3z8mln9/
	RWsvsnj4Kao3NSlWf/KrH2bTGWHMKO6wgZ//JRHw3MfwUf4dWSeuxNMDR22Tkhhd6nlNj6
	lMH0Ay1ehl9ncYP06y3ifxDE1Xj1WghtW34dhq3Vqtx7ATRC9seSDPzSrtMAxg==
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
Subject: [PATCH v2] scsi: dc395x: correctly discard the return value in certain reads
Date: Mon, 22 Sep 2025 23:26:08 +0800
Message-ID: <20250922152609.827311-1-cyan@cyano.uk>
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

Other changes:
* Also slightly modify the formatting of the DC395x_* macros.

Cc: stable@vger.kernel.org
Signed-off-by: Xinhui Yang <cyan@cyano.uk>

---
Changes since v1 [1]:
- Add Cc: tag to include this patch to the stable tree.
- Add additional description about the formatting changes.

[1]: https://lore.kernel.org/linux-scsi/20250922143619.824129-1-cyan@cyano.uk
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


