Return-Path: <stable+bounces-57937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD892631E
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E35D1F22D7D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6ED17DA2D;
	Wed,  3 Jul 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m822tjsP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D75176ADB
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015901; cv=none; b=BYl06Nbx9cqHxIkx8QyBgszUQg8tXX6hBvbNlMEZCZ3vjidvVCTVwYpkBKsEvD1rxtZ+WGYDGUb/U7KyzWm+Ee9QFzaqSj5CoAKMhrSO29Ru6Diamx+NNh6xDdSYlbZhsiexXagxUCKyZj1j01mU2g0Fikg5sKF/DKBTMEkrqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015901; c=relaxed/simple;
	bh=pmkB2Z/k2B+6kSxt2+ZHbwzNdeCo97HasWUc9aOwuCc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lg5eYfIYQ4INUfX0psZeZwM14O5ImTMxS+y+7wsGUoduM/+dRbY0pg63wYSVnIG5jubzBV/eLV7aYICGHxqH1n8F2hr9a/eSOYBgdpaYRU6SdHpHLmBUOolEVN7oLnZa/FSxnv2EKjVYGUc5ZYP9U5DoHQrveZTOTgR9+hhvtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m822tjsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25FAC2BD10;
	Wed,  3 Jul 2024 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720015901;
	bh=pmkB2Z/k2B+6kSxt2+ZHbwzNdeCo97HasWUc9aOwuCc=;
	h=Subject:To:Cc:From:Date:From;
	b=m822tjsPK6HlRnigFL8RE/YSQ29GCBe4gMpZ8nVqdcHmzL4UFcuYCZtvwyjawyyvW
	 z7Qx7gbtRENiM0ZX7ea+0INErOzdADBQrn30dbJ1XVbcOCQrVMbbq9jgTi8h09Ze77
	 jDxzpxvXp14hz/NMqCc72pko3dM/ElTheSbFyUeE=
Subject: FAILED: patch "[PATCH] serial: 8250_omap: Fix Errata i2310 with RX FIFO level check" failed to apply to 5.15-stable tree
To: u-kumar1@ti.com,gregkh@linuxfoundation.org,vigneshr@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Jul 2024 16:11:38 +0200
Message-ID: <2024070338-skid-sauna-cd1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c128a1b0523b685c8856ddc0ac0e1caef1fdeee5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070338-skid-sauna-cd1d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


