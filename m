Return-Path: <stable+bounces-85465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD99C99E772
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540C8B2390D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1031D90DB;
	Tue, 15 Oct 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n+FrpOG+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788EA1D0492;
	Tue, 15 Oct 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993205; cv=none; b=IIOHlSDdfSNPYC/6Rc1pjTGiY8F2rTMp18VUvClnYJOkrXzN2lpD1JhENZJCqKPk95MZv2cid8ps6U2Qzt1IYyZ5B8Q0sIsQC1/kqvnAppJbzg+0ozPTXoBCWeGQ8ELxfmWwsc0C3csUjUcGUZhtn7o9EKtFoJ1Rt5HGAIcYJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993205; c=relaxed/simple;
	bh=pfpF3b95H0YuVWjqQw80R8KSRhVfvPHoEbbO5RV8R7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUQBi07Wztp/B0rLNCaU40lfMyrzXmFL+KfEvc3MSzsdC9IiM4WL0pflShXAWemvpjpDlMOc2sVKanK8Se1mjpZaA/WdYGSdS/ahUb7IGcyff7u0Dww/VY10jJ50yxhweY6I6rDHcngnqr4rzGDNVM47qvTEk0amWyCeq6zY3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n+FrpOG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAB7C4CEC6;
	Tue, 15 Oct 2024 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993205;
	bh=pfpF3b95H0YuVWjqQw80R8KSRhVfvPHoEbbO5RV8R7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+FrpOG+KUzREnL49AMmnMMGxu1HTaPpUeHhUlOJfva+jduNEAYNEeU4a8xK1zH36
	 O7r73g0wEQLEi4ex6VM2rHXse2QFwmEfKzGTm5DJItyhUZBHSkJphR6eoYWOfFHy82
	 GuEKVlLx2szdTQCfvsvlZPln8f+iqFOIt4ca/2Sw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@linux-m68k.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 315/691] scsi: mac_scsi: Revise printk(KERN_DEBUG ...) messages
Date: Tue, 15 Oct 2024 13:24:23 +0200
Message-ID: <20241015112452.838806552@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/scsi/mac_scsi.c | 42 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index 53ee8f84d094..e67b038a3577 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -286,13 +286,14 @@ static inline int macscsi_pread(struct NCR5380_hostdata *hostdata,
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
@@ -302,23 +303,23 @@ static inline int macscsi_pread(struct NCR5380_hostdata *hostdata,
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
@@ -345,13 +346,14 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
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
@@ -370,23 +372,23 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
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
-- 
2.46.2




