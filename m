Return-Path: <stable+bounces-233444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFAWKCUm1Gn5rgcAu9opvQ
	(envelope-from <stable+bounces-233444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 23:31:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B53A78DA
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 23:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11DA730530DA
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 21:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4174E38F622;
	Mon,  6 Apr 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3q32ixZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C927B327;
	Mon,  6 Apr 2026 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511045; cv=none; b=HoXBKmQLA09xBnicpiYC572jBksYgBAO0I8XIMXqZ1g3Wou3FlXg0KTDtAd8DZv/bTIf9b0svAj5ey3NlO+Lv0Uxlj7pJzOI4d76PzVkFB/uJXkilRLJVhbpkWUP1PYs+GoE6YRr4dWv1CiiXDEBegyppwnoCnZYwUeBFRoVXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511045; c=relaxed/simple;
	bh=ywAdslSkXEHiaEUo7CIvzAf02MCl08cuacNLclByGmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuYZSn9ea3P4HjOBT3zXwSf+eZufSbSo3KQgEgvBReyN2hc8CYqqYJ4oVmedLRe/vjtO/3RVTC1wvyBpotaX/96xE0u33CGiue/UKhURPAxQagPgk1hQjwb5qIqaXexf6PncFdLTNlUR2oT/xcI9UCu0P0gNa5Dryas8sVILjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3q32ixZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775511043; x=1807047043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ywAdslSkXEHiaEUo7CIvzAf02MCl08cuacNLclByGmQ=;
  b=V3q32ixZhpEptb1fWD/+Qk28pmSZSup5XX0FNtPdwZGWsk7lvClo/dxV
   hPswhnnqjEMEuAmlEDhLzDkQ6+lcB3yQUTN2x7bK47uh5KQ5io1bfBvU3
   fNiEhBjXGYJhFbaH0vZPBOgCg6IxGAajFC39O756BXPbqTUjFX5h3Ol/M
   hY8pqhG7Txqary2CTxc5BUt2+lhGXk5qNF09FRvsQsg1+ywmL+q4z+B4M
   xYo296i/+ZRODpnlBUxdjEpYL1WrlLoFaBvbNjjUoVdfcji4+hISTxZFm
   5aPAQH05pzuDJgcwGIGdmngLF5Hbo1N4SyzlePz4v18CSXzKAlLCMLWT7
   w==;
X-CSE-ConnectionGUID: pMWGgS3wQk+qG0mMRuo7xw==
X-CSE-MsgGUID: UQDP+Qy+SKq1TKQbJKIJQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79057374"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="79057374"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 14:30:41 -0700
X-CSE-ConnectionGUID: vEmb8VZ7TH2MUNfoAG61pA==
X-CSE-MsgGUID: 8eWtdGJnT/qeqtxWWChcqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="228248098"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 06 Apr 2026 14:30:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	sgzhang@google.com,
	stable@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 1/9] idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling
Date: Mon,  6 Apr 2026 14:30:28 -0700
Message-ID: <20260406213038.444732-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
References: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233444-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 245B53A78DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emil Tantilov <emil.s.tantilov@intel.com>

Switch from using the completion's raw spinlock to a local lock in the
idpf_vc_xn struct. The conversion is safe because complete/_all() are
called outside the lock and there is no reason to share the completion
lock in the current logic. This avoids invalid wait context reported by
the kernel due to the async handler taking BH spinlock:

[  805.726977] =============================
[  805.726991] [ BUG: Invalid wait context ]
[  805.727006] 7.0.0-rc2-net-devq-031026+ #28 Tainted: G S         OE
[  805.727026] -----------------------------
[  805.727038] kworker/u261:0/572 is trying to lock:
[  805.727051] ff190da6a8dbb6a0 (&vport_config->mac_filter_list_lock){+...}-{3:3}, at: idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
[  805.727099] other info that might help us debug this:
[  805.727111] context-{5:5}
[  805.727119] 3 locks held by kworker/u261:0/572:
[  805.727132]  #0: ff190da6db3e6148 ((wq_completion)idpf-0000:83:00.0-mbx){+.+.}-{0:0}, at: process_one_work+0x4b5/0x730
[  805.727163]  #1: ff3c6f0a6131fe50 ((work_completion)(&(&adapter->mbx_task)->work)){+.+.}-{0:0}, at: process_one_work+0x1e5/0x730
[  805.727191]  #2: ff190da765190020 (&x->wait#34){+.+.}-{2:2}, at: idpf_recv_mb_msg+0xc8/0x710 [idpf]
[  805.727218] stack backtrace:
...
[  805.727238] Workqueue: idpf-0000:83:00.0-mbx idpf_mbx_task [idpf]
[  805.727247] Call Trace:
[  805.727249]  <TASK>
[  805.727251]  dump_stack_lvl+0x77/0xb0
[  805.727259]  __lock_acquire+0xb3b/0x2290
[  805.727268]  ? __irq_work_queue_local+0x59/0x130
[  805.727275]  lock_acquire+0xc6/0x2f0
[  805.727277]  ? idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
[  805.727284]  ? _printk+0x5b/0x80
[  805.727290]  _raw_spin_lock_bh+0x38/0x50
[  805.727298]  ? idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
[  805.727303]  idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
[  805.727310]  idpf_recv_mb_msg+0x1c8/0x710 [idpf]
[  805.727317]  process_one_work+0x226/0x730
[  805.727322]  worker_thread+0x19e/0x340
[  805.727325]  ? __pfx_worker_thread+0x10/0x10
[  805.727328]  kthread+0xf4/0x130
[  805.727333]  ? __pfx_kthread+0x10/0x10
[  805.727336]  ret_from_fork+0x32c/0x410
[  805.727345]  ? __pfx_kthread+0x10/0x10
[  805.727347]  ret_from_fork_asm+0x1a/0x30
[  805.727354]  </TASK>

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Ray Zhang <sgzhang@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 14 +++++---------
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h |  5 +++--
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 113ecfc16dd7..582e0c8e9dc0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -287,26 +287,21 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter, struct idpf_ctlq_info *asq,
 	return err;
 }
 
-/* API for virtchnl "transaction" support ("xn" for short).
- *
- * We are reusing the completion lock to serialize the accesses to the
- * transaction state for simplicity, but it could be its own separate synchro
- * as well. For now, this API is only used from within a workqueue context;
- * raw_spin_lock() is enough.
- */
+/* API for virtchnl "transaction" support ("xn" for short). */
+
 /**
  * idpf_vc_xn_lock - Request exclusive access to vc transaction
  * @xn: struct idpf_vc_xn* to access
  */
 #define idpf_vc_xn_lock(xn)			\
-	raw_spin_lock(&(xn)->completed.wait.lock)
+	spin_lock(&(xn)->lock)
 
 /**
  * idpf_vc_xn_unlock - Release exclusive access to vc transaction
  * @xn: struct idpf_vc_xn* to access
  */
 #define idpf_vc_xn_unlock(xn)		\
-	raw_spin_unlock(&(xn)->completed.wait.lock)
+	spin_unlock(&(xn)->lock)
 
 /**
  * idpf_vc_xn_release_bufs - Release reference to reply buffer(s) and
@@ -338,6 +333,7 @@ static void idpf_vc_xn_init(struct idpf_vc_xn_manager *vcxn_mngr)
 		xn->state = IDPF_VC_XN_IDLE;
 		xn->idx = i;
 		idpf_vc_xn_release_bufs(xn);
+		spin_lock_init(&xn->lock);
 		init_completion(&xn->completed);
 	}
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index fe065911ad5a..6876e3ed9d1b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -42,8 +42,8 @@ typedef int (*async_vc_cb) (struct idpf_adapter *, struct idpf_vc_xn *,
  * struct idpf_vc_xn - Data structure representing virtchnl transactions
  * @completed: virtchnl event loop uses that to signal when a reply is
  *	       available, uses kernel completion API
- * @state: virtchnl event loop stores the data below, protected by the
- *	   completion's lock.
+ * @lock: protects the transaction state fields below
+ * @state: virtchnl event loop stores the data below, protected by @lock
  * @reply_sz: Original size of reply, may be > reply_buf.iov_len; it will be
  *	      truncated on its way to the receiver thread according to
  *	      reply_buf.iov_len.
@@ -58,6 +58,7 @@ typedef int (*async_vc_cb) (struct idpf_adapter *, struct idpf_vc_xn *,
  */
 struct idpf_vc_xn {
 	struct completion completed;
+	spinlock_t lock;
 	enum idpf_vc_xn_state state;
 	size_t reply_sz;
 	struct kvec reply;
-- 
2.47.1


