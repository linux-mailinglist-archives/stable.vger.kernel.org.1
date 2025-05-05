Return-Path: <stable+bounces-140522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC86AAA9AF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ABB3A86B7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680992D1647;
	Mon,  5 May 2025 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg4qWe+W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20929A3E0;
	Mon,  5 May 2025 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485035; cv=none; b=mgufAQjhx8Z/bPYsjJiOyUHCRJl6LgcKPZlONacf5nJy98wvLtA0KJc8ZgADsdpDafdX4LMhEqjdR1icODpanWPf4u/KOpQ96cUjIf0YOmLqSKHOLUkGFA+sgZ0tPijpzd6F3keOqgW9GHHrlCs1DHbzaOAfmKaOPwSjkyATAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485035; c=relaxed/simple;
	bh=jTphWrmv44YP6NtaA/99o5KYTtq/M3BPS0eJY1PDA/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1y4VKvl/cZ3rMbHieyntamvZtkd5g2piW8c/lNPZf8nPRpUQSX7c+YopEq2fCaLr5LTGQfBb27iTQhxojPrR88qiZQ9w38E4vlBQLBpe+vvmI4S4m8MY74yrxk1vXJMX58VimoEQBzwBUo7/ykTOQg337LN4RKDk91rtD1Etbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg4qWe+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B0BC4CEE4;
	Mon,  5 May 2025 22:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485035;
	bh=jTphWrmv44YP6NtaA/99o5KYTtq/M3BPS0eJY1PDA/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fg4qWe+WVSKRfNDKisKSOvunKp7kYcIcm1vnFmmXGG46C0NUapErCtRiGVH8WA9/0
	 a03u937XGlGGC2CF0E3UshDYuh/VtJnkk7/9K/ti9V/Qb0YiSqOxNIDMXCUzU7rIAX
	 D0UBYaqMvIg36BUCZY7vXdskH8vrMSSNNDZrCLTmwlSr/TpZcpqmf+B0GLZk6k9VNR
	 YlxSdXMAwrTQAJrqUKO54ZQ14vDYyMZ/Zz9VeaHdQ0fUVeKdzOMySn+vNcmuX+VDUX
	 QHZT9/qO74QIy+6qWBsT6Mpgykpz/jPzfbTWXq1/4CzVKPiD4TVDfeiZoMuTtASzHB
	 GLreHb2sa1SPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de,
	frederic@kernel.org
Subject: [PATCH AUTOSEL 6.12 133/486] timer_list: Don't use %pK through printk()
Date: Mon,  5 May 2025 18:33:29 -0400
Message-Id: <20250505223922.2682012-133-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit a52067c24ccf6ee4c85acffa0f155e9714f9adce ]

This reverts commit f590308536db ("timer debug: Hide kernel addresses via
%pK in /proc/timer_list")

The timer list helper SEQ_printf() uses either the real seq_printf() for
procfs output or vprintk() to print to the kernel log, when invoked from
SysRq-q. It uses %pK for printing pointers.

In the past %pK was prefered over %p as it would not leak raw pointer
values into the kernel log. Since commit ad67b74d2469 ("printk: hash
addresses printed with %p") the regular %p has been improved to avoid this
issue.

Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer, easier to reason
about and sufficient here.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Link: https://lore.kernel.org/all/20250311-restricted-pointers-timer-v1-1-6626b91e54ab@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timer_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 1c311c46da507..cfbb46cc4e761 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -46,7 +46,7 @@ static void
 print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *timer,
 	    int idx, u64 now)
 {
-	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, timer->function);
+	SEQ_printf(m, " #%d: <%p>, %ps", idx, taddr, timer->function);
 	SEQ_printf(m, ", S:%02x", timer->state);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",
@@ -98,7 +98,7 @@ print_active_timers(struct seq_file *m, struct hrtimer_clock_base *base,
 static void
 print_base(struct seq_file *m, struct hrtimer_clock_base *base, u64 now)
 {
-	SEQ_printf(m, "  .base:       %pK\n", base);
+	SEQ_printf(m, "  .base:       %p\n", base);
 	SEQ_printf(m, "  .index:      %d\n", base->index);
 
 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);
-- 
2.39.5


