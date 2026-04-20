Return-Path: <stable+bounces-238681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBloDYuU5WnrlgEAu9opvQ
	(envelope-from <stable+bounces-238681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 04:50:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B41A42669D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 04:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4753025913
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E723037F729;
	Mon, 20 Apr 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFrs9ygn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC937EFEE;
	Mon, 20 Apr 2026 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653413; cv=none; b=DwAaRvlX6O1hUdEpGDvpP9/dc1Z3YhxbJ7bhTVnjAqUMnemxPSrwAdf7bIvyHUgh8kmoZAedaPsNjDA9u7CTrLDReXCID4muYINj76x5ZDZxG0Yov4aRI/tm2+VF/GPBzvtvXeV4T5U3vlNI1BXOcZCc1kMBZH9+Cn1C5XYaaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653413; c=relaxed/simple;
	bh=Qkh5yZr3vefHZXHn+qNZLM8IegPI8fk/2+sfH3oU/uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBMKhTb8URBrE8/0LwNhVkC2dj0bCIRxVIbfx0cSBO5htgSzS70MZFIzYihcE0RxPuNvawZn4A3Errbgj5jeTxZnB0PQr8ppDX4jPzdTPdfSUikauGQ4GjRnYSk31MTzFjV505r+KPpDY1dD93pFS+20DBufRDBXoamtF01AjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFrs9ygn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776653413; x=1808189413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qkh5yZr3vefHZXHn+qNZLM8IegPI8fk/2+sfH3oU/uo=;
  b=AFrs9ygnHcNjonH4Rh8bGOejEYUyDuxUSs9nHSYGA1qN7tCPMLuxeGWD
   52p55w7fXpjg4/wMQaKrWxChUbb59pPBc8G4Ntbjjaus00IkOW3ZmhLi+
   Ng08dJ3YvhhXJNmV8Qb/pl9uG6bu5M9YoucOCk1WRhkC8zIz5GboPc49q
   OL1C+WCnLSTpO4u9QrpRVvXuKnZsy2gdflj27RWvLMXnfH3SHUgu+to8I
   emhHcYu2yZX/SjkiwtfMGe9Gpq+iEfv/Dwqf0XRo+CogqRZNfHRhV+zHo
   +JiJHejK7ZkTHyGS6OY/Pwh0F5RGMpeXu+/pvUumpGm7OPrd600TC3eUa
   g==;
X-CSE-ConnectionGUID: nYQa5f5VTGuK91+bDVP1tA==
X-CSE-MsgGUID: 8Lhl3ABfRyO5zDXbppZQBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81442156"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="81442156"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 19:50:12 -0700
X-CSE-ConnectionGUID: c0aCffKXQUGhrTfroEsWBA==
X-CSE-MsgGUID: 31K6dTS8Tom1MiZriN7NOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="228908001"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 19 Apr 2026 19:50:08 -0700
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
Subject: [Patch v2 1/4] perf/x86/intel: Clear stale ACR mask before updating new mask
Date: Mon, 20 Apr 2026 10:45:25 +0800
Message-Id: <20260420024528.2130065-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
References: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-238681-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 9B41A42669D
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

V2: Clear stale acr_mask for all events.

 arch/x86/events/intel/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4768236c054b..774ae9a4eeaf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3334,6 +3334,12 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
 	struct perf_event *event, *leader;
 	int i, j, idx;
 
+	/* Clear stale ACR mask first. */
+	for (i = 0; i < cpuc->n_events; i++) {
+		event = cpuc->event_list[i];
+		event->hw.config1 = 0;
+	}
+
 	for (i = 0; i < cpuc->n_events; i++) {
 		leader = cpuc->event_list[i];
 		if (!is_acr_event_group(leader))
-- 
2.34.1


