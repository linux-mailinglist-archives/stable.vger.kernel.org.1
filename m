Return-Path: <stable+bounces-141443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E614AAB35C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AA417941C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0F23F42D;
	Tue,  6 May 2025 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCjnBuBg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54822DA18;
	Mon,  5 May 2025 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486333; cv=none; b=CEkpz4Cg2JTwdGrFJzlVu+Nw24QzSdIbxdupmfBw+3rc0upIic6uH4Xdw8urm2ICRMuyOoALZOP3cI4EWcZJaqLdjx6tA86Y6GJJP9S7OxdKBDDx+UaTSgCzVcC0zno0kjiJojyZ+Kp0zVnkr1pDujQv1f9csSvZ3/CfTi8++RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486333; c=relaxed/simple;
	bh=vXvdjUF/hV7GZJ2IXMja+Qh44JjPdYQpEmxOugKImzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IF8B1fejYnNz9EH3Ljd3SbkBk0gGAdg2W1OqXqiex6LKG56c5ZCdPUnpv4UoRIJgnli+Js2Gsotqn/XIPJpKV/YVceOS/nPZ9SbMX9uI1lxCCgwUt4D0UL0Obsj8b5SMLc4g+oh1t5VhU5Js4ZA0FduLho095vBbYtGU1NkH92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCjnBuBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAF1C4CEEE;
	Mon,  5 May 2025 23:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486332;
	bh=vXvdjUF/hV7GZJ2IXMja+Qh44JjPdYQpEmxOugKImzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCjnBuBgltdT43FCTAPfQffqzCLMb0QdGZFLIAA4NijeuY0+h8BvQnWeNz58AMTpY
	 ehiubaGvBEMvKgn2wtEXRd9YAgSRc6xUqXNqqyro8d2LJpiFOYM3ur+KRGFiTapg47
	 pIY9iGBIISW4QgDMAVV60O8zwyZHJV+uSMM2Q3kqmsla6VEBJTK1flkDANHp+B4SkM
	 eKqsFkuphsGpkb0SRYouobj8msGza3YNgwHSR2hzuoN0f0VJPGYT38Jz8KwykDOZ16
	 D84UcVtQtcpsykyAKs/tKzQxHzCblJTgoFLEJo6zKTOIowQWAcNKY+LhL1uJNtJA0p
	 lEhybbgRflFkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 264/294] rcu: fix header guard for rcu_all_qs()
Date: Mon,  5 May 2025 18:56:04 -0400
Message-Id: <20250505225634.2688578-264-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

[ Upstream commit ad6b5b73ff565e88aca7a7d1286788d80c97ba71 ]

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 126f6b418f6af..559f758bf2eaa 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -104,7 +104,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.39.5


