Return-Path: <stable+bounces-39306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC98A2DD4
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 13:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA54283EEB
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7A5577C;
	Fri, 12 Apr 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Kr0DbUoZ"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20D54BEA
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922928; cv=none; b=NNcZai/nXLUssd3f11hN9Nf+/zCnY+5a9GmdRHzIM6Ms9CIy63r50SeelzphPUg7u+uT71Ir2rQ+KxEnUGqtER547xtJXKOGGL8wHAcWlZMAKA8+HFklFflDHEvgWrejEUkZYbfJMeQQOxhQhz4ei4OQ6WZtgJJ1mRuQ7Z/4itc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922928; c=relaxed/simple;
	bh=u7gLDEpN74BodkxT573YCXqP6AaVccZPhInfOFyvBjk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tu60YuKsLAQ5j9Rtec4XdKyJkHLaHUtQHT80jLIJMp4pOXG0dO2nny7XYorHbVm26GYLaFEvSvICNu5NfY0Al22LgS8Ocg/mK6J44ZtF424+dmQp9fsJkGZhKgpK87L6afQJYy2pFQQyyILUWm/ES376pUSgJVyd6pBqvMFxqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Kr0DbUoZ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C8TuIw027966;
	Fri, 12 Apr 2024 13:55:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=pZTglg/
	HlM2BtGSZeEkt33ZkSaI8FMfC/perTKbCehE=; b=Kr0DbUoZeBcoCNWll8m1kYP
	T7TmA0BUeHsMs+yfsRIfhe2VR5/mfHESRkQFvC6nVWB+vrA7ZuaW96BvN/9jONO+
	JgqRNyL75kruypGI0HnLZD1BilVwxMzOQjYVRRyZNODX1p2cW6KEn7c5uUZYrWuf
	VwS46mUpVwzCBE3+6QF44ZzxRJHgytMt4sN/4Tzrk+6Ryl58/u63wfMFTEZ6vF4K
	vAtk9WsyuSo1inziUc22KuWGwJni5Q4/hFWf+C4nn+Swj2N2extEsfxAxpHpefRw
	f5WQaaB02KxkV+Oy5lpc6cQ6P1UeuklJCrLSEykY+K7BpdmIIifPh/nuwY4rOxQ=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xbhbjf15h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 13:55:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 23FD840044;
	Fri, 12 Apr 2024 13:55:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1CCC3214549;
	Fri, 12 Apr 2024 13:54:30 +0200 (CEST)
Received: from localhost (10.48.86.103) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Apr
 2024 13:54:29 +0200
From: Maxime MERE <maxime.mere@foss.st.com>
To: Maxime MERE <maxime.mere@st.com>
CC: Maxime <mere.maxime@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>, <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Song Liu <song@kernel.org>
Subject: [PATCH 1/3] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Fri, 12 Apr 2024 13:54:20 +0200
Message-ID: <20240412115422.2693663-1-maxime.mere@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_08,2024-04-09_01,2023-05-22_02

From: Andrii Nakryiko <andrii@kernel.org>

Recent changes to count number of matching symbols when creating
a kprobe event failed to take into account kernel modules. As such, it
breaks kprobes on kernel module symbols, by assuming there is no match.

Fix this my calling module_kallsyms_on_each_symbol() in addition to
kallsyms_on_each_match_symbol() to perform a proper counting.

Link: https://lore.kernel.org/all/20231027233126.2073148-1-andrii@kernel.org/

Cc: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 95c5b0668cb7..e834f149695b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
 	return 0;
 }
 
+struct sym_count_ctx {
+	unsigned int count;
+	const char *name;
+};
+
+static int count_mod_symbols(void *data, const char *name, unsigned long unused)
+{
+	struct sym_count_ctx *ctx = data;
+
+	if (strcmp(name, ctx->name) == 0)
+		ctx->count++;
+
+	return 0;
+}
+
 static unsigned int number_of_same_symbols(char *func_name)
 {
-	unsigned int count;
+	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
+
+	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
 
-	count = 0;
-	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
+	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
 
-	return count;
+	return ctx.count;
 }
 
 static int __trace_kprobe_create(int argc, const char *argv[])
-- 
2.25.1


