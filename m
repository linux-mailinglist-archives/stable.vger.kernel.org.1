Return-Path: <stable+bounces-4908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2280812F
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 07:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BFE1F21370
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF2A13AED;
	Thu,  7 Dec 2023 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L/IHDWz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613F14280
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 06:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FEFC433C7;
	Thu,  7 Dec 2023 06:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701931877;
	bh=R2x2cuD3sDXaqFhqtbJWG1AiE+KRrWsjJWoz87Sh89A=;
	h=Subject:To:From:Date:From;
	b=L/IHDWz+9CLBq7W2/nI16YhKhRZJqc10Ipy+I0aQ7LImnCuhDnHtDIxYvOkj6gWaZ
	 nYB3aGGlrR2+18VmRXIE8E13wWarxPjsbnLrQjtFWxY/XUJ/IlVleiWhpfxg+A9qfS
	 4qJZcrp0fo8xxV12NE6S/YFhZqMvVwo9EL/lfORo=
Subject: patch "serial: ma35d1: Validate console index before assignment" added to tty-linus
To: andi.shyti@kernel.org,gregkh@linuxfoundation.org,stable@vger.kernel.org,ychuang3@nuvoton.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 07 Dec 2023 10:49:41 +0900
Message-ID: <2023120741-sadly-saint-4319@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: ma35d1: Validate console index before assignment

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From f0b9d97a77fa8f18400450713358303a435ab688 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@kernel.org>
Date: Mon, 4 Dec 2023 17:38:03 +0100
Subject: serial: ma35d1: Validate console index before assignment

The console is immediately assigned to the ma35d1 port without
checking its index. This oversight can lead to out-of-bounds
errors when the index falls outside the valid '0' to
MA35_UART_NR range. Such scenario trigges ran error like the
following:

 UBSAN: array-index-out-of-bounds in drivers/tty/serial/ma35d1_serial.c:555:51
 index -1 is out of range for type 'uart_ma35d1_port [17]

Check the index before using it and bail out with a warning.

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>
Cc: <stable@vger.kernel.org> # v6.5+
Link: https://lore.kernel.org/r/20231204163804.1331415-2-andi.shyti@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/ma35d1_serial.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index a6a7c405892e..21b574f78b86 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -552,11 +552,19 @@ static void ma35d1serial_console_putchar(struct uart_port *port, unsigned char c
  */
 static void ma35d1serial_console_write(struct console *co, const char *s, u32 count)
 {
-	struct uart_ma35d1_port *up = &ma35d1serial_ports[co->index];
+	struct uart_ma35d1_port *up;
 	unsigned long flags;
 	int locked = 1;
 	u32 ier;
 
+	if ((co->index < 0) || (co->index >= MA35_UART_NR)) {
+		pr_warn("Failed to write on ononsole port %x, out of range\n",
+			co->index);
+		return;
+	}
+
+	up = &ma35d1serial_ports[co->index];
+
 	if (up->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-- 
2.43.0



