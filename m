Return-Path: <stable+bounces-141677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D236AAB56D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C5C7B2A0C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D8B49F072;
	Tue,  6 May 2025 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKDb4bVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B53AC584;
	Mon,  5 May 2025 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487141; cv=none; b=symlnPCR/zZc8/w7bFS0IU3LkUaNg7KvrU0yrxzfWhJSSmfsrOi22H2zwg0medIBoXNIVmi/6S6ojtDQBUKO9a0HA/lXkseWOSvWRpqcIKl00wHF8QhYcSQtNM7IG/5qVd9C4sbubPOIkHhHnQyJCwK5a8Nd0YqntpF8TlA3DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487141; c=relaxed/simple;
	bh=B4/AFmH4EzCm+/gzXspUOA/ZQOae4G4h8zpgvZNFaUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KuuK9QKShiQlJZyPgzEnE9xI7ufRcagRHON5xIbA8JhWoS5J0R2+wLLk51r4Wh5FeBQeWTn1L/hZl+8hfMmjPzDVE/QA5ZPd+dmlL63FsHDCHJs55Dusu+QPn1f1DSvwT4CGdPG7VLfQiW/ps8NXZP1chPLQ/FvFig9xkpZ6sYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKDb4bVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F8FC4CEE4;
	Mon,  5 May 2025 23:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487140;
	bh=B4/AFmH4EzCm+/gzXspUOA/ZQOae4G4h8zpgvZNFaUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKDb4bVNN79c0miYr+Zo1oQkCjTrVqi7m17qNVzpm0HuYrYtb9RRc8vnB3bet7r6E
	 IO3g8l2nOqXdSU7fnD7Eu9AcdBGcA6KAkKVt1z4ZvaZjFciwmsfwlxhtAEtFQTWHpC
	 iT2MDvJ/zV8lIIwJEtLc87LZw3CdoyOnr/HV1ch45O1r8KaCtTewMcNW98+V8oIlNt
	 hr+bzUV6bxhAyHnFhf+IcI5TU60NPnvUftUZxy30OgYkw1jllXBViMy9YO2RIV+EuS
	 cQNBeMugC/ZjcU6FDidiRG3xTHkHYLF8FPFnqQqePcU0FbJzQ3kMv3ja4NihWCyVxQ
	 sd7dWhdD5dRiQ==
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
Subject: [PATCH AUTOSEL 5.10 021/114] clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
Date: Mon,  5 May 2025 19:16:44 -0400
Message-Id: <20250505231817.2697367-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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


