Return-Path: <stable+bounces-85290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87A399E6A2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED77282C54
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76B1EB9E6;
	Tue, 15 Oct 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iQDVgl8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7513F435;
	Tue, 15 Oct 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992613; cv=none; b=LVT0wMqwANAlyAmRFnRBXWxpah4KcPCzbAku5vO5tBumkm6wbzOMDEHY773Ro23SubaLTRYs8eRQHu5bN1NvIPU5QymQc9yyLIZZE8Phu20r4Jg9Ki43Cze4CPljQQaJ1+xB9Z0AaTNyV3N3EudDq7DUd1B5JB2XJlrVCyCuv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992613; c=relaxed/simple;
	bh=CLSOq0PEKOzw22RxOWLhHFL+mDLeQ9x/uWmjQSjHZng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVKT+cmvji7YF5chZldUVRu7CUoAGyJFJRvmOio9bwETaYILSWb786q1oIGzHJtDK7zjUIk8l5w7oD51ULaO3YIi5+etv81/d5J8TIGy61TePGh1fR8J16wb0X6V/IijOHGlmgZ/sa8BWq8OUygpJXUZMnxrv3NKknwzO9nMHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iQDVgl8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9999C4CECE;
	Tue, 15 Oct 2024 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992613;
	bh=CLSOq0PEKOzw22RxOWLhHFL+mDLeQ9x/uWmjQSjHZng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQDVgl8wOHlxayEklty/YkL5JWadTSg6Q5patwszKBYXbt8PiTStb4stH3Dv7q4Mc
	 +KPzl3ruwKJFjlGlAOASwSp0nwy/82tdV0R8lkkkVGdONUeNymfQ0XV5wAR8IC4IpS
	 /o1gEx3i6tz4O3s801YoXZ0vEXpHuiJH1aehz4ws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@linux-m68k.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 167/691] scsi: NCR5380: Check for phase match during PDMA fixup
Date: Tue, 15 Oct 2024 13:21:55 +0200
Message-ID: <20241015112446.995402484@linuxfoundation.org>
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

[ Upstream commit 5768718da9417331803fc4bc090544c2a93b88dc ]

It's not an error for a target to change the bus phase during a transfer.
Unfortunately, the FLAG_DMA_FIXUP workaround does not allow for that -- a
phase change produces a DRQ timeout error and the device borken flag will
be set.

Check the phase match bit during FLAG_DMA_FIXUP processing. Don't forget to
decrement the command residual. While we are here, change shost_printk()
into scmd_printk() for better consistency with other DMA error messages.

Tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 55181be8ced1 ("ncr5380: Replace redundant flags with FLAG_NO_DMA_FIXUP")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Link: https://lore.kernel.org/r/99dc7d1f4c825621b5b120963a69f6cd3e9ca659.1723001788.git.fthain@linux-m68k.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/NCR5380.c | 78 +++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 98b1a98db90f6..e8e0bd231df30 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -1485,6 +1485,7 @@ static int NCR5380_transfer_dma(struct Scsi_Host *instance,
 				unsigned char **data)
 {
 	struct NCR5380_hostdata *hostdata = shost_priv(instance);
+	struct NCR5380_cmd *ncmd = NCR5380_to_ncmd(hostdata->connected);
 	int c = *count;
 	unsigned char p = *phase;
 	unsigned char *d = *data;
@@ -1496,7 +1497,7 @@ static int NCR5380_transfer_dma(struct Scsi_Host *instance,
 		return -1;
 	}
 
-	NCR5380_to_ncmd(hostdata->connected)->phase = p;
+	ncmd->phase = p;
 
 	if (p & SR_IO) {
 		if (hostdata->read_overruns)
@@ -1608,45 +1609,44 @@ static int NCR5380_transfer_dma(struct Scsi_Host *instance,
  * request.
  */
 
-	if (hostdata->flags & FLAG_DMA_FIXUP) {
-		if (p & SR_IO) {
-			/*
-			 * The workaround was to transfer fewer bytes than we
-			 * intended to with the pseudo-DMA read function, wait for
-			 * the chip to latch the last byte, read it, and then disable
-			 * pseudo-DMA mode.
-			 *
-			 * After REQ is asserted, the NCR5380 asserts DRQ and ACK.
-			 * REQ is deasserted when ACK is asserted, and not reasserted
-			 * until ACK goes false.  Since the NCR5380 won't lower ACK
-			 * until DACK is asserted, which won't happen unless we twiddle
-			 * the DMA port or we take the NCR5380 out of DMA mode, we
-			 * can guarantee that we won't handshake another extra
-			 * byte.
-			 */
-
-			if (NCR5380_poll_politely(hostdata, BUS_AND_STATUS_REG,
-			                          BASR_DRQ, BASR_DRQ, 0) < 0) {
-				result = -1;
-				shost_printk(KERN_ERR, instance, "PDMA read: DRQ timeout\n");
-			}
-			if (NCR5380_poll_politely(hostdata, STATUS_REG,
-			                          SR_REQ, 0, 0) < 0) {
-				result = -1;
-				shost_printk(KERN_ERR, instance, "PDMA read: !REQ timeout\n");
-			}
-			d[*count - 1] = NCR5380_read(INPUT_DATA_REG);
-		} else {
-			/*
-			 * Wait for the last byte to be sent.  If REQ is being asserted for
-			 * the byte we're interested, we'll ACK it and it will go false.
-			 */
-			if (NCR5380_poll_politely2(hostdata,
-			     BUS_AND_STATUS_REG, BASR_DRQ, BASR_DRQ,
-			     BUS_AND_STATUS_REG, BASR_PHASE_MATCH, 0, 0) < 0) {
-				result = -1;
-				shost_printk(KERN_ERR, instance, "PDMA write: DRQ and phase timeout\n");
+	if ((hostdata->flags & FLAG_DMA_FIXUP) &&
+	    (NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH)) {
+		/*
+		 * The workaround was to transfer fewer bytes than we
+		 * intended to with the pseudo-DMA receive function, wait for
+		 * the chip to latch the last byte, read it, and then disable
+		 * DMA mode.
+		 *
+		 * After REQ is asserted, the NCR5380 asserts DRQ and ACK.
+		 * REQ is deasserted when ACK is asserted, and not reasserted
+		 * until ACK goes false. Since the NCR5380 won't lower ACK
+		 * until DACK is asserted, which won't happen unless we twiddle
+		 * the DMA port or we take the NCR5380 out of DMA mode, we
+		 * can guarantee that we won't handshake another extra
+		 * byte.
+		 *
+		 * If sending, wait for the last byte to be sent. If REQ is
+		 * being asserted for the byte we're interested, we'll ACK it
+		 * and it will go false.
+		 */
+		if (!NCR5380_poll_politely(hostdata, BUS_AND_STATUS_REG,
+					   BASR_DRQ, BASR_DRQ, 0)) {
+			if ((p & SR_IO) &&
+			    (NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH)) {
+				if (!NCR5380_poll_politely(hostdata, STATUS_REG,
+							   SR_REQ, 0, 0)) {
+					d[c] = NCR5380_read(INPUT_DATA_REG);
+					--ncmd->this_residual;
+				} else {
+					result = -1;
+					scmd_printk(KERN_ERR, hostdata->connected,
+						    "PDMA fixup: !REQ timeout\n");
+				}
 			}
+		} else if (NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH) {
+			result = -1;
+			scmd_printk(KERN_ERR, hostdata->connected,
+				    "PDMA fixup: DRQ timeout\n");
 		}
 	}
 
-- 
2.43.0




