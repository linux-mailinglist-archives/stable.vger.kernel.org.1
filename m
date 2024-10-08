Return-Path: <stable+bounces-83107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D966995A17
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E78B22331
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809AA21503B;
	Tue,  8 Oct 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YnFuSqgf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94474215026
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728426609; cv=none; b=GLNPfEL0wLCDuwjn0nZK3yRFfjFJcvdVVDwV9LOUbLwB7jk62aAs5JCxQKqT/spEgLffhdTW5cAHgifNtODjFUV69C/amCpr1g6rx7LdNZdRppUkS+oX7AARYiALsNEbOEvBLyX8lZCoWlPEyohZLM+qG72gLYpoV6CYvLzC5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728426609; c=relaxed/simple;
	bh=mnVu797CqqCKzLCOutr0ZAT9Tbml29tbGFl9tbhh1fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knYCQr8zt4rG4/OMPrL85u328Gg8GxQeJqgImqmn4Ake7d8iijSW5GtLSITFV+Qt3hN5eX8b/hST20mcTs/b0O42Mgx+F7aufvGsos2NJ8v5mgh/48Z9c9MHzZp/rLb7d5ysuHdj1u6KWM03/UsyAl2QE+o5M6W54XywrQi2RrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YnFuSqgf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JtauE004858;
	Tue, 8 Oct 2024 22:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=fJ7EQ
	vKKhYWas5XuiWk7JYnD0Sa9aDNM2emN6JfD8wI=; b=YnFuSqgfn0EEs2dEYApSU
	EyWNdXHSRDsO4E+lDyt/fiFuLLMEFfjU951CK8ktQiUmMWvcQPkhUaOU1zgLlIlo
	mLiYrwY4Z1OZFmFxVMxavKTxuID4LBLNBV8AD6GO8phe3NvNAgAVfEqRUgl4nN0t
	0sNsTNPyksiLiQHzTu32Q1ouiM6Nh9e9lWaJU5pn/BW4YT92Ly4VKntNrgGabmq4
	OpzzMohfmLV+uDufToBk5qwqPmAJe+9cKOM2uwUWdyewsdsyXtCNGTBE0ZwtUF5O
	t5RAQWSZzNt3sp0WiN7C7lVb5qsW/fJ6e8E0Z6ai5e6BpwMjXLC+gJvyiSaJm7a9
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv70mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:30:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498L0GbL019066;
	Tue, 8 Oct 2024 22:30:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwe3rhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:30:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 498MTsjN036464;
	Tue, 8 Oct 2024 22:30:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uwe3ra6-5;
	Tue, 08 Oct 2024 22:30:00 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, jeyu@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        ast@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
        sherry.yang@oracle.com, flaniel@linux.microsoft.com
Subject: [PATCH 5.10.y 4/4] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Tue,  8 Oct 2024 15:29:48 -0700
Message-ID: <20241008222948.1084461-5-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008222948.1084461-1-sherry.yang@oracle.com>
References: <20241008222948.1084461-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_22,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080146
X-Proofpoint-GUID: yo1eF3u6c0rrCsNyMHqqmDK1HFCeaFsR
X-Proofpoint-ORIG-GUID: yo1eF3u6c0rrCsNyMHqqmDK1HFCeaFsR

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
[Sherry: It's a fix for previous backport, thus backport together]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 kernel/trace/trace_kprobe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 91dfe8cf1ce8..ae059345ddf4 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -742,6 +742,8 @@ static unsigned int number_of_same_symbols(char *func_name)
 
 	kallsyms_on_each_symbol(count_symbols, &args);
 
+	module_kallsyms_on_each_symbol(count_symbols, &args);
+
 	return args.count;
 }
 
-- 
2.46.0


