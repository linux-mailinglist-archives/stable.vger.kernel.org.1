Return-Path: <stable+bounces-164353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E5B0E7DA
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F017C6C7798
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43013C816;
	Wed, 23 Jul 2025 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxVLgB7p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34B23A6;
	Wed, 23 Jul 2025 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232370; cv=none; b=rGfFzAfGEL4WOi81PVxfrvWcA+QSA5SeFKGg/u5RLZgIWf9uggqZXf73sHJxCtY8rrWURy6Ee7aNZYknHl/imXTKzxu5/tScgldn5nWdaXMf0t5QWreLP7OGcPnsm+rCr+Odp62NgsVnBb9vxt6qavIFPqmfZuBEBfqq89huusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232370; c=relaxed/simple;
	bh=hzBxAooqxaH73dOWBczz2r0GKTXKr+B5PW7NY3kPFUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LugRQqF+HoD0gKpa2Rq7fuLN+sgsIKJE8N4+t7FFzPvfYlqCKxJ7Xa4JysVDJ/Vo4iUHlb0CjL96tGZUbZbibwibNCz4EQOHud/LK5ZETLY6LLgEpRnaQ94dC+ajkB0qKhsjn/9knp2N6oOPwN7DowQa2xYnPn9jlmU/fu52GDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxVLgB7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD82BC4CEEB;
	Wed, 23 Jul 2025 00:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753232370;
	bh=hzBxAooqxaH73dOWBczz2r0GKTXKr+B5PW7NY3kPFUE=;
	h=From:To:Cc:Subject:Date:From;
	b=TxVLgB7p5A30z3eBe3aq9a+HYs/spAMn6oCGrFsnaosqF46s1AhtYQixLIFXcxp1d
	 XytloXlxeZClZJGe86C/DxLY+A6yp/Cy8Hz4xFLjrPi8661IGCtZCB7JDdvQtoZ19H
	 HwHmxgGcUY+vkcqv7tHp/ZD0vaXCF0dV1UWNRbrE/FrrrqqIWOpC7zs2AzGE/aZEGJ
	 Sc9k5Ia+w2z+tSDInUWWMq1koaGgRZO+YvNHpMlHIS5ilyBKZUwLtENFfidJ+bOfGS
	 bP4JTkjYBCJNr0+/BXjW3TgvXOMTaZLi1zw/M6nNhID4CcrNJJ7WeaSaaED4t+BlT0
	 9tkPCu6lIkY8g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S . Miller" <davem@davemloft.net>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH AUTOSEL 5.10 1/2] ethernet: intel: fix building with large NR_CPUS
Date: Tue, 22 Jul 2025 20:59:24 -0400
Message-Id: <20250723005925.1023630-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 24171a5a4a952c26568ff0d2a0bc8c4708a95e1d ]

With large values of CONFIG_NR_CPUS, three Intel ethernet drivers fail to
compile like:

In function ‘i40e_free_q_vector’,
    inlined from ‘i40e_vsi_alloc_q_vectors’ at drivers/net/ethernet/intel/i40e/i40e_main.c:12112:3:
  571 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
include/linux/rcupdate.h:1084:17: note: in expansion of macro ‘BUILD_BUG_ON’
 1084 |                 BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);    \
drivers/net/ethernet/intel/i40e/i40e_main.c:5113:9: note: in expansion of macro ‘kfree_rcu’
 5113 |         kfree_rcu(q_vector, rcu);
      |         ^~~~~~~~~

The problem is that the 'rcu' member in 'q_vector' is too far from the start
of the structure. Move this member before the CPU mask instead, in all three
drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: David S. Miller <davem@davemloft.net>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Compilation Failure Fix**: This fixes a build-time compilation
   failure that occurs with large values of CONFIG_NR_CPUS. The error
   prevents the kernel from building successfully, which is a
   significant issue for systems configured with high CPU counts.

2. **Root Cause**: The issue stems from the `kfree_rcu()` macro in
   `include/linux/rcupdate.h:1084` which includes a
   `BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096)` check. This
   compile-time assertion ensures that the RCU head field is within the
   first 4096 bytes of the structure.

3. **Simple and Safe Fix**: The fix is straightforward - it moves the
   `struct rcu_head rcu` member earlier in the structure, placing it
   before the `cpumask_t affinity_mask` member. This is a safe change
   because:
   - It only reorders structure members
   - The RCU head doesn't need to be at any specific location
     functionally
   - Moving it earlier reduces the offset from the structure start
   - No functional code changes are required

4. **Affects Multiple Drivers**: The issue affects three Intel ethernet
   drivers (i40e, ixgbe, fm10k), all of which are fixed identically by
   moving the rcu member earlier in their respective q_vector
   structures.

5. **Configuration-Dependent Bug**: This bug only manifests with large
   CONFIG_NR_CPUS values (likely >= 512 or higher), where the
   `cpumask_t` type becomes large enough to push the rcu member beyond
   the 4096-byte offset limit. Systems with high core counts are
   becoming more common in production environments.

6. **No Risk of Regression**: The change is minimal and doesn't alter
   any functionality. It's purely a structural reordering that maintains
   all existing behavior while fixing the compilation issue.

7. **Meets Stable Criteria**: This fix clearly meets the stable kernel
   criteria as it:
   - Fixes a real bug (compilation failure)
   - Is minimal and contained
   - Has no risk of introducing new issues
   - Affects users with legitimate configurations

The commit is an excellent candidate for stable backporting as it fixes
a real compilation issue that prevents kernel builds on systems with
large CPU counts, and the fix is trivial with no risk of regression.

 drivers/net/ethernet/intel/fm10k/fm10k.h | 3 ++-
 drivers/net/ethernet/intel/i40e/i40e.h   | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 6119a41088381..65a2816142d96 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -189,13 +189,14 @@ struct fm10k_q_vector {
 	struct fm10k_ring_container rx, tx;
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
+
 	cpumask_t affinity_mask;
 	char name[IFNAMSIZ + 9];
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbg_q_vector;
 #endif /* CONFIG_DEBUG_FS */
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	/* for dynamic allocation of rings associated with this q_vector */
 	struct fm10k_ring ring[] ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index dd630b6bc74bd..add9a3107d9a0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -863,6 +863,7 @@ struct i40e_q_vector {
 	u16 reg_idx;		/* register index of the interrupt */
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	struct i40e_ring_container rx;
 	struct i40e_ring_container tx;
@@ -873,7 +874,6 @@ struct i40e_q_vector {
 	cpumask_t affinity_mask;
 	struct irq_affinity_notify affinity_notify;
 
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[I40E_INT_NAME_STR_LEN];
 	bool arm_wb_state;
 } ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 18251edbfabfb..3ea7095fc04f5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -457,9 +457,10 @@ struct ixgbe_q_vector {
 	struct ixgbe_ring_container rx, tx;
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
+
 	cpumask_t affinity_mask;
 	int numa_node;
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[IFNAMSIZ + 9];
 
 	/* for dynamic allocation of rings associated with this q_vector */
-- 
2.39.5


