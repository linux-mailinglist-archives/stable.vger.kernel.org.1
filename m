Return-Path: <stable+bounces-201123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28386CC07A7
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 02:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 428CD301357C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 01:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978C627E7DA;
	Tue, 16 Dec 2025 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksAHmGc9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD413C3F2;
	Tue, 16 Dec 2025 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849371; cv=none; b=GfTci0XmnknjAsmkKtnm8iJo+6Y87L1WpwxQsYCBNW+HqN8IHyqFcFLDXN/7+o77vZDXXrB+BzFbDDGcLsRfdRt00x0xYyJ4PJW3i1QRggtBTtqU+gPlQQVXlYYPTgut3rByW3dHi8seU1Q4HU0U7lOJHNOiiOPf8/ESSkI0c2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849371; c=relaxed/simple;
	bh=+wI/maUGiiwwz81QpyvTJ+eJ/2U0A+v++rAocI1k0BA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oa5fIu4UcsqnLJ59SOkfSEzPEG9N3qV1D9tEMT8SWp9IN8/Ow+Tc19m6xhVhC/YiyPuV2n7PG3bAr41PjAiqbtjWBz+wwvhQWhwT5h8BLHPpWeJhO5jGYShpFOVmITLZGra9AOEEehgQKNKhtS70hYG4nVY5G58omHAoYvJyUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksAHmGc9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765849369; x=1797385369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+wI/maUGiiwwz81QpyvTJ+eJ/2U0A+v++rAocI1k0BA=;
  b=ksAHmGc9OletAQ8UIfBt/nBBvB3KJ8FuAVjYZzCyJ9S2u8PTU/8wMW75
   va9ztJWD+7EUyoY7TrKvCBGeslD3FgrkATtrKzlYsbApkAzAQlXd8peq5
   pUPjMk+kZNJykR2MJJ2iVeoxUxbv41lJUnSj1nnZJKlPvXwAeDhdQZfr1
   zwmpA+i4GK5fBtlC91k99nwfPsKZ9AUCCE6Z250TShNJVBi8XvdgVAgWL
   oPM5DmJ/DYFBUYsD6iaXz1DyBzWvUWQa4AugMXMT/USEs9DdKtrU3s9Ox
   cWBiQmHxp+URsseXZ5SSdVVqNhAOM1tGLB6raq37jUvsgxXSSuFWM6o2s
   A==;
X-CSE-ConnectionGUID: fvqAWf6LQYWccnPUbsRM6Q==
X-CSE-MsgGUID: U2vfu03jRRSS2C+VbF/ENg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="55327346"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="55327346"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 17:42:44 -0800
X-CSE-ConnectionGUID: HaYJsbM/RTez8ofooBEdbQ==
X-CSE-MsgGUID: XDLOFB1ARuenIwkAOH1xvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="202989049"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 15 Dec 2025 17:42:40 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf Documentation: Correct branch stack sampling call-stack option
Date: Tue, 16 Dec 2025 09:39:49 +0800
Message-Id: <20251216013949.1557008-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct call-stack option for branch stack sampling should be "stack"
instead of "call_stack". Correct it.

$perf record -e instructions -j call_stack -- sleep 1
unknown branch filter call_stack, check man page

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -j, --branch-filter <branch filter mask>
                          branch stack filter modes

Cc: stable@vger.kernel.org
Fixes: 955f6def5590 ("perf record: Add remaining branch filters: "no_cycles", "no_flags" & "hw_index"")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index e8b9aadbbfa5..3d19e77c9c53 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -454,7 +454,7 @@ following filters are defined:
 	- no_tx: only when the target is not in a hardware transaction
 	- abort_tx: only when the target is a hardware transaction abort
 	- cond: conditional branches
-	- call_stack: save call stack
+	- stack: save call stack
 	- no_flags: don't save branch flags e.g prediction, misprediction etc
 	- no_cycles: don't save branch cycles
 	- hw_index: save branch hardware index

base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
-- 
2.34.1


