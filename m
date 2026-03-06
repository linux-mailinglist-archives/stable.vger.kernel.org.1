Return-Path: <stable+bounces-223342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOunGG/eqmlqXwEAu9opvQ
	(envelope-from <stable+bounces-223342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:02:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D02223BF
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FEC63016909
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF7384256;
	Fri,  6 Mar 2026 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Rp0tgeMO"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE5D39C628
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805659; cv=none; b=i6cXbp3Ju9Q0gzZKgS5ggngrj8yEy9/0G9tE66A2MnN38FETJS0DJR87xaeCCFaTYPVeKJDAxvwCSfj3klvQuuCZWxYxQFwLpzwS7qPeIg52Gc8KTVEEObTg3GZIv3l64K8u7jbzBtIp7lwEiwD3qAzlDSzkSMn6ZCz0EtQPVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805659; c=relaxed/simple;
	bh=rwcJjUw8LB/dFpLm95Eoxg+1cVOCbCR5++Qh1V42sV0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kCwoqmjH912Slk131BIoTDp/z+c8N+5RV+B8Q2f1hBgN9PZMxnEAi7yHtQW9mmBnYZV2Pmkn7EYX8tHYde+X4AwUvrvPkjbekcefPx4T8oiqL5t2Pf9ly8EPApVTfJs3ebyupD0J/+9yb3p0OkTeXe8OZt/Wn4tnl8f05OkouO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Rp0tgeMO; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1772805643; bh=EO4E4RR2NMVQkuWMb7xivQNzUGAZ+NqsTaP5UMh4SU4=;
	h=From:To:Cc:Subject:Date;
	b=Rp0tgeMORSd8GZjC00t1ypC2UPTfPTSPybx+HDlUAdpnXQ0hhEmfNUpsiMyGsu/9R
	 cAMA352/b7WIM+OCvj85Z1+8NOlrW5AukBxBmulNzrcmgePiwk4zHNTvZgG+mAg+3l
	 cBLsQlHyxB7l6sK5lFFHHZ2JJRMzKAu9iaCHyvlA=
Received: from zjh-os.zhaoxin.com ([2407:cdc0:d002::1061])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id EDCACC70; Fri, 06 Mar 2026 21:59:28 +0800
X-QQ-mid: xmsmtpt1772805568tvj671ho7
Message-ID: <tencent_F70AFD1D8067E3D2409764BC1A199DA6AF0A@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb56bAAPd7juxWrgPh++Gjl/gJCYRApNRUup2ECelGqd86l2Z+tAw
	 TZoCbzo3M+9D6TOn7IHUbhmMD37MmH5s8nL5fRdGDbUd0B/cNfv9ZJEtPBIOqAyEwWlOD3BDjaW8
	 SZtfTZviILef/JRGHoWRcJJhu3nuptb2cP0eCO0WjFzOjIJsw/fsozpP1GlOec5VdGFwgGEA1YYy
	 cYl4f1pHa7RIFWIV7W0aYDtp8+gdaA3PynLrX1uNUDCPWZng9oqDNz+8/UA+eQXiUXRAe8/XMiyI
	 mC3JyNWxeSGOLYTgBUXKxHojLiEder0y5fYnrRvgBbSb7Lqh1mZ6FZlm2s7QBIGJycyoWl81hCAy
	 uEes/aCAMz6tZOdkUry9oZBQMADdRrRLITl5k94IxQmnSMHqp9o0IAa7JN4fVvXJaxmT1hoXcUgS
	 o9mXq0kmAKNot2vXg0Qjjn8FjIl1ZJlQUl0k0V3VIgilx1mp7sxT1ImgJd7iqa5LhT2wIyiIb5I5
	 bscaYR/JipocAH8ANcPVVvea51jzyvWq/aI1RoTPvW7pIW03ne3jKhASEbDdWVovu1Y/KsISVxx5
	 8UairAnz8fv8KYr7W1zbpj73Oddy87EpLieQ2GjgnZGipnMIis7jCh6TcQLC0c8g8UKCLipQvLal
	 vikHR2u5gT5Tn8oBSGZCM9R0NDql8tDaRrcUYGzfORj1xZVuPd19DHtwBZEQ99KCzQTIcxUh9uVq
	 rQI1m4lg9s/Wdbl9B4BRXtLB2DTk5hKevSunsuKm48fqIMMNrQnQxs2r5KMR38UdihSq8mbIHzvs
	 iiOENGd9yKbu6pavWV/fkUuYplQv6bnBdJsrEEDlsO1lerIgUytEszjvNoE0Aohg+sd2t6SCvp1E
	 1UN3Ulj2+/tkVlFaThdn5yu9jcIZsqEIpjtkkD8XAKSj54Y1weAHE08wkGIpIx0v+15tj5B/WHvv
	 B9TxhPvHVklU0h+vOOapetmh3RVKCzyZTUAnwU+DG+AWdiUaQtZ8kOF/SDY+7cQ09yGQ+cZW9LSf
	 JmiYyMtXQX2m1pjjMV5esfxKBEQKSqsqNOBEXisg5SKDHdkuu5JcynTsjflAKKS4GR0y71F4KnbZ
	 nPa4sLaY/VFs7j+4GpsS0WNLWwCnmdJvKirhBB
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jianhui Zhou <jianhuizz@qq.com>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jonas Zhou <jonaszhou@zhaoxin.com>,
	Jianhui Zhou <jianhuizzzzz@gmail.com>,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Fri,  6 Mar 2026 21:59:26 +0800
X-OQ-MSGID: <20260306135926.169662-1-jianhuizz@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA9D02223BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223342-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,kvack.org,vger.kernel.org,zhaoxin.com,gmail.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizz@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:mid,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
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


