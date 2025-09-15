Return-Path: <stable+bounces-179634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C5FB57FDF
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 17:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E403C3B4FB3
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93866334720;
	Mon, 15 Sep 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P4KvE/Pj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C03002A3;
	Mon, 15 Sep 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948678; cv=none; b=qv2fnVtb3+hzTqEHeFw29DnGwImx+Hzu9N46DoX4kDAxTfNWGXaSFflH6eA/V83tpBMVUxyMTe1VEheEa2IUAAzxHoydYFWsWugT86UYqgvQZLkVl+JfpcGXuR0ffNj4wwHHE4VQVvlBZI9/pSvm9UrqwqfTJZltCQYBeIw0o9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948678; c=relaxed/simple;
	bh=xvnqzI4YPheYiNJKhNordMfeNl5gOJV4He0BexXkeVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avrERplfcmMpw5nLmAOfSJ0/L7DTr9iQ5ZsyO7SBTkt5E7Nl9VhbArFz7+LQaO1h1cq6rsXyFeeNWcqCLl+akq4U4sySP6ueacl+iWXmCO30wQt2IDxXlOQkBAmplQeJ2pTn6nDyalRjHfEYmjo3kU6XSdsIOgi686RCRljIWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P4KvE/Pj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FELwsp024260;
	Mon, 15 Sep 2025 15:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qmdNsGBOZCkUMkcwK
	u0VTm354ODoqN+DZWqUieU9Sjg=; b=P4KvE/PjXmQhcYMQ/92z+lJ+SPbkepgsg
	qQVTQRDaPi+IJVTj+XWVi49alUNqJkVI5SBgbR3Luvg/kB+IIYkEvXDcA7DUYel0
	mOPa6ZMXRydjjxukpQpz1NzSlEUr87jTGsb+LzznOFHjxZV1e/nq+t9y1LSPwZvE
	2BX4NGWKJ0A42v5O6yuVJ1do+QTMjKYllajtJy80TsHxZd4moxt8eaMOgeE66NJa
	HWVZZROJR+AsgxijjHOCPcG2cJzJyCy8zRw+jBtD7WBAemJbgMx/MNeCQSyWj+pM
	XOk81pQq5pOSZqN9G50nd8U9PP0xUsQxZZEm//DC6x3wj00XXeIaQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnkbfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FEq3EU014559;
	Mon, 15 Sep 2025 15:03:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnkbf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FBalnG022328;
	Mon, 15 Sep 2025 15:03:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpf11f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FF3GSJ31785440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:03:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7E922004B;
	Mon, 15 Sep 2025 15:03:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF91B20040;
	Mon, 15 Sep 2025 15:03:13 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown [9.109.215.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 15:03:13 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Wei Yang <richard.weiyang@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
        Donet Tom <donettom@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/ksm: Fix incorrect KSM counter handling in mm_struct during fork
Date: Mon, 15 Sep 2025 20:33:04 +0530
Message-ID: <4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757946863.git.donettom@linux.ibm.com>
References: <cover.1757946863.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -V2HJDoKY9xomFcL3raGfCvo050dAgzB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDAyOCBTYWx0ZWRfX/rzsfviO1d4H
 x7GrWJ8Mgk29wL51Ja/QDFwGSYeT2UMO8mDUHrVq3g1uDW9k25Kh76YPgVs+ejYuAJ2/D/Uxgfc
 wF/2VXG+sF7URzatS/dGVrOZPS5f+5ogJ5N0d7I119X/0pKBbXm9EMlmyb9lSCJU329Hrdz3dMe
 pdRONcod6ss1TUFV/ciSbM6Bn31fKTFOBIYez+Idr6EcnEItn4IhYJsNZnY7VGllfUcIW1zih1M
 yUqBPIq7Qw+QjAJYgUQLoQ4s9hA7pleiqwJ5x76u8ZuZFi4Xze7kAf2Go94vUYkTw+b45zOKHxG
 WPFwc1LoehS/7C9BBcPQBkzU7rIBbQyuQEzvCDpKwoxbMcZTLqV7EtS62lzlkwyt0f0lXXUw7LR
 cB8VQkB4
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=68c82abb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=rGnqKr3d-3nbiQ24QTYA:9
X-Proofpoint-GUID: Swr6_VKceyeMYbvkO6k7QhlnGOpy66FD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150028

Currently, the KSM-related counters in `mm_struct`, such as
`ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages`, are
inherited by the child process during fork. This results in inconsistent
accounting.

When a process uses KSM, identical pages are merged and an rmap item is
created for each merged page. The `ksm_merging_pages` and
`ksm_rmap_items` counters are updated accordingly. However, after a
fork, these counters are copied to the child while the corresponding
rmap items are not. As a result, when the child later triggers an
unmerge, there are no rmap items present in the child, so the counters
remain stale, leading to incorrect accounting.

A similar issue exists with `ksm_zero_pages`, which maintains both a
global counter and a per-process counter. During fork, the per-process
counter is inherited by the child, but the global counter is not
incremented. Since the child also references zero pages, the global
counter should be updated as well. Otherwise, during zero-page unmerge,
both the global and per-process counters are decremented, causing the
global counter to become inconsistent.

To fix this, ksm_merging_pages and ksm_rmap_items are reset to 0
during fork, and the global ksm_zero_pages counter is updated with the
per-process ksm_zero_pages value inherited by the child. This ensures
that KSM statistics remain accurate and reflect the activity of each
process correctly.

Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")
Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each process")
Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
cc: stable@vger.kernel.org # v6.6
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 include/linux/ksm.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 22e67ca7cba3..067538fc4d58 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -56,8 +56,14 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
 static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	/* Adding mm to ksm is best effort on fork. */
-	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm))
+	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) {
+		long nr_ksm_zero_pages = atomic_long_read(&mm->ksm_zero_pages);
+
+		mm->ksm_merging_pages = 0;
+		mm->ksm_rmap_items = 0;
+		atomic_long_add(nr_ksm_zero_pages, &ksm_zero_pages);
 		__ksm_enter(mm);
+	}
 }
 
 static inline int ksm_execve(struct mm_struct *mm)
-- 
2.51.0


