Return-Path: <stable+bounces-16027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85283E73E
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9812CB26DB7
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B232557A;
	Fri, 26 Jan 2024 23:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JG2b144a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE520320
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312891; cv=none; b=FVgCxEre2oP1fZcgwm4hmEkSHgOCT08bY9cr1pQbhL3ptAVFFllqL1A0BLXGrKg9CsGeo3C3uMarERYcsU2DIcaJAE+j0c76kI8Gb0OM+iMDS65xufU5KbEi6pJKH+qxbxByipLnCRB22q9Ib/GOlEXXTW/F5H3UV7xfPY/Dl08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312891; c=relaxed/simple;
	bh=cXldl83TpD6HeEs9amAfNUHrT1J9RIUsi3g4Buw4uDI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XAwOdCDVMAyStm9DO0PzfjZIESE4GVgNbh+4p3Yv8eVbdAOLGB+fGQXou9Gy+CGK2AI5IPmgVEW4WGvj3wJbodSNxbRlBMB7EQu1/DdmwPsBCSkfIar1wg6dPhGl+GDE0zJMU6na3JlqTNhm4VqHZU897AT/bw14tjPpJ9FFH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JG2b144a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64494C43394;
	Fri, 26 Jan 2024 23:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312890;
	bh=cXldl83TpD6HeEs9amAfNUHrT1J9RIUsi3g4Buw4uDI=;
	h=Subject:To:Cc:From:Date:From;
	b=JG2b144aRS52mtfBJuSkjSyOKsi3mwuXsRKMmhn1a0hEwwbL+7dI1QZ7TChWALfdC
	 v4aFV9vZO/iNy4Ap9Kyu9rptVLHJzRFTthrwmh2/SEOt0q2AlJ+9WI1rA/3kUWX/XB
	 bLZLxgts/1XR7UH0rflnS+tQwQV/I6AHTqQ1OqSY=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: remove obsolete loop in" failed to apply to 5.10-stable tree
To: hvilleneuve@dimonoff.com,andy.shevchenko@gmail.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:48:09 -0800
Message-ID: <2024012609-phonebook-scrimmage-36f9@gregkh>
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
git cherry-pick -x ed647256e8f226241ecff7baaecdb8632ffc7ec1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012609-phonebook-scrimmage-36f9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

ed647256e8f2 ("serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()")
4409df5866b7 ("serial: sc16is7xx: change EFR lock to operate on each channels")
e045e18dbf3e ("Merge 6.7-rc5 into tty-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed647256e8f226241ecff7baaecdb8632ffc7ec1 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:11 -0500
Subject: [PATCH] serial: sc16is7xx: remove obsolete loop in
 sc16is7xx_port_irq()

Commit 834449872105 ("sc16is7xx: Fix for multi-channel stall") changed
sc16is7xx_port_irq() from looping multiple times when there was still
interrupts to serve. It simply changed the do {} while(1) loop to a
do {} while(0) loop, which makes the loop itself now obsolete.

Clean the code by removing this obsolete do {} while(0) loop.

Fixes: 834449872105 ("sc16is7xx: Fix for multi-channel stall")
Cc:  <stable@vger.kernel.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-5-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ced2446909a2..44a11c89c949 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -725,58 +725,55 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
 	bool rc = true;
+	unsigned int iir, rxlen;
 	struct uart_port *port = &s->p[portno].port;
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
 	mutex_lock(&one->efr_lock);
 
-	do {
-		unsigned int iir, rxlen;
+	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
+	if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
+		rc = false;
+		goto out_port_irq;
+	}
 
-		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
-		if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
-			rc = false;
-			goto out_port_irq;
-		}
+	iir &= SC16IS7XX_IIR_ID_MASK;
 
-		iir &= SC16IS7XX_IIR_ID_MASK;
-
-		switch (iir) {
-		case SC16IS7XX_IIR_RDI_SRC:
-		case SC16IS7XX_IIR_RLSE_SRC:
-		case SC16IS7XX_IIR_RTOI_SRC:
-		case SC16IS7XX_IIR_XOFFI_SRC:
-			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
-
-			/*
-			 * There is a silicon bug that makes the chip report a
-			 * time-out interrupt but no data in the FIFO. This is
-			 * described in errata section 18.1.4.
-			 *
-			 * When this happens, read one byte from the FIFO to
-			 * clear the interrupt.
-			 */
-			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
-				rxlen = 1;
-
-			if (rxlen)
-				sc16is7xx_handle_rx(port, rxlen, iir);
-			break;
+	switch (iir) {
+	case SC16IS7XX_IIR_RDI_SRC:
+	case SC16IS7XX_IIR_RLSE_SRC:
+	case SC16IS7XX_IIR_RTOI_SRC:
+	case SC16IS7XX_IIR_XOFFI_SRC:
+		rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
+
+		/*
+		 * There is a silicon bug that makes the chip report a
+		 * time-out interrupt but no data in the FIFO. This is
+		 * described in errata section 18.1.4.
+		 *
+		 * When this happens, read one byte from the FIFO to
+		 * clear the interrupt.
+		 */
+		if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
+			rxlen = 1;
+
+		if (rxlen)
+			sc16is7xx_handle_rx(port, rxlen, iir);
+		break;
 		/* CTSRTS interrupt comes only when CTS goes inactive */
-		case SC16IS7XX_IIR_CTSRTS_SRC:
-		case SC16IS7XX_IIR_MSI_SRC:
-			sc16is7xx_update_mlines(one);
-			break;
-		case SC16IS7XX_IIR_THRI_SRC:
-			sc16is7xx_handle_tx(port);
-			break;
-		default:
-			dev_err_ratelimited(port->dev,
-					    "ttySC%i: Unexpected interrupt: %x",
-					    port->line, iir);
-			break;
-		}
-	} while (0);
+	case SC16IS7XX_IIR_CTSRTS_SRC:
+	case SC16IS7XX_IIR_MSI_SRC:
+		sc16is7xx_update_mlines(one);
+		break;
+	case SC16IS7XX_IIR_THRI_SRC:
+		sc16is7xx_handle_tx(port);
+		break;
+	default:
+		dev_err_ratelimited(port->dev,
+				    "ttySC%i: Unexpected interrupt: %x",
+				    port->line, iir);
+		break;
+	}
 
 out_port_irq:
 	mutex_unlock(&one->efr_lock);


