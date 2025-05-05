Return-Path: <stable+bounces-141293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE0AAB244
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB7118855E7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E631A0F8;
	Tue,  6 May 2025 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKngETU0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309F2D7AC0;
	Mon,  5 May 2025 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485710; cv=none; b=VAST2ACpx0UPlX+VmDNzHufQUaUEMHoO3YjMm9Air8WWoc5zA8rsZ/dogaLe6BvwCS5J0fmIaZqJCCVJbNkQQKEeFlBw8ti9yyXOC+kqj5++bZu2iMgkgAlB00lM7olzDkB27M73xwpDgMc5Ys9Comu/N7z1MXo/Ks/ahtw4JY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485710; c=relaxed/simple;
	bh=o4/F9papw4kULnFMb213ufc0N5eWnIHuj6y4znAYhfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcHxbr34r5zhiXCdJSIK7rkyPtxaZwwWlt2m/ZgiIjuGJKh7mARKjbD3afO/B7nK4m7iq+p47Wbb7Pp24J42WUiTg/VKwRFRCoPOtjWoBvwSXqi2TjgiLaZWSmPABKQkk4sKC166fHY8wzwI2HaInfaUfBYbA3dPMDLjgaDAsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKngETU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFDDC4CEF1;
	Mon,  5 May 2025 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485708;
	bh=o4/F9papw4kULnFMb213ufc0N5eWnIHuj6y4znAYhfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKngETU0HFVDQ773SdAhS/hQxCQH2icPswK2EDggdTtHYyBuxQpqk5hHtmKItloUJ
	 VPu1+ii1UnFqOHu1Lm4oRojxtDQkNyyRtlRVPriGqPUROYcFsS63V39x946VgBXYa+
	 56tppbB0EPf1ZGFxB5XSnUUAoXkpJXuUSJWsSnL8g+MyBVyHjixV8Gou6sYUC3H9gA
	 ZKUJMLVG0nmQ54q5SSE2NFy/vwFIPVrYpc/6UrcXU9ruoL+nyKKCG6+3PH13tOa3Mb
	 dK32a3WjFwN1rHueP+wsyN2eurvCfyMuf9UjO55Tr9bIZaQNgwczFr8NpC8ejpVZLP
	 v61WCjJIBQoAA==
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
Subject: [PATCH AUTOSEL 6.12 436/486] rcu: fix header guard for rcu_all_qs()
Date: Mon,  5 May 2025 18:38:32 -0400
Message-Id: <20250505223922.2682012-436-sashal@kernel.org>
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
index 90a684f94776e..ae8b5cb475a36 100644
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


