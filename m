Return-Path: <stable+bounces-227384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D+oMUxnvGnQyAIAu9opvQ
	(envelope-from <stable+bounces-227384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:14:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC42D2951
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FCA23081809
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A7402B83;
	Thu, 19 Mar 2026 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rhd24Mf0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F7402427;
	Thu, 19 Mar 2026 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954852; cv=none; b=eWPHgsjdCKIuksKVDdlWRwzaSSwHixtYXIkwIdeiBNBfPS8NZ9bNnrqAEpmDCRjYLQhYFk+kutE6rZfEHN/xsGML1vol0ptiO1BrRWPwFpbIKO6COpMOnoAXm62HNUwk5/CvToqbrp4Z+mVW2ZzOjpAJtoDrD9ABmMc/737A988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954852; c=relaxed/simple;
	bh=mRP95+w+fhUk8Uwl9cU7Js17s7tnPpW9z6YR7cq7YPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tZ4GAb0cCGDUq+Tzmcg283kqS4480uoEeKUGPvzAaY5VPdhUG40WMxfmZhoy6ph2/fepX0T0vlJ/i5Hnu4nn06tx7CuZg/D6KWXXGL32CQKbAuAtnqisK52qSMG4gBq8FTA+v5n/rN8ijijLiTyF/6sbYqnCai08+fl/itFY5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rhd24Mf0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773954846; x=1805490846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mRP95+w+fhUk8Uwl9cU7Js17s7tnPpW9z6YR7cq7YPA=;
  b=Rhd24Mf0GHONvNKKgGlrmvVLKu+znSMUjJxZwgbd45BJRbyyxPl3voAP
   1p9hui54FkrYAVpf7760aE9+N3KJ0yrt58SQzKekio+/Q9B+n0iWO4utJ
   +cxPVISKGDXJ+cE8uDXztZRfbIihoo2WFFzyPYkKgk9KCn/2DXZoM62o8
   n7MfPeHqr8A33aQL+HxV3HDFHtfbSYQUn1w4PWcAMMj/F/spq9av3uAhN
   eTJps4nWzpxdRzO6R7w5PWdTsgoTDLfvatUbQ7zyna13pwThUH887RWy+
   PDvXhk06jHTeI8idl/bRBh9NB/jaPpxYtyXUZNEqZV5ZkS06alzWzRjES
   g==;
X-CSE-ConnectionGUID: 85pFbo7xQT6njDlbt8Yxmw==
X-CSE-MsgGUID: fshrUCPjS4iL+SWxe4AGUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86116366"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86116366"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:14:03 -0700
X-CSE-ConnectionGUID: Wxz5GlsfQkCc7Fz6/QQ1Vw==
X-CSE-MsgGUID: axzZsgLrS6uLUFO4Jvthyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227221172"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 14:14:02 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	sgzhang@google.com,
	boolli@google.com,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2 1/3] idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling
Date: Thu, 19 Mar 2026 14:13:33 -0700
Message-Id: <20260319211335.23236-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260319211335.23236-1-emil.s.tantilov@intel.com>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227384-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.965];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 2EAC42D2951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.37.3


