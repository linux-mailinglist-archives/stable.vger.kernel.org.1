Return-Path: <stable+bounces-220101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI+QBZIoo2k++AQAu9opvQ
	(envelope-from <stable+bounces-220101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDA91C503B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 388F5308BECD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923547B413;
	Sat, 28 Feb 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4Y56Ajc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F046AEF1;
	Sat, 28 Feb 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300007; cv=none; b=OoyUTvYevpBUJ4KWCmwkw5X/4gj4DJm6v43WvEjubuZottYfObfXljG4WFhzqT8KS2d/FYxPtbxMHClkZaZDiTIi6ov5KNxn3xylxnifcasvCdMJL5HM8MPdGbyZ8fhkhGonJ1/BhbmXbSkLBJ9aSjxlHO66CrOcHxjDH6goU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300007; c=relaxed/simple;
	bh=5DLthrwaQ4P8bCT3/l3haLmoSWFTHHexrJJVVVyJFYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y96rw9RKfa4TiH6vG+kplc0nUV3Di7CMJWJF1NMpOtqWLFrm5xKNnZURfEfeJ4gkID7VaBAw2ehjLvo9ObtH7ZsxYttcLfpS1tcsuwK5uSAcLsepUI3kVhFbZt0BPWHHr1criqAvoPFY/BUET/2IaK+uaUl1a+VEYS0LMGYm/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4Y56Ajc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9476C19423;
	Sat, 28 Feb 2026 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300007;
	bh=5DLthrwaQ4P8bCT3/l3haLmoSWFTHHexrJJVVVyJFYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4Y56AjckbpHTsvZ651IA1MDdRUUhMZ8mw+YX23J7cQreEXxPfO4yLIfV2dacLqjj
	 +65QfSUQTWauvXomaCqcqT1Qa1pdFjbsw4uTSSv7WYr8+KehbWQohZwecfbL/ZTFEG
	 INBJepPP8M7POQvxph+3kJqUhZUNV50ePDs9/XXvOumNSvigONXBtmRUd5aXSope9A
	 tBiKKUHoZnle3g3une4UuX4VymxmQB0GrXhbzzZu11s3EHmwwGx+IFON73YVTkohXH
	 ym8bO9mxcxEOJkMvjEsX3FlzwY9tUR78sKeYFwFktvrKThG1j6GXskUJV9iyLgUeu3
	 mTQ4c3NWmQ/7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>,
	Suyash Mahar <smahar@meta.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 023/844] perf vendor events amd: Fix Zen 5 MAB allocation events
Date: Sat, 28 Feb 2026 12:18:56 -0500
Message-ID: <20260228173244.1509663-24-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220101-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 2DDA91C503B
X-Rspamd-Action: no action

From: Sandipan Das <sandipan.das@amd.com>

[ Upstream commit 76b2cf07a6d2a836108f9c2486d76599f7adf6e8 ]

The unit masks for PMCx041 vary across different generations of Zen
processors.

Fix the Zen 5 events based on PMCx041 as they incorrectly use the same
unit masks as that of Zen 4.

Fixes: 45c072f2537ab07b ("perf vendor events amd: Add Zen 5 core events")
Reported-by: Suyash Mahar <smahar@meta.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ananth Narayan <ananth.narayan@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
index ff6627a778057..06bbaea159259 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
@@ -70,19 +70,19 @@
     "EventName": "ls_mab_alloc.load_store_allocations",
     "EventCode": "0x41",
     "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for load-store allocations.",
-    "UMask": "0x3f"
+    "UMask": "0x07"
   },
   {
     "EventName": "ls_mab_alloc.hardware_prefetcher_allocations",
     "EventCode": "0x41",
     "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for hardware prefetcher allocations.",
-    "UMask": "0x40"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_mab_alloc.all_allocations",
     "EventCode": "0x41",
     "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for all types of allocations.",
-    "UMask": "0x7f"
+    "UMask": "0x0f"
   },
   {
     "EventName": "ls_dmnd_fills_from_sys.local_l2",
-- 
2.51.0


