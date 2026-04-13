Return-Path: <stable+bounces-235869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDdoJatB3GkzOgkAu9opvQ
	(envelope-from <stable+bounces-235869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:06:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4D93E68CD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 306B8300E5E1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 01:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DA1E32A2;
	Mon, 13 Apr 2026 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lH/H9Npj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60451D61A3;
	Mon, 13 Apr 2026 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776042404; cv=none; b=AETpkkodcTItdvwRJBnGG2HduCpkdGOeX43bojCZg3n0qjayX09i5U/w/EStt4hrSM0W9OPmVzhlmsgDNdpEU7Yrj3SAQ7sK/Ufni5HK/tthS+1ZBDkJsTqmHRSzJ0WsXxPc2BZw/6anq56rL1hvRoMxWskJoA9hPLq0gfKV/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776042404; c=relaxed/simple;
	bh=z27Wx9RbZKS6KhOhuDy83+bXUfRhgeIvAVCfUVH3OwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZD2ji5vEZCmsMn7sD9sPyaybrSueYfLvyRpnDI8/eU2wPDPAImTqW2/ROdeD+F9OTdrbJ0GN6cI5THYgtdUtV9nWKcy4CsTASL9y6xMdTSXvdEpQdgQ3zg5dNnuAUOLz1eEeMj3sgQo8aCP7kY0gfwyGjl9OYSUf/2Blq8K2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lH/H9Npj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776042403; x=1807578403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z27Wx9RbZKS6KhOhuDy83+bXUfRhgeIvAVCfUVH3OwY=;
  b=lH/H9NpjDfeBs7N1hUzHfzKkkegFgvM756hDzWp8s4uSyo1XrrEArCKR
   kcGEuS3hfpdfjzPIrjq3z0iOqh/XAKz9o8wyKfINTUOzTuG79cwi6pGbA
   RudWnBeGOQ8qghW8vcR8/DDCT8cL+XaLLsSZQwMdfeY/AQNgtR4gHgZvj
   J02ERbYgwLEX0Fm05cKB74i2lWflKkKu6W0ycQX1gSHuwbFJfkz7bz5l/
   jMO44CVR7SiiU3SSfvUS9TLBo++2bWYVGrve5JpQy69Xhp4nlgGWjGH37
   4/ZP+woWH5xUtbhNL3ig5GH/ttfqmywnF16C3ijgZm1I6am+BZp46+cfi
   g==;
X-CSE-ConnectionGUID: UqaszkbFQ/KkXoC7s8u1mQ==
X-CSE-MsgGUID: nYCdj5CnTBeIwJQu4TyRHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76933881"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="76933881"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 18:06:43 -0700
X-CSE-ConnectionGUID: tZy/QF7/Qqu8LondvLF2lg==
X-CSE-MsgGUID: jlTO72vWQgSI//KO/tSmow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="231366307"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 12 Apr 2026 18:06:39 -0700
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
Subject: [PATCH 1/2] perf/x86/intel: Clear stale ACR mask before updating new mask
Date: Mon, 13 Apr 2026 09:01:56 +0800
Message-Id: <20260413010157.535990-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413010157.535990-1-dapeng1.mi@linux.intel.com>
References: <20260413010157.535990-1-dapeng1.mi@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235869-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 0E4D93E68CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current implementation forgets to clear the ACR mask before applying
a new one. During event rescheduling, this allow bits from a previous
stale ACR mask to persist, leading to an incorrect hardware state.

Ensure that the ACR mask is zeroed out before setting the new mask to
prevent state pollution.

Cc: stable@vger.kernel.org
Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4768236c054b..58c236ce4747 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3344,6 +3344,9 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
 			event = cpuc->event_list[j];
 			if (event->group_leader != leader->group_leader)
 				break;
+
+			/* Clear stale ACR mask first. */
+			event->hw.config1 = 0;
 			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
 				if (i + idx >= cpuc->n_events ||
 				    !is_acr_event_group(cpuc->event_list[i + idx]))
-- 
2.34.1


