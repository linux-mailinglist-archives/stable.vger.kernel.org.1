Return-Path: <stable+bounces-56155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF8D91D501
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370AD2813D6
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2B58AC4;
	Mon,  1 Jul 2024 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUpja1lM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73742AB1;
	Mon,  1 Jul 2024 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792760; cv=none; b=BXAu0AX2nLykQ2rPRglECIRnRvdPr7iQuTactyHiW6yOcMiCgilsgsSmipID2Z37I5oL+NlEbNfCjosUykXc9uKJKn4NzbinXNY/OVHDKfnBGPzbyVvEt01M+DH3PjtIjFA6VRr7k9y1c504bmepEkR4ckEz9wybiRQCtfcBmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792760; c=relaxed/simple;
	bh=MfFFfT3IEudwtXCJK122nhjdOoxHe90ND2jrAw6n1y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAwDoccEXq4UYCOJ3uqA4T7Z8A8Jnvtckl+nnvNIRasW940pvWPxVc9r3NaviwACStfsbWov/riMWj0UPkyzfzJ1v5LJyj9/U3WBVlLOkX7hnLES14rArPeHWbWhCV23sJqAWOY5fg5pmP9EnV1Xpa7f72z5GxqFEwj1Xn25kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUpja1lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DF2C4AF0B;
	Mon,  1 Jul 2024 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792759;
	bh=MfFFfT3IEudwtXCJK122nhjdOoxHe90ND2jrAw6n1y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUpja1lMDOSAjG9KI98E0qlY7hgtckU27YT36CZax3F/kBvClpWxASUYjA7PgcyGS
	 UC4/Pp3RnfGZWmdsJnMMWMM4Q27UEzlSGwkWP6iose+kLxP33YYcUTsgS9+JyTHkEi
	 FaRNSK55SdsdOsMrCFiq6OgiZ0rXxqpvN9SrR0J5JxjjPFP4BYwkZSisGPfO2BUuZ1
	 G++2MC4E14QV72SsEhnKEZ4BprG3gZ7UmcuatrCH0nStvGUvRzk0Gdj/iGUH6t2VBQ
	 SukLTMjHX0KnEt/hOEmSuQkuUosjqn59F7b6sJyiZftp94cdJMuBYiB/C88lhTpd9D
	 4id4TuzjNn+HQ==
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
Subject: [PATCH AUTOSEL 6.9 12/20] cpumask: limit FORCE_NR_CPUS to just the UP case
Date: Sun, 30 Jun 2024 20:11:17 -0400
Message-ID: <20240701001209.2920293-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
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
index 4557bb8a52565..c98e11c7330ec 100644
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


