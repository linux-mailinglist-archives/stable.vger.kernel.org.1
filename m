Return-Path: <stable+bounces-204441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87725CEE0AB
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33B51300D65B
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0952D738A;
	Fri,  2 Jan 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tkH6fcW5"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA82BE64F
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344859; cv=none; b=YSvtOgNQnWqWVw85ZREokBgYMDUZHl0KwB1hD76USrSRz/DDi0L/ojM8Z7VzbcmY5TJsQDCzxjrkJVACYSNj6UzJaOctvaaZV0jtoCbAbYOUYkSexe0wty6wLAvUILRObsWa/F/QFmMP5MN0VSOU5cqMdrfIkOjNLH6AkfhbIwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344859; c=relaxed/simple;
	bh=nIQNvWEwyYl2hWK3GcNjeOvmr0mJVipk9z6LCDGpUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXx6plyRaGEqm2ptcvVodN2beoLKX5RbjiOeiOv/XFsDAdGF3psm3Aqz2csTfPlA4IrQP/DBD76YaQFcsjEArKU0RUcof1Dy0ly1MqRXMd1+c7ySnFmrT4Rf6+80cpljs/7McZqfav6wQWnTHIVMCzGkM7fLZPw0jqNM/9lqJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tkH6fcW5; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767344855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMj5TrrlMif37vw/D7M5rWgGjiFm22plFTpEXR8IQhw=;
	b=tkH6fcW5Xme0JrpKnovfVILgVmIT/exsoT9krDEwZCaYTEfp5m8azT+mMHma4vlzCz1iFY
	cOB+OHZeSj0jLCfg5RWmL+12JF3xWevk4pw5e+255psmFDuH2oOTn3reLrAatJnG6TAc6Z
	hOu/apt0s2SXMySPxQPd4R5tLFTmQtY=
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
Subject: [PATCH 6.6.y 4/4] perf/x86/amd: Don't reject non-sampling events with configured LBR
Date: Fri,  2 Jan 2026 17:03:20 +0800
Message-ID: <20260102090320.32843-5-leon.hwang@linux.dev>
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

[ Upstream commit 9794563d4d053b1b46a0cc91901f0a11d8678c19 ]

Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
point, there is no reason to artificially limit this feature to just
sampling events. So corresponding check is removed. AFAIU, there is no
correctness implications of doing this (and it was possible to bypass
this check by just setting perf_event's sample_period to 1 anyways, so
it doesn't guard all that much).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20240402022118.1046049-5-andrii@kernel.org
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/events/amd/lbr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 33d0a45c0cd3..19c7b76e21bc 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -310,10 +310,6 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
 {
 	int ret = 0;
 
-	/* LBR is not recommended in counting mode */
-	if (!is_sampling_event(event))
-		return -EINVAL;
-
 	ret = amd_pmu_lbr_setup_filter(event);
 	if (!ret)
 		event->attach_state |= PERF_ATTACH_SCHED_CB;
-- 
2.52.0


