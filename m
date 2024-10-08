Return-Path: <stable+bounces-83106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF12995A15
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44701F22E6F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB04215029;
	Tue,  8 Oct 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kSTIRnCW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C3F21500E
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728426605; cv=none; b=faCkdhVmpiNUP5jpatL460WcaK+U9vl87y4Me4Q7EXNBlIy6xfbcwukj68f8mxn7YMtxE7vLYJFg5gkiHJDEdjDNWzmooXH7XIDJMudA1fS1HeIPMSYkHQaVEDcnrkkQ0rjb15UFbiRlefNsBjGhDBEyhp6GIM3Ru71flCXTCQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728426605; c=relaxed/simple;
	bh=tfa50dd2I6MLIXFWvZgHad0ab+euBmZSNsSLa8+G3Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlY1AxLj7N+gFNySLQWgx6GJ6Htpp0mAIPRSzx/W+IXpM/sUXGQYv0R66d/nzxYpvWnLSA1PeOVdS5km7Z8G2rFbaLntsVNQvO7q1SOaDaC80W7F9VTgt8wdoQmffUGAjxdUPaw+ASQWA7uanJykEZ91KGCRcUzzxogknIO9+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kSTIRnCW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JtZtv022304;
	Tue, 8 Oct 2024 22:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=8Dupf
	IGBzjnBCHOTHi3NWoPAPndNrIj3HgG/lmoXqVA=; b=kSTIRnCWDQ2QC1mIAVQi+
	Bk8sZOKGpd2N30RNKq1/HvVwKJWrSYAHgZyF7Xdaw0xpDYXuGhRWk09y858pjCv4
	9QsnUTF3p1HP71C38cdEzjgA0lwubXojLwuYHj0D7WJG0QL1KqfdllQGrZay3vPM
	9BnbZ64S+E6seYyRx4HomJQCiDnim5YUghdQI/8C9LxVXRfPfo6DL+A+EBAgoMb6
	IIrumWbK+rdl1PY8cEHlP2gRFjcqJA3h+rMSfVDSY2LahCTYA1cackMphXrw1NaX
	FouZylQG1K4pxa+grEw++3rmjRqCSiydEFHGY51iNm9MnCkfVXmMxkWQq0ev/Wcs
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034q76j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:29:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498Krb8w019135;
	Tue, 8 Oct 2024 22:29:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwe3red-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:29:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 498MTsjH036464;
	Tue, 8 Oct 2024 22:29:56 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uwe3ra6-2;
	Tue, 08 Oct 2024 22:29:56 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, jeyu@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        ast@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
        sherry.yang@oracle.com, flaniel@linux.microsoft.com
Subject: [PATCH 5.10.y 1/4] kallsyms: Make kallsyms_on_each_symbol generally available
Date: Tue,  8 Oct 2024 15:29:45 -0700
Message-ID: <20241008222948.1084461-2-sherry.yang@oracle.com>
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
X-Proofpoint-GUID: JB40yJPHELv0bCCnoBiQ75Zyeu2zbqRR
X-Proofpoint-ORIG-GUID: JB40yJPHELv0bCCnoBiQ75Zyeu2zbqRR

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit d721def7392a7348ffb9f3583b264239cbd3702c ]

Making kallsyms_on_each_symbol generally available, so it can be
used outside CONFIG_LIVEPATCH option in following changes.

Rather than adding another ifdef option let's make the function
generally available (when CONFIG_KALLSYMS option is defined).

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20220510122616.2652285-2-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Stable-dep-of: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when
func matches several symbols")
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 include/linux/kallsyms.h | 7 ++++++-
 kernel/kallsyms.c        | 2 --
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 465060acc981..430f1cefbb9e 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -71,11 +71,11 @@ static inline void *dereference_symbol_descriptor(void *ptr)
 	return ptr;
 }
 
+#ifdef CONFIG_KALLSYMS
 int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 				      unsigned long),
 			    void *data);
 
-#ifdef CONFIG_KALLSYMS
 /* Lookup the address for a symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name);
 
@@ -155,6 +155,11 @@ static inline bool kallsyms_show_value(const struct cred *cred)
 	return false;
 }
 
+static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
+					  unsigned long), void *data)
+{
+	return -EOPNOTSUPP;
+}
 #endif /*CONFIG_KALLSYMS*/
 
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 8043a90aa50e..a0d3f0865916 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -177,7 +177,6 @@ unsigned long kallsyms_lookup_name(const char *name)
 	return module_kallsyms_lookup_name(name);
 }
 
-#ifdef CONFIG_LIVEPATCH
 /*
  * Iterate over all symbols in vmlinux.  For symbols from modules use
  * module_kallsyms_on_each_symbol instead.
@@ -199,7 +198,6 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 	}
 	return 0;
 }
-#endif /* CONFIG_LIVEPATCH */
 
 static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
-- 
2.46.0


