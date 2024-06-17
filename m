Return-Path: <stable+bounces-52359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0229890A90D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99928285349
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB7E374D9;
	Mon, 17 Jun 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B2+C/RcC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F1190685
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615227; cv=none; b=OfAUYFJhg8TpEXbQ4+EiKsbVc9amtZAnkJOIAn6YqDrVjrulidR6PIyZhwQNTE0fXB3iBf3/naY4Az1o6oD9SNb+BON+2ga/SkqT313iFyTHpywguOsFYe9j8OoNERPRfrWrGOvkchjGLZu9nPeF0S948WfGsSStscsa+ShhITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615227; c=relaxed/simple;
	bh=nVN6hHZ0H3izUqLn5Z2IdSDAbYs7zbSnlpSmr6ip6is=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s9WzV9ikvutpn+H4jvbqhNFfB3cLJSl6ThXQ13gLvrlDwnjLJrWi3AQSfakQGqwfMWk9yFwLA0MyqPM9idTIbiObiunfM7bNLZXSJ9+7XqBqm4CL+L4TDs4qBn7s40//w2LAQ9oaAqmaBq5heEyAyfvhI640J+Mn/jsXXZhO49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B2+C/RcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3E3C3277B;
	Mon, 17 Jun 2024 09:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718615226;
	bh=nVN6hHZ0H3izUqLn5Z2IdSDAbYs7zbSnlpSmr6ip6is=;
	h=Subject:To:Cc:From:Date:From;
	b=B2+C/RcCOTjdku/gI+WdnAmzFYSzGqnpeGpLFTVOXWF6esYHz0/SYCH549lwGy0Ca
	 o7fBGuBoSAERsLzM8lAJBMnmCwOHvQv60iu9WIJvSXiZ+pUzsZKKaccwDzES99N8Ik
	 pM7otElmgeVG2GvlsScrYAOpUrSs5tSBUvI40LoY=
Subject: FAILED: patch "[PATCH] serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level" failed to apply to 5.10-stable tree
To: doug@schmorgal.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 11:06:57 +0200
Message-ID: <2024061757-squid-skating-bd26@gregkh>
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
git cherry-pick -x 5208e7ced520a813b4f4774451fbac4e517e78b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061757-squid-skating-bd26@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

5208e7ced520 ("serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level")
cc6628f07e0d ("serial: 8250_pxa: Switch to use uart_read_port_properties()")

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


