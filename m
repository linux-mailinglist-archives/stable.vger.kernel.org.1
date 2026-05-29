Return-Path: <stable+bounces-256501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCvNJS0eGWpoqggAu9opvQ
	(envelope-from <stable+bounces-256501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:03:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 790725FD3D5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74D7C3017CD3
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE839E164;
	Fri, 29 May 2026 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="lzqXenZD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6C38E113
	for <stable@vger.kernel.org>; Fri, 29 May 2026 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031006; cv=none; b=bYJVwrZgR4vsobYmgOoh9gqMl3jZeney4USrH+r5LD9pM74IrClrrOoC/abaz5Hgzp9Z+X7XGzZZhpsDtFXibDjdVoNw70OPkBBpKWCwnrPQLNGtQdMzcjuaM+xVLEeWnTX1WzmpoEyyYfjsVpB5OfHDp1xSulchvKCnrPtpXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031006; c=relaxed/simple;
	bh=QKZrsNDYiuefJptktlYttDY8xjCYZ8XOXh5z4Sj20+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwMcVP5Ri+ck8tcSjcysstKcjeG3kvSXVXsJb8tseT5oH2UbQx7TMCroKeNWTj9pTZkmvfEBpVd0SwU9UmqyP5l8E+6UQ3mJZScfGNbK/2WsKppwH6MeTvYp1kfo7bsCP3g9/C0PTkl5ZcO9uXldJFLg9E/LmxKkJtGjhG/PVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=lzqXenZD; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T4K2vQ3467785;
	Thu, 28 May 2026 22:02:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MfLRKeSmvYn5uCp3OE3OJgd8g6Ba94ugsI1TbBUXG4Y=; b=
	lzqXenZDg/0b4Fei59D4lzIbOtYKW50GjQ7PCpPtBIhRpu87mPwSJQOhDC9IQ/5Q
	ERJ647U11ObGJ4CdLCUWCuO7XFv+iS5Vc4dleTVU022kvqLx8KTspffCnd63OtCt
	pnVky4Q9Ow1HttBCzkOigpMk0LpDCaRBYUd2KXhKGNWkevvH7lTf0pIcGJ6+h5z/
	54xgAY4/FeKGQTrwYC/3htiyes8xxiQ7TFAGhlyauOHaiyqM39iaa6bbWZy73EJ7
	pB55i1FBq+ddY/3OAMfAq4EesfBV5csJ4dE28OLfmyilWx9AO4987BFj8vqegZsh
	NlFSvkSAxZBaepry7HCJAA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ee7x6j04y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 28 May 2026 22:02:37 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 28 May 2026 22:02:36 -0700
Received: from pek-lpd-susbld.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 28 May 2026 22:02:32 -0700
From: Li Wang <li.wang@windriver.com>
To: <sashal@kernel.org>
CC: <akpm@linux-foundation.org>, <chrisl@kernel.org>, <david@kernel.org>,
        <hannes@cmpxchg.org>, <hughd@google.com>, <jackmanb@google.com>,
        <linux-mm@kvack.org>, <mhocko@suse.com>,
        <mikhail.v.gavrilov@gmail.com>, <npiggin@gmail.com>,
        <ryncsn@gmail.com>, <stable@vger.kernel.org>, <surenb@google.com>,
        <vbabka@suse.cz>, <willy@infradead.org>, <ziy@nvidia.com>
Subject: [PATCH] mm/page_alloc: clear page->private in free_pages_prepare()
Date: Fri, 29 May 2026 13:02:30 +0800
Message-ID: <20260529050231.1849697-1-li.wang@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260301013838.1699247-1-sashal@kernel.org>
References: <20260301013838.1699247-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ByPxEch99TkJW6u_SMEC8EIFC64UK1-U
X-Proofpoint-ORIG-GUID: ByPxEch99TkJW6u_SMEC8EIFC64UK1-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA0NSBTYWx0ZWRfX6eLWvh2mQSG6
 QtuAQrsqBOjRQoB4plIeeMX/q1xOu42+3gKxMDLHC0/5FWgCiRXUWC6+8GqXxf2ODhu/+G+PRQX
 fZRM+IV+ewfCWyRfqDleUcbqK4z+Yu44j8toytublkUNOB+VmtYYVyYRuJqPqIn86n9GXEQJj8S
 NVBu2jguijHstMVHbZYI8QS7jSDhOose7CKoMoKnhJ05FgP2/APZq+oP0D1EUgAMWEXAn/Woy2K
 G+kxZ+nt20vS6KVU9NbUIGSIFyuMw7u5XrEtUY8WdM9vylH1wdVY1H6XVyQnIHEJV8l8iKLVJfs
 aGktv2j7BS7Oos9fVK8ZAo8qTgHRC8+S3aB3AEruLBy4xrZ9KWoiciCOyIabFdWzb5EMShLgpqu
 MjAvXumCVMK2GeoikzJ9Db4001wIXyuCR7FMy9+TcAJO88oxLJzaEk9OItvbb6USdMsX7UB9vra
 dl9g2WrRHKetPNq47gg==
X-Authority-Analysis: v=2.4 cv=bY1bluPB c=1 sm=1 tr=0 ts=6a191ded cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8
 a=1XWaLZrsAAAA:8 a=ufHFDILaAAAA:8 a=JfrnYn6hAAAA:8 a=iox4zFpeAAAA:8
 a=Z4Rwk6OoAAAA:8 a=t7CeM3EgAAAA:8 a=yWvz4_beDETysViLzRIA:9
 a=ZmIg1sZ3JBWsdXgziEIF:22 a=1CNFftbPRP8L7MoqJWF3:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290045
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256501-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,google.com,kvack.org,suse.com,gmail.com,vger.kernel.org,suse.cz,infradead.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[li.wang@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 790725FD3D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

[commit ac1ea219590c09572ed5992dc233bbf7bb70fef9 upstream]

Several subsystems (slub, shmem, ttm, etc.) use page->private but don't
clear it before freeing pages.  When these pages are later allocated as
high-order pages and split via split_page(), tail pages retain stale
page->private values.

This causes a use-after-free in the swap subsystem.  The swap code uses
page->private to track swap count continuations, assuming freshly
allocated pages have page->private == 0.  When stale values are present,
swap_count_continued() incorrectly assumes the continuation list is valid
and iterates over uninitialized page->lru containing LIST_POISON values,
causing a crash:

  KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead000000000107]
  RIP: 0010:__do_sys_swapoff+0x1151/0x1860

Fix this by clearing page->private in free_pages_prepare(), ensuring all
freed pages have clean state regardless of previous use.

Link: https://lkml.kernel.org/r/20260207173615.146159-1-mikhail.v.gavrilov@gmail.com
Fixes: 3b8000ae185c ("mm/vmalloc: huge vmalloc backing pages should be split rather than compound")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Suggested-by: Zi Yan <ziy@nvidia.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[backport: context only]
Signed-off-by: Li Wang <li.wang@windriver.com>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b617fb364b15..ffdc71103c2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1178,6 +1178,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	page_cpupid_reset_last(page);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page->private = 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
 
-- 
2.34.1


