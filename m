Return-Path: <stable+bounces-181541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26D8B973C6
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 20:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86E34A45D2
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFA27CCE7;
	Tue, 23 Sep 2025 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DjyGSMSc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8020A5C4;
	Tue, 23 Sep 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653263; cv=none; b=f7eL8JmJ54Y6BtmDEqgAH/s4Toj2sjHnDp37MNZGAqim5HhHIf14wQR5DjpjJ8Z+Je3Iy4gA1X/+8Jvhb6UWN3Gj/oinJDlbOh2Akn9z6gDPSp7P9mSD0w2cOceIYAugEHBVFdnCs7HxEfSHiUqH7xPt93nNwqIwVFihfPX4ZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653263; c=relaxed/simple;
	bh=/rcKksjFl1k4+WxBdoQg/HlJfNF841ZtdIhy0TnB09A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+MKwtR3Q2DnjgX3SbTUABGviI68a+tfxbahFKkqxQxtPbiznXcgFx3NEj0tr1MNbZ9FbJMnT9YRFRMPx9qPLIrGO5NhJWkE3GRBuy61VXPIhIx98UpJ19hOmO6+au9We27VdVzyiwuJC8rW/GY+dNX+qXwEeVWXyyKLfSM7RyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DjyGSMSc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NCNhMS007713;
	Tue, 23 Sep 2025 18:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q+P8gW3hL4ZNrxFEt
	44emVCG+0Bn24wEbgunKb5MOTU=; b=DjyGSMScuBeMkr+CHSYZK6LjDUu26CIh+
	/tR4OJL7/DhuDL+uRJ3hpPRKUurD0GuNeGioQxsMHHCeIRe+/81W945Px2FMsBiT
	s1ZwvY3WwPHncaPMGWIT/w93Big2peS5ihii5TLYJO5ywouPg9elcAoXWUMHmn//
	5SamthlN+XzP82dpj2gZzmrXYbe8rrsvUu0OeQDxcv4hjQ4SyzZ6UMh0zvaBwVQs
	1V3alRMN45i4k6/wSz7SMh+3xcOeHeGk+flbrwqOcqoYo4GZtUj4cgcmT6zcu5Pa
	3JlNuVG0XpTJKLacmfkH+Fjpjw/Faz7I1T12YwjGyDyWtbJ3pDlOw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jk0rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:47:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58NIj2pS001810;
	Tue, 23 Sep 2025 18:47:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jk0rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:47:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58NFW5T3008359;
	Tue, 23 Sep 2025 18:47:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yxw57k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:47:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58NIlQgJ41550206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 18:47:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86FA920043;
	Tue, 23 Sep 2025 18:47:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D33520040;
	Tue, 23 Sep 2025 18:47:23 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown [9.39.28.7])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 18:47:23 +0000 (GMT)
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
Subject: [PATCH v3 1/2] mm/ksm: Fix incorrect KSM counter handling in mm_struct during fork
Date: Wed, 24 Sep 2025 00:16:59 +0530
Message-ID: <7b9870eb67ccc0d79593940d9dbd4a0b39b5d396.1758648700.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758648700.git.donettom@linux.ibm.com>
References: <cover.1758648700.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX++mP26t9VP05
 cfvfiTNHpf1mwtZOfB8oEAlaJeP1/q8v20DEO6U3OkAoBUtBmN0JyM+lRKNDp3Tj2n1kXwo1jic
 wZeVcgXjuEpGe5I+wD9FwrmryzzybDy5N9XSTclPnoFtBN03ZI2Q8+pntLVEDmf24OxhYAZ54TA
 ic+1JE0KqFBZo2cq9PsnM++pgZ5AdiVl+N1TU8aQp5yq/xB9nGbvLnTHvi5vYf7mu6F3Aw5y8h/
 QdDz6HzHeUCJL5DLuVeQvxsXp2gAV90P3W0MVrEDbvdjfBwHOsJXXU5xhRlxSAyPzNMZIoOLxGb
 c6Al+WAtTBXm6LDywb+je9NYj0VOGqCJ/QZEJyfvrklXrcnZm1gYUvdl4BA4mJPXZjB7EdqwmF5
 7ZEJCdyG
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d2eb44 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=rGnqKr3d-3nbiQ24QTYA:9
X-Proofpoint-ORIG-GUID: G6J1obe0iSIJ2jPiSryxKlCawTRtYp00
X-Proofpoint-GUID: 8xMEdo0Z_hPz569z3DfCw9bx-z37Xl1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

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
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
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


