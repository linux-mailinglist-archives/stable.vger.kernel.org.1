Return-Path: <stable+bounces-93303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45A9CD877
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EFB1F21E71
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117DF18734F;
	Fri, 15 Nov 2024 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2h0pXGeS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A4186294;
	Fri, 15 Nov 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653470; cv=none; b=l5hfYeNqcKX7eKzN26D0nusKXBjBHfk3ojszZH3cs/ezuYFh7sXBKJZQOcKCJ3ggHXTszgiIWCuk6Gc9T9izudaqeuzkRgEBoxpBajWSYXJWisJ0wQ8aA9IbzoAda2OQa48lscgCNtnc6fu61c4a8DPL8v27p0OSvnWD6QRY/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653470; c=relaxed/simple;
	bh=Dv3if9JP2LPoJNVqJzgBKrZAd8vsNOdt6ReWyH4Cm2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFDlv4vZunTF3L24mOfcWkwfxOIWHqiQ1h8R6iYntdcvUbJM4y3WOSaznftL/qxMysUi5ARut2xU8zCmrUn4ArNOji1hoLPNZPF7QhTNO4ERZR9HoVfc5DAZth6c3D68+7Bk0y7yXUfPEN6SOrDaNO8xasJ5amqIFfnMJr+YDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2h0pXGeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CC5C4CECF;
	Fri, 15 Nov 2024 06:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653470;
	bh=Dv3if9JP2LPoJNVqJzgBKrZAd8vsNOdt6ReWyH4Cm2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2h0pXGeSwZkWuSS5wBG4ncKB2r2HMwKbVgcLCs44iIBg1oH5a76N08RfPNnTrkWSs
	 f2dHgW/zhvmAilQFe910P2fvQA7KNYvNzyH3Abmau8Xphs7VPRinKmyOgl7t8HksIc
	 nXJ+0aLUSIH0Ns8yOo+dOcJwlIVjxBvilKGqZfzs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Matsievskiy <matsievskiysv@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 04/48] irqchip/ocelot: Fix trigger register address
Date: Fri, 15 Nov 2024 07:37:53 +0100
Message-ID: <20241115063723.123696090@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
References: <20241115063722.962047137@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Matsievskiy <matsievskiysv@gmail.com>

[ Upstream commit 9e9c4666abb5bb444dac37e2d7eb5250c8d52a45 ]

Controllers, supported by this driver, have two sets of registers:

 * (main) interrupt registers control peripheral interrupt sources.

 * device interrupt registers configure per-device (network interface)
   interrupts and act as an extra stage before the main interrupt
   registers.

In the driver unmask code, device trigger registers are used in the mask
calculation of the main interrupt sticky register, mixing two kinds of
registers.

Use the main interrupt trigger register instead.

Signed-off-by: Sergey Matsievskiy <matsievskiysv@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240925184416.54204-2-matsievskiysv@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-mscc-ocelot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 4d0c3532dbe73..c19ab379e8c5e 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -37,7 +37,7 @@ static struct chip_props ocelot_props = {
 	.reg_off_ena_clr	= 0x1c,
 	.reg_off_ena_set	= 0x20,
 	.reg_off_ident		= 0x38,
-	.reg_off_trigger	= 0x5c,
+	.reg_off_trigger	= 0x4,
 	.n_irq			= 24,
 };
 
@@ -70,7 +70,7 @@ static struct chip_props jaguar2_props = {
 	.reg_off_ena_clr	= 0x1c,
 	.reg_off_ena_set	= 0x20,
 	.reg_off_ident		= 0x38,
-	.reg_off_trigger	= 0x5c,
+	.reg_off_trigger	= 0x4,
 	.n_irq			= 29,
 };
 
-- 
2.43.0




