Return-Path: <stable+bounces-56171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2124291D52F
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1911F240E2
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB271494B8;
	Mon,  1 Jul 2024 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmt9DBG7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA113D886;
	Mon,  1 Jul 2024 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792842; cv=none; b=kPuNqnD8zxC3XWdASkKajltO4Z57X4Hpe9vYsQi95/a/op4h6URXWTqZvag1FcwOoJ0jeK/PS1T38qXatqMdj/Gb+k2hwLOLlvDWWTK78wf8OM+cKzVwBwLaFMIedaCnr5C/E+CY/HEH2vGaNGHOiIV/1Cgpp4Z0Fu6L8tRG84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792842; c=relaxed/simple;
	bh=TOXD3TzfdAshihje47H+53+6tvFBaDEyBMZlyz883kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxM0VLBa7FkSxRun/c6XYDh2ITmdl65B0f2fjxk91gW8DiHC8gQL0vtJu+YGIwCcKc/KmHJryAT52M8TLl/zopXMZDV46ziDpkRVfslymc1p8eDbUDSudDzP6WF+8kV0WT3Y7zCRDsFRJs2xFSB9EXAal5FwLZ5xqzvR7ojEf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmt9DBG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB492C2BD10;
	Mon,  1 Jul 2024 00:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792842;
	bh=TOXD3TzfdAshihje47H+53+6tvFBaDEyBMZlyz883kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmt9DBG76nb//3J3CZchu1bHBY30kAyW75lR6fnduabWTbX7tFmvylIw0cSRtf27n
	 PMOzTqe36V6kjinJrfUJbncp4v+nDEjiuPzabqNVRsXhny9CNE/N3ytdPNMTUKCYss
	 49jonUco+Qa2l4Pv9y3xohWUrlm+J48rEkojEZJN5lSk+Fi2uOHK2NfCrjn47Kgbec
	 b1UWBE3NvHukWTpwbUsQ7vJfQpzzaWNxhypOQcJTkavOvdpTBw32A4WPYE0o5qi2LM
	 birLo7poXPDV/4Y9F4yqoj/m2fTmuBuLRwNEdnS+MeOQtkjqGj4rGxNEZzvQRwXKXn
	 AQbW9dqqL2+NA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul McKenney <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Yury Norov <yury.norov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 08/12] cpumask: limit FORCE_NR_CPUS to just the UP case
Date: Sun, 30 Jun 2024 20:13:27 -0400
Message-ID: <20240701001342.2920907-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001342.2920907-1-sashal@kernel.org>
References: <20240701001342.2920907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 5d272dd1b3430bb31fa30042490fa081512424e4 ]

Hardcoding the number of CPUs at compile time does improve code
generation, but if you get it wrong the result will be confusion.

We already limited this earlier to only "experts" (see commit
fe5759d5bfda "cpumask: limit visibility of FORCE_NR_CPUS"), but with
distro kernel configs often having EXPERT enabled, that turns out to not
be much of a limit.

To quote the philosophers at Disney: "Everyone can be an expert. And
when everyone's an expert, no one will be".

There's a runtime warning if you then set nr_cpus to anything but the
forced number, but apparently that can be ignored too [1] and by then
it's pretty much too late anyway.

If we had some real way to limit this to "embedded only", maybe it would
be worth it, but let's see if anybody even notices that the option is
gone.  We need to simplify kernel configuration anyway.

Link: https://lore.kernel.org/all/20240618105036.208a8860@rorschach.local.home/ [1]
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Paul McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/Kconfig | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index c686f4adc1246..ee365b7402f19 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -539,13 +539,7 @@ config CPUMASK_OFFSTACK
 	  stack overflow.
 
 config FORCE_NR_CPUS
-       bool "Set number of CPUs at compile time"
-       depends on SMP && EXPERT && !COMPILE_TEST
-       help
-         Say Yes if you have NR_CPUS set to an actual number of possible
-         CPUs in your system, not to a default value. This forces the core
-         code to rely on compile-time value and optimize kernel routines
-         better.
+	def_bool !SMP
 
 config CPU_RMAP
 	bool
-- 
2.43.0


