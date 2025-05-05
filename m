Return-Path: <stable+bounces-141042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CA5AAAD82
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D572516B7C2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01424399ECD;
	Mon,  5 May 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxQpOiSt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C59399ED5;
	Mon,  5 May 2025 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487295; cv=none; b=U1oAzlCdH5/EV0zM+I/rq/X+2f/KN2qD3KuPZIgoDYJKDtPyPDSnyOrJgnErLJZGQ8l6cgBlxGSeg6OBJ2WdjxtdltPDjyJXBNgoqLAmqG4lEvZrYIbtlxf4H73iLfn4UhQPJAmESzaZa/l5D/NcZYVZJTRZKCnBEVKmsZW6Fqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487295; c=relaxed/simple;
	bh=ZgvyVmPfgELbPy25Ynv0th0rMxCoP8Mk8pmjV4xcbHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PNWrpXTy9DMICXB94YtjT7anDLMCmLwwqLIDYMH0rNoQSbOp68n206fWlS/G0xfpbXMHEwST5tAO6hQ20tV5U/wA2bCuIAJ43m3TI3nIHvPqXTIazM8/f4+lkpSBqsiYLZ68v/SgTloEBtaiAKsj7DzduxtdlRulgyDgGquXzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxQpOiSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41DFC4CEF5;
	Mon,  5 May 2025 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487294;
	bh=ZgvyVmPfgELbPy25Ynv0th0rMxCoP8Mk8pmjV4xcbHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxQpOiStVJV8ojZh3PPwCAla+DowTRAHD0lOgyardL9WTOGjG/jMMyDk1VKnKy/qA
	 6IZ71tCrSR2p3I0BKlz3wv+QiWCNF7UB8kzkwRvCX3GqVvNYbd30t5rNUqCBfkJeqp
	 7L0GElmlyG31oALSIEA00xDAKFmhVB4lHCHBNB1w47vSU0uvIRBvg+aeDkkBLVSeBl
	 JaqLyauO+6Q8QpFn49clta7TNsxveYCVTAyGcujMHCOZdu9m/PmTd0ZFjDsjgkKKx6
	 2On9IoVeP6JBIhGb6gC3xX7P2keoGhU2P3hCjUqHUua7YKgTHCtXMWK3VhK5Y1PI38
	 AbduGs0tg985A==
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
Subject: [PATCH AUTOSEL 5.10 103/114] rcu: fix header guard for rcu_all_qs()
Date: Mon,  5 May 2025 19:18:06 -0400
Message-Id: <20250505231817.2697367-103-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 59eb5cd567d7a..92f04fcb89473 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -64,7 +64,7 @@ extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.39.5


