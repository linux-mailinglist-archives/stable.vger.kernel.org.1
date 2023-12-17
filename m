Return-Path: <stable+bounces-6892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A2F815F69
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 14:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856541F21FC0
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5E4437A;
	Sun, 17 Dec 2023 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i6Waudnt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206CA847A
	for <stable@vger.kernel.org>; Sun, 17 Dec 2023 13:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D587C433C7;
	Sun, 17 Dec 2023 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702819811;
	bh=oqMtiwuFAClipmYh/hEAjQA2dgI4FCyizCxd0/DE3H8=;
	h=Subject:To:From:Date:From;
	b=i6WaudntZDbb3S61vrbGEiRoc/FTUbCfuDq/N7mjmIJncFiHmkylECGfSWkGi7J0Q
	 yQTlSPOd5+z6c3OFVjyOl6Ob+P6VXoAu28IjJwA3mN55oKzMdXVsxvCN1tWzDNmUD8
	 ltvkDFSeEAMHcI7YgCjNMxhimULyqWT1p9O046YQ=
Subject: patch "serial: sc16is7xx: remove unused line structure member" added to tty-next
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Dec 2023 14:27:50 +0100
Message-ID: <2023121750-headdress-grain-b09e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: sc16is7xx: remove unused line structure member

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 41a308cbedb2a68a6831f0f2e992e296c4b8aff0 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 11 Dec 2023 12:13:50 -0500
Subject: serial: sc16is7xx: remove unused line structure member

Now that the driver has been converted to use one regmap per port, the line
structure member is no longer used, so remove it.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231211171353.2901416-4-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index a4ad3ae8cae2..0a7a9aa5c9fa 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -322,7 +322,6 @@ struct sc16is7xx_one_config {
 
 struct sc16is7xx_one {
 	struct uart_port		port;
-	u8				line;
 	struct regmap			*regmap;
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
@@ -1552,7 +1551,6 @@ static int sc16is7xx_probe(struct device *dev,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
-		s->p[i].line		= i;
 		/* Initialize port data */
 		s->p[i].port.dev	= dev;
 		s->p[i].port.irq	= irq;
-- 
2.43.0



