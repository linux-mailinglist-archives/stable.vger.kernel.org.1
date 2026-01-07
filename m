Return-Path: <stable+bounces-206117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7DCCFD486
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 11:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CC113067477
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1A32A3D4;
	Wed,  7 Jan 2026 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9tumf4m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IAxv8oCv"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576C325713;
	Wed,  7 Jan 2026 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782372; cv=none; b=XllHyvDbCwrvk3L3tCnkBwhRkMXDAuXX/8v0/dj+g2HDVghzS1VYFTQ5aZ2Ot+VE4HEnxUZVOp1EXxvKruGqUbZ1lu5TtfuYulV9LIicG7SRrfApS0WzHB5Ly4nYdZIrwhW/ZGNYR6xR7NmRHje05dIHJIb75OLkGekMjLgMV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782372; c=relaxed/simple;
	bh=fbxLThsdhcTtUl50liW5oJUBAkgsYCcubStwZ+W+O+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lcR7Cyu7Q1w0RJ6fylVl7pqLR1xi7J+K3cp+F/MbRsl0DS5sS4J17OBsiTtP0wHXdWAq3oVtBQuYEObyAQdu0isYntQDfyw2TPgv7wvaP17Ym/qI+LZG/cridDkVvLR4ocSpn1J2zZnScV1N84fJ8U7rXyUf4F5ZAiYVNHdpGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s9tumf4m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IAxv8oCv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767782368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eAE5uWC1VmcBBMF9C80qj8qv0snhl0xWlSFXc8wT0/4=;
	b=s9tumf4miLgZ5VorGyXX3ZbtqXdn1cp25fTrqfyoC4ndf6erW5+Eqg+8rsLo/QBxID6nLS
	C0TJE8PSWGRfvh124OTPafAl0Ld/6Sk9Or47gX5ypwZ7ZNy9uA7X+xOu+UIZ7Ap7JtjO5m
	WqVjiPt+72TFkCBIWIm9jZVTqVTezYUyN3pSnW7QHJlLGvvvzgkQyuk0yzYnnIF754H6Zl
	et9VB+wKlLbi3Q3ztcYPx0Cx1bjL8SoIYTxsFAO+yQbw/VDdkK7KxRZrfoUD/LZTMDH2F9
	D9mCI8hoImOpm3FbR18wvMGLHUZFQrORcxWzboGg2oMdmO/KF1AEAErYtcIG3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767782368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eAE5uWC1VmcBBMF9C80qj8qv0snhl0xWlSFXc8wT0/4=;
	b=IAxv8oCvcXCIrd/lHXVbJD5ymuoiY7B3R8WD7l5sRLaOFlilbOdhcJz+NTHs7bT5MaVRR8
	Z9XgbrxDD2okloAQ==
Date: Wed, 07 Jan 2026 11:39:24 +0100
Subject: [PATCH] hrtimer: Fix softirq base check in update_needs_ipi()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260107-hrtimer-clock-base-check-v1-1-afb5dbce94a1@linutronix.de>
X-B4-Tracking: v=1; b=H4sIANs3XmkC/x2MSQqAMAwAvyI5G2gF6/IV8aBttMGVVEQQ/271N
 nOYuSGQMAWokxuETg68rVF0moD13ToSsosOmcqM0ipHLwcvJGjnzU7Yd4HQevqw0i4vTV+ooYC
 Y70IDX/+6aZ/nBUTUdexqAAAA
X-Change-ID: 20260105-hrtimer-clock-base-check-b91d586b70f7
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767782367; l=1094;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fbxLThsdhcTtUl50liW5oJUBAkgsYCcubStwZ+W+O+s=;
 b=hB8KqEwgMCBQkaXRxvkZfEgDJ0zomsaTUKbNe8EzWKu8ZCTelpM+fQR15s6zmVUeT1sW8pMIa
 YHvMcsm0oGgBbzPcugh7LZ84YVwgtNI1ag9XaxiE9qEpSYSazcxtRfs
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The 'clockid' field is not the correct way to check for a softirq base.

Fix the check to correctly compare the base type instead of the clockid.

Fixes: 1e7f7fbcd40c ("hrtimer: Avoid more SMP function calls in clock_was_set()")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f8ea8c8fc895..d0c59fc0beb4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -913,7 +913,7 @@ static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
 			return true;
 
 		/* Extra check for softirq clock bases */
-		if (base->clockid < HRTIMER_BASE_MONOTONIC_SOFT)
+		if (base->index < HRTIMER_BASE_MONOTONIC_SOFT)
 			continue;
 		if (cpu_base->softirq_activated)
 			continue;

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260105-hrtimer-clock-base-check-b91d586b70f7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


