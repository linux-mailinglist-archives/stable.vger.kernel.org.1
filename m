Return-Path: <stable+bounces-52361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF2C90A90F
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A529AB23555
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29749190678;
	Mon, 17 Jun 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygnZWaQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1019066E
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615234; cv=none; b=XioRiDYoIwxYjPT1tcdUoH/NYZvCUbAxQ6/woySVWMwElywQRCqIN6ZgJ+7SvCsyvP87tjrK94AMWnccwNJ7+mQQY6eWQJCF9FoWFmzIP3g2jcN2oJYxmRUybzHAGthojot1Bo6Ky2F9SmBe74N4VpPrvtR/U1VKIV6ez764Ggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615234; c=relaxed/simple;
	bh=tX9US6uqo+ew8fP53FBbyoFESDM/6FwjCyFUGa06IFA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MAWFjwJHs0JHCpQrZ+IRMFrbNhkzE1qGg6B4OgCaUCsDSGFAFcGHHvOBHpXD3p6haayyr/WvgdI1TPEZWAr7AEaNSGUMtYWx+37eFh8l2RA2j9XhoTnmPe8ZIyN4bQoXeH4G/ycCol2WNcPMkD94ye3FBZND1NLPN0gEi7f1nGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygnZWaQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AD5C2BD10;
	Mon, 17 Jun 2024 09:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718615234;
	bh=tX9US6uqo+ew8fP53FBbyoFESDM/6FwjCyFUGa06IFA=;
	h=Subject:To:Cc:From:Date:From;
	b=ygnZWaQMLolleBmcToH1N/wcgRSwxmF32aNUcSqAmgHpBSWZZVlGdHbCNDeROtCnC
	 mLToqxLVCSF/0ceg0NpbIvuU7F0kjKxkINwhzcW3vwGH2CiVsU80dChpnuJccP0XaK
	 vARiSgl92WsqLVyXsFE//EgD33cMBAYkl3j2ZOlg=
Subject: FAILED: patch "[PATCH] serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level" failed to apply to 4.19-stable tree
To: doug@schmorgal.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 11:06:58 +0200
Message-ID: <2024061758-junkyard-thimble-efb0@gregkh>
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
git cherry-pick -x 5208e7ced520a813b4f4774451fbac4e517e78b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061758-junkyard-thimble-efb0@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

5208e7ced520 ("serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level")
cc6628f07e0d ("serial: 8250_pxa: Switch to use uart_read_port_properties()")
e914072cacb6 ("serial: 8250_pxa: Switch to use platform_get_irq()")
8c6b6ffac367 ("serial: 8250_pxa: avoid autodetecting the port type")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5208e7ced520a813b4f4774451fbac4e517e78b2 Mon Sep 17 00:00:00 2001
From: Doug Brown <doug@schmorgal.com>
Date: Sun, 19 May 2024 12:19:30 -0700
Subject: [PATCH] serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level

The FIFO is 64 bytes, but the FCR is configured to fire the TX interrupt
when the FIFO is half empty (bit 3 = 0). Thus, we should only write 32
bytes when a TX interrupt occurs.

This fixes a problem observed on the PXA168 that dropped a bunch of TX
bytes during large transmissions.

Fixes: ab28f51c77cd ("serial: rewrite pxa2xx-uart to use 8250_core")
Signed-off-by: Doug Brown <doug@schmorgal.com>
Link: https://lore.kernel.org/r/20240519191929.122202-1-doug@schmorgal.com
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index f1a51b00b1b9..ba96fa913e7f 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -125,6 +125,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	uart.port.iotype = UPIO_MEM32;
 	uart.port.regshift = 2;
 	uart.port.fifosize = 64;
+	uart.tx_loadsz = 32;
 	uart.dl_write = serial_pxa_dl_write;
 
 	ret = serial8250_register_8250_port(&uart);


