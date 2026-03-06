Return-Path: <stable+bounces-223341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFRNL1PdqmlqXwEAu9opvQ
	(envelope-from <stable+bounces-223341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 14:57:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AED93222316
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 14:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286AA30AF5A6
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E643A2564;
	Fri,  6 Mar 2026 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QlTjSpUm"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F543446DA
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805148; cv=none; b=HkL4oN3CAvsy5KFvH3YqIVgbRKhBq8v35cI7rnLZvE0qtgFol4OaawbdjtZJ4ucLd0KWMsy2/z8XehSQeMfF3EEXBHE7UZ8zkuGfOuAVvEtomLXdKH8YdJm7YuFQ5FhRcMvIN9m+pazDHFQNA0AyNYKCHiAWCKKaNQm7Rc5ZAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805148; c=relaxed/simple;
	bh=rwcJjUw8LB/dFpLm95Eoxg+1cVOCbCR5++Qh1V42sV0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dDxFcixLac+3kv/5t+xPTozmRflPOxzkLRx+C6qFjLScqRMltV0H6y41GSUCPURBpw9SsSa0nwg9SF9SSuoasKb3axRnfVWL9LFlDFW68PLGCOa1Hmf8D7Kax3avrBeyHMeF8Ciw1ONJbgzw4uF5MD92xU13cSTvMh+Il1BwUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QlTjSpUm; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1772805126; bh=EO4E4RR2NMVQkuWMb7xivQNzUGAZ+NqsTaP5UMh4SU4=;
	h=From:To:Cc:Subject:Date;
	b=QlTjSpUmtmWvPOuQezNx/sei08k3KEESGkiJMyhwWM6g6A2GVtEBvdCK5h2Mjm3VU
	 zcWHV88SN6muVkmBG7GE4o7VoD5jkjK/YXazAgR/wpE7KvLmre+8EilG8h8V5ICGuV
	 XwNmMLhqV6696micSVZB2lJx5UlRi6TQSk6kMbpk=
Received: from zjh-os.zhaoxin.com ([2407:cdc0:d002::1061])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id CFA8F6B5; Fri, 06 Mar 2026 21:51:58 +0800
X-QQ-mid: xmsmtpt1772805118tyaiz4r4z
Message-ID: <tencent_CC5D70B9A0BF33788C1C4E795785FFA8C009@qq.com>
X-QQ-XMAILINFO: OGvxYKx7ShGE3GMdkE5XgFFOwfIX+Xxpn7gZYvZg1A2JEepuh9gXSUlHdyLxTz
	 HvlJ5PaCVpU99D4c4EMgk/R2qv+pKbOLmAWu0zmlK6IRNRz2Qt6o6aJAJRxpA4PM5ZZVvZWIxjzJ
	 C/i4xr1wkTkkS2pdPWDOOKj6ksGfno3lh0Yb7p89VVaCHylOp4m+wmkZaIJWw/WF2PBATzYeVT7x
	 fCdJ86Aarp5q3dWZdsKJh2hC5YC2xIVrWu9Ue+wHu2K2eOZPRcuw0y4BWa+R2lDY6BKFKFPmXPAe
	 VJ3yNk7e8/HLKNmXgDgxtaaR2rmFklVU2yLFNSGI1Jp4PeiT7toVvojjIDYGR/hZCETpLzIXeRJT
	 gTF9Zj93jiFg9HxqBxC7QjiBs9pah/thD/5krM4eghzXeKegzccOas5egNPNnYEL/t+TFmHgldtU
	 LJv4I7B8v+/iQZOcoGmC8e3fZ6ypnrKFo42Rb59QyUc4HFtqTAWvNlkkOUd2x0jjUHH7KKVsOuny
	 IVPSO74bV5ERkiHq+Y1Dtamsgi7KtOP9im7EvLq5222Y5mD+QlNIsdcEtmUKP0j4xooqQtu9vC/+
	 6gZ/Rdk1EWE9IZzG8GT+bsEDXGFqUofDRG8gC8adzQ2Y0/UFTqLFYuu+Q7Cm7sOwV5PeQg19+rnG
	 TmAgvHDIcgETOe8WE/G2NAk5zLiLrxOcc48u7RBCBrzB5rcF8lV3pne/Xueyv66Xdh2z4tVAlP6O
	 eXC4QPxTT79UMsgdRSz8t1YfXjKHoGXj8TVxcv4BwCUMT1uHQdgg212onyEH6iaKDV74tOeB6ipq
	 od/olS4wCvPwxlmXLLJvKE1yEIUTb6LVovtPsCqOfjt0W9CNXf0uFPs3o/983adCoDYU8scvGmOo
	 gE7ClYt5wqUXWKhTHQU7XijaV82BYmkyOOsdOurBKe7ZmLZGZRSgxmapyH/gqcEEJuCfmepIGbZK
	 2inDT884qR7U5D92WNVFqlHXzo43jSbDx5VWYx+iSyfKwnD6CgwPUh/Dly/hILdjW9gqa60xRRVz
	 RnvVpUXUW+BZfv/feif1uaL1IGywU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Jianhui Zhou <jianhuizz@qq.com>
To: jonaszhou@zhaoxin.com
Cc: Jianhui Zhou <jianhuizzzzz@gmail.com>,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Fri,  6 Mar 2026 21:51:54 +0800
X-OQ-MSGID: <20260306135154.166342-1-jianhuizz@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AED93222316
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223341-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizz@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,qq.com:dkim,qq.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Jianhui Zhou <jianhuizzzzz@gmail.com>

In mfill_atomic_hugetlb(), linear_page_index() is used to calculate the
page index for hugetlb_fault_mutex_hash(). However, linear_page_index()
returns the index in PAGE_SIZE units, while hugetlb_fault_mutex_hash()
expects the index in huge page units (as calculated by
vma_hugecache_offset()). This mismatch means that different addresses
within the same huge page can produce different hash values, leading to
the use of different mutexes for the same huge page. This can cause
races between faulting threads, which can corrupt the reservation map
and trigger the BUG_ON in resv_map_release().

Fix this by replacing linear_page_index() with vma_hugecache_offset()
and applying huge_page_mask() to align the address properly. To make
vma_hugecache_offset() available outside of mm/hugetlb.c, move it to
include/linux/hugetlb.h as a static inline function.

Fixes: 60d4d2d2b40e ("userfaultfd: hugetlbfs: add __mcopy_atomic_hugetlb for huge page UFFDIO_COPY")
Reported-by: syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f525fd79634858f478e7
Cc: stable@vger.kernel.org
Signed-off-by: Jianhui Zhou <jianhuizzzzz@gmail.com>
---
 include/linux/hugetlb.h | 17 +++++++++++++++++
 mm/hugetlb.c            | 11 -----------
 mm/userfaultfd.c        |  5 ++++-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65910437be1c..3f994f3e839c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -796,6 +796,17 @@ static inline unsigned huge_page_shift(struct hstate *h)
 	return h->order + PAGE_SHIFT;
 }
 
+/*
+ * Convert the address within this vma to the page offset within
+ * the mapping, huge page units here.
+ */
+static inline pgoff_t vma_hugecache_offset(struct hstate *h,
+		struct vm_area_struct *vma, unsigned long address)
+{
+	return ((address - vma->vm_start) >> huge_page_shift(h)) +
+		(vma->vm_pgoff >> huge_page_order(h));
+}
+
 static inline bool order_is_gigantic(unsigned int order)
 {
 	return order > MAX_PAGE_ORDER;
@@ -1197,6 +1208,12 @@ static inline unsigned int huge_page_shift(struct hstate *h)
 	return PAGE_SHIFT;
 }
 
+static inline pgoff_t vma_hugecache_offset(struct hstate *h,
+		struct vm_area_struct *vma, unsigned long address)
+{
+	return linear_page_index(vma, address);
+}
+
 static inline bool hstate_is_gigantic(struct hstate *h)
 {
 	return false;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0beb6e22bc26..b87ed652c748 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1006,17 +1006,6 @@ static long region_count(struct resv_map *resv, long f, long t)
 	return chg;
 }
 
-/*
- * Convert the address within this vma to the page offset within
- * the mapping, huge page units here.
- */
-static pgoff_t vma_hugecache_offset(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long address)
-{
-	return ((address - vma->vm_start) >> huge_page_shift(h)) +
-			(vma->vm_pgoff >> huge_page_order(h));
-}
-
 /**
  * vma_kernel_pagesize - Page size granularity for this VMA.
  * @vma: The user mapping.
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 927086bb4a3c..8efebc47a410 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -507,6 +507,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	pgoff_t idx;
 	u32 hash;
 	struct address_space *mapping;
+	struct hstate *h;
 
 	/*
 	 * There is no default zero huge page for all huge page sizes as
@@ -564,6 +565,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 	}
 
+	h = hstate_vma(dst_vma);
+
 	while (src_addr < src_start + len) {
 		VM_WARN_ON_ONCE(dst_addr >= dst_start + len);
 
@@ -573,7 +576,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		 * in the case of shared pmds.  fault mutex prevents
 		 * races with other faulting threads.
 		 */
-		idx = linear_page_index(dst_vma, dst_addr);
+		idx = vma_hugecache_offset(h, dst_vma, dst_addr & huge_page_mask(h));
 		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
-- 
2.43.0


