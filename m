Return-Path: <stable+bounces-79014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A3298D619
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994BF1C2221D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9F61D0429;
	Wed,  2 Oct 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wLZIVFBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982431CDFBC;
	Wed,  2 Oct 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876188; cv=none; b=nOmfcUC1d4IVArQH0ukWEiWWkjdW2jepYvtHVxzrlm1RcjWyYcW1EIcoCbZzQm1Q17tY/YHL1S5yQfW1Ul9o01ZTsWtxuemMref4UfRPyckvJ84ngsapEA1PtcKdGNFzpZmkIKNyCKE4E16oiYTUiF7MgexYaMNPGXp8M76CtV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876188; c=relaxed/simple;
	bh=K2DYM3nSItWeJWQqIC0GSZcLrlOjKtgbBohwKYkhDNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mj4FNgJEEscG8m/aM6Bi3EP4Bd98Y6hXL717Xz9xil+SSccKE5cGJyyi7WjwOhzxx8ZCmN+vvsVNCpr6C7X/LKmgDdPo0xn6XTwX7gdtd7q24/fYNMuyDp6uHFSYv1w74zESaOhC7MpjpKaXYgIo2/b48TqMa7u0Jvbuhe+NI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wLZIVFBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4765C4CECD;
	Wed,  2 Oct 2024 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876188;
	bh=K2DYM3nSItWeJWQqIC0GSZcLrlOjKtgbBohwKYkhDNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wLZIVFBHpO/8yAP2C9vFqasSsRFQD0VLBPvxMJenD+rprjJFd8DOrcUp4tJpxwdWq
	 WoVai27n75Vwqfz7XD48LYeaSpFh5ex+Hg9wpXMkedAk1KjGCgIIizxsqTL/nRXmKO
	 ZtIwiMxX0oUpXO2lYz0X34+JowN3+E4y10YoT0SM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Song Liu <song@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Weilin Wang <weilin.wang@intel.com>
Subject: [PATCH 6.11 328/695] perf vendor events: SKX, CLX, SNR uncore cache event fixes
Date: Wed,  2 Oct 2024 14:55:26 +0200
Message-ID: <20241002125835.541340890@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 7a75c6c23a2ea8dd22d90805b3a42bd65c53830e ]

Cache home agent (CHA) events were setting the low rather than high
config1 bits. SNR was using CLX CHA events, however its CHA is similar
to ICX so remove the events.

Incorporate the updates in:

  https://github.com/intel/perfmon/pull/215
  https://github.com/intel/perfmon/pull/216

Fixes: 4cc49942444e958b ("perf vendor events: Update cascadelakex events/metrics")
Closes: https://lore.kernel.org/linux-perf-users/CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com/
Reported-by: Song Liu <song@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240811042004.421869-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arch/x86/cascadelakex/uncore-cache.json   | 60 +++++++++----------
 .../arch/x86/skylakex/uncore-cache.json       | 60 +++++++++----------
 .../arch/x86/snowridgex/uncore-cache.json     | 57 ------------------
 3 files changed, 60 insertions(+), 117 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
index c9596e18ec090..6347eba488105 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
@@ -4577,7 +4577,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
-        "Filter": "config1=0x40233",
+        "Filter": "config1=0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4588,7 +4588,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
-        "Filter": "config1=0x40433",
+        "Filter": "config1=0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4599,7 +4599,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=0x4b233",
+        "Filter": "config1=0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4609,7 +4609,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=0x4b433",
+        "Filter": "config1=0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4619,7 +4619,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=0x4b033",
+        "Filter": "config1=0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores that hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4630,7 +4630,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4651,7 +4651,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
-        "Filter": "config1=0x40233",
+        "Filter": "config1=0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4662,7 +4662,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
-        "Filter": "config1=0x40433",
+        "Filter": "config1=0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4673,7 +4673,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=0x4b233",
+        "Filter": "config1=0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4683,7 +4683,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=0x4b433",
+        "Filter": "config1=0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4693,7 +4693,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=0x4b033",
+        "Filter": "config1=0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores that missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4704,7 +4704,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4747,7 +4747,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=0x49033",
+        "Filter": "config1=0x4903300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO ItoM requests that miss the LLC. An ItoM request is used by IIO to request a data write without first reading the data for ownership.",
         "UMask": "0x24",
@@ -4759,7 +4759,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=0x43C33",
+        "Filter": "config1=0x43c3300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO RdCur requests and miss the LLC. A RdCur request is used by IIO to read data without changing state.",
         "UMask": "0x24",
@@ -4771,7 +4771,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO RFO requests that miss the LLC. A read for ownership (RFO) requests a cache line to be cached in E state with the intent to modify.",
         "UMask": "0x24",
@@ -4999,7 +4999,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
-        "Filter": "config1=0x40233",
+        "Filter": "config1=0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -5010,7 +5010,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
-        "Filter": "config1=0x40433",
+        "Filter": "config1=0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -5021,7 +5021,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=0x4b233",
+        "Filter": "config1=0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -5031,7 +5031,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=0x4b433",
+        "Filter": "config1=0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -5041,7 +5041,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=0x4b033",
+        "Filter": "config1=0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Cores that hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -5052,7 +5052,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -5073,7 +5073,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
-        "Filter": "config1=0x40233",
+        "Filter": "config1=0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5084,7 +5084,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
-        "Filter": "config1=0x40433",
+        "Filter": "config1=0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5095,7 +5095,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=0x4b233",
+        "Filter": "config1=0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -5105,7 +5105,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=0x4b433",
+        "Filter": "config1=0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -5115,7 +5115,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=0x4b033",
+        "Filter": "config1=0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Cores that missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5126,7 +5126,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5171,7 +5171,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=0x49033",
+        "Filter": "config1=0x4903300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO ItoM requests that miss the LLC. An ItoM is used by IIO to request a data write without first reading the data for ownership.",
         "UMask": "0x24",
@@ -5183,7 +5183,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=0x43C33",
+        "Filter": "config1=0x43c3300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO RdCur requests that miss the LLC. A RdCur request is used by IIO to read data without changing state.",
         "UMask": "0x24",
@@ -5195,7 +5195,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO RFO requests that miss the LLC. A read for ownership (RFO) requests data to be cached in E state with the intent to modify.",
         "UMask": "0x24",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
index da46a3aeb58c7..4fc8186264912 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
@@ -4454,7 +4454,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
-        "Filter": "config1=0x40233",
+        "Filter": "config1=0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4465,7 +4465,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
-        "Filter": "config1=0x40433",
+        "Filter": "config1=0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4476,7 +4476,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=0x4b233",
+        "Filter": "config1=0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4486,7 +4486,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=0x4b433",
+        "Filter": "config1=0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4496,7 +4496,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=0x4b033",
+        "Filter": "config1=0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores that hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4507,7 +4507,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4528,7 +4528,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
-        "Filter": "config1=0x40233",
+        "Filter": "config1=0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4539,7 +4539,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
-        "Filter": "config1=0x40433",
+        "Filter": "config1=0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4550,7 +4550,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=0x4b233",
+        "Filter": "config1=0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4560,7 +4560,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=0x4b433",
+        "Filter": "config1=0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4570,7 +4570,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=0x4b033",
+        "Filter": "config1=0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores that missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4581,7 +4581,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4624,7 +4624,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=0x49033",
+        "Filter": "config1=0x4903300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO ItoM requests that miss the LLC. An ItoM request is used by IIO to request a data write without first reading the data for ownership.",
         "UMask": "0x24",
@@ -4636,7 +4636,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=0x43C33",
+        "Filter": "config1=0x43c3300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO RdCur requests and miss the LLC. A RdCur request is used by IIO to read data without changing state.",
         "UMask": "0x24",
@@ -4648,7 +4648,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO RFO requests that miss the LLC. A read for ownership (RFO) requests a cache line to be cached in E state with the intent to modify.",
         "UMask": "0x24",
@@ -4865,7 +4865,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
-        "Filter": "config1=0x40233",
+        "Filter": "config1=0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4876,7 +4876,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
-        "Filter": "config1=0x40433",
+        "Filter": "config1=0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4887,7 +4887,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=0x4b233",
+        "Filter": "config1=0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4897,7 +4897,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=0x4b433",
+        "Filter": "config1=0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4907,7 +4907,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=0x4b033",
+        "Filter": "config1=0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Cores that hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4918,7 +4918,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4939,7 +4939,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
-        "Filter": "config1=0x40233",
+        "Filter": "config1=0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4950,7 +4950,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
-        "Filter": "config1=0x40433",
+        "Filter": "config1=0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4961,7 +4961,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=0x4b233",
+        "Filter": "config1=0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4971,7 +4971,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=0x4b433",
+        "Filter": "config1=0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4981,7 +4981,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=0x4b033",
+        "Filter": "config1=0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Cores that missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4992,7 +4992,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5037,7 +5037,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=0x49033",
+        "Filter": "config1=0x4903300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO ItoM requests that miss the LLC. An ItoM is used by IIO to request a data write without first reading the data for ownership.",
         "UMask": "0x24",
@@ -5049,7 +5049,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=0x43C33",
+        "Filter": "config1=0x43c3300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO RdCur requests that miss the LLC. A RdCur request is used by IIO to read data without changing state.",
         "UMask": "0x24",
@@ -5061,7 +5061,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=0x40033",
+        "Filter": "config1=0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO RFO requests that miss the LLC. A read for ownership (RFO) requests data to be cached in E state with the intent to modify.",
         "UMask": "0x24",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
index 7551fb91a9d7d..a81776deb2e61 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
@@ -1,61 +1,4 @@
 [
-    {
-        "BriefDescription": "MMIO reads. Derived from unc_cha_tor_inserts.ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_READ",
-        "Filter": "config1=0x40040e33",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "MMIO writes. Derived from unc_cha_tor_inserts.ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_WRITE",
-        "Filter": "config1=0x40041e33",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . Derived from unc_cha_tor_inserts.ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.UNCACHEABLE",
-        "Filter": "config1=0x40e33",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "Streaming stores (full cache line). Derived from unc_cha_tor_inserts.ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_FULL",
-        "Filter": "config1=0x41833",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "Streaming stores (partial cache line). Derived from unc_cha_tor_inserts.ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
-        "Filter": "config1=0x41a33",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgress 0",
         "Counter": "0,1,2,3",
-- 
2.43.0




