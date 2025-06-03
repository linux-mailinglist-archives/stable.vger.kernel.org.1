Return-Path: <stable+bounces-150683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD830ACC39E
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2823A3AD6
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F372820D3;
	Tue,  3 Jun 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LWeCr4rn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5QNFbJ6c"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85928151E;
	Tue,  3 Jun 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944346; cv=none; b=M+IxzA1suwUPHXKwh5KjOvLilnDC8EJhLGZBMenOSEpuDvpHsS6Kb/m6tyv1oJEz6Xw8aYQW6A8nnlBaUWcHcxOHE4GbRm7RbTIowG34vqnKXiB0Ke2g2CaziGOLiLtW/11M5WMLv7NrL8qLMrdxnABtV3VmGxhpXIGpyCvnp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944346; c=relaxed/simple;
	bh=Xlxi9rPd9vD9mqlymmA7AuEXXEJbaZWZ9v07jx7GWOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g4t1CkVjClpexpMmvBw46OQli1rw1ugrA07AbCMQrnolzq03ZaVjxMw4GhKuMoocvG9KYm+AWnyeTud3Y//l6aPEPIaTZ+TSvgKhJtaL1OhNqbFk71cluroC/VAItGoya6T90TCEmvFqwBcEFtZmtknT5ETNvTQuMly6drPj2M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LWeCr4rn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5QNFbJ6c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748944337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rmYgAnk0V4lp/9zkefQtVct+J2O63fqxijSOg/js5bY=;
	b=LWeCr4rnQ8CKYH5Y3v54ZkDkEqGHqYbjpIgtgrAmV10YeqOmIFI3xH2inH60m/rinQGR+N
	kEBkA4sHSJH4fO1G8uK/xr5fk2H/hgAaq9A6YxWxuES0c6JmwA/o5Y6HgdNiz8LMpjyc1r
	vFMnwXl/svo1RYoRp7xQDYiGjpn7LvDP89HArd98pjhF3qSTD/PZy7g6N/OfEkfi3coV2V
	ytbHg8X7HYiYgBPF3N9g3Mh/hM1Xg/fG+hzxY1h5HYt/T5yGylUEnT5wZLqTcj78t2tslr
	5eFQP7S6Irop0b3dbYFqbFqAyOjwcKbhhOWBHeBeqHkgGM+Hz8qIkz3aXZYytg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748944337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rmYgAnk0V4lp/9zkefQtVct+J2O63fqxijSOg/js5bY=;
	b=5QNFbJ6cHzeTgRCctSafeiupEElh8yGKbOaviuWXQoz8s8lpjC+ahpqMcXgcCjVdBh19z9
	WlXQyXm5apjgiyAQ==
Date: Tue, 03 Jun 2025 11:52:13 +0200
Subject: [PATCH] sched: Fix preemption string of preempt_dynamic_none
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250603-preempt-str-none-v1-1-f0e9916dcf44@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAMzFPmgC/x2MQQqAIBAAvxJ7bkFXiugr0SF0qz2kohGB+Pek4
 8DMFMichDPMXYHEj2QJvoHuO7Dn5g9GcY2BFA1qVAZjYr7ijflO6INndKTJaGuJzAQta8Iu779
 c1lo/F9Oz4WIAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748944334; l=1237;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Xlxi9rPd9vD9mqlymmA7AuEXXEJbaZWZ9v07jx7GWOI=;
 b=rU9NK325oLcYMqv3CYc1Zro/M5sdzjehER2RK3SaMV9Ymni4W3xTWHL0I7UCRw6dG7TOk9S6U
 k2ypHlC8c85DgoNM4lD1gTI1SQaHUuzRT1mDetLVm6MdioqZH+ztnGK
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Zero is a valid value for "preempt_dynamic_mode", namely
"preempt_dynamic_none".

Fix the off-by-one in preempt_model_str(), so that "preempty_dynamic_none"
is correctly formatted as PREEMPT(none) instead of PREEMPT(undef).

Fixes: 8bdc5daaa01e ("sched: Add a generic function to return the preemption string")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
change-id: 20250603-preempt-str-none-d21231cc2238

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


