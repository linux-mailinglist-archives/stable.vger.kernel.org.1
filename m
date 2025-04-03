Return-Path: <stable+bounces-127557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B23A7A590
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1511888BFA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112A24EF7D;
	Thu,  3 Apr 2025 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I/MVTpRK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710124EF75
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691404; cv=none; b=dBWB53pXF6a9MmlY4VNGgrfIsvEm5NHpDMaUFyAVw8eMn2xqTaZMAyE+7MFyy9g2VrRP94Gga6fEiSoVKXrBsQODpHxvtY5aYxcQJo68bWP5XGPVJ9H+tU8UhDDG3qfFrmeO3ubrODPu5jYqWYQqqFURBNs0Hml6xdgMOKiil74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691404; c=relaxed/simple;
	bh=bDOt34s0u9W7P76U2IFVzIvEWHSB981OL/P1NHbuJ9o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AeCuAAQqU5CX6cZx9FdbQuAWGArgDxVFAZJn4F8v8i9MESsE3Ks0i/ROzQOYxoKmcYIpgxlC99C+BgwYg/N/stR6rtLW3eqmaJfeop6V1Zav1iwo/5XlruHczDXB4YVYzTvK7VZGBXpz6ZG0pFW5JhWD5MgKbpbchC0iQ07xxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I/MVTpRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B162FC4CEE3;
	Thu,  3 Apr 2025 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743691404;
	bh=bDOt34s0u9W7P76U2IFVzIvEWHSB981OL/P1NHbuJ9o=;
	h=Subject:To:Cc:From:Date:From;
	b=I/MVTpRKvAm4tVN4/4XBzXYkRWJMt4xfdacsVxLJxfIQea8hMjnUfYVkO+Fl2tsK3
	 KxQnJGeQHMt3vqcqRVBPfprwIPVQbNZSLvlDfZuocgWw+pkMUegrANLyYx/SrD/kH9
	 AERqtE4ubmzxrOP7Xll3VrQ0+QaG7KINipY1Pzwk=
Subject: FAILED: patch "[PATCH] serial: stm32: do not deassert RS485 RTS GPIO prematurely" failed to apply to 6.1-stable tree
To: cheick.traore@foss.st.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Apr 2025 15:41:48 +0100
Message-ID: <2025040348-deem-hazard-b9f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2790ce23951f0c497810c44ad60a126a59c8d84c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040348-deem-hazard-b9f8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


