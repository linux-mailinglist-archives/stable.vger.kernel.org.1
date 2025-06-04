Return-Path: <stable+bounces-151129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB7ACD3B0
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4C93A5017
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3394D599;
	Wed,  4 Jun 2025 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDmEqP6j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E31DF98B;
	Wed,  4 Jun 2025 01:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999004; cv=none; b=d4Pc3qINYdJVX3l6CKlizEg09ksMSVOTmGDQ0TM9y+6QQ2FN/NPTq58blT24bR5rTgZEInMrJ9pgrtemHaPA7NJgvfIjft/zYOWBCmyy0v47tceDSvu3rCi9VeCS7RyJDIYy+Evydv/f7rqfL4pip5Jx2VQm7X5G9hdq6ReRuIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999004; c=relaxed/simple;
	bh=llq2AZsDPYB2GrJ4BllTE8haJkQWEsxa1XLPNgIF5rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNrKvvV9iwAgCugfqHEn7kyB60/9eQaEFhwaDzhCQ4u/AHjCf4QWR2VfvcSHUjH0vqe8GPXx9QEDlE1oy1QyIKSg3CTTwXE97RU4+riL/68pcmoLp9UHYWHqHkG/RzMed+3Jn0R0bBs1LYV9SmkFeIwI8Lit+E/5lLNzAbzsojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDmEqP6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF00C4CEF1;
	Wed,  4 Jun 2025 01:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999002;
	bh=llq2AZsDPYB2GrJ4BllTE8haJkQWEsxa1XLPNgIF5rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDmEqP6js++t+woVshBIZ5uhiIuALHZhgWk1sAFOkYfe1yQ6U+ymJ0HOLjWrTq3r8
	 0EohVnf/BsSqMG/6u+hfDrH4eiGTxIoATQbVqwijSgSIIVOJ3u0vP1JwVeZBclu6fC
	 Q5VJmUZ+j2k1DhLHZvoOmtRoyv4yxZelYEokDHHZUlNWXEz/HbEQuEXHZw1o0YXVVN
	 fBxt1U18Bb7zTzRsKnUpb8HdT3vC6SWZ3T97M0prpapIUbKRGLQZFRuy+K7m86BhnY
	 tyWExel1nxkzZsjiwAhdjAbz/v+Nfd+CTXS9c2H8TYxuxvXm22+99lq7mMNM6nY0nB
	 zD7sUv8nKIuRA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	yedidya.ben.shimol@intel.com
Subject: [PATCH AUTOSEL 6.6 39/62] wifi: iwlwifi: pcie: make sure to lock rxq->read
Date: Tue,  3 Jun 2025 21:01:50 -0400
Message-Id: <20250604010213.3462-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010213.3462-1-sashal@kernel.org>
References: <20250604010213.3462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 1cc2c48c4af81bed5ddbe9f2c9d6e20fa163acf9 ]

rxq->read is accessed without the rxq->lock in a few places,
Make sure to have the lock there.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Tested-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Link: https://patch.msgid.link/20250424153620.73725f207aaa.I1a3e4b6c5fd370e029fdacfcdc9ee335788afa98@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the surrounding code, here is my
assessment: ## YES This commit should be backported to stable kernel
trees. ### Analysis: **1. Race Condition Fix:** The commit fixes a clear
race condition where `rxq->read` is accessed without proper locking in
two functions: - `iwl_dbgfs_rx_queue_read()` - a debugfs read function -
`iwl_trans_pcie_dump_data()` - a function that calculates buffer sizes
for error dumps **2. Specific Code Changes:** - In
`iwl_dbgfs_rx_queue_read()`, the commit adds `spin_lock_bh(&rxq->lock)`
before accessing `rxq->read` and `spin_unlock_bh(&rxq->lock)` after
finishing with all rxq fields - In `iwl_trans_pcie_dump_data()`, it adds
the same locking around the calculation `num_rbs = (num_rbs - rxq->read)
& RX_QUEUE_MASK` **3. Why This Needs Backporting:** **Race Condition
Impact:** Looking at the rx.c code, `rxq->read` is modified in the hot
path interrupt handling code (`iwl_pcie_irq_rx_handler`) under
`spin_lock(&rxq->lock)`. The unlocked access in the debugfs and dump
functions can lead to: - Reading inconsistent values during updates -
Potential crashes if the read occurs during structure modifications -
Incorrect debug information or dump calculations **Similarity to
Backported Commits:** This follows the exact same pattern as Similar
Commit #1 and #3, which were both marked as "YES" for backporting. Both
dealt with missing locking for shared data structures in the iwlwifi
driver. **4. Backport Criteria Assessment:** - ✅ **Fixes a bug affecting
users:** Race conditions can cause system instability - ✅ **Small and
contained fix:** Only adds proper locking, minimal code change - ✅ **No
major architectural changes:** Just adds missing synchronization - ✅
**Minimal risk of regression:** Standard locking pattern already used
elsewhere - ✅ **Confined to iwlwifi subsystem:** Changes are local to
Intel WiFi driver **5. Risk Assessment:** The fix is extremely low risk
- it simply adds the missing locking that should have been there
originally. The locking pattern (`spin_lock_bh`/`spin_unlock_bh`) is
already used extensively throughout the same file for protecting rxq
access. This is a textbook stable tree candidate: it fixes a real
concurrency bug with minimal, safe code changes that follow existing
patterns in the codebase.

 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index e9807fcca6ad1..5c2e8d2883976 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2701,6 +2701,8 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 	for (i = 0; i < trans->num_rx_queues && pos < bufsz; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
+		spin_lock_bh(&rxq->lock);
+
 		pos += scnprintf(buf + pos, bufsz - pos, "queue#: %2d\n",
 				 i);
 		pos += scnprintf(buf + pos, bufsz - pos, "\tread: %u\n",
@@ -2721,6 +2723,7 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 			pos += scnprintf(buf + pos, bufsz - pos,
 					 "\tclosed_rb_num: Not Allocated\n");
 		}
+		spin_unlock_bh(&rxq->lock);
 	}
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 	kfree(buf);
@@ -3385,8 +3388,11 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans,
 		/* Dump RBs is supported only for pre-9000 devices (1 queue) */
 		struct iwl_rxq *rxq = &trans_pcie->rxq[0];
 		/* RBs */
+		spin_lock_bh(&rxq->lock);
 		num_rbs = iwl_get_closed_rb_stts(trans, rxq);
 		num_rbs = (num_rbs - rxq->read) & RX_QUEUE_MASK;
+		spin_unlock_bh(&rxq->lock);
+
 		len += num_rbs * (sizeof(*data) +
 				  sizeof(struct iwl_fw_error_dump_rb) +
 				  (PAGE_SIZE << trans_pcie->rx_page_order));
-- 
2.39.5


