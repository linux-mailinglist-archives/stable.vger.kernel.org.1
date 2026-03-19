Return-Path: <stable+bounces-227383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EYbMEJnvGkByQIAu9opvQ
	(envelope-from <stable+bounces-227383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:14:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC952D2942
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55204301B70F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 21:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D3240244F;
	Thu, 19 Mar 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdY4y6oo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05C402448;
	Thu, 19 Mar 2026 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954850; cv=none; b=kR1PjXL0BGCFjaAOY/goEpMY95vBbtw1q4md8gSql1YoFvcCCZoYVxkobSnu4k5T4hCQB6IrmDcLDX8u/uwj7kqLYNulDoaJgaDbDdsv63LYsWlVuOCpiuqI0TtC0r7U22El4vIVK0hZ46seVzt1wq0P4nWf+joLoZ7YhwShV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954850; c=relaxed/simple;
	bh=oRpzbw8xGxDnBQtkUrD1pw82znTvjifsBtJ+zx1wwAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=B4PVpMVtaVZ+tOSusoyF+eUOsMPVLJ+xSaWLtrN1nes36QdHPV6U7noIQavgNLVDxxWyxRxjNtSZq3UvoS0bK3NzSQSrMeLcTkRz3H2PCrraPJD+8G/wTQqnDTGj06+mxxTmVaJ/iUANtPe+IwitaOfaORfkWybN2ovMYLaQy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdY4y6oo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773954847; x=1805490847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oRpzbw8xGxDnBQtkUrD1pw82znTvjifsBtJ+zx1wwAI=;
  b=CdY4y6oov8Sw94G8H+xPb0j25wMdf6T38/B8JtqKMlKflOGxwZMHRAMc
   JwW16p8QSzTRcedALGx819Hbm7SbU8BhWWhtmWpHt30L4NrSyGSN3ffmZ
   OnWhzi/3okrpuUYkoW5ptdqN9nbwfrLFhMY8JyLBAOwCQjoqRebDDVM2B
   nQHEVKypLg4GauByZdu5eD7/38YGa9KzUUwuTAS1t+bn041abKkr+1Fo5
   tgGIJgpMkSDFWkt98vWnZ2ZuC2Y518jqjGu7gZDBsKp6voH86V5PIckTI
   y9m9mJfhby94iwHM1IehUpsTClQcVOGRucb9K2a7wFv/h11bmlIULQzQJ
   Q==;
X-CSE-ConnectionGUID: WIHfQe+tTCCtcL7Y8j0oww==
X-CSE-MsgGUID: jMTHGaBERqKr8hxFt3hMdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86116382"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86116382"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:14:03 -0700
X-CSE-ConnectionGUID: REe93wI8QfGVVyM1f/5zkA==
X-CSE-MsgGUID: JCzPACKwTgKixmtbe025Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227221175"
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
Subject: [PATCH iwl-net v2 2/3] idpf: improve locking around idpf_vc_xn_push_free()
Date: Thu, 19 Mar 2026 14:13:34 -0700
Message-Id: <20260319211335.23236-3-emil.s.tantilov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227383-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.969];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EC952D2942
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Protect the set_bit() operation for the free_xn bitmask in
idpf_vc_xn_push_free(), to make the locking consistent with rest of the
code and avoid potential races in that logic.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org
Reported-by: Ray Zhang <sgzhang@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 582e0c8e9dc0..fbd5a15b015c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -402,7 +402,9 @@ static void idpf_vc_xn_push_free(struct idpf_vc_xn_manager *vcxn_mngr,
 				 struct idpf_vc_xn *xn)
 {
 	idpf_vc_xn_release_bufs(xn);
+	spin_lock_bh(&vcxn_mngr->xn_bm_lock);
 	set_bit(xn->idx, vcxn_mngr->free_xn_bm);
+	spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
 }
 
 /**
-- 
2.37.3


