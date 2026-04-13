Return-Path: <stable+bounces-237605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM2eG6Am3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:23:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D96A3F14DC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25001301CE56
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D7318ED2;
	Mon, 13 Apr 2026 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDA1nKx4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B4F32F765
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101021; cv=none; b=J2TgQKgaB48kizPLEgPUV2rXMV9byBLCGNteaTHoFqGATKK6uZCUTYuE/Qnt+gBeqpTxU19j2IyZzOJcrCbC51ZtEUHo2LUU4lAzt6vKrL70ffh+eOps2pIIEOclYrC38bpayn/dqQ+diWAek0VSqDhf6TLPGFqaH9NYtUru59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101021; c=relaxed/simple;
	bh=DcUwx5ui8uO0V3gB963hdowc16MCpAu4QmOm9zaUVWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOZYOneH+wqvpaBi2FEFRpAIqmptP8p9ySj+TQC/r8wO0MHl0X7z0Jjy4B+AlcMB9lh4hGIGd2+CGhWpzLK4nSPa7op6SxzZ6VXCThH2VDVQBi98+RvL+AfiQXsCtsVPeHa2cd8+4+khYME+rmUYeYRfDBEd2Dlft6A58ExcD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDA1nKx4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776101020; x=1807637020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DcUwx5ui8uO0V3gB963hdowc16MCpAu4QmOm9zaUVWo=;
  b=YDA1nKx4/TsgKmIZYGRSQpOaCA6F2AxSqLq97KqNYiGA4ouVlHl1r+97
   RhqPah56JcIr2rWcu993g0S1a5H7GczkIaGE4y5nm9ak6pd1tfXk+EDUX
   P+q7JD9Jsr+Mm6b7bzLjgXRC+Y97gqsgEvzhj5txFLGxH6qU8LSBoPSpN
   d8iTmebAH6UGKKYN1zIIVpXInFIjc4ebMHy9mOM+vjUFhzxtl03fWQ/4U
   i1P/DnENcGVkoMw48+SMui2GEumpOqlXdpipu3MTD+PGI4MXAUSI4oAKq
   pwF6yoLZMPoP4t3YYZwkggMsSjCzEjrudTS47g0Rk33+aGjT23OlVBtgV
   A==;
X-CSE-ConnectionGUID: HDbvkT6lT1CLWD2X2twUsg==
X-CSE-MsgGUID: cfCEd5cvR0utSOoGYcboWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="88426831"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="88426831"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 10:23:40 -0700
X-CSE-ConnectionGUID: 6sMKstqKQvW626LOIqc1UA==
X-CSE-MsgGUID: QXqDwy0UQyqK30RMPyslqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="231572066"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
  by fmviesa004.fm.intel.com with ESMTP; 13 Apr 2026 10:23:39 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: stable@vger.kernel.org
Cc: jacob.e.keller@intel.com,
	madhu.chittim@intel.com,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ray Zhang <sgzhang@google.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.12.y] idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling
Date: Mon, 13 Apr 2026 10:07:50 -0700
Message-Id: <20260413170750.59676-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <2026041354-trowel-buggy-c7ca@gregkh>
References: <2026041354-trowel-buggy-c7ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237605-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D96A3F14DC
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
(cherry picked from commit 591478118293c1bd628de330a99eb1eb2ef8d76b)
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3d80b53161a4..eeb4436ec2c9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -59,6 +59,7 @@ typedef int (*async_vc_cb) (struct idpf_adapter *, struct idpf_vc_xn *,
  */
 struct idpf_vc_xn {
 	struct completion completed;
+	spinlock_t lock;
 	enum idpf_vc_xn_state state;
 	size_t reply_sz;
 	struct kvec reply;
@@ -312,26 +313,21 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
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
@@ -363,6 +359,7 @@ static void idpf_vc_xn_init(struct idpf_vc_xn_manager *vcxn_mngr)
 		xn->state = IDPF_VC_XN_IDLE;
 		xn->idx = i;
 		idpf_vc_xn_release_bufs(xn);
+		spin_lock_init(&xn->lock);
 		init_completion(&xn->completed);
 	}
 
-- 
2.37.3


