Return-Path: <stable+bounces-158675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D8EAE99E2
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 11:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6024A3223
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F4B295D87;
	Thu, 26 Jun 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBHynQYO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F2PDavr/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8918C332;
	Thu, 26 Jun 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929839; cv=none; b=a3ZKyeXOXdKF1lXKBF+xDXH4EA9oF+Jalcg/3GkH6Wc2lUSpdjSD4RxgWzD38wU/O8E60HHcz1vXLNzYyIrsygTUzM7rDiL6G6AsUoN3ipR5nT3iuR3lzLUir7wGFiCbCZxp5cyJosqlCNE95XJu7UyGgoIYeW9nA1mzNlYkRHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929839; c=relaxed/simple;
	bh=qefygG19a70dJv46vYC1EnTIxHXTAsx2nrgYvCYxMKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rHKMmOK1tsSQwtet4FI4f3qUjk0tl/6qochdNI5/o0WIpu4aL3/N+Dmt6x7CrKTHgE9RL95c4UwrlFK9iL8BfoSenDeM4Ux5bXkuwau+1vEqJHTx1PdEDaJV1Qicvd4pUyxFaQYe5OCgZ1YL8MzYVxvf2/NgaoN/eTwroPAAJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBHynQYO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F2PDavr/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750929836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i4K0WCp7W/aJOeJ11xc56lmM+3AvDScAzbW1dYGjQv4=;
	b=DBHynQYOgmbyzFJw3/d0crd9G6Cppsucge9a7YDgcaK3PAHWheWDZJT40J5RHdih2BfGX/
	4Fk2aMhWMcoWndnQ9j/WZqhxMVabbIx/+bBI8OCagM2Ur3bvHEvumPCmg/QMIuzR9FBVsy
	w+s2lb+l7TJLTwPnaatOOg2+Zv2gyJKTVjFBhp4dqWpfW/YyWTTXZ+fOMUy+/x6V/oeGo7
	9ysPbZkN5RXaI1coDXetX6AZcFStVxqbSKGDQwQ4otflfyvKAbuhIRmT5AnL2vOrkqCzV5
	e55i2k0OE0ROoIb1h24fza2rfNLlj4nLAfGD2i+Ws4D2W/dX/v9vCahXrfrRsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750929836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i4K0WCp7W/aJOeJ11xc56lmM+3AvDScAzbW1dYGjQv4=;
	b=F2PDavr/2DO4WuKMtVrvoPzFllySlcGjC7XBKrOhveUAwBGQWQaGuVKKBncIYK/p1lWBvv
	Y5RpWfRPKzhUzzBQ==
Date: Thu, 26 Jun 2025 11:23:44 +0200
Subject: [PATCH v2] sched: Fix preemption string of preempt_dynamic_none
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-preempt-str-none-v2-1-526213b70a89@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJ8RXWgC/32NQQrCMBBFr1Jm7UgyrcW68h7ShSQTO6BJSWKol
 N7d2AO4fJ//318hcRROcGlWiFwkSfAV6NCAme7+wSi2MpCik+pVi3Nkfs0ZU47og2e0pKnVxhC
 1Z6izWnCy7MrbWHmSlEP87A9F/9I/sqJRo1M8DLq3xnXd9Sn+nWPwshwtw7ht2xcTUv+jtAAAA
 A==
X-Change-ID: 20250603-preempt-str-none-d21231cc2238
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750929834; l=1533;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qefygG19a70dJv46vYC1EnTIxHXTAsx2nrgYvCYxMKw=;
 b=vv12BvyU6bPTM7lClHQ5+r1baolvyX+1iC4MnCv7bmn0Rrkb1PNk1QB1TO9KfA/eCPDHjtJVZ
 lxhIM5clwGIB6wdNYd6ZqGxhV3zIwvdZIeVrHqNSjWhvmPSDws7lK+B
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Zero is a valid value for "preempt_dynamic_mode", namely
"preempt_dynamic_none".

Fix the off-by-one in preempt_model_str(), so that "preempty_dynamic_none"
is correctly formatted as PREEMPT(none) instead of PREEMPT(undef).

Fixes: 8bdc5daaa01e ("sched: Add a generic function to return the preemption string")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Changes in v2:
- Pick up Reviewed-by and Tested-by
- Rebase on v6.16-rc1
- Link to v1: https://lore.kernel.org/r/20250603-preempt-str-none-v1-1-f0e9916dcf44@linutronix.de
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dce50fa57471dffc4311b9d393ae300a43d38d20..021b0a703d094b3386c5ba50e0e111e3a7c2b3df 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7663,7 +7663,7 @@ const char *preempt_model_str(void)
 
 		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
 			seq_buf_printf(&s, "(%s)%s",
-				       preempt_dynamic_mode > 0 ?
+				       preempt_dynamic_mode >= 0 ?
 				       preempt_modes[preempt_dynamic_mode] : "undef",
 				       brace ? "}" : "");
 			return seq_buf_str(&s);

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250603-preempt-str-none-d21231cc2238

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


