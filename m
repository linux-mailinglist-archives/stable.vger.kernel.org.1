Return-Path: <stable+bounces-141665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAD5AAB568
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768091C0775C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C249C646;
	Tue,  6 May 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIQgdC7V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D872F6B2B;
	Mon,  5 May 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487075; cv=none; b=gvV0ngaE0icMsspZ4NDTdU2ysbDG7M2XO6Hbd0YCCNTqzGzzYlh/XUHD1UB3HTWPwngd1WQKXlVeJU0u1kMoSWvyLMdP4soste3v/HVc/oUs/xW4i0/k6eawRQ4cy/CRZsJZcMBXzgU840qOYZjqF9OmQubKkH8FT8mSxQiX7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487075; c=relaxed/simple;
	bh=/2J5vELcYhIB5u+gaNT3hu3osVWdh/Cs8c/m8gYGHg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lSy/UFqSnPrPZ8DWI8cMg6lfdWxQH95rS3o1FKlXovuHJPy6uCy80Pmicw6k9Xo0fNFKht5R6CNfRQTkkIZPR3CsQN0vW8UKeQJqqjdowgnp/R7tU9ndv8Q1H0JDXsYKLiQKCrG1gdc2q9HMApcGKRWy+YdLhwXGyxU5KGfEoRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIQgdC7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857B4C4CEEF;
	Mon,  5 May 2025 23:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487074;
	bh=/2J5vELcYhIB5u+gaNT3hu3osVWdh/Cs8c/m8gYGHg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIQgdC7VMBEXLV3+NTb3vxpg+5uQ3khw6HwHTjOvGfRTBcITeNWA30R2OGzepm807
	 zZ4TrcQr48PVrhqlfNxwA/QXVOuxLAQ9mZwtlRbnMs7/o4Y7bhCmOmqkTngeo6tcyl
	 CudtxkmbMOzk7gP4LfTIALQsdBBVtdn3SaCV39VfM6P64SpEq6IGGWOsWcs8z1mJau
	 v8y9B6cFJHzD7unXdKBNOci2ZHao3MbDx/Kx/1wseHyURzHlzSSJrOIJGjZIN2mk2f
	 GZ8Hane0fxmegSgOBCCrrn/KDtAPrU1o7gs0zrMCjTp+7lrkKLMKeRLT7oT2ZoUuti
	 uz6L4VbWKbDnA==
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
Subject: [PATCH AUTOSEL 5.15 140/153] rcu: fix header guard for rcu_all_qs()
Date: Mon,  5 May 2025 19:13:07 -0400
Message-Id: <20250505231320.2695319-140-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 53209d6694001..3828ff8a2f9c9 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -66,7 +66,7 @@ extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.39.5


