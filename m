Return-Path: <stable+bounces-16557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392E0840D75
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E985028AFC0
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE315959B;
	Mon, 29 Jan 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uNqXs6dG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210F157E62;
	Mon, 29 Jan 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548108; cv=none; b=Q4loGnlwc76ycyymEU54hSOuGlGZ1v/RCYQQtiXlvE8WWjUIp/hsAsH+BWKUDKkuqJkr4uW+PicrbTydGbKkGXy/0rAG3wRohrEjetBEQgiHp3JYnSoCOhHXpCY7OxY/9xN9DSH9NkK253/7GP0ZrFJdUJkKMD4N7f4q7lpcZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548108; c=relaxed/simple;
	bh=B4ZGtIrgs1YiJgo4QrTWH++CdYCBeyHsCl/zOJFLRag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0DSuKSJgO5Wb3dvGCatgtcm94tdZIiMg+aclPgxx8U57A0053HvQ7/5UtO+hmyI0LGdCr9qd1h28km1GDhksJCiFAgT9CRkbYS5n7zZ2TWaosJ21AkmDmcDRvIFeUHQZRxBSyiK0rr0CXnExKoJLtm0/Hv8WHKVbuqETCmtX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uNqXs6dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A9BC433C7;
	Mon, 29 Jan 2024 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548108;
	bh=B4ZGtIrgs1YiJgo4QrTWH++CdYCBeyHsCl/zOJFLRag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNqXs6dGkvFrckFBn9QscRXEDBYOcrRRvmwEYbkFDZFNBeN1a5JaN5f09nBwVjU0+
	 roLdHV6LcSQlCMexiGmfe/BZ8lWusnxmyJifSEyKclFcfZ7OmFdXtDGNlHKj+rWj+G
	 hK7lDpPR9W05A2ISKoF1MuUeco+31BOGTcBldDF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 6.7 130/346] serial: sc16is7xx: remove unused line structure member
Date: Mon, 29 Jan 2024 09:02:41 -0800
Message-ID: <20240129170020.200005308@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit 41a308cbedb2a68a6831f0f2e992e296c4b8aff0 upstream.

Now that the driver has been converted to use one regmap per port, the line
structure member is no longer used, so remove it.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231211171353.2901416-4-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -323,7 +323,6 @@ struct sc16is7xx_one_config {
 
 struct sc16is7xx_one {
 	struct uart_port		port;
-	u8				line;
 	struct regmap			*regmap;
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
@@ -1553,7 +1552,6 @@ static int sc16is7xx_probe(struct device
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
-		s->p[i].line		= i;
 		/* Initialize port data */
 		s->p[i].port.dev	= dev;
 		s->p[i].port.irq	= irq;



