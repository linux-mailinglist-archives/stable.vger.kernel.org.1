Return-Path: <stable+bounces-139859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924D7AAA113
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72281A83FE7
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4A299A87;
	Mon,  5 May 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uND8PcYl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B929953D;
	Mon,  5 May 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483553; cv=none; b=GqiMemU7FxpufS6xPaxuYlSgtuT0DXjka69/MhvgfLKDLqoYkqgtltu8n7iGH3IHJ5I3lsRjvx+UHNfIZnFqOwHMm6/j8m10C2ycpYKrp+1UnNAKJwiNvoko509oZuWf+YmNyBtpXKUTzg7ecijBoLp3BjDQNwuczwpn4BmXv34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483553; c=relaxed/simple;
	bh=NWrCB9QKWE9LHJw3TZ6TiMGktRwEOC/Vp74f1sAzblg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6a1GMYlsLJJ1RoFn9gtfSOWwKUnbwUpX3yk8m9tYjaFw07EzUGljhRxpgz+hfj52OfbPngA+D7I6bQzDDi0mvITS8dVlP3eEYJfhtm7gJbcsq/wkKyHaxPJ5s2+KSgtbSZHJyIDFdG8IqgewpVzp03RneI9IwaDuPfcYzjKmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uND8PcYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7072C4CEEE;
	Mon,  5 May 2025 22:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483553;
	bh=NWrCB9QKWE9LHJw3TZ6TiMGktRwEOC/Vp74f1sAzblg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uND8PcYlzRMFuED9TY1zophUqD5SUZyWkOk1xva1vuUzNqqguNa8XYOZGKQCAj/rE
	 saYl1m14SDW7oFvSoN34DMQjrZXFdKktDdtc39lYJsnZJHiQYV9l4JjRzmav77X8NB
	 iHKM+ZkaRpWUk/a/+FTf536Yc9F/7pM6Gx7GTUAiBIz0nV3K9tGUQK8pYBDWmcZmF1
	 dhpFMnT9VsCYN/6sP0FnlWEGpTRSBkCLg4PzY9teVlrAQwT3k2bPknEriciQ7Ig1Sk
	 MC5o7fyaw/7MZ9Gh4ZtE6Qlibfkkh1mNRaH+CEB4AZRBkH2CdDXSw+tjgE1R1fvKsZ
	 47sMnUhFreqeA==
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
Subject: [PATCH AUTOSEL 6.14 112/642] clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
Date: Mon,  5 May 2025 18:05:28 -0400
Message-Id: <20250505221419.2672473-112-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


