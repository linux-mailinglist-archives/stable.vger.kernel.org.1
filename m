Return-Path: <stable+bounces-140894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5BDAAAC3E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB04E165C22
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D682F20C5;
	Mon,  5 May 2025 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al6KvPNV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5D2F1CDA;
	Mon,  5 May 2025 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486766; cv=none; b=DcbdqukEFvJWWNNVdwDocertSeO1D+haJpwGb6tkRxcPkDFFH+fAQaCwBx2wmLgP665VGOpOAgekfPtz/vbwM9kvd7wYuVibJ6pMSzKVsz1GJgbr/iNXUV6LRxGq+pl+ybRVVJPNb/8A3gix0G4nswjhfzQtqoALi0HlpA7wS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486766; c=relaxed/simple;
	bh=IW9xsafdlpO9IQruWFkcsKA7HeeDftLSa9a1ASloEHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XoyWnMDTSU/4bd3lbYhUfGWAaibwKjFq3xyrCpV3keVpAARJ0GXIHA8/8xBS9Vof5yGECE59qw0K9qXgfU1vmJ5Hi+iPql84Zo/IteVulq2OWpfBgkhnAFFrtkeTFk59e1dEOHCb7OcNEJuzCFUEl02dmbpyq2VucofwCJfbjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al6KvPNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA55BC4CEEE;
	Mon,  5 May 2025 23:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486765;
	bh=IW9xsafdlpO9IQruWFkcsKA7HeeDftLSa9a1ASloEHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=al6KvPNVp5w4GUTc52Lm91vPLpHPiaUA0rqh+6oLPly/Vt2jK1WT0kpQwqP8A0pYp
	 eDqT1YN7zGfiwLuafbs9aJupcBJIJCn82um3UGvelfcVWcwDzjO2fyrEij6/tNNCyz
	 0IB+H7AauSiYE7qKvGkGAG8gS8E1ZA+Up7g8/bMv2RrT5JNF0YuQl3/MMUbtZ+e+wJ
	 wju/95q99+v8DGnxzRmA1Zxzwsj6yEnK2gLje/5QD7c7b80DWlvWb/nTm9RoHGjnDE
	 uv7GWKdqYd/0FoDbtU1mft4J3orYat2qFo29IflBTiLFTtWpjckdXlj6K0pwo3RPUF
	 nR5ouUt1laJuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 191/212] rcu: handle unstable rdp in rcu_read_unlock_strict()
Date: Mon,  5 May 2025 19:06:03 -0400
Message-Id: <20250505230624.2692522-191-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

[ Upstream commit fcf0e25ad4c8d14d2faab4d9a17040f31efce205 ]

rcu_read_unlock_strict() can be called with preemption enabled
which can make for an unstable rdp and a racy norm value.

Fix this by dropping the preempt-count in __rcu_read_unlock()
after the call to rcu_read_unlock_strict(), adjusting the
preempt-count check appropriately.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcupdate.h |  2 +-
 kernel/rcu/tree_plugin.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d001a69fcb7d4..17bec9c3f3173 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -97,9 +97,9 @@ static inline void __rcu_read_lock(void)
 
 static inline void __rcu_read_unlock(void)
 {
-	preempt_enable();
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		rcu_read_unlock_strict();
+	preempt_enable();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4f45562be7b54..3929ef8148c10 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -821,8 +821,17 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || in_atomic_preempt_off() || !rcu_state.gp_kthread)
 		return;
+
+	/*
+	 * rcu_report_qs_rdp() can only be invoked with a stable rdp and
+	 * from the local CPU.
+	 *
+	 * The in_atomic_preempt_off() check ensures that we come here holding
+	 * the last preempt_count (which will get dropped once we return to
+	 * __rcu_read_unlock().
+	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
-- 
2.39.5


