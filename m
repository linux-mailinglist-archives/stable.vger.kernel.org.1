Return-Path: <stable+bounces-85053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC44299D43E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8670F1F22904
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653401ABEBD;
	Mon, 14 Oct 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kzKkJ+ii"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B11ABEB8
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922025; cv=none; b=e50InJeg3ZITAhOq0f3SS8fLeNw8F2NArBc89HH8fHfk+UtDrvmZxtTr79OqQuUFWu1fx6MuaKjp+wQiNSHaJTHvZyhy8cjsfv7DIk4PQk6R18nQyLcJbJDIGwiuXVYNJTMG11Y2RtwiPDD9FmsJYdxt47sQ8EYUP2NxL3ZI/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922025; c=relaxed/simple;
	bh=D3oLuwP6Dv6obMJ5odxVQzTAjbaZ9Z+G5xZvfXXWUcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8yAgGJsdt8gJp3RPbGPFGeDGxFswrYxwgXB+0J0CRQgHBoq9oK8RY6Eq0TogX8JY0ohJmksGZLh6c7iU44RiMbWGe5TgePAQRFqo4pz4QYCljTr7XtjryywNHM00GNS5G8NMi27tFfb6lgblvbRPiP2Kt9CGBwrZ5t9GfKohKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kzKkJ+ii; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEfcRr024106;
	Mon, 14 Oct 2024 16:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=n5Wgk
	42lYzokNmEIlnNyGYK3U2saSL2y5ta9ak5AIJ4=; b=kzKkJ+iiRMoQwQSLfepdT
	1F1nl7JEJDmFj0uTXG9yvhIRthwTbPAUJmhxeZZejRX2wPW0tvhYs+CfKYsPjV/S
	/g4FXFxw9y8UDt5BUXRC9uxTn+NZ4J/KdrZXl1oaSxAXOGjfaWkvOvto6bHIM4Bz
	2Mov+GXYHnEIwT2Wn8L4r4Pc4MJpgMiuMvoSf4l6FDo/XVpWSwv1O8Q5EOcqo6cn
	lwmOTK84MFK6y09BRWPU7W5lUM43lo/WdQNphmnhNokADPJyS2WRu0xprMlwHrYC
	zm7P/H+v67XncN7+iAKLG9SZtY1YSLk6OVb3yXuvwevLzlwpWoCVQe39Y5J+4v+V
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt6u5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 16:06:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEbNLC036080;
	Mon, 14 Oct 2024 16:06:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjchk3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 16:06:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49EG4YYi036561;
	Mon, 14 Oct 2024 16:06:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjchk1a-3;
	Mon, 14 Oct 2024 16:06:55 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org, mingo@redhat.com, sherry.yang@oracle.com
Subject: [PATCH 5.4.y 2/2] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Mon, 14 Oct 2024 09:06:52 -0700
Message-ID: <20241014160652.2622878-3-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014160652.2622878-1-sherry.yang@oracle.com>
References: <20241014160652.2622878-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140117
X-Proofpoint-ORIG-GUID: 4JrRpYNHGTO_l4zQdYstpa7tZ7bdksS1
X-Proofpoint-GUID: 4JrRpYNHGTO_l4zQdYstpa7tZ7bdksS1

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


