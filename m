Return-Path: <stable+bounces-127558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7129A7A58C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7A916CB27
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6210124EF82;
	Thu,  3 Apr 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ItRO2NR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0724EA85
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691407; cv=none; b=IB/w9yHyk0wsgrf1RTmSObBkXl/EAyG+ZtVyW1jIZOZ2qbgtUBq+qtC5vHrF9ujcGW0C+kGeR/yjqbTVzNCbxcpReIwnamkEi3AhAGqQQOxFxen8O5QIOfj/tb7njItK9ebi/Uga1XtGcVkhEWK5iffTgsqB3EhY8Md4yPvmY1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691407; c=relaxed/simple;
	bh=JMRAmSTMRPgnH9BUVyUjuMHk4izlrheRKz0+8s14GrM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lBRIEqbTUresaCSGd+j0kKh21AYGG0T4qeO2gIBCOu0Tek3BNJ7/Fa9S1TT2mvp5lp9XrA/HMQsYOwBFeLYTND9AKsTH8OBn/aQMVN4G+AyQx6iHCaOO6Ho7f5KdK7JWyNUiFir50uuIRpbs2nmwF0dwnGYuTSN/q7goiydCXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ItRO2NR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F808C4CEE5;
	Thu,  3 Apr 2025 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743691406;
	bh=JMRAmSTMRPgnH9BUVyUjuMHk4izlrheRKz0+8s14GrM=;
	h=Subject:To:Cc:From:Date:From;
	b=ItRO2NR2XvgJq3ufWXK8FKsdedGaES0Q9YWzCNmLxPSR8VD/u10t+yy2ql9WqJ9W6
	 odDeU8PNXOi/9qez2r8A4XcGBPe4u1kZ7S+xju+TUFdOCs5cnEdU+IUeT5+on7+PYo
	 7ADa0cqycpw4qKgxpz0qTC6HbNUd6IUTLiUrODuQ=
Subject: FAILED: patch "[PATCH] serial: stm32: do not deassert RS485 RTS GPIO prematurely" failed to apply to 5.15-stable tree
To: cheick.traore@foss.st.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Apr 2025 15:41:48 +0100
Message-ID: <2025040348-sudoku-backspace-0802@gregkh>
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
git cherry-pick -x 2790ce23951f0c497810c44ad60a126a59c8d84c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040348-sudoku-backspace-0802@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2790ce23951f0c497810c44ad60a126a59c8d84c Mon Sep 17 00:00:00 2001
From: Cheick Traore <cheick.traore@foss.st.com>
Date: Thu, 20 Mar 2025 16:25:40 +0100
Subject: [PATCH] serial: stm32: do not deassert RS485 RTS GPIO prematurely

If stm32_usart_start_tx is called with an empty xmit buffer, RTS GPIO
could be deasserted prematurely, as bytes in TX FIFO are still
transmitting.
So this patch remove rts disable when xmit buffer is empty.

Fixes: d7c76716169d ("serial: stm32: Use TC interrupt to deassert GPIO RTS in RS485 mode")
Cc: stable <stable@kernel.org>
Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
Link: https://lore.kernel.org/r/20250320152540.709091-1-cheick.traore@foss.st.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4c97965ec43b..ad06b760cfca 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -965,10 +965,8 @@ static void stm32_usart_start_tx(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
 
-	if (kfifo_is_empty(&tport->xmit_fifo) && !port->x_char) {
-		stm32_usart_rs485_rts_disable(port);
+	if (kfifo_is_empty(&tport->xmit_fifo) && !port->x_char)
 		return;
-	}
 
 	stm32_usart_rs485_rts_enable(port);
 


