Return-Path: <stable+bounces-204438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C53CEE096
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D64CB3009864
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5452D595F;
	Fri,  2 Jan 2026 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fKWOGzNT"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628391397
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344838; cv=none; b=hsdwE2GYY4fqG2DoQfJ4fCxQ5kVkLEew9IMT0BYNTC6iiXYy2eISw3FhiXK/7ouONyWcqodhO6F6zQjclriSNCpAgJqWreJ9T0MiIolTCcjcSNuRBWOc78T3iJR1ZmuhayCojNZKpGt5Ew1x2qtXxWihhikHsHyfWhDhOJJCDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344838; c=relaxed/simple;
	bh=TNOac1DJmVODH6H1Jscbp58si1kVmhqdNk259tDLcEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW+YqolFKyEy17ZHhq4FhnNs8t5f0HILc84viH0nwMPXVkkiQhEN8v1ZQN+JDAc1DG/3NvN/rpqcpy9TXe9WOKFc0wFvTbct3APRVTfKczNidDqV8br/dHsBLcUYSkBz7QqbumXsyh/iahPe+tV1snmVjsunbXkr2KmWdYD14qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fKWOGzNT; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767344834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gl52UYjuxKXySDrefeSnj8xmRj7F+GTc8QMFl3Q24hw=;
	b=fKWOGzNTOY0xA+Ze2bcHPPtWh0O7MKqbKQpcPbob+0n5I12ehz7unRis1+lXA9i4/suWtI
	5f/VBGLnsL8tLXr6TWHhbLJUCeRrLZNWc7W6G+pIlWkFqPBnq5PyOpCYhVOMTtzGAGgfzc
	HMYImxXpqpITkGx8zEw3bM4VFe+iSm4=
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
	Leon Hwang <leon.hwang@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 6.6.y 1/4] perf/x86/amd: Ensure amd_pmu_core_disable_all() is always inlined
Date: Fri,  2 Jan 2026 17:03:17 +0800
Message-ID: <20260102090320.32843-2-leon.hwang@linux.dev>
In-Reply-To: <20260102090320.32843-1-leon.hwang@linux.dev>
References: <20260102090320.32843-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

[ Upstream commit 0dbf66fa7e80024629f816c2ec7a9f3d39637822 ]

In the following patches we will enable LBR capture on AMD CPUs at
arbitrary point in time, which means that LBR recording won't be frozen
by hardware automatically as part of hardware overflow event. So we need
to take care to minimize amount of branches and function calls/returns
on the path to freezing LBR, minimizing LBR snapshot altering as much as
possible.

amd_pmu_core_disable_all() is one of the functions on this path, and is
already marked as __always_inline. But it calls amd_pmu_set_global_ctl()
which is marked as just inline.  So to guarantee no function call will
be generated thoughout mark amd_pmu_set_global_ctl() as __always_inline
as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20240402022118.1046049-2-andrii@kernel.org
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index aa8fc2cf1bde..3b09ec4f2b0d 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -632,7 +632,7 @@ static void amd_pmu_cpu_dead(int cpu)
 	}
 }
 
-static inline void amd_pmu_set_global_ctl(u64 ctl)
+static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
 {
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }
-- 
2.52.0


