Return-Path: <stable+bounces-9765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4B48250C7
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0611C22BA5
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1658622F13;
	Fri,  5 Jan 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WT8Xbumd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF622F0C
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 09:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA2EC433C8;
	Fri,  5 Jan 2024 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446594;
	bh=4Ht5HCTfburmPWd+0NAsL04ix4oTEzBItuvZZg6hruY=;
	h=Subject:To:From:Date:From;
	b=WT8XbumdKa0vmwfoQMrp+eNgysf45vEDTmFTpV5To8fb8J4372W82ToLHC2nFRnko
	 X73T/okNANEPlLVBo0F77yCItspixoayMkTNzt5spAmt0m5kB9ZJqXSRaAMk4MZS6o
	 8FH40nUotfnxjV5DiimwRC8jwEVm5dvF5uMLMp2U=
Subject: patch "serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()" added to tty-next
To: hvilleneuve@dimonoff.com,andy.shevchenko@gmail.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:21:56 +0100
Message-ID: <2024010556-transpose-balsamic-cfdd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From d5078509c8b06c5c472a60232815e41af81c6446 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:12 -0500
Subject: serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()

Simplify and improve readability by replacing while(1) loop with
do {} while, and by using the keep_polling variable as the exit
condition, making it more explicit.

Fixes: 834449872105 ("sc16is7xx: Fix for multi-channel stall")
Cc:  <stable@vger.kernel.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-6-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 44a11c89c949..8d257208cbf3 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -783,17 +783,18 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
 {
+	bool keep_polling;
+
 	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
 
-	while (1) {
-		bool keep_polling = false;
+	do {
 		int i;
 
+		keep_polling = false;
+
 		for (i = 0; i < s->devtype->nr_uart; ++i)
 			keep_polling |= sc16is7xx_port_irq(s, i);
-		if (!keep_polling)
-			break;
-	}
+	} while (keep_polling);
 
 	return IRQ_HANDLED;
 }
-- 
2.43.0



