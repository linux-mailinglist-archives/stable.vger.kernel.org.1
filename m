Return-Path: <stable+bounces-233446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OKvOKkm1Gn5rgcAu9opvQ
	(envelope-from <stable+bounces-233446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 23:33:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9014D3A792B
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 23:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCEE230915F8
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53245397E7C;
	Mon,  6 Apr 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OT/ZHl+c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6238C2BE;
	Mon,  6 Apr 2026 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511049; cv=none; b=IdS/e2vbaRKJU/XR0cLP40kJVXNrXZ3A8hzAKM+GPAXKSUKmhV8j+xEU2Oe0qF1m0YYbUotpEzUq38pg0LWX9Sn9V/p7PZ3VDwQ6oXAdFfnZKF8CnkmGwBCCDNc/0niOdTzn4w/DbuvLc/r7xqJrCwc2E2y0/5asfy/AgIBX1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511049; c=relaxed/simple;
	bh=oiYwxhECjz3AIHcUgobFSs0e+AuAlRnHRi4XWl6bYz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFb8tf8Zs2totGaIRmgxMUg1l1g6LaApz1PeHk2EhVgEFTDNkP1Nvnjwf0xuNzDq0XpkhEyQDFM4Xrshqe8AGXXdyiMevJNcb6uzpZLSgYwJ0Kw4SG6RBaDdyqtg+xGmYUVwlM+kr8/lOogCSvav57r9n/wqQCrVfIijArtYX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OT/ZHl+c; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775511048; x=1807047048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oiYwxhECjz3AIHcUgobFSs0e+AuAlRnHRi4XWl6bYz0=;
  b=OT/ZHl+cw4Mt6zwwhysYL6tZ/LAMYzePe5mqLDR9gOPwkxql4cqGe64+
   YoKbWHwMeymxvM0JrMvDFrRzU08E6N5zAfuew+kjwuC8igCZo8s1ELZEo
   1S6S5vp9O00u3Lb0KkRByzaZSAC0HLkuAcFBcLN/JgioryBhSU6B9a79M
   4+Q/1QX1seZcKy8L8huOw0VuWBouz4lCBYnmtH0Lm0ziZMcb5ityjrPLx
   Atp6+c+blSHFdl+TwpEFX0juRY4yV/zUf1yMBY3yzL0CkNN8xKyTmo+Gu
   8KpshgrpyOxnGaONZ7UScTeFYyJc/Xdc0M6IbgXrS9xvWWJAt72mw2dS+
   w==;
X-CSE-ConnectionGUID: ZAAe3ZkmTmqccdtYBM092g==
X-CSE-MsgGUID: kS7Czz1aSCCSRtu4QYyaCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79057433"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="79057433"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 14:30:42 -0700
X-CSE-ConnectionGUID: 59RiAQ1ZS2CkLg09NEkGzQ==
X-CSE-MsgGUID: 7psJ9mzjQDyLh8OjTffVeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="228248123"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 06 Apr 2026 14:30:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alex Dvoretsky <advoretsky@gmail.com>,
	anthony.l.nguyen@intel.com,
	kurt@linutronix.de,
	sriram.yagnaraman@ericsson.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Patryk Holda <patryk.holda@intel.com>
Subject: [PATCH net 8/9] igb: remove napi_synchronize() in igb_down()
Date: Mon,  6 Apr 2026 14:30:35 -0700
Message-ID: <20260406213038.444732-9-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,linutronix.de,ericsson.com,kernel.org,iogearbox.net,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233446-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9014D3A792B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alex Dvoretsky <advoretsky@gmail.com>

When an AF_XDP zero-copy application terminates abruptly (e.g., kill -9),
the XSK buffer pool is destroyed but NAPI polling continues.
igb_clean_rx_irq_zc() repeatedly returns the full budget, preventing
napi_complete_done() from clearing NAPI_STATE_SCHED.

igb_down() calls napi_synchronize() before napi_disable() for each queue
vector. napi_synchronize() spins waiting for NAPI_STATE_SCHED to clear,
which never happens. igb_down() blocks indefinitely, the TX watchdog
fires, and the TX queue remains permanently stalled.

napi_disable() already handles this correctly: it sets NAPI_STATE_DISABLE.
After a full-budget poll, __napi_poll() checks napi_disable_pending(). If
set, it forces completion and clears NAPI_STATE_SCHED, breaking the loop
that napi_synchronize() cannot.

napi_synchronize() was added in commit 41f149a285da ("igb: Fix possible
panic caused by Rx traffic arrival while interface is down").
napi_disable() provides stronger guarantees: it prevents further
scheduling and waits for any active poll to exit.
Other Intel drivers (ixgbe, ice, i40e) use napi_disable() without a
preceding napi_synchronize() in their down paths.

Remove redundant napi_synchronize() call and reorder napi_disable()
before igb_set_queue_napi() so the queue-to-NAPI mapping is only
cleared after polling has fully stopped.

Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alex Dvoretsky <advoretsky@gmail.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ee99fd8fd513..ce91dda00ec0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2203,9 +2203,8 @@ void igb_down(struct igb_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
-			igb_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
+			igb_set_queue_napi(adapter, i, NULL);
 		}
 	}
 
-- 
2.47.1


