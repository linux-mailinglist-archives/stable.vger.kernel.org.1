Return-Path: <stable+bounces-16030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9FD83E740
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC51C28C0EB
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FF725578;
	Fri, 26 Jan 2024 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eJo8uRXR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF220320
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312907; cv=none; b=L2ktOZRpEGMnZ5OX0dhnH6czVmHQics9V39/PhUrCzTxiEe6Ij3IydwzfQpEUdVhvIGh1mKklqzDZGYqz6Mb7rIVZAROF5W/gHktkyWOEqZkqXMJZl9bdF+wjFHVAC4Ed8I2W4bTq5gJZhbYonrwHP3c4rp/l9aXznR0m76LakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312907; c=relaxed/simple;
	bh=7ULRqevugg0ExH4K+dD9S6w1wVyWtkZGBt5V80fIED0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SwAEkNgkV2kTgD1nP4xfa+m39gZDMUHylg4Ng+gpY20oVL1p7lSJ3Yn1L9tPOxMtWphQraV3C7v9r9LQq4tpgA3Zk6BfVw8pezPTy/C/Ief5VTZglyA3PIORmeDLokeAriI1I0MS94g6s0Da9Ef9aSRCtW57Ukw3zB3lRRrHq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eJo8uRXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A9C433F1;
	Fri, 26 Jan 2024 23:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312907;
	bh=7ULRqevugg0ExH4K+dD9S6w1wVyWtkZGBt5V80fIED0=;
	h=Subject:To:Cc:From:Date:From;
	b=eJo8uRXRmSmCF8Pj2US9J193bmTBRzb0t5iFsEENqukD6cx6LkY3jUG30DOcPwO0o
	 4bT514cdVd1Mhmk3uv6uv0WssC/A29+ctWxu3hSt+cEL1a7aQQ8fUxTCZUakQYD842
	 NXu31+A5L/3+VdDUV9Spm8967aMw8TCi/zNiVbGU=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()" failed to apply to 5.15-stable tree
To: hvilleneuve@dimonoff.com,andy.shevchenko@gmail.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:48:26 -0800
Message-ID: <2024012626-mutilator-saline-742b@gregkh>
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
git cherry-pick -x d5078509c8b06c5c472a60232815e41af81c6446
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012626-mutilator-saline-742b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d5078509c8b0 ("serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()")
4409df5866b7 ("serial: sc16is7xx: change EFR lock to operate on each channels")
3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
b4a778303ea0 ("serial: sc16is7xx: add missing support for rs485 devicetree properties")
049994292834 ("serial: sc16is7xx: fix regression with GPIO configuration")
dabc54a45711 ("serial: sc16is7xx: remove obsolete out_thread label")
c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later in probe")
267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
21144bab4f11 ("sc16is7xx: Handle modem status lines")
cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
d4ab5487cc77 ("Merge 5.17-rc6 into tty-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d5078509c8b06c5c472a60232815e41af81c6446 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:12 -0500
Subject: [PATCH] serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()

Simplify and improve readability by replacing while(1) loop with
do {} while, and by using the keep_polling variable as the exit
condition, making it more explicit.

Fixes: 834449872105 ("sc16is7xx: Fix for multi-channel stall")
Cc:  <stable@vger.kernel.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-6-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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


