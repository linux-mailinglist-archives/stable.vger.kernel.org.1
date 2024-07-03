Return-Path: <stable+bounces-57938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E8926321
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC291C224F6
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DF183091;
	Wed,  3 Jul 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ednnol7f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4217C9E8
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015910; cv=none; b=coJyUqZ5aAfx8cIQIi1Xpc4LwTCDLakTw2bf3S1macYmizV3bWOpqDKzgP1QGTP10AG5xoZRTHdwQtJglJWHPAPxHhAuAm27PHWXUy+uZZiCuN2+qJY4g/5Gr4fUoUaKgTae4bLfMdPRwME/HHDULLYYWRrBFR7cnlbLxLOiQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015910; c=relaxed/simple;
	bh=T8926mHDEmWiMIc+0h6r5pou2OhcmjwNUQFV2bcSAAc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SgPw0ZipJcBg/IGsKxDwgfdrnEAC/z6e1vzDiE+9I2CZp6dJf1JiZ42JkVJxG9HKN9/sXs4HI0lsxZyas4VGVteAsL3+Uuz9Je780DiZLPsIzGJXXaIwwPRTlay4HBETKXhFmDqaAFH6nkReS4h0SNrZPeD50MPntC85KiUzdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ednnol7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16C8C4AF07;
	Wed,  3 Jul 2024 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720015910;
	bh=T8926mHDEmWiMIc+0h6r5pou2OhcmjwNUQFV2bcSAAc=;
	h=Subject:To:Cc:From:Date:From;
	b=ednnol7fhBlrCBRRs2WEfyTm7boOJ1RfWoXVhxbxiGV4TMm54fiwn6/Sn+lbuCTKg
	 /cXToiGpf2SPmjKomwNSeIn3OYmb2PaCR9K2GfzrpYqIpBs+ZO1CoYR4Ddc/p6A5Xb
	 bgixlnwRFBHOqv53+MJAr/+b8DnmyXLXptyxS4pI=
Subject: FAILED: patch "[PATCH] serial: 8250_omap: Fix Errata i2310 with RX FIFO level check" failed to apply to 5.10-stable tree
To: u-kumar1@ti.com,gregkh@linuxfoundation.org,vigneshr@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Jul 2024 16:11:39 +0200
Message-ID: <2024070339-simile-village-6731@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c128a1b0523b685c8856ddc0ac0e1caef1fdeee5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070339-simile-village-6731@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c128a1b0523b685c8856ddc0ac0e1caef1fdeee5 Mon Sep 17 00:00:00 2001
From: Udit Kumar <u-kumar1@ti.com>
Date: Tue, 25 Jun 2024 21:37:25 +0530
Subject: [PATCH] serial: 8250_omap: Fix Errata i2310 with RX FIFO level check

Errata i2310[0] says, Erroneous timeout can be triggered,
if this Erroneous interrupt is not cleared then it may leads
to storm of interrupts.

Commit 9d141c1e6157 ("serial: 8250_omap: Implementation of Errata i2310")
which added the workaround but missed ensuring RX FIFO is really empty
before applying the errata workaround as recommended in the errata text.
Fix this by adding back check for UART_OMAP_RX_LVL to be 0 for
workaround to take effect.

[0] https://www.ti.com/lit/pdf/sprz536 page 23

Fixes: 9d141c1e6157 ("serial: 8250_omap: Implementation of Errata i2310")
Cc: stable@vger.kernel.org
Reported-by: Vignesh Raghavendra <vigneshr@ti.com>
Closes: https://lore.kernel.org/all/e96d0c55-0b12-4cbf-9d23-48963543de49@ti.com/
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Link: https://lore.kernel.org/r/20240625160725.2102194-1-u-kumar1@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ddac0a13cf84..1af9aed99c65 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -672,7 +672,8 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 	 * https://www.ti.com/lit/pdf/sprz536
 	 */
 	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
-		(iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT) {
+	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
+	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
 		unsigned char efr2, timeout_h, timeout_l;
 
 		efr2 = serial_in(up, UART_OMAP_EFR2);


