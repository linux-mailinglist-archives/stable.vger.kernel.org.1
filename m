Return-Path: <stable+bounces-217418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIZeNJLilmnkqQIAu9opvQ
	(envelope-from <stable+bounces-217418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 702C615DB00
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6D130488EE
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FD326933;
	Thu, 19 Feb 2026 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KSe/t33s"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161530F94E;
	Thu, 19 Feb 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496036; cv=none; b=i8ZBYYtdbxLW1IAVjLUeQSj3x4HIGWdnhpTW7w7tHfot12eWbpQbS3tjLTyXgLpfRoNw0b6LPmN/0AtxiVi3ZaMvjqnqaLJFGj4U827l2hlSV1kBIR9BNr34fL8wUlj2oAZ3hshkPxBf6BCtlOAMMVmyMden6J9eYT7uiGjmVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496036; c=relaxed/simple;
	bh=xDY6lFRJsPNm7hAj0Hg/gin0+JWuA6xeHuJDXXJaPEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YblKRWH3GAHzjUvhPhJ+9mcRaANrC1HLJ0f1ZrXOYdGSEDbryZeapTwLmWLt7VwULm/cgu4OblT7Eznlv6msSnGKI+0bG3G/DBEcDmrtHuFH8VHhz87Tj+iQ0cq3iLiyBAgGABPfbwIa2ns45nzDfOqGe/hE1WVuezKGsqhbZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KSe/t33s; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J89QT03675464;
	Thu, 19 Feb 2026 10:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ShByB
	G0+pfknkRdOCyr3PCQORL9NZsBiMBo4O1Ge0nk=; b=KSe/t33sNVyqtiNNW7qVB
	1n4X73VaMZYdfQEpN+rPNyvEKI/KUz7PUeIab+wBBFpifMRiMdKSZzLud3mfdMav
	qVKbJqiRodRr62wnZlmvipj5aQ3aWdRgAEh+tjNxTbiwEAazooC77U79PiK86uKK
	P1PJKsxsA4c7UxMKuizd4JvCcY0fCb1ALv6ErQkNjbJ88VVJ7JHhQLU79xoTE5QS
	yw9Z2zmXIeFAPEFnm4Y278SE3kfkzyjkm9qekjyV8+w5V1sBMaeK2/wTa8clRlEO
	eOloZYh6icFVYQGeWGyGCc+nQ1RNJoKczvFrmt+iM7vh9G3jDVAeLvdXLjj41RT2
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0ay4ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J7mqkf033223;
	Thu, 19 Feb 2026 10:13:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228upk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADUM0037324;
	Thu, 19 Feb 2026 10:13:47 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-9;
	Thu, 19 Feb 2026 10:13:46 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: kevin.brodsky@arm.com, linux-kselftest@vger.kernel.org,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joey Gouly <joey.gouly@arm.com>, Keith Lucas <keith.lucas@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 08/14] selftests/mm: define types using typedef in pkey-helpers.h
Date: Thu, 19 Feb 2026 02:13:12 -0800
Message-ID: <20260219101318.2442406-9-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
References: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602190094
X-Proofpoint-GUID: AZPxRtsRmnEC11Z58b_NKt0mvsrI-yB8
X-Proofpoint-ORIG-GUID: AZPxRtsRmnEC11Z58b_NKt0mvsrI-yB8
X-Authority-Analysis: v=2.4 cv=UsVu9uwB c=1 sm=1 tr=0 ts=6996e25c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=mXqxyP1hdmV6Hc6UhQEA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX7zKnj6rKJoWf
 gOjAuQNLXxxYyzwUJrtbPWHaC3LB+rGURsfqlMM3jn5dLmXB593X1bevreUpWu+eyeqJRw/CVO0
 8MFjdS3AvbGalJtqVB3WOFEgVLJBctqGZRuKyQEUczn/FSfQ3H1NAY0lfvJWOR3ShCLRARFQ2I3
 iCqW8bCxeXJA8f1YDvSvKaECx3BX/5ROA0jtf2kUbWcU5qnjsmIqCZvO7F859gTbE+AYAndrWJk
 APPL+QLUeQuqHbuoXY52dxg6VTb4caQPMjCZdFe9PIjHRFgaJPe6/NBzAvYQ6P4hriPcuQSOCZX
 8Rki2751PoHi+54zlLUFXF8O6f1ohJNoqIK8kr+OTRHW4NtQIjtcsU96FLLbfjpf1wI+zmvOgHa
 mBM9/XaAApql17EcReZCuY4GPbjDwaUGQWV03LtDgoCJ/XNbN6xVyxh6NpZdHXjc0EYD+VrM1Lt
 rIlGRbpbSepr0PSu/mQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217418-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 702C615DB00
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit f7ed8331ecb84aaf7b6cb822182a11bf385d8c23 ]

Using #define to define types should be avoided.  Use typedef instead.
Also ensure that __u* types are actually defined by including
<linux/types.h>.

Link: https://lkml.kernel.org/r/20241209095019.1732120-8-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit f7ed8331ecb84aaf7b6cb822182a11bf385d8c23)
[Harshit: backport to 6.12.y , clean backport]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey-helpers.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 472febd992eb..84376ab09545 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -13,13 +13,15 @@
 #include <ucontext.h>
 #include <sys/mman.h>
 
+#include <linux/types.h>
+
 #include "../kselftest.h"
 
 /* Define some kernel-like types */
-#define  u8 __u8
-#define u16 __u16
-#define u32 __u32
-#define u64 __u64
+typedef __u8	u8;
+typedef __u16	u16;
+typedef __u32	u32;
+typedef __u64	u64;
 
 #define PTR_ERR_ENOTSUP ((void *)-ENOTSUP)
 
-- 
2.47.3


