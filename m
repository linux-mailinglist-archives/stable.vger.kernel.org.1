Return-Path: <stable+bounces-141607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0697AAB4D8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6B5188165F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F13289825;
	Tue,  6 May 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO7eDF7N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456428982F;
	Mon,  5 May 2025 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486860; cv=none; b=lNLUwOL7b4Lnx/F3UDnhoIn3+tWGuuJJAtOmdFs2r71oTS+zzjtHhGSd5OcRTk4V0lIkY74NG9oNN+H7I/ks/F7vnWxHLvjmdvh7tNzUuEAchZ4FZQ+Xhdn84uiySjObbsheIq//jGnZWOv9dymQP70UbDvUYxqHizLzFNDc9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486860; c=relaxed/simple;
	bh=B4/AFmH4EzCm+/gzXspUOA/ZQOae4G4h8zpgvZNFaUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F46b1Ryrcv9CAtMQjnXHQ8ZDroxgolwy2heDTFJFMJPzDccvRbcnLCL/HTR8xkgXOxS7rYLb6+6HlJrsDZrVhCjpmdRwWJQbEaFfplcBZ1+Sgk9EweDbZdz9JmGpA65nC6t6x+ZxnL2KzhaEspfxUyLhhYHtE8MsT6PiIzMK1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO7eDF7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03528C4CEED;
	Mon,  5 May 2025 23:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486860;
	bh=B4/AFmH4EzCm+/gzXspUOA/ZQOae4G4h8zpgvZNFaUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MO7eDF7Nx1f0WrpHwAd5nrTmkCoVhkCad9iJKRLOSUPrF8/Dj/l2zDdoeEXV7pbIV
	 fOC8Yu/aBpxQ1Fbku/aWZzhNabiljJx9Ff+X53QehDPTrxomdpwTfTs/FSa1QeNA8z
	 k/L0Mxpw8V+E0fUnOBp9yfi+fA397lJW8ZSl8M0qzGf2UFmWs3k4t1XVKV0xYUQVpt
	 0YTbkeXBU/6pEarqk45oOnbMzV1nWMOfCwIPlV9d9FNKAGcwrpQ9e7Nspjc7fwPHNO
	 oexFm7i8eeR/0Vtxi7CiQrvnwFhRMvBbBJE6bAJp++HDaoFlKYe75gD8Tz45vJ3xPY
	 jMyudL0nB8nHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nick Hu <nick.hu@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 030/153] clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
Date: Mon,  5 May 2025 19:11:17 -0400
Message-Id: <20250505231320.2695319-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Nick Hu <nick.hu@sifive.com>

[ Upstream commit 70c93b026ed07078e933583591aa9ca6701cd9da ]

Stop the timer when the cpu is going to be offline otherwise the
timer interrupt may be pending while performing power-down.

Suggested-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u
Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250219114135.27764-3-nick.hu@sifive.com
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-riscv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index c51c5ed15aa75..427c92dd048c4 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -75,7 +75,13 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 
 static int riscv_timer_dying_cpu(unsigned int cpu)
 {
+	/*
+	 * Stop the timer when the cpu is going to be offline otherwise
+	 * the timer interrupt may be pending while performing power-down.
+	 */
+	riscv_clock_event_stop();
 	disable_percpu_irq(riscv_clock_event_irq);
+
 	return 0;
 }
 
-- 
2.39.5


