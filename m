Return-Path: <stable+bounces-96255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F59E18C7
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF78282E12
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5AB1E0DA9;
	Tue,  3 Dec 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWWyb7UZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C71E0B93
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220321; cv=none; b=WDlOxcCekr62JswQH5T51PfQUmHvdOLL9iwrxVYNFkWdp6yuWYKZph/crl+dl8seLbZk3IrwaxgsJ1R9aYhQcb+buRlKP/Q/GlQ7kSk+p5GFC39YwGhzr4b9bBg1EesJpVhoyKloMbP8Ita0K/ZSjpMw1GtIznS5hPcFbiQJJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220321; c=relaxed/simple;
	bh=FpZX+agy5ZoLY/MIc5khheClnykPLRwHh1W/0OB8uI4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fN86QsFfJq9pAhINDB6FPXEMeyHqbr70QLOdKp3ZiXichpLjWRHb41FQUT+Ddhr12DEp1CE1EgRb/+gEjAPuf+geZsyEvTIuDO/6rnsxPkSxGxrNwxnFKzgLd/J8ciosvgXQf0JhCJAiIMJ2GKmCY48gbELK0Y2wg8eAIG+u2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LWWyb7UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F666C4CECF;
	Tue,  3 Dec 2024 10:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733220320;
	bh=FpZX+agy5ZoLY/MIc5khheClnykPLRwHh1W/0OB8uI4=;
	h=Subject:To:Cc:From:Date:From;
	b=LWWyb7UZ/QpQg5erbdbVYFDIt4EtuDOZVWmid++hRhWdkA+oOLgEfymVx6cg+x0Ji
	 znIYfPTpb8E34A0gLel5/N/eWJgVL8FyCFyxEZwp5XfkS1Sbygq4fZ5YAlmQn2dbm7
	 Rt24IPftSFn1EBoqzIL9GEoMwgowOuhyLMrbnwjQ=
Subject: FAILED: patch "[PATCH] serial: amba-pl011: Fix RX stall when DMA is used" failed to apply to 4.19-stable tree
To: kkartik@nvidia.com,gregkh@linuxfoundation.org,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:04:59 +0100
Message-ID: <2024120358-dating-yahoo-5b4b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2bcacc1c87acf9a8ebc17de18cb2b3cfeca547cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120358-dating-yahoo-5b4b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2bcacc1c87acf9a8ebc17de18cb2b3cfeca547cf Mon Sep 17 00:00:00 2001
From: Kartik Rajput <kkartik@nvidia.com>
Date: Wed, 13 Nov 2024 14:56:29 +0530
Subject: [PATCH] serial: amba-pl011: Fix RX stall when DMA is used

Function pl011_throttle_rx() calls pl011_stop_rx() to disable RX, which
also disables the RX DMA by clearing the RXDMAE bit of the DMACR
register. However, to properly unthrottle RX when DMA is used, the
function pl011_unthrottle_rx() is expected to set the RXDMAE bit of
the DMACR register, which it currently lacks. This causes RX to stall
after the throttle API is called.

Set RXDMAE bit in the DMACR register while unthrottling RX if RX DMA is
used.

Fixes: 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle")
Cc: stable@vger.kernel.org
Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20241113092629.60226-1-kkartik@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 56e587b94823..2facdbcd73eb 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1819,6 +1819,11 @@ static void pl011_unthrottle_rx(struct uart_port *port)
 
 	pl011_write(uap->im, uap, REG_IMSC);
 
+	if (uap->using_rx_dma) {
+		uap->dmacr |= UART011_RXDMAE;
+		pl011_write(uap->dmacr, uap, REG_DMACR);
+	}
+
 	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 


