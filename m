Return-Path: <stable+bounces-223425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCYrGOE3rGkbnAEAu9opvQ
	(envelope-from <stable+bounces-223425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 15:36:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C7722C317
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09FA93045AAD
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73173392C55;
	Sat,  7 Mar 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqRXE7GT"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D77AD2C
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772894174; cv=none; b=mwIwUG1cHU/+waoI19P3RPxodGG3GxDdskoKIOsM2AC8JGr4Wvu4HNBnMgv+VMgZgD3OCMV/1bbXvs2rcz/PxAYqpErgT3ZNyvMY4z30v0wG3mlkPM9VufsUCGYa2YxIWNI0ULeuHyY2uKJpJFpFRpA09p4xavrpXLgMUj75szA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772894174; c=relaxed/simple;
	bh=tgHk/z7k/HzBTGlZ10i9USwUqv11xqNQR7L4O77YHC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLXAnG6efrb1pgLfMuaq3IK8zOMgz3HvSd3ZiTcWg1P8+5c/Um9xOzSxRtMWMnVOhTVNMe+M3va4eNgP3YJKTzw4KhRTRQgP9F4mPV5EIdPVHT+uSxkz7mdl1jyYE3vQBNfN7njlIC3WycB8MaDIOe6L2fMB8LvAdxMQmH3P6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqRXE7GT; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be26842fd5so2223811eec.1
        for <stable@vger.kernel.org>; Sat, 07 Mar 2026 06:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772894172; x=1773498972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK4cahr2Z+5GEumxXm/3Zlvde4k/k71gu3JdZggtk9Q=;
        b=QqRXE7GTjc0jj2CDIr4k1YWdq+KFgXn6kvG6RYz3m2rpo9I/4IokP6HirRxZZgA3lG
         nkPJbRhs2cGbBfcEEgamiJQHHsoiOYVW1wmBSMv7E3MMiQ0dRofMHns+swW//hXDwItV
         dlFg03Lqcim4oIYMeT2+EEZW4wW4L7IET/aGGh9HWTAqP6B0m7YvNwoTJXB67tmU0Khw
         hOTcyuaBufyUd9Q3DSMSRhRrSc4Aqc2pAxIDkTxMSExdmuT5bNHvHnLaJGuJw6n9FByZ
         QhaPK0xdE8bq/fSGnZwFjSXxhd6ku7BgxsFFR8fycaUPAJabvOZAGTucMjDTSsH6Ez9i
         VhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772894172; x=1773498972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FK4cahr2Z+5GEumxXm/3Zlvde4k/k71gu3JdZggtk9Q=;
        b=TAXYSRGIKVsCVcgngbAOnUmIPu5JTqzGwL3Aco+OwIKEXwpZ3osroDot3yfinhJcL3
         OYYAtcyM39zFcFcoZxzLwPG/NbjLb6VsTzCAfnE725jj9aiSHmS8KdEW2xiuvUcJ+Fag
         HT/Zuh0SghmEHpeGLngWK8kP53c8mmE7cZwrBZxS91IwCL6csrolPFMEkzD121KnYB/f
         JAY5cHU0UBLLU90ggeHOwELGnZkqO7xgr6T7oGpXg8Khz7CJYgzd/RVj9aNpxEBA879e
         UthCfgYRvhiA5uQym3dseH3DP7KVYttR5oGOv06hqquG4IUTlYq2YOPKkG788m2QfXjN
         2V9w==
X-Forwarded-Encrypted: i=1; AJvYcCVpNYiG4fn0hkT4AyJmoNqId/4Fw2anM9Hd8GFhP0jF2hH0BRvJB9YNnn1T9vApEGuyMI/g1JA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfkleq9JDZesadw1KByJXC8JVfGDIU6tcAOLM55jbuZfLNSFGT
	hCNu+jC7/gQedRKGDsjWQkhhyJQe0YWw51fTmaxLY8Zm+LDCdxgLWHyv
X-Gm-Gg: ATEYQzzk0h427UsM+70JFNL9pHPg03CdNnIWyOlDzSXlPHGLnkljzLPHSuTm5WCkMho
	t7KZEbSJxwIHGQVGdTb4F5uUL8b2NLbvpvWE8v0Wd7/JkB1QxsRRyfMqwpKFTyVHPe4frpLBkUb
	k26cD+979QMGWG/X5iWMNDix0BkNMjlX++Le9r4g1ioQIzk2hN/ll7HyHzfOPuGvehPcc9Y4GvA
	ZVMpQO0RvpjOYiNnDEhV08jG/3+EIOih/+Wy7tSg5KEHIj9Ye+W2KOaoOa4Ck25M2Aq7HEgAk7t
	0/kzhBcr8yG1xcr83fvknAH3p4n7t4kTAJgars30spiXboSb7jjYtqIC+1nLG3XEdIMvljmkPmu
	q4ylEo7VdxKRerC9ynHek+AH9o0TYcT9m19vzHAcnD8s3GyLcXPERMpuE81MEaPYJniX1iR7Mi+
	Nb517w5Lffnns/NnHHhg==
X-Received: by 2002:a05:693c:60d3:b0:2ba:a7b8:3fe9 with SMTP id 5a478bee46e88-2be3e18f4e7mr2691990eec.3.1772894171949;
        Sat, 07 Mar 2026 06:36:11 -0800 (PST)
Received: from zjh-MS-7E01.. ([2602:fbf1:b002::1032])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96f64dsm3481762eec.27.2026.03.07.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:36:11 -0800 (PST)
From: Jianhui Zhou <jianhuizzzzz@gmail.com>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	SeongJae Park <sj@kernel.org>,
	Jonas Zhou <jonaszhou@zhaoxin.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com,
	Jianhui Zhou <jianhuizzzzz@gmail.com>
Subject: [PATCH v2] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Sat,  7 Mar 2026 22:35:39 +0800
Message-ID: <20260307143542.179953-1-jianhuizzzzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89C7722C317
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,zhaoxin.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-223425-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizzzzz@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

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
v2:
- Remove unnecessary !CONFIG_HUGETLB_PAGE stub for vma_hugecache_offset()
  (Peter Xu, SeongJae Park)

 include/linux/hugetlb.h | 11 +++++++++++
 mm/hugetlb.c            | 11 -----------
 mm/userfaultfd.c        |  5 ++++-
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65910437be1c..f003afe0cc91 100644
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


