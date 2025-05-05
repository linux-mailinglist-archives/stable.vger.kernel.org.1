Return-Path: <stable+bounces-140474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B832AAA956
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71AB9A0610
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97A729A3CA;
	Mon,  5 May 2025 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSE+zTCj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03F35903A;
	Mon,  5 May 2025 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484943; cv=none; b=bEzD+87fQjIuRbDnFAsX0j4Dvu7X60jYtTO6poCk8Eopfmcyl+r06mxB8jvn+Mg8pVcsmW6VH3PsF4BiToNRZVBPVMFC2JIIpnR0kFIZWgOcqh+XTMk+X/ctqLm8Qv3JIYnOz2CcaiI59CI8sQCKfMdFrgYowTMQgNqr2622WS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484943; c=relaxed/simple;
	bh=NWrCB9QKWE9LHJw3TZ6TiMGktRwEOC/Vp74f1sAzblg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1/ek/P7ZZyWs5eBaxX5FTRg4rPJfH63/xjxkhzAQj8xNGJD4a7ZrPWuVb0OLzLcSvhnMGMwlTvVSOl4TyFu4GON6JnOjhISoZ3/VTJmXOqJrfqKjxt1LvyG2GURSZIDJxXZ+JVnxSsEgBRUNsk8nYVfUjkP1Q29CNW7iJBKAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSE+zTCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69BCC4CEEE;
	Mon,  5 May 2025 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484942;
	bh=NWrCB9QKWE9LHJw3TZ6TiMGktRwEOC/Vp74f1sAzblg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSE+zTCjLJlGfk8mItOdo+seOCE5rZTTvX/I6wR9XZQzOjOfIu12FVeJhyqeb3Nm1
	 rIg+ePm9hK2EScULUM18mnrgCkC2X2IYbK50U9YKMgG6ElxTQhNieYQ4KG81Am4geO
	 yel+AXewG28Dk/3vWWYxnALPe2aj4h3YRe5i+DRpSK2O8jr1insaNbC1eXG+5Ooupj
	 YsS5z0M7YZ27QGzZxVZWc1r8wFksvzzhg1VJ69nL9qHStTjYfvCSZoLf1OiiYYlPc3
	 83xqtuyY/E9qbFRheIRWsaURDk4iJSSwWXBb9YYD3xqkpc18fD6BJHXK1jqPhdX4Yx
	 zVr7fp1EEK9dA==
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
Subject: [PATCH AUTOSEL 6.12 088/486] clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
Date: Mon,  5 May 2025 18:32:44 -0400
Message-Id: <20250505223922.2682012-88-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 48ce50c5f5e68..4d7cf338824a3 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -126,7 +126,13 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 
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


