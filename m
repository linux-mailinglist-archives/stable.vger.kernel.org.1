Return-Path: <stable+bounces-262180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QLBDBkegJ2pOzwIAu9opvQ
	(envelope-from <stable+bounces-262180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 07:10:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A3365C5C8
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 07:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Fd0TkFSY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262180-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262180-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA73F305A8A1
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 05:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC1367B65;
	Tue,  9 Jun 2026 05:08:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFC932470F;
	Tue,  9 Jun 2026 05:08:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981682; cv=none; b=GtbvmSOq34bxEUTLIZvxUEMjVErpJ8ZGrglUgbEmQpa+g3J33zulK7u0e86qbleqyHRvlTRoJcMS3rBuIzW1bYCZCiCOPY8fRHd9QZGB/WPAgIyIbIcU5t2sbBkDsA/bgkg7CEvWHxB8VATC3IQUF01/2IiHelubmCT5sx3EEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981682; c=relaxed/simple;
	bh=ajgOVuxyFbWnbkUlyWDn1u4u8MKM+Bqb6tp1Z9tZLG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4AwyigF0AlmSY5lAg/sAeO1AoEQuVHkJMbNthMzjiWNY/2b1+V4tpZ+GrKYMnAaiROiI0afdgh1HJh+TV1ob2SZq9YQQMd/1pfUCcSiy1Xcgm3oKBPQWPNkIOt/pz2msrSXnNNoIzB0qDbHVIkuT8w1nTAi1RRfBdRTpBGPznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fd0TkFSY; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981682; x=1812517682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ajgOVuxyFbWnbkUlyWDn1u4u8MKM+Bqb6tp1Z9tZLG0=;
  b=Fd0TkFSYS94KaoIbxQEuCFvlZEeMlluvaw/BSKYS6I3kMQSwWVSLOMee
   35VU2QfoJ1u4vIXY93Jf6SRCiWMpcaAWd23mMJYITVZOeYBvDlOX+W4kD
   fqM4TzAh07XQ7gC6roclN5NcavaSCQGIKb0heNHuXRygt3guPN5ja19ds
   PToVf6tR0f8PdbJy4kFC075gDumR73FfIyWGyKdBNWi6owMx1Ij5y6uvM
   6ix9q+GIPG8SR4c1ZzJUUMZMgAtv4pVA8Fhh9qyzc1B0gKOjGn29GSret
   ZAXn+tdQHQwkKkdhybF0Art3HIv5tYHMFFRnBlTFXCeaRqCUJ3IOvEPbv
   w==;
X-CSE-ConnectionGUID: ztAZ2SnbQbaPQ8WkGc68Vg==
X-CSE-MsgGUID: 3la+Nc5kSZWQ2/iqOyJdPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81586176"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81586176"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:08:01 -0700
X-CSE-ConnectionGUID: cPDE1IBiRKC3VVajP3YVtw==
X-CSE-MsgGUID: yruJnsmYSACVuCPhkepTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283838915"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 22:07:57 -0700
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
Subject: [Patch v2 5/9] perf/x86/intel: Drop LBR entries whose privilege level mismatches br_sel
Date: Tue,  9 Jun 2026 13:02:18 +0800
Message-Id: <20260609050222.2458129-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-262180-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:alexander.shishkin@linux.intel.com,m:ak@linux.intel.com,m:eranian@google.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:dapeng1.mi@intel.com,m:zide.chen@intel.com,m:thomas.falcon@intel.com,m:xudong.hao@intel.com,m:dapeng1.mi@linux.intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74A3365C5C8

Before Arch LBR gained CPL filtering support, a user-only branch stack
could still contain kernel addresses. As a result, kernel branch records
may be exposed to user space even when PERF_SAMPLE_BRANCH_USER is
requested.

For example, on Intel Tiger Lake, the following command can still report
SYSRET/ERET entries with kernel-space from addresses:

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

The problem is that intel_pmu_lbr_filter() does not fully validate the
privilege level of sampled entries. It filters some mismatches based on
the branch type and the to address, but it does not reject entries whose
from address violates the requested branch privilege filter.

Fix this by extending software filtering to validate both from and to
addresses against br_sel. Any LBR entry whose privilege level does not
match the requested user/kernel filter is dropped. This prevents kernel
addresses from appearing in user-only branch stacks, and likewise drops
user entries from kernel-only stacks.

Cc: stable@vger.kernel.org
Reported-by: Ian Rogers <irogers@google.com>
Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index d4c0ed85e1fb..807ce903c972 100644
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
@@ -1245,8 +1245,16 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 				type |= X86_BR_NO_TX;
 		}
 
-		/* if type does not correspond, then discard */
-		if (type == X86_BR_NONE || (br_sel & type) != type) {
+		from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
+		/*
+		 * If type does not correspond, then discard.
+		 * Especially filter out the entries whose from or to address is
+		 * a kernel address while only X86_BR_USER is set. This prevents
+		 * kernel address from being leaked into a user-space-only LBR stack.
+		 */
+		if (type == X86_BR_NONE || (br_sel & type) != type ||
+		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL)) ||
+		    (!(br_sel & X86_BR_USER) && (from_plm & X86_BR_USER))) {
 			cpuc->lbr_entries[i].from = 0;
 			compress = true;
 		}
-- 
2.34.1


