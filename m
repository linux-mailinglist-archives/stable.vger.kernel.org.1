Return-Path: <stable+bounces-134762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269EA94D82
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 09:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6795A188FE4D
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE9C1172A;
	Mon, 21 Apr 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W5s5YFBY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A120D4F2;
	Mon, 21 Apr 2025 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222039; cv=none; b=rFdM0s9ITfcYHNPc8dz69qQjP1/1Cy5eRwwwkvTAjVtlOn2j/UJLEBosIG0xGhKEa1QAhYuxiu05eIBNZEXIdQtTHGkWta2yZ6s2xkat9MAFaVjQL3QSAH+7g1y4zCJ0w0u0cIVsFdwDbItJ7sussLa84qO3Xv0ZfPwAfNkgPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222039; c=relaxed/simple;
	bh=gkizvQE2WuXh1qOKHyGyJTDTiqv4/vG9LrxxlO30Gdo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kF21K/1X4kKKWPIeGklNt0sSrdl8mgU/bgWYl1Ed18ShYlmfMTu2XxcM4NzHi4df+Jzlflz+kc0B7iQbXwqGkiL+x8CQRqihyXq9D8E21C8Nwo/FL0JlNp27WhUpeaC4muZ1HC3OkqRTgA/wwlhXIhBBYxon+gcwMFs2Kh4g3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W5s5YFBY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNKDNw010248;
	Mon, 21 Apr 2025 07:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ppYXZ3wkWrV0BixkWCtHnH
	/2YA2f+v2dT2O39a4EUuk=; b=W5s5YFBYa7DrUfsGiCheWWMM+jY+XjjrLs9qXE
	tn4/9qwUVdnjMUbGE5RCyqukKJU3xCsZ9kxt36e/YB7P7vFuK6TfU3xi4/fV+Kqe
	sZJycfxCm6+1sW/iEkQGGTtqa+r8Ko4w60U2HkNjfhT5vufaQmcO0QdYvPPjGyY5
	yU9J9Q0Q40EN5kWQP3m1OWnAo5wq6IzmX5Fr+jX2o3NePxKFQ3Jpk9gyLaqNUnct
	o608UHw6A33z8xzi3u3v0izvKjef+ySId/Z4dhkD3XT3pe/LPU0MAlg4G4fELcop
	QYxKaHoPeipFVu9CRPssDaW2OnkB0zBZBvJ6+PyFvGZ2nWDg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46450pbae3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 07:52:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53L7qqBX022213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 07:52:52 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Apr 2025 00:52:48 -0700
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <cl@linux.com>, <rientjes@google.com>, <vbabka@suse.cz>,
        <roman.gushchin@linux.dev>, <harry.yoo@oracle.com>,
        <surenb@google.com>, <pasha.tatashin@soleen.com>,
        <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <quic_tingweiz@quicinc.com>, Zhenhua Huang <quic_zhenhuah@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] mm, slab: clean up slab->obj_exts always
Date: Mon, 21 Apr 2025 15:52:32 +0800
Message-ID: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=6805f954 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=TuTZUksUTkBGaCY47_EA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vOWrspQ1g8xb5AE5zS7VeoD1AIprgx-j
X-Proofpoint-ORIG-GUID: vOWrspQ1g8xb5AE5zS7VeoD1AIprgx-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_03,2025-04-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210060

When memory allocation profiling is disabled at runtime or due to an
error, shutdown_mem_profiling() is called: slab->obj_exts which
previously allocated remains.
It won't be cleared by unaccount_slab() because of
mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
should always be cleaned up in unaccount_slab() to avoid following error:

[...]BUG: Bad page state in process...
..
[...]page dumped because: page still charged to cgroup

Cc: stable@vger.kernel.org
Fixes: 21c690a349ba ("mm: introduce slabobj_ext to support slab object extensions")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Tested-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 566eb8b8282d..a98ce1426076 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2028,8 +2028,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	return 0;
 }
 
-/* Should be called only if mem_alloc_profiling_enabled() */
-static noinline void free_slab_obj_exts(struct slab *slab)
+/* Free only if slab_obj_exts(slab) */
+static inline void free_slab_obj_exts(struct slab *slab)
 {
 	struct slabobj_ext *obj_exts;
 
@@ -2601,8 +2601,12 @@ static __always_inline void account_slab(struct slab *slab, int order,
 static __always_inline void unaccount_slab(struct slab *slab, int order,
 					   struct kmem_cache *s)
 {
-	if (memcg_kmem_online() || need_slab_obj_ext())
-		free_slab_obj_exts(slab);
+	/*
+	 * The slab object extensions should now be freed regardless of
+	 * whether mem_alloc_profiling_enabled() or not because profiling
+	 * might have been disabled after slab->obj_exts got allocated.
+	 */
+	free_slab_obj_exts(slab);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
-- 
2.34.1


