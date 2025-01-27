Return-Path: <stable+bounces-110875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA8A1D9D2
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 16:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921FE1882085
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918E2166F3D;
	Mon, 27 Jan 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYTPL4wN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE71662EF;
	Mon, 27 Jan 2025 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992596; cv=none; b=gWl4mbcdNoamRQXkl1bIyML8KJSb3EtxecjEGq3r6NrxYRbQPad8WSNJFvbSxLoEJgw0QJsItu9Dp00FA4bz34uW3DztspbHCuHgrEEfanaGsa8c8sbzCsQM0MHwBsWsFRY4K+9ywH2FAbSTJs/C4SO1rJp+R+g9RbGmB/yhFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992596; c=relaxed/simple;
	bh=kX/YSYtIb+j9PpE3vuIZD1EGQsaa7icK6vh24/B1ho0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvHwy1NUW6NYoJViniVCW0T4vcdFALFJDnmw/w4kI1fDP4RBvEST6aVD176DGVzhYMShcLbsnNH1cr9wU0CIdiXYyiEANQHAGsPc1sBh97T4zcBdU3jPWYjeEFGpWLEDwKuR8eggl35yaAPwon0zkKPLS06KdPcjQubTAz8EYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYTPL4wN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7033C4CED2;
	Mon, 27 Jan 2025 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737992594;
	bh=kX/YSYtIb+j9PpE3vuIZD1EGQsaa7icK6vh24/B1ho0=;
	h=From:To:Cc:Subject:Date:From;
	b=GYTPL4wNcmbPQICMnxSRs/hDNM/147gkDG94EPKRV8zRuahk8PJUVJg9OMQlmEQG+
	 9GmzLcq6Tq93fj9e67uMPkwwWotQaBan4ETJ4+s0AlTQVNpORZxNhkxfib16djGS8S
	 z2N8RmocvNw72cRKt0e/qyZwRoiyusqHdJSeVS8EXatW1F2CHNZCA/4xzuVHbOCOuR
	 ZNxqcJvMVQlj2wWmu5nJ4weTTTAC6LNdUrYdH3xWEJuIFebXjoFtbRNCFKkq91S/RJ
	 CSeIuvP4S6I/evWvMs8AR56hwajdAv/RXP8Tbxmsn9tWw8+8FnIMiWQMhnprzU7Z5z
	 TmkujskUpmh+w==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	stable@vger.kernel.org,
	reveliofuzzing <reveliofuzzing@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: libata-sff: Ensure that we cannot write outside the allocated buffer
Date: Mon, 27 Jan 2025 16:43:04 +0100
Message-ID: <20250127154303.15567-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849; i=cassel@kernel.org; h=from:subject; bh=kX/YSYtIb+j9PpE3vuIZD1EGQsaa7icK6vh24/B1ho0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKnr2zn2H2zVeVfzYn3Dgc95ryP0HCdceR8qkc9B9vB0 utxC+1+dpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAieywYGa4tX7bpOcspn+5L G7bO+j71jbVS0F9+8Y8fGEPCX6R8O3WN4X/CvLMB+o+Dt0UUFkn/Swx//iTIJmb7/v0qyTmhX4N vrOADAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

reveliofuzzing reported that a SCSI_IOCTL_SEND_COMMAND ioctl with out_len
set to 0xd42, SCSI command set to ATA_16 PASS-THROUGH, ATA command set to
ATA_NOP, and protocol set to ATA_PROT_PIO, can cause ata_pio_sector() to
write outside the allocated buffer, overwriting random memory.

While a ATA device is supposed to abort a ATA_NOP command, there does seem
to be a bug either in libata-sff or QEMU, where either this status is not
set, or the status is cleared before read by ata_sff_hsm_move().
Anyway, that is most likely a separate bug.

Looking at __atapi_pio_bytes(), it already has a safety check to ensure
that __atapi_pio_bytes() cannot write outside the allocated buffer.

Add a similar check to ata_pio_sector(), such that also ata_pio_sector()
cannot write outside the allocated buffer.

Cc: stable@vger.kernel.org
Reported-by: reveliofuzzing <reveliofuzzing@gmail.com>
Closes: https://lore.kernel.org/linux-ide/CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Add stable to Cc.

 drivers/ata/libata-sff.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 67f277e1c3bf..5a46c066abc3 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -601,7 +601,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct page *page;
-	unsigned int offset;
+	unsigned int offset, count;
 
 	if (!qc->cursg) {
 		qc->curbytes = qc->nbytes;
@@ -617,25 +617,27 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	trace_ata_sff_pio_transfer_data(qc, offset, qc->sect_size);
+	/* don't overrun current sg */
+	count = min(qc->cursg->length - qc->cursg_ofs, qc->sect_size);
+
+	trace_ata_sff_pio_transfer_data(qc, offset, count);
 
 	/*
 	 * Split the transfer when it splits a page boundary.  Note that the
 	 * split still has to be dword aligned like all ATA data transfers.
 	 */
 	WARN_ON_ONCE(offset % 4);
-	if (offset + qc->sect_size > PAGE_SIZE) {
+	if (offset + count > PAGE_SIZE) {
 		unsigned int split_len = PAGE_SIZE - offset;
 
 		ata_pio_xfer(qc, page, offset, split_len);
-		ata_pio_xfer(qc, nth_page(page, 1), 0,
-			     qc->sect_size - split_len);
+		ata_pio_xfer(qc, nth_page(page, 1), 0, count - split_len);
 	} else {
-		ata_pio_xfer(qc, page, offset, qc->sect_size);
+		ata_pio_xfer(qc, page, offset, count);
 	}
 
-	qc->curbytes += qc->sect_size;
-	qc->cursg_ofs += qc->sect_size;
+	qc->curbytes += count;
+	qc->cursg_ofs += count;
 
 	if (qc->cursg_ofs == qc->cursg->length) {
 		qc->cursg = sg_next(qc->cursg);
-- 
2.48.1


