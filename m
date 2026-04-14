Return-Path: <stable+bounces-237703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ1mKqak3Wl8hAkAu9opvQ
	(envelope-from <stable+bounces-237703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:21:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159ED3F4FB3
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA56130479FB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68929C33F;
	Tue, 14 Apr 2026 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUAZxUFU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602E270545;
	Tue, 14 Apr 2026 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133161; cv=none; b=WHnUNQYNDXA688JRF6OSEn3dOkoLwE4VnDX3H6qgQxS2I13ABdr+dVw7psCIbxaIDIgVefZOJ8dEOVThAGb1aXjufN87DWTLexU23E59cZ7RgNti0B1ZrXmYkPm4XClKBGLpiFVdEmEHdlFXphQbznoM05zTyBNUzDB9okAJ6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133161; c=relaxed/simple;
	bh=v2yxuQUctm7ww5INPMeCkQAa9+Zrg7dtiJ6rvDxXvw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQP5FBueWuqtjJhIb2KmKnvaStv9p8+R2Xg84xIME5W9RTEVho+ytRfJmAPr0RX2QVQusbEcwrq/2oVV8B7KYMf32mquToBQVmyhmZz95xO0w+98Vd0jg9uYNfHSCBKi0oR1v3nTKBh7ifjKjd4A7n1JdBK6wcD1TQD5FmMAuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUAZxUFU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776133160; x=1807669160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v2yxuQUctm7ww5INPMeCkQAa9+Zrg7dtiJ6rvDxXvw4=;
  b=dUAZxUFUJNuftqnAUljXMGEqo6c3OlZpb/ifqjV85uGRd0Ic5RlasU7A
   bn4NKzHGkrZEThN7W8ZRja964A7W4XZst+WrHdUxZYL1WUx19WcR9275O
   m4oa1BxhrGfCEHF4YUnl8dkG3+pFT0J9FflyiS83MxGSb9jo/RWf1rSdz
   Cbo4SO4vgxvG3TT/NI/UxTxDeKrw8yBfq6kYZMmhnt/VB7nVDKLwgEmF5
   b+K0ejOK9yFFqDLT/kLXWNjuQ9gg3JPOt09dzuk1Uh5ns/aU+7LAaWtFt
   0W05iVZkAmR38cM1/ZbPwRYy5PDFqw7rO7Ubzb8NjR+flkLjC+y0lqU/+
   w==;
X-CSE-ConnectionGUID: VYu39KgJSAuKS6svP+5BCw==
X-CSE-MsgGUID: G2FbZQjASDyFl5WEEu7HhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76245468"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="76245468"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 19:19:19 -0700
X-CSE-ConnectionGUID: Aev3IrTIQXq0HU2BUkf0dA==
X-CSE-MsgGUID: WYUhOcA9RtygMIxEflZ91g==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 13 Apr 2026 19:19:15 -0700
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
Subject: [PATCH 1/2] perf/x86/intel: Fix redundant branch type check in intel_pmu_lbr_filter()
Date: Tue, 14 Apr 2026 10:14:39 +0800
Message-Id: <20260414021440.928068-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237703-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 159ED3F4FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In intel_pmu_lbr_filter(), the 'type' variable is bitwise ORed with
'to_plm' (which contains X86_BR_USER and/or X86_BR_KERNEL bits). Because
of this, 'type' can never equal X86_BR_NONE (0) after the assignment.

As a result, the subsequent check 'if (type == X86_BR_NONE)' is dead code
and the entries with X86_BR_NONE type would not be skipped eventually.

Correct this by masking out the X86_BR_KERNEL and X86_BR_USER bits
before performing the X86_BR_NONE comparison.

Cc: stable@vger.kernel.org
Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 72f2adcda7c6..16977e4c6f8a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1245,7 +1245,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		}
 
 		/* if type does not correspond, then discard */
-		if (type == X86_BR_NONE || (br_sel & type) != type) {
+		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
 			cpuc->lbr_entries[i].from = 0;
 			compress = true;
 		}
-- 
2.34.1


