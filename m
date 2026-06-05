Return-Path: <stable+bounces-260601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8kIOHOonImr3TAEAu9opvQ
	(envelope-from <stable+bounces-260601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 03:35:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD8B644719
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 03:35:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MC7o1w2L;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260601-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260601-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 308AD313FA32
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 01:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A06E38F64F;
	Fri,  5 Jun 2026 01:17:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E5302146;
	Fri,  5 Jun 2026 01:17:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622235; cv=none; b=BEZmSSmLtCWYVJNy9zMoEIJ3sF9lOrbwFTTPG6o9azm62b3edYLc+P7Hg1vEN5dPLNUjtijcypsXSV5yEo6SVLHDq4uN39/l1yiKPllt84+RJLVG9OJdq1fMjG1++PdSPEopQMNPk2P2UIbPsvTIHTHUmEQNNK7HOoKNl+WQrOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622235; c=relaxed/simple;
	bh=1xqqepDK/sIzH2p5f3vcymeZZbvqnGrqr53wGsDaiTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E6RMOJszwMwmnjVtBAS0AIiLLZ5h2Z7dy82rKPWFWIegVcFqAn9dZTsQgNqxVbt7RT8JOm+xKJ59NJ/4/n+Jzctm++AAHglfYEX5FhSYP3FUjg94ywJ2cL4UXyyrjN60HfaOfZ/2XK3i06eicrNbO9RteV1R6GBLgjATQLuSQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MC7o1w2L; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780622228; x=1812158228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xqqepDK/sIzH2p5f3vcymeZZbvqnGrqr53wGsDaiTw=;
  b=MC7o1w2LOoEmFLBwf2vo0TDjMQ/LKm2P3pSZWWYzAycfac6k6jKchbGK
   vbFpno4XaMEzP5z7nWbqPqZ7ZXpvbaHtqu5Gz/3dZL4phxKM9eInYr8rp
   PJ4Bzd9d2BJUe0ONA+MOfK2tcODO6y26Lu3DG4s+eLheE+SnFcWxxfDxJ
   wxWBBtKGv3odGKLlg2Qq/Tun/ezLggo4yuHhT+EslbkH3+5CgZYiVM9Ks
   XFZptMZWmwss+nhet4eo64YG6P+X1HvHB4TNbisAW2pGg95ZX4NDrC+I+
   HTYqHMyQoFoaiDog05GE11Xa+7EGzmTZp8SvXYblOkqLJvpfKyO5pCOKr
   Q==;
X-CSE-ConnectionGUID: O4wxLnSkR++9yGB2LpItUw==
X-CSE-MsgGUID: kCMEcLvnSEi+RhFBeKSbbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91772201"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="91772201"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 18:17:08 -0700
X-CSE-ConnectionGUID: 3MFOZ9QzTWySCH9yKOVj0Q==
X-CSE-MsgGUID: B07lG1+ATQeREm96OaDDtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244817129"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2026 18:17:05 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/8] perf/x86/intel: Fix kernel address leakages in LBR stack
Date: Fri,  5 Jun 2026 09:11:33 +0800
Message-Id: <20260605011136.2043393-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-260601-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:alexander.shishkin@linux.intel.com,m:ak@linux.intel.com,m:eranian@google.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:dapeng1.mi@intel.com,m:zide.chen@intel.com,m:thomas.falcon@intel.com,m:xudong.hao@intel.com,m:dapeng1.mi@linux.intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email,intel.com:dkim,linux.intel.com:from_mime,linux.intel.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAD8B644719

Prior to the arch-LBR which supports CPL filtering, the kernel address
could be leaked to user space even PERF_SAMPLE_BRANCH_USER is required.

e.g., run below command on Intel Tigerlake platform,

```
$./perf record -e cycles:p -o - --branch-filter any,save_type,u -- \
 	./perf bench syscall basic --loop 1000 | \
	./perf script -i - --fields brstack|tr ' ' '\n'| \
	grep -E '0x[89a-f][0-9a-f]{15}'

    Total time: 0.000 [sec]

      0.219000 usecs/op
     4,566,210 ops/sec
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.551 MB - ]
0xffffffff93c001c8/0x7f12a2b1d647/P/-/-/16959/SYSRET/-
0xffffffff93c001c8/0x7f12a2b1d5c2/P/-/-/17535/SYSRET/-
0xffffffff93c01928/0x7f12a2861000/P/-/-/6719/ERET/-
0xffffffff93c01928/0x7f12a297a000/P/-/-/8575/ERET/-
```
The SYSRET/ERET branch calls are found the in the LBR stack, whose "from"
addresses are obviously kernel address.

Currently intel_pmu_lbr_filter() only filters out the LBR entries whose
"to" address is a kernel address but doesn't check the "from" address.

To fix the issue, extend the software filtering to both "from" and "to"
addresses.

Cc: stable@vger.kernel.org
Reported-by: Ian Rogers <irogers@google.com>
Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

Original patch link:
https://lore.kernel.org/all/20260414021440.928068-2-dapeng1.mi@linux.intel.com/

 arch/x86/events/intel/lbr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 16977e4c6f8a..deef81c16571 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1212,7 +1212,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 {
 	u64 from, to;
 	int br_sel = cpuc->br_sel;
-	int i, j, type, to_plm;
+	int i, j, type, to_plm, from_plm;
 	bool compress = false;
 
 	/* if sampling all branches, then nothing to filter */
@@ -1244,8 +1244,15 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 				type |= X86_BR_NO_TX;
 		}
 
-		/* if type does not correspond, then discard */
-		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
+		from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
+		/*
+		 * If type does not correspond, then discard.
+		 * Especially filter out the entries whose from or to address
+		 * is a kernel address while only X86_BR_USER is set. This prevents
+		 * kernel address from being leaked into a user-space-only LBR stack.
+		 */
+		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type ||
+		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
 			cpuc->lbr_entries[i].from = 0;
 			compress = true;
 		}
-- 
2.34.1


