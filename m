Return-Path: <stable+bounces-87840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0036E9ACC5B
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5301F256D2
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FAD1C9DF9;
	Wed, 23 Oct 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOCaT0tk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A081C9DC6;
	Wed, 23 Oct 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693822; cv=none; b=F5srWULnL1Ik1wLyk56c0qafnS/9vyqUeeD3z16wznLA1CH0SYeSCECwtMZXY/oxB79ykuwT87u8W5w/tq6fVD55kbJEShy+tzggbbURW3C30kOyxEmj+vmCTXKeDO5N5tim4mHdAm09ubLtOhKtRoLM+kMa5PwnyszOdPV5ZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693822; c=relaxed/simple;
	bh=eLcq8MuiQb/sOJuduYqKMuTG95hX8gQlc+dMMaRWQKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9PgmUvNCzJEV2AKrYjLA9dZQz5oKqX5PG5P6f/gU+WODyFGbQnhab78xf8TGqro9Vs/GrRmC9lQbVYm5u24yv7JxvbOC2EkUBsfPnuPWV3tReYCdEeaL1cRkLEVTBcLKupME3SMfXRtVjl1XKZqOeGrMp+YxYjp1J6hJEQP8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOCaT0tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED9DC4CEC6;
	Wed, 23 Oct 2024 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693821;
	bh=eLcq8MuiQb/sOJuduYqKMuTG95hX8gQlc+dMMaRWQKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOCaT0tkb6fkN4+m0/8oOD3TRLLy+Bgcl2yCYrdJWBnyHSzRMamZ3gFQOihyqvgyu
	 Lw+8QK7n7FVVCSQjxfRbL8z7I63dgySFsJZy5bfKCxnpD7Xp0eskmRa8BQW6+7EjzB
	 qDnMvdHCyWvd7ZRNa0pV6NsMI+Erbd15oJvR2yHOP62FFndLjfcDtaK2T5qieNUmiy
	 H2J5AZoA0aPf1ULruOS15OiP0nu/0Pv6v0cQX2zfOTRv6hfyeuHQckiYNZem+gZg+q
	 tEIlsocwGWZEnevp9re1Dok2KTiELa03Rks9NKbyxWDDGb9+7PBsssUIEci9DEhkg0
	 9cG+BYV6H9ltw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sergey Matsievskiy <matsievskiysv@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 05/30] irqchip/ocelot: Fix trigger register address
Date: Wed, 23 Oct 2024 10:29:30 -0400
Message-ID: <20241023143012.2980728-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
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


