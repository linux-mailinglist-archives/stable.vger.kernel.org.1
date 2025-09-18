Return-Path: <stable+bounces-167341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A2B22F8A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789EE7A8A48
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF22FDC25;
	Tue, 12 Aug 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PwV1fIiz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8A2F7461;
	Tue, 12 Aug 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020488; cv=none; b=ITuQaZfiWpGIb4feMLaUFmDwuwa4XwgQakIvGB2svCHRceiwE0Xl30V8LmYVfb8fAWzDyQzqmwEif1r5DPQ7iMnYSel1xNTMG/ckTusXb+ajM0Jk7+v09JZcUL+dUCvK+ZUBR/BWmPoyPHfAYzIo0JCtRH1e9sfPq1MvpI/x1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020488; c=relaxed/simple;
	bh=zRa9sIQ6764zCA/BVTFkV2t8Gtbj0R69sI5hnZUGp8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1kn0kFbr8MvyRce2Ezh1q6zfgop6pEBiNcJUQhvoD4rgvcxTf9fIMmratq6diDXo3iUA8hZdppqOzKi+B8ED4Una/JU6u56Bi8yaCu+o+ZpjQeBozdAXK5nswLlHvMUd7QMh9h1GIYwBC+pTxxvAJgW+7BA4ZBpmt5SgtIe4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PwV1fIiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4F9C4CEF0;
	Tue, 12 Aug 2025 17:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020488;
	bh=zRa9sIQ6764zCA/BVTFkV2t8Gtbj0R69sI5hnZUGp8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PwV1fIizo+d1tAMmHbtfXjnrr4Z2uMiknfQrtjcj9zFVI4dbaMCVpWJyTj/Z50YNp
	 S/oxF3ZIMXK3l+ocsHWJWENorQkY8mm404EvjIGutB9wxp2sQKYScgFtkNVz7rvb5N
	 oeUBmX0qzMzIVqiF8hmp9SFiMWRPfjZ9o3TOLi2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH 6.1 061/253] ethernet: intel: fix building with large NR_CPUS
Date: Tue, 12 Aug 2025 19:27:29 +0200
Message-ID: <20250812172951.321470565@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 drivers/net/ethernet/intel/fm10k/fm10k.h | 3 ++-
 drivers/net/ethernet/intel/i40e/i40e.h   | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 6119a4108838..65a2816142d9 100644
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
index 22ac8c48ca34..61590e92f3ab 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -980,6 +980,7 @@ struct i40e_q_vector {
 	u16 reg_idx;		/* register index of the interrupt */
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	struct i40e_ring_container rx;
 	struct i40e_ring_container tx;
@@ -990,7 +991,6 @@ struct i40e_q_vector {
 	cpumask_t affinity_mask;
 	struct irq_affinity_notify affinity_notify;
 
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[I40E_INT_NAME_STR_LEN];
 	bool arm_wb_state;
 	bool in_busy_poll;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 2bf387e52e20..f49b99b175ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -498,9 +498,10 @@ struct ixgbe_q_vector {
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




