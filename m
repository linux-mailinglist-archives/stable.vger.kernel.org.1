Return-Path: <stable+bounces-204437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2ACEE093
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91DE83005AA4
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2EB22A1D4;
	Fri,  2 Jan 2026 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1mdgcKO"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A551397
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344835; cv=none; b=DkLTI3Q+18RFAPOjqiGEius/WBbeaofWMh8xo7PGl4A4S3raR5IbqnRcvFSnns1ydaTRVrMcpKOtuZU1IPTxp7xETlkGeY9fSqXHT6IpaXDUtw16DPzzYcbnqtUgOmAVjIr+emVS0QGAHLxAoN5+I9uImsaBhNtVuMZH3ew/OKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344835; c=relaxed/simple;
	bh=3YFkyRm4e/2hKfRESSPrjfJBhMg1YY/FedeOgq6/O1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zl4PNGJ0h7WUFOweCldVPRplVN6u3krQHHtraL0eZcNw1WnwzEw4dPeLDE5zyrGgWTJwp8BByx1HOtUOLTgxXUZkE1GBHW72En/tgb7YzvDc8Ij8HNjdRGuoFKeuUZ7cRb/3hYhb10R+hai2pRGCYoOMmcr1PJJlPc8W2bEXeLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V1mdgcKO; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767344827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j5ppCpfzQuNT9JlCYGq+KGDP27/4hX4fKaPbHWsJWDg=;
	b=V1mdgcKOPBIKxi8Yc/dO1m9SnegQJ2XaPOLwPGmaiyS7M2t/2DEKKVsMZ95zmnMcSPbRub
	wIsagmBUwiSACeA3mKZtNqFioOuRPIceU6Zr/otHLoT+mRuIveV0gA4CmLa/IHVHWHyq8O
	+LcANumo1nAqR6h81IpiqHsUwEx2Zkc=
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH 6.6.y 0/4] perf/x86/amd: add LBR capture support outside of hardware events
Date: Fri,  2 Jan 2026 17:03:16 +0800
Message-ID: <20260102090320.32843-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

This backport wires up AMD perfmon v2 so BPF and other software clients
can snapshot LBR stacks on demand, similar to the Intel support
upstream. The series keeps the LBR-freeze path branchless, adds the
perf_snapshot_branch_stack callback for AMD, and drops the
sampling-only restriction now that snapshots can be taken from software
contexts.

Leon Hwang (4):
  perf/x86/amd: Ensure amd_pmu_core_disable_all() is always inlined
  perf/x86/amd: Avoid taking branches before disabling LBR
  perf/x86/amd: Support capturing LBR from software events
  perf/x86/amd: Don't reject non-sampling events with configured LBR

 arch/x86/events/amd/core.c   | 37 +++++++++++++++++++++++++++++++++++-
 arch/x86/events/amd/lbr.c    | 13 +------------
 arch/x86/events/perf_event.h | 13 +++++++++++++
 3 files changed, 50 insertions(+), 13 deletions(-)

--
2.52.0

