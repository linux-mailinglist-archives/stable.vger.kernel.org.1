Return-Path: <stable+bounces-6820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC48148FD
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 14:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C3E1C23349
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713152DB65;
	Fri, 15 Dec 2023 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bft5prgL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1A2FE38
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 13:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499B9C433C7;
	Fri, 15 Dec 2023 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702646464;
	bh=9ADrbossqAK6t9+2kre0zKPpm0Bt+93Ic73/DYHCLcU=;
	h=Subject:To:From:Date:From;
	b=Bft5prgLjpm/7QHij+UGn1QToD5Mbt5Ne/Y00kpL5RBrMEbv57NOU/saoYLR8hoa5
	 k5mJph3l4Bwd8tGXhreqPRqzPWwP/3+QcVFMi7CR1xboGnBvO1/q4j7j+g63/nxkwI
	 nRixI89RAW0mPX81T86ngDHO4k7er39j83VmuxIY=
Subject: patch "serial: sc16is7xx: remove wasteful static buffer in" added to tty-testing
To: hvilleneuve@dimonoff.com,andy.shevchenko@gmail.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Dec 2023 14:20:50 +0100
Message-ID: <2023121550-unmoved-crunching-3e2d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: sc16is7xx: remove wasteful static buffer in

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 6bcab3c8acc88e265c570dea969fd04f137c8a4c Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 11 Dec 2023 12:13:48 -0500
Subject: serial: sc16is7xx: remove wasteful static buffer in
 sc16is7xx_regmap_name()

Using a static buffer inside sc16is7xx_regmap_name() was a convenient and
simple way to set the regmap name without having to allocate and free a
buffer each time it is called. The drawback is that the static buffer
wastes memory for nothing once regmap is fully initialized.

Remove static buffer and use constant strings instead.

This also avoids a truncation warning when using "%d" or "%u" in snprintf
which was flagged by kernel test robot.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc:  <stable@vger.kernel.org> # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231211171353.2901416-2-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 9cb503169a48..8d1de4982b65 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1708,13 +1708,15 @@ static struct regmap_config regcfg = {
 	.max_register = SC16IS7XX_EFCR_REG,
 };
 
-static const char *sc16is7xx_regmap_name(unsigned int port_id)
+static const char *sc16is7xx_regmap_name(u8 port_id)
 {
-	static char buf[6];
-
-	snprintf(buf, sizeof(buf), "port%d", port_id);
-
-	return buf;
+	switch (port_id) {
+	case 0:	return "port0";
+	case 1:	return "port1";
+	default:
+		WARN_ON(true);
+		return NULL;
+	}
 }
 
 static unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id)
-- 
2.43.0



