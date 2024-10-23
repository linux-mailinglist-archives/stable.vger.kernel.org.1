Return-Path: <stable+bounces-87907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 094329ACD22
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE8FB2443A
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEFF212D10;
	Wed, 23 Oct 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHwrJ/m7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F21CEAAD;
	Wed, 23 Oct 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693959; cv=none; b=fXYGVLf+4dtpZnyHsHy5wQXQY0glMbTGC9pO8ashl9NHToOTGOQfWoaREq7q2qu2lKQwnXp87lk/GByFpYeYsWtH/4gRUd1BJ26n5cXKDA9NMYyTtovjz5p47Yt5OcgGoNMvk92dC/NIuFRfLihc2a8rkYbet8Rq/mU9tNCgT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693959; c=relaxed/simple;
	bh=eLcq8MuiQb/sOJuduYqKMuTG95hX8gQlc+dMMaRWQKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N693Xh5DBZv2HHaG34qPd8UYOp/VG176qQAlFxdarp9xa4nn3rWBFxDDZrTEXB2137UlJMjIPjLssLQZrd7OtTMjIq2D4X01eTmhKU6Wx5+l+/KXoAIbDQ2fv7VQiLAg+XRZGzGQh9dR0e6KlfAO7UQ+n4PrD2wjzYOmqlym7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHwrJ/m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46CAC4CEE9;
	Wed, 23 Oct 2024 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693959;
	bh=eLcq8MuiQb/sOJuduYqKMuTG95hX8gQlc+dMMaRWQKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHwrJ/m78BXmhuYNXxbnGs1rn7Or+Q9pUyCsz8p1yEgSFOK4Kw9Xl5vix2GOlLlP7
	 tFA5ByYpCCdgoWHRBDaLKhLqOpayQNmgbEu3HNtryeMFxsjc16eGSFQZkirFUQfDBj
	 spWbafGi/modPd3mKvsRZLGbD3tENuOqxdw334zeZOa8Ynrqgb8+cm/dZGT6VVgcf6
	 WlwA1HcXuYYN05zj8lMyQLEWwvjFeEXRIcE0myjavEERPwNywPDngcO2kNmi9CffqZ
	 p6PjtqocydqKpPTlRVERVC5iCPBx+L5+WKud1QLti8vx0b4mfo2QYlQaBrY+uEIYP4
	 XeftOzJJoCq6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sergey Matsievskiy <matsievskiysv@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 02/10] irqchip/ocelot: Fix trigger register address
Date: Wed, 23 Oct 2024 10:32:23 -0400
Message-ID: <20241023143235.2982363-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143235.2982363-1-sashal@kernel.org>
References: <20241023143235.2982363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.169
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


