Return-Path: <stable+bounces-80429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC41998DD64
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45AA1C21AD4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423561D0DFE;
	Wed,  2 Oct 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GvNyYz6V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418A9475;
	Wed,  2 Oct 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880349; cv=none; b=e7e5XWMODULzZ5fAWAUC8b35LyxCWJxybwS/4B55vDrM7dobcRpslr4VVTkzVPuQHig3A7Edbr4tkmxtJ4UA5um8R6NpI0ncv1BBx2vw7VyXzR56WOt0E+gP06ehX9PCmt7sv9L6NCg/zCrU/Ju1wSibakRNmY+0TPrRAUXAWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880349; c=relaxed/simple;
	bh=Ao6ioC3RqHipQjJZ4Xf84RxeWo/yIsmMZaGOY0O4prM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEPjKB65+v8tkzCZ9O6XLulC5CAT+DWhiNbi6+wQQDUafSR8Psvn2fBXtr7oejSLI4UDONaQ2wbF3j8yW9FZ//R94sTm6deP1bC2MqKhFit4zaZZHdaaELM21P6iA/IPORInRJEU2cy4b/qBmgmHFtBvvEtWBXSpALhkAasJ7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GvNyYz6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2C7C4CEC2;
	Wed,  2 Oct 2024 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880348;
	bh=Ao6ioC3RqHipQjJZ4Xf84RxeWo/yIsmMZaGOY0O4prM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvNyYz6Vzl0WNpt9GFcBmuoRHj4V43v4IdRjut32iGjh5mEg7sikp/ECPaJD2SBgI
	 TGf2C6UIRvKOH2fhAO1gTvo6IwZzirosEe/te9WZrQil1BnMmznMdiIjk1R3Ovv4kr
	 3hHAvgNXhDUibQocDiJfBn/XyHppiFBpYtf4pXEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@linux-m68k.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 427/538] scsi: mac_scsi: Revise printk(KERN_DEBUG ...) messages
Date: Wed,  2 Oct 2024 15:01:06 +0200
Message-ID: <20241002125809.290310455@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@linux-m68k.org>

commit 5ec4f820cb9766e4583df947150a6febce8da794 upstream.

After a bus fault, capture and log the chip registers immediately, if the
NDEBUG_PSEUDO_DMA macro is defined. Remove some printk(KERN_DEBUG ...)
messages that aren't needed any more.  Don't skip the debug message when
bytes == 0. Show all of the byte counters in the debug messages.

Cc: stable@vger.kernel.org # 5.15+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Link: https://lore.kernel.org/r/7573c79f4e488fc00af2b8a191e257ca945e0409.1723001788.git.fthain@linux-m68k.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mac_scsi.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -286,13 +286,14 @@ static inline int macscsi_pread(struct N
 	while (!NCR5380_poll_politely(hostdata, BUS_AND_STATUS_REG,
 	                              BASR_DRQ | BASR_PHASE_MATCH,
 	                              BASR_DRQ | BASR_PHASE_MATCH, 0)) {
-		int bytes;
+		int bytes, chunk_bytes;
 
 		if (macintosh_config->ident == MAC_MODEL_IIFX)
 			write_ctrl_reg(hostdata, CTRL_HANDSHAKE_MODE |
 			                         CTRL_INTERRUPTS_ENABLE);
 
-		bytes = mac_pdma_recv(s, d, min(hostdata->pdma_residual, 512));
+		chunk_bytes = min(hostdata->pdma_residual, 512);
+		bytes = mac_pdma_recv(s, d, chunk_bytes);
 
 		if (bytes > 0) {
 			d += bytes;
@@ -302,23 +303,23 @@ static inline int macscsi_pread(struct N
 		if (hostdata->pdma_residual == 0)
 			goto out;
 
-		if (NCR5380_poll_politely2(hostdata, STATUS_REG, SR_REQ, SR_REQ,
-		                           BUS_AND_STATUS_REG, BASR_ACK,
-		                           BASR_ACK, 0) < 0)
-			scmd_printk(KERN_DEBUG, hostdata->connected,
-			            "%s: !REQ and !ACK\n", __func__);
 		if (!(NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH))
 			goto out;
 
 		if (bytes == 0)
 			udelay(MAC_PDMA_DELAY);
 
-		if (bytes >= 0)
+		if (bytes > 0)
 			continue;
 
-		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
-		         "%s: bus error (%d/%d)\n", __func__, d - dst, len);
 		NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
+		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
+			 "%s: bus error [%d/%d] (%d/%d)\n",
+			 __func__, d - dst, len, bytes, chunk_bytes);
+
+		if (bytes == 0)
+			continue;
+
 		result = -1;
 		goto out;
 	}
@@ -345,13 +346,14 @@ static inline int macscsi_pwrite(struct
 	while (!NCR5380_poll_politely(hostdata, BUS_AND_STATUS_REG,
 	                              BASR_DRQ | BASR_PHASE_MATCH,
 	                              BASR_DRQ | BASR_PHASE_MATCH, 0)) {
-		int bytes;
+		int bytes, chunk_bytes;
 
 		if (macintosh_config->ident == MAC_MODEL_IIFX)
 			write_ctrl_reg(hostdata, CTRL_HANDSHAKE_MODE |
 			                         CTRL_INTERRUPTS_ENABLE);
 
-		bytes = mac_pdma_send(s, d, min(hostdata->pdma_residual, 512));
+		chunk_bytes = min(hostdata->pdma_residual, 512);
+		bytes = mac_pdma_send(s, d, chunk_bytes);
 
 		if (bytes > 0) {
 			s += bytes;
@@ -370,23 +372,23 @@ static inline int macscsi_pwrite(struct
 			goto out;
 		}
 
-		if (NCR5380_poll_politely2(hostdata, STATUS_REG, SR_REQ, SR_REQ,
-		                           BUS_AND_STATUS_REG, BASR_ACK,
-		                           BASR_ACK, 0) < 0)
-			scmd_printk(KERN_DEBUG, hostdata->connected,
-			            "%s: !REQ and !ACK\n", __func__);
 		if (!(NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH))
 			goto out;
 
 		if (bytes == 0)
 			udelay(MAC_PDMA_DELAY);
 
-		if (bytes >= 0)
+		if (bytes > 0)
 			continue;
 
-		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
-		         "%s: bus error (%d/%d)\n", __func__, s - src, len);
 		NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
+		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
+			 "%s: bus error [%d/%d] (%d/%d)\n",
+			 __func__, s - src, len, bytes, chunk_bytes);
+
+		if (bytes == 0)
+			continue;
+
 		result = -1;
 		goto out;
 	}



