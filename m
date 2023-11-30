Return-Path: <stable+bounces-3558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC17FFAD6
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 20:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68911C2114B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98C5FF0E;
	Thu, 30 Nov 2023 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Gm9kSMoJ"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E7910E4;
	Thu, 30 Nov 2023 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=AEm+IaX9A4uvKk4v1WSGhlTmQPSBKm4TU4lKJNYntmE=; b=Gm9kSMoJBgC1JfrodPB2e0/Yvp
	8xiv7QWolS5WzDxSL3I06gC7hYgmBUIQVJpvlghkP1mO1D8Yt4NxZL3BXM5/fO9h7yryINSJ4MWYd
	jSi5d3SarkgfCVVtil2rAEX3fa9mreEqZQAsVbEovOK2mvP8qLxMCXxFe9UI+UAsMOZM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48272 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r8mR4-0003sb-No; Thu, 30 Nov 2023 14:10:55 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	stable@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 30 Nov 2023 14:10:43 -0500
Message-Id: <20231130191050.3165862-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130191050.3165862-1-hugo@hugovil.com>
References: <20231130191050.3165862-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in sc16is7xx_regmap_name()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Change snprint format specifier from %d to %u since port_id is unsigned.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc: stable@vger.kernel.org # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
I did not originally add a "Cc: stable" tag for commit 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
as it was intended only to improve debugging using debugfs. But
since then, I have been able to confirm that it also fixes a long standing
bug in our system where the Tx interrupt are no longer enabled at some
point when transmitting large RS-485 paquets (> 64 bytes, which is the size
of the FIFO). I have been investigating why, but so far I haven't found the
exact cause, altough I suspect it has something to do with regmap caching.
Therefore, I have added it as a prerequisite for this patch so that it is
automatically added to the stable kernels.
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 10e90a7774f0..8e5baf2f6ec6 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1700,7 +1700,7 @@ static const char *sc16is7xx_regmap_name(unsigned int port_id)
 {
 	static char buf[6];
 
-	snprintf(buf, sizeof(buf), "port%d", port_id);
+	snprintf(buf, sizeof(buf), "port%u", port_id);
 
 	return buf;
 }
-- 
2.39.2


