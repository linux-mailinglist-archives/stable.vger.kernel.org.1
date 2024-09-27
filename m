Return-Path: <stable+bounces-78162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBD7988BEA
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D951F22216
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86853171E5F;
	Fri, 27 Sep 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZgkXyV9a"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB716F909;
	Fri, 27 Sep 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727473474; cv=none; b=pJdT41yC0wUyBPe+p0q3jnMsbZf8gfC48BwY7C6F+48XEiBvwgx74e8NjlRMOyDYiVJ1kUWhWZy8BWRp3+0nwzc4iHrJAWS8t+Q9jyo2lagAb6qIq8i++wkYKAp+kT2kXAgcx+2DOQlKR1c2U3iJiYiFKR9P3+X5Aj7jpHyQu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727473474; c=relaxed/simple;
	bh=D3oLuwP6Dv6obMJ5odxVQzTAjbaZ9Z+G5xZvfXXWUcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPVpqXZu9YgAl6ui/68eeGDpcUwCxlAdGCf3njsPnqRvne8de/Vwo5f9gHfeqnjLpenIYZMy045LQ87cqLW7P6kXnNXoeNJEvIqkJfSDN54bUTEo50AiguAoP9nrWDA3yE6bGhUE7m5mHGy8PF9m4S/5ccwxV367ZqnD8uhBcoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZgkXyV9a; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RKVlH9025180;
	Fri, 27 Sep 2024 21:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=n
	5Wgk42lYzokNmEIlnNyGYK3U2saSL2y5ta9ak5AIJ4=; b=ZgkXyV9absOSVzl0z
	Pm5ApyoOi9ytxZVv/P8RyrljssnPwfzxhxr+cDUTVIWJg/TYbjU6Ht8dgGsX5BeJ
	qxVNH0LMySkF91zlIMvWSyGsfP0fpCNBhdF44DTEVNdfdHHZs7SUhRnG4iG1OCpv
	y7xLqPzRrBtVqc7vKX/E9hyhnXdOtr6czHP/R8NLxq+o89jumkyWPlXhexRFIse9
	wUQ4tc3PNDXtin3RtYEuZ84SO2JWMH91PtMHTwY5g6OkpG0O10bqazHYDPUL9vn8
	p2zlSrUNAGyDCv/CoZptGIwrwbanc5bA9j6mtEnpdr3b5VOIO94JX3QWGcXg74ft
	XR/Jw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrte5kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 21:44:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RK6MMc025352;
	Fri, 27 Sep 2024 21:44:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smke5afy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 21:44:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RLaw36030299;
	Fri, 27 Sep 2024 21:44:03 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smke5ae0-3;
	Fri, 27 Sep 2024 21:44:03 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: rostedt@goodmis.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        sherry.yang@oracle.com
Subject: [PATCH 5.4.y 2/2] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Fri, 27 Sep 2024 14:43:59 -0700
Message-ID: <20240927214359.7611-3-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240927214359.7611-1-sherry.yang@oracle.com>
References: <20240927214359.7611-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270159
X-Proofpoint-GUID: TCm0kOeeB55gQJa1Kw68urfico7sQatD
X-Proofpoint-ORIG-GUID: TCm0kOeeB55gQJa1Kw68urfico7sQatD

From: Andrii Nakryiko <andrii@kernel.org>

commit 926fe783c8a64b33997fec405cf1af3e61aed441 upstream.

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
Signed-off-by: Markus Boehme <markubo@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Sherry: It's a fix for previous backport, thus backport together to
5.4.y]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 kernel/trace/trace_kprobe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 80a59dbdd631..2164abe06d84 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -741,6 +741,8 @@ static unsigned int number_of_same_symbols(char *func_name)
 
 	kallsyms_on_each_symbol(count_symbols, &args);
 
+	module_kallsyms_on_each_symbol(count_symbols, &args);
+
 	return args.count;
 }
 
-- 
2.46.0


