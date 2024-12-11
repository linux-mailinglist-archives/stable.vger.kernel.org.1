Return-Path: <stable+bounces-100527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D419EC3FA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 05:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98EB2843E4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 04:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545D01BD9FB;
	Wed, 11 Dec 2024 04:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GrG84HtF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338E1BF7E0
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733891167; cv=none; b=Lr41/0h7F0CyA7nVZkE8aV1d4cvoiqsyr2ICTjXKqQsatovdm5kXpX84XGq7OBTjjigSiUWUNVK8whPo3seyBUbUyKt0RST1lfyZy2B1TT3TmPjqggKMtWPFWOKDbaBijx7sZlzJvRHtSn9mgNVQxEcHDWGkwVxCHjAhcmG1Y2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733891167; c=relaxed/simple;
	bh=4goXdOx9lfRVnaXZlUVvcAhlw3Mb1G0PYn6TF+/Wg/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJ7wCi8ZqRcFH8dBtIs5yh4LSDGRPyrnbsIJRNsJrQ+reYXVKcDEoclqpHAAq3r/xUHbVFiO0UnNNq4YR2x30ftFELpnOP1viHgXkzzKk62RYr1ZxmrJy+CySEWiEV+CbOTMEFj7a/pCr3Nf1lMm9G9yq3Fn6SyzX/+B8W9Soj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GrG84HtF; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from hwang4-ThinkPad-T14s-Gen-2a.. (unknown [120.85.107.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 382AB3FB97;
	Wed, 11 Dec 2024 04:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733891163;
	bh=PvngHJdImia0SPIQHxBEG2gJH1U//d+dGI8nrQPy1wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=GrG84HtFvx64pCSzaClGcO/ZnCJMRVfhFSwHLVaeaMfUikJaVEJhz9RJOq5YtXoR1
	 b1X0VuUKJBZjuTXjSHA7ruykxgOonS5wq3GbaN+MvCQxr9lidFWGw53GOha0PCSYWB
	 8pJfpSkVpV1eJHsU8aeqvEifigbyZNYQwbCn9joUBi1UmgoegKBr90aYO0LS54zs0L
	 JE0HywXFZE4m+0/CFvNT4fEg12zPFVmBeyKRS4zKIBwj5y5maMx5K0JbQrx2TYMk9L
	 /dSlBkXKQC7SGIrVC6EwJRLcvmvl1ByOkAFfkTO2t5V2LnFYMmBLFFwnib1AsVWpTY
	 wTfEsMMLj+OVA==
From: Hui Wang <hui.wang@canonical.com>
To: stable@vger.kernel.org,
	patches@lists.linux.dev,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: hvilleneuve@dimonoff.com,
	hui.wang@canonical.com
Subject: [stable-kernel][5.15.y][PATCH 4/5] serial: sc16is7xx: remove unused line structure member
Date: Wed, 11 Dec 2024 12:25:43 +0800
Message-Id: <20241211042545.202482-5-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211042545.202482-1-hui.wang@canonical.com>
References: <20241211042545.202482-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit 41a308cbedb2a68a6831f0f2e992e296c4b8aff0 upstream.

Now that the driver has been converted to use one regmap per port, the line
structure member is no longer used, so remove it.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231211171353.2901416-4-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 90b39ddec082..a2d05dd5a339 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -313,7 +313,6 @@ struct sc16is7xx_one_config {
 
 struct sc16is7xx_one {
 	struct uart_port		port;
-	u8				line;
 	struct regmap			*regmap;
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
@@ -1278,7 +1277,6 @@ static int sc16is7xx_probe(struct device *dev,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
-		s->p[i].line		= i;
 		/* Initialize port data */
 		s->p[i].port.dev	= dev;
 		s->p[i].port.irq	= irq;
-- 
2.34.1


