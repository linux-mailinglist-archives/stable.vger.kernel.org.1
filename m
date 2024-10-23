Return-Path: <stable+bounces-87869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBD49ACCB8
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A35E1C20C85
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162EA1FB3E8;
	Wed, 23 Oct 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUiZ6tyP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DF1FB3C9;
	Wed, 23 Oct 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693883; cv=none; b=nANq0yKNHG3etb+XtjEC+0Gkkv3gDh5qlm/cZAK8JRhF0zjBJ+t5iZx2qFtdK7lQKPTk0IjL7JoeehnLySF+vs+ze92SpGd6TKJveihpkF712X8u1ixbuLn2cqfkoSwLT5cY/2H59+rz9CifF6+2TTxTToWrlJI6KWmQx8qsY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693883; c=relaxed/simple;
	bh=eLcq8MuiQb/sOJuduYqKMuTG95hX8gQlc+dMMaRWQKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2yjf+NngdsXk3E7jvpZAL/oiIbORnfmTsZNJMAoW7BTL7HtePN5Coxy/yU+n/X2wUUiFNc6ST3QmI+w39T/2DlmujV1Nzo8jIUIINIshM8rMftTEnxk5MMUg23kwEdt1UHCEK5cUT0oQBzQJ4WchtAMQ0ptrIUrWXn5qHGJNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUiZ6tyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13177C4CEC6;
	Wed, 23 Oct 2024 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693883;
	bh=eLcq8MuiQb/sOJuduYqKMuTG95hX8gQlc+dMMaRWQKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUiZ6tyPNl/G0/u8kObNRg/PeMqOaTxv8MsOuntRigWbjQvc4BfW9f/YWgW1Brecb
	 62i7yDe01jiHlj9co74PuOOJu353/LjuRX61uvYKd2MvRw3Ol11rpiiezHizzIKpze
	 iHS4EQvUMYLgPUXWZbHi8BvEMLoGv0YNwlifz0NNaMgfryGqi1Y33BzmL0HBKiJvv2
	 a2PQYaKk8gjTs1flQOhDjusz/XYbMg9LqmoXWD5nK2yfHjsBz5ynLPFccEczPGH3bW
	 zbJW+vyYqdhE5zFspqabeprJgX0uyPrRfBEMRY+sPuSYTjuAblh2d/UeWDLFLdFQ1G
	 X5w85K+MWd6qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sergey Matsievskiy <matsievskiysv@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 04/23] irqchip/ocelot: Fix trigger register address
Date: Wed, 23 Oct 2024 10:30:48 -0400
Message-ID: <20241023143116.2981369-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

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


