Return-Path: <stable+bounces-223343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCgtLKzfqmlqXwEAu9opvQ
	(envelope-from <stable+bounces-223343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:07:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B92224FB
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDAA73058E11
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDBE3A7F6F;
	Fri,  6 Mar 2026 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffyWdXI5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A93313E2C
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805994; cv=none; b=mMfATXM7seRBPAp8Uiyx2H6Q3WH0ESWolpp/tR9O8j4NmpZ+lar8BE43DNfUJqlDEaDu93TseIkgjN37+aL+Mcew09yR0EXm3y4XM9Fvs8jHkplbwIwzWECuB+H7cI42ynmcFR4KPjkLq7PmGRt+BAEnAcebZcZzQkztqc5p8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805994; c=relaxed/simple;
	bh=pew9Y3nMgHOEvgenC0yPfi4+wWkxb9Nhz+zKDRW1zKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RckSgT11+a54nJiifx4fd7yvmaHTCx//gGWKvo7j58E46nKAKkSaseI3xQYLe+NOUK7OLM4ZFA5eLRyHICQBldaCct/mS1Ir91LwiiFnjS/HVrp7lg9/VmaPbQdYpQhl0pZ2MBQ2uvtuotlPb2ANc5k86mrBFmu9d0kApT2xVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffyWdXI5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c738b98bfd9so976964a12.3
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 06:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772805992; x=1773410792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W13+CBFURjvfUajrgf80QK1S6lJ7DWAdvvvI450YWW4=;
        b=ffyWdXI5UvuPr0Bg9ZNrT1tSJh3KYdGxbNzSkprepTBimHdWvmRrz4pAy35r28gtpQ
         JcN+82CXKSDQbeVxI+PQKMlfz119y1DphWKa0MK3/HCXF3Ii2mctqQvgpvjkz6f5N3qk
         epLD/xtAeIDWxp7GET68B/T3J2doLqQblp9Q5qYzRefvOHflr4R1xHuS2ToiMQtLovy4
         uY2noceH/itBXdwPwwQ6YEhMDT07DPYHGVzwF0q1auEFlt031tkuj5vIVyGCUfDgSb7x
         UnHw0fnsNJwQ7izacmmT/t8Neu3oytKWNMoOJSlN/PUjrIm1856t70MuAugp6/mNdLU/
         rizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805992; x=1773410792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W13+CBFURjvfUajrgf80QK1S6lJ7DWAdvvvI450YWW4=;
        b=ht5griGDkzNLuc9NgFb4kpqie9wenO74Dp2gIQK+awUyH+dzMxQ6JhhNI5V7rjCM37
         PkNrf7uv5US+XfQ462TcFFHL1PLc16/yciU7sAInQaLyADPQINnnt6qzRgXTGWIqn9Ml
         fvJcpBw7y+7rRrVI1bGoQI7wT5kXu9vfxD9l0bHY6+z5++C3XRr6vmfMCDvY4qjdp/1O
         a0SceWbq1ksPLYc8cefPVLUiwWvJgkrXiFLohFagzu+CDFj3Ewq/XIEDJVznPQH7AxtN
         +8EZoKWFLrhl30N1F35GMVLcjk5Ox/cRcm2OsL2ZEv9SPKY4tQnWdHTLgitZCA9OsvGK
         huBg==
X-Forwarded-Encrypted: i=1; AJvYcCUXg/IQhNeE6aaOU0o4UmZid6sfPbrnsfQxbYe81C6qFJSdE0CxhwBX71RvWvVQ+ELaEOnn/0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YEYoMBL5HdETKDvOvWi7kS02eibXadkAmAE/OEE7naDgldVg
	y5SjnpX5/1LCQR1Lhna8whA2/NG5Iu8YH6Jelc52PFMxRAGtuZYeQLbg
X-Gm-Gg: ATEYQzzOwHH3/8mMQgCbiGVBH++5ZEyOq+xVv3NZkQ8EqdC2s6Mz96ctlEE7wztcaTX
	6bpAnlp7nGiKTh3HNQW/btzXI+G8eJRC+4wIOwFVPOQS0GgfMjofYLDaODaNd5XjlT6YhC4GAxr
	msiS8Z7qIXt6O+bwu/wYuPpZHkz3xg6iKkE8+3oie5dIUzizbRMF6hdZIOz6BpC0J6awutoSoRK
	/H5iFgu8GI0iuaV9761C8ZBGI1EXXR6E9e+CfFKCiTBkt3nZuTSTgSVCKvW/cy6HUwsEEj9qfkS
	gQtkgGa7Gd4XNET+7dabUuWtatzBzeQx6HubxMcEZkRkYQyJzH3aHq1vuyEgQiPYFYEQHRG+J/o
	r3uACwOek6GP9Bxhsuky6JZLXlQThKsPsEPGEVb/+zYy4LmX/qNk+Y8/1dFiLKV0DvEPJY25h6r
	inx9doe/iy71xnTjIhZUV+kPajS/N/KAsksBTB/8Y=
X-Received: by 2002:a05:6a21:514:b0:395:3677:2be4 with SMTP id adf61e73a8af0-39858e02140mr2687015637.0.1772805991793;
        Fri, 06 Mar 2026 06:06:31 -0800 (PST)
Received: from zjh-os.zhaoxin.com ([2404:7ac0:642d:3126:54a4:fbcc:e0a0:ce02])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e16cebbsm1786713a12.16.2026.03.06.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:06:31 -0800 (PST)
From: Jianhui Zhou <jianhuizzzzz@gmail.com>
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
Date: Fri,  6 Mar 2026 22:03:32 +0800
Message-ID: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A8B92224FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,kvack.org,vger.kernel.org,zhaoxin.com,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-223343-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizzzzz@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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


