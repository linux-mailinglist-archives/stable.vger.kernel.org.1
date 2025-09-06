Return-Path: <stable+bounces-177970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96658B473BE
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601CE5871F3
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0D5224AEB;
	Sat,  6 Sep 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQnkq4lv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46820E6E3
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175071; cv=none; b=F3/rNUAYw1CfTR5wWWDap71hXx+N3k225ADoVuCByGSvWQ2gfODp25CUcdtzgR6GAtVekdqzGbb+vrj635BIHCdFPVjQgqic2kBQAvVMQ+3nWYL5JdIyfK27pTanLzVbQJ+6lpYnl34nzUl1FDKKulAvHgSqnlitFS+ASiZVJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175071; c=relaxed/simple;
	bh=iBFXEwpj1XH88duZ1969OYqJ7T3EPT7cgsKUGHgx9QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fp8EyCQkCjisGiojCrxSw7f+dRWoihxBuJLyIdIHPogvP0htzqVv9UbeeXfyvkP2N7Fjcq3HV4DAw5ToK6suQJa0xqUwPNPNhMJnD2W1bX1yhTrCC/k/6L4t1MTv3PAa/RxLzifBnnIg8eAR26wQAwnaNFAQq4HHZ3hSfFdEqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQnkq4lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FD7C4CEE7;
	Sat,  6 Sep 2025 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757175071;
	bh=iBFXEwpj1XH88duZ1969OYqJ7T3EPT7cgsKUGHgx9QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQnkq4lvU0m9C+PtvQpGl7UkRpPD6+jywbjWLhh+lJS1vP3WTJ8YfdWq+ut4Poc5A
	 imrKVJhuaIZXf/0yYzLVwFhZrKZDz3G5EVHfXEkCJ7iN38xmEor5m7J43g37iYKGAH
	 HmRfZ6/6lerHxlOQWTNqvVrdCmYfoPtPlcrhpTOY6E7riumF845yoUL4CabXBvzi7s
	 N9QtCrMxNbNW/mVfAq7QIghj0u0ElfGZI6SXr1FY9/q9JPI+fC2FtgHXJUEDFfgKaI
	 OBF7XuoVNoktGY12hvxonm3DmqeAJm4G+Ga7SYP3TPkLmgOQgcg2LdsDpEtemy+Gne
	 9bb5HmwMDy3ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] cpufreq/sched: Explicitly synchronize limits_changed flag handling
Date: Sat,  6 Sep 2025 12:11:09 -0400
Message-ID: <20250906161109.141162-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025042156-uncurled-citizen-ae9a@gregkh>
References: <2025042156-uncurled-citizen-ae9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 79443a7e9da3c9f68290a8653837e23aba0fa89f ]

The handling of the limits_changed flag in struct sugov_policy needs to
be explicitly synchronized to ensure that cpufreq policy limits updates
will not be missed in some cases.

Without that synchronization it is theoretically possible that
the limits_changed update in sugov_should_update_freq() will be
reordered with respect to the reads of the policy limits in
cpufreq_driver_resolve_freq() and in that case, if the limits_changed
update in sugov_limits() clobbers the one in sugov_should_update_freq(),
the new policy limits may not take effect for a long time.

Likewise, the limits_changed update in sugov_limits() may theoretically
get reordered with respect to the updates of the policy limits in
cpufreq_set_policy() and if sugov_should_update_freq() runs between
them, the policy limits change may be missed.

To ensure that the above situations will not take place, add memory
barriers preventing the reordering in question from taking place and
add READ_ONCE() and WRITE_ONCE() annotations around all of the
limits_changed flag updates to prevent the compiler from messing up
with that code.

Fixes: 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change")
Cc: 5.3+ <stable@vger.kernel.org> # 5.3+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/3376719.44csPzL39Z@rjwysocki.net
[ bw_min => bw_dl ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4dcb489733181..3221bafb799da 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -82,9 +82,20 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	if (!cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
-	if (unlikely(sg_policy->limits_changed)) {
-		sg_policy->limits_changed = false;
+	if (unlikely(READ_ONCE(sg_policy->limits_changed))) {
+		WRITE_ONCE(sg_policy->limits_changed, false);
 		sg_policy->need_freq_update = true;
+
+		/*
+		 * The above limits_changed update must occur before the reads
+		 * of policy limits in cpufreq_driver_resolve_freq() or a policy
+		 * limits update might be missed, so use a memory barrier to
+		 * ensure it.
+		 *
+		 * This pairs with the write memory barrier in sugov_limits().
+		 */
+		smp_mb();
+
 		return true;
 	}
 
@@ -318,7 +329,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
-		sg_cpu->sg_policy->limits_changed = true;
+		WRITE_ONCE(sg_cpu->sg_policy->limits_changed, true);
 }
 
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
@@ -825,7 +836,16 @@ static void sugov_limits(struct cpufreq_policy *policy)
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-	sg_policy->limits_changed = true;
+	/*
+	 * The limits_changed update below must take place before the updates
+	 * of policy limits in cpufreq_set_policy() or a policy limits update
+	 * might be missed, so use a memory barrier to ensure it.
+	 *
+	 * This pairs with the memory barrier in sugov_should_update_freq().
+	 */
+	smp_wmb();
+
+	WRITE_ONCE(sg_policy->limits_changed, true);
 }
 
 struct cpufreq_governor schedutil_gov = {
-- 
2.51.0


