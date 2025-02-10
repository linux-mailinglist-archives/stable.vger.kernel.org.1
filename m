Return-Path: <stable+bounces-114517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BB4A2ECFD
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCAC7A46BD
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7A22653F;
	Mon, 10 Feb 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z7wau+ak"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976B81741
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191989; cv=none; b=doivAI9VtMxTUrSnkAjbBefkRwVaD1QKznsdwprJ/+LWgzzxKj96BiRY1r7xNJaK0aLKrUnd+VmwS4xYtKlpOyc+9XyneUWBRHUrxgvmHe9tyfv9BN0rEW8BtEQKJG674wYhwm3/8j+nSRarNYkea1jlTkGE5QNldy3A+4nk1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191989; c=relaxed/simple;
	bh=aCWl7OW2Dhj15F+rx7UGYXKaGaNyhII6gyrpUb2W+X8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fbldyk1pJz/z4I5fsxJ3WmxruSlUqXU7HxZYcTnHwyAgaZDPeOTAWhbCmS+uMa056e71TsjCCRSfU1HGnxtcJWmrfIx3FN3Fbys8dLYV8QRCBJ4b8UC0EagcUt0WU6M6iCFB/biei6bn8uVdJSlrCHbxKuXS2aJbft2iThM+pRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z7wau+ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A60CC4CED1;
	Mon, 10 Feb 2025 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739191988;
	bh=aCWl7OW2Dhj15F+rx7UGYXKaGaNyhII6gyrpUb2W+X8=;
	h=Subject:To:Cc:From:Date:From;
	b=z7wau+akrfdpVJGJM51g1l1NadIsKPIwvQ2H7SpmTYmSDo3i4rFZnD7nNfVD6V7vV
	 6DScdApqYTslcfXR9qvoimc/8I9tyLN0WkC+G0NfwWa4V56ORxRm0tfxO0eO32ENzn
	 85PQjSw01zpQ1n2ku4hBNKLHLIPdaep8kXBdfNQU=
Subject: FAILED: patch "[PATCH] spi: atmel-qspi: Memory barriers after memory-mapped I/O" failed to apply to 6.6-stable tree
To: csokas.bence@prolan.hu,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 13:53:01 +0100
Message-ID: <2025021001-swinging-ashes-6c0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x be92ab2de0ee1a13291c3b47b2d7eb24d80c0a2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021001-swinging-ashes-6c0f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be92ab2de0ee1a13291c3b47b2d7eb24d80c0a2c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Thu, 19 Dec 2024 10:12:58 +0100
Subject: [PATCH] spi: atmel-qspi: Memory barriers after memory-mapped I/O
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The QSPI peripheral control and status registers are
accessible via the SoC's APB bus, whereas MMIO transactions'
data travels on the AHB bus.

Microchip documentation and even sample code from Atmel
emphasises the need for a memory barrier before the first
MMIO transaction to the AHB-connected QSPI, and before the
last write to its registers via APB. This is achieved by
the following lines in `atmel_qspi_transfer()`:

	/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
	(void)atmel_qspi_read(aq, QSPI_IFR);

However, the current documentation makes no mention to
synchronization requirements in the other direction, i.e.
after the last data written via AHB, and before the first
register access on APB.

In our case, we were facing an issue where the QSPI peripheral
would cease to send any new CSR (nCS Rise) interrupts,
leading to a timeout in `atmel_qspi_wait_for_completion()`
and ultimately this panic in higher levels:

	ubi0 error: ubi_io_write: error -110 while writing 63108 bytes
 to PEB 491:128, written 63104 bytes

After months of extensive research of the codebase, fiddling
around the debugger with kgdb, and back-and-forth with
Microchip, we came to the conclusion that the issue is
probably that the peripheral is still busy receiving on AHB
when the LASTXFER bit is written to its Control Register
on APB, therefore this write gets lost, and the peripheral
still thinks there is more data to come in the MMIO transfer.
This was first formulated when we noticed that doubling the
write() of QSPI_CR_LASTXFER seemed to solve the problem.

Ultimately, the solution is to introduce memory barriers
after the AHB-mapped MMIO transfers, to ensure ordering.

Fixes: d5433def3153 ("mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi")
Cc: Hari.PrasathGE@microchip.com
Cc: Mahesh.Abotula@microchip.com
Cc: Marco.Cardellini@microchip.com
Cc: stable@vger.kernel.org # c0a0203cf579: ("spi: atmel-quadspi: Create `atmel_qspi_ops`"...)
Cc: stable@vger.kernel.org # 6.x.y
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
Link: https://patch.msgid.link/20241219091258.395187-1-csokas.bence@prolan.hu
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index f46da363574f..8fdc9d27a95e 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -661,13 +661,20 @@ static int atmel_qspi_transfer(struct spi_mem *mem,
 	(void)atmel_qspi_read(aq, QSPI_IFR);
 
 	/* Send/Receive data */
-	if (op->data.dir == SPI_MEM_DATA_IN)
+	if (op->data.dir == SPI_MEM_DATA_IN) {
 		memcpy_fromio(op->data.buf.in, aq->mem + offset,
 			      op->data.nbytes);
-	else
+
+		/* Synchronize AHB and APB accesses again */
+		rmb();
+	} else {
 		memcpy_toio(aq->mem + offset, op->data.buf.out,
 			    op->data.nbytes);
 
+		/* Synchronize AHB and APB accesses again */
+		wmb();
+	}
+
 	/* Release the chip-select */
 	atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
 


