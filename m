Return-Path: <stable+bounces-83108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13647995A16
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3241B1C21F0E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D11216459;
	Tue,  8 Oct 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JR3AJg+S"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6621644D
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728426610; cv=none; b=Qh6MYM2KqkAos1LzIUAWNVdxb8Nc4HBNh1h0gxIdYoWpNw6wVkeQli/Kop1bGmzz824QBLVLnkcaCtBT1YQ2cI49f8jWOy/DBDmhkepsGwo6OivYKnhKOTYcHX7agfHflaYRQk1i73dj8aKZ37NV43G1PxtX02NkvXulWOq+JYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728426610; c=relaxed/simple;
	bh=bvzzjZzpBJfI+Pt1hc5iGi0o6v09yAtXPMOG/TgkWzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uU6b5uO0L72gico+XxsmYA26GgaLmZ7GMlBCHENoaLOusNLWD+QpUlfxk8YogJgRRzmZikSoFiKzyGuFu9X0giXe05CI6xiSAVXg+Lch+EB30x/ssiH5z4h/VD1eh9YGaCLsxUWCVCR/F1RT6XmVzykd4b1sEIDuDjlf2268+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JR3AJg+S; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JtcLx003560;
	Tue, 8 Oct 2024 22:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=rQD/N
	TuTE2P03cP7IQ55O8VFAdCFhdTJ6vvH7Oc+moY=; b=JR3AJg+SMnBedon0KGnT4
	FnrYmfN+HQ+/+MdU2gKqQSwnC+Pk9fI/ySSzHWxxy64pI9xOkr4WrayN5osydkNz
	ZAmlXHxo1p9XLfmefDJ4myAWpa8Ffe9yye1L6276XCgtHGk9ArXA2w2tGz5cgugT
	FLx1mblT7BvXwp7MlJ1Av9Ts7VerhD+IqTo8gzFkcx5nj78yvc3/zqDfIuI4s/eI
	nKysciRbIdEr5YO/VRdlrjm0zN4zdzBrw6ZWZOP4UE8+H+Kkf1R8tqaCX96Y8Pya
	s9FZ98mAYI3fZxx+kNfVa8HT9MbUiC5/wmBmLytlvT/4uDyy9z5l4b7bLGXIV2y4
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063pxpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:29:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498Kpn5V019107;
	Tue, 8 Oct 2024 22:29:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwe3rff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:29:58 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 498MTsjJ036464;
	Tue, 8 Oct 2024 22:29:57 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uwe3ra6-3;
	Tue, 08 Oct 2024 22:29:57 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, jeyu@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        ast@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
        sherry.yang@oracle.com, flaniel@linux.microsoft.com
Subject: [PATCH 5.10.y 2/4] kallsyms: Make module_kallsyms_on_each_symbol generally available
Date: Tue,  8 Oct 2024 15:29:46 -0700
Message-ID: <20241008222948.1084461-3-sherry.yang@oracle.com>
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
X-Proofpoint-ORIG-GUID: QVceGASGTdtBydjJefY0NpwY9OWjcv89
X-Proofpoint-GUID: QVceGASGTdtBydjJefY0NpwY9OWjcv89

From: Jiri Olsa <jolsa@kernel.org>

commit 73feb8d5fa3b755bb51077c0aabfb6aa556fd498 upstream.

Making module_kallsyms_on_each_symbol generally available, so it
can be used outside CONFIG_LIVEPATCH option in following changes.

Rather than adding another ifdef option let's make the function
generally available (when CONFIG_KALLSYMS and CONFIG_MODULES
options are defined).

Cc: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20221025134148.3300700-2-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looking at modules as well")
Signed-off-by: Markus Boehme <markubo@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 329197033bb0 ("tracing/kprobes: Fix symbol counting logic
by looking at modules as well")
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 include/linux/module.h | 9 +++++++++
 kernel/module.c        | 2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index a55a40c28568..63fe94e6ae6f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -875,8 +875,17 @@ static inline bool module_sig_ok(struct module *module)
 }
 #endif	/* CONFIG_MODULE_SIG */
 
+#if defined(CONFIG_MODULES) && defined(CONFIG_KALLSYMS)
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data);
+#else
+static inline int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
+						 struct module *, unsigned long),
+						 void *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/module.c b/kernel/module.c
index edc7b99cb16f..7f3ba597af6c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4444,7 +4444,6 @@ unsigned long module_kallsyms_lookup_name(const char *name)
 	return ret;
 }
 
-#ifdef CONFIG_LIVEPATCH
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data)
@@ -4475,7 +4474,6 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 	mutex_unlock(&module_mutex);
 	return ret;
 }
-#endif /* CONFIG_LIVEPATCH */
 #endif /* CONFIG_KALLSYMS */
 
 /* Maximum number of characters written by module_flags() */
-- 
2.46.0


