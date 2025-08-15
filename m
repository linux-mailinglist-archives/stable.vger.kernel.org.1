Return-Path: <stable+bounces-169803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F29C3B285BA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168A67BDADB
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2CB1F4165;
	Fri, 15 Aug 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FDKCOwaa"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23B317714
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282001; cv=none; b=YdQ9jg5CKOpnd7/CYUP/AhBmucmTeWhV6/WAjo8ERYyw/QMPIepQEhAfgfcsHvEjNn3zPMJUmkNwybELcFuQtSuWKJSFYD/HF1raONfg/3Ho90lAoXmEW5DWujJ+qwHtJ/OyimHNoJwFx09sb0LDRTK/m0qXGHyQDudB67WCJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282001; c=relaxed/simple;
	bh=UXA10uU3L2OvIrIoYVp5OT9NfGLrl79m4gfEoHoZAEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KKwYop/R/xizhjJHC47AmI5yrqxQ6I4YVerffTm+L3nd2zMf0nrEEoEK1lViTAASLlaYp2T7fK+7Uv315SrLnThgxwdcMe/5vnHxGuISARs++OdPELdpsH7pWlYoki9doLlhAjbbfjIyYMwEC7LC52RaBakrwe2shgoA7fCT5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FDKCOwaa; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755281971;
	bh=o71CyvIgV9EHtxRNyrbELAPs5xHSpR1wDoVeMU6rbj4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FDKCOwaaSoNEg1L/3TysxCNGsTInXLS35ep9sSJ6DqJB7BNub1osKDsJHN78l6suc
	 so4F4pYHNkNiPko7Zfwuf8AXsjB47x0f7y6Pc0ZY+HMdJwgzgFHtoNOS5C/1GD1xBD
	 jBYMzMfLIJgvNaBlctwOnHsCnuz7SNtrktGUvkKU=
X-QQ-mid: esmtpgz10t1755281966t50a3fb47
X-QQ-Originating-IP: cmajPJ0hKCP2NVoS/PdEEWRsg74OAru607hVJfbMpVY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 02:19:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11989606281891100026
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 4/8] energy_model: Use a fixed reference frequency
Date: Sat, 16 Aug 2025 02:16:14 +0800
Message-Id: <20250815181618.3199442-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250815181618.3199442-1-guanwentao@uniontech.com>
References: <20250815181618.3199442-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NKf9S9z8koRU63Evq5QUeAF1tJskRVkpFiDszj6PKi/NJKmi3t8B9IWx
	Fma529K2AoJZh0UqIiXWq0rftcM/Fju2oPX8ZYz4ZgM+cHEdII6ox6wO/XgOAySeJ1DJTEM
	lRcG1Y7bXQDMUE0g/72NGyCKN4GgM7hB3OSDS84Jo24OzXXQqc1gW3lcqLy2475uxwpdjqr
	vO/C6SqpefddXRKMX3eb5EhRyauLRQuWPyAShd9Smhwq/jNNbScNvYCCW/sQoYOrqw/Rw/h
	tHQc3+Rq9Hia926XkEQyLVSNE+WbwwZA1KpBdl8uz9DTGT+J0Tsl3k5fOzeYmhobVIZfvNT
	GXjp6bSUkNxLYN9rZxYql0NqoxrFAZDj3L20qq1bCtIKBXQDS9S7PaDupM/fgRUJIvxEaui
	G9F9YJL8ZJJuqlXVlAwsMc3j9Dn7Ew1NF4C2MN8MJDeWPnOLhKfJTxTdwh6frAYFS0EeBgI
	f5/3FItuYtiNRBSGdpkjhBq+n0hqLlW2HybQvi92Iks4XYtWIwIZ+6hNnt/0AwwaLaQOl5W
	OMUug35f2Gg7yqKxpSR1MGmGW1x72GfqsAJERL8XsynHfAMCMmxiKFYsJ77tII+XDkq6dcW
	E0uJGIQ+4DrJzTi2GjY6KLL5rAcRZuOHvWBpoeOxvOtyCebRuxOBf8yyaCN5ctS+Z5mg2gM
	0QhCib28zOglZ0kvZrmXXXKWXzZYR+YTfsPQY8QWA8HePB0NOSsAdGF6/F7+WFUaqjirzlH
	5/kHpiUjfAsQrL9ElpraEQzXT7Ja80bAkLosU+7nveLGOENbgKb8FoJR5FMWOkvIMTBH8EE
	goBf4WKYe/j9IJxrtwxDUmajbFVT9NjTkIb2XzeMZ7Oe6KhYmeFx24HbylIsq5rwml/m7bg
	sLGtSVQ6gxFuih+JeEcmteofXUn1NYbcPypYRDmoZTy+LTnWNdlML3DWOry/ZzLCukye1ja
	bZY/4OZyRZo5CSOf5F5XJr6u0v04hxlHWkL7fIhcUFQEDbfcdv59ede/M6Ajhw5LMdAXhHJ
	OiPDyjs4bdSXG630RcALSSxrsSvEO+gSShooHRzngiTdYojBcwib+kKxsiIMdFN0EzgGRQ1
	3wynkylzvNZp8mlsl0cSe8o4KvfHnsp2A2oPZM5ESGxTMXqIxv8u8YEAlteFyZmdaAjDTzL
	N8e+
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

From: Vincent Guittot <vincent.guittot@linaro.org>

The last item of a performance domain is not always the performance point
that has been used to compute CPU's capacity. This can lead to different
target frequency compared with other part of the system like schedutil and
would result in wrong energy estimation.

A new arch_scale_freq_ref() is available to return a fixed and coherent
frequency reference that can be used when computing the CPU's frequency
for an level of utilization. Use this function to get this reference
frequency.

Energy model is never used without defining arch_scale_freq_ref() but
can be compiled. Define a default arch_scale_freq_ref() returning 0
in such case.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20231211104855.558096-5-vincent.guittot@linaro.org
(cherry picked from commit 15cbbd1d317e07b4e5c6aca5d4c5579539a82784)
Stable-dep-of: e37617c8e53a ("sched/fair: Fix frequency selection for non-invariant case")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/linux/energy_model.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index adec808b371a..88d91e087471 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -224,7 +224,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
-	unsigned long freq, scale_cpu;
+	unsigned long freq, ref_freq, scale_cpu;
 	struct em_perf_state *ps;
 	int cpu;
 
@@ -241,10 +241,10 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
-	ps = &pd->table[pd->nr_perf_states - 1];
+	ref_freq = arch_scale_freq_ref(cpu);
 
 	max_util = min(max_util, allowed_cpu_cap);
-	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
+	freq = map_util_freq(max_util, ref_freq, scale_cpu);
 
 	/*
 	 * Find the lowest performance state of the Energy Model above the
-- 
2.20.1


