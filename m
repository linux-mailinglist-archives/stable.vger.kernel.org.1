Return-Path: <stable+bounces-223481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFH8Dhw/rmndAwIAu9opvQ
	(envelope-from <stable+bounces-223481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 04:31:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD56923388B
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 04:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F471300B044
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 03:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30D4270545;
	Mon,  9 Mar 2026 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K64wNThA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5217A2E8
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027087; cv=none; b=KUGQGgq7QQwmmgISrJ6xUZBxxdGRLxKd7LR4BkMHEEx17z9vLp658mkmhs4yiifJN5XRw/ajYf5yFvt5Uoz5coNimix1NKKg1WEbZrK3YOXiTlbXroTxjJg/6d6p7rLfbJD8gdTLT1HeLGBeTJl54Ppt3DiOojfBbisa0DdNJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027087; c=relaxed/simple;
	bh=WK3VMsmiVA4UhKOimIlT2Y7HmxJOqocaXkxmjVqvFPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fH65VQSviTI06V4K/GJ2lYWgABhfEAcgKp8J+Dahbfvu/8pUFyLi9aDIkaqI3dX+HVULCOWMVBYnmymniAUcLLOR0Qoj6LwCQv0dv6F6FuudoU5BFgeU4KHTvs44/i9kFxdIujUnZwlIbok8aIjh7639LUKvgj/htMxpxfB+yF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K64wNThA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae5636ab04so77955345ad.3
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 20:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773027086; x=1773631886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRG8W6zvaeyPSQPZSzI9vt2gCkqaLRuFzjk0nW6pVNs=;
        b=K64wNThAN41wzjzsTSMM75vXMynf4gUV0dr5llI/WU2mUH5eYS+Nqv9G1uz0h5Zomr
         wmbrR5C5P8EF5FzSHifcRdL6BPferxAwd2TX5g1hFqIRF4ybh8s9uLmZT5wcoiO7/QhF
         xLLJbA1c+I7UqSP+MRzYEBHj/exYnoCg9rb5HhXel55s5VJMCtw2Cmyb1DwUhAay4leK
         sotlIi701g0zyAufk5szN4yd5bHt0uIRg+MNFuO5jh6gA65Ak+LJenwJJWBBCDf0WtH6
         X3LywqTY0tLBq/AIuAvy01WpRkT12Hxe2ccQDzNhQAaHUSHA17fQgKtRfh5z3GQRS18U
         0TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773027086; x=1773631886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRG8W6zvaeyPSQPZSzI9vt2gCkqaLRuFzjk0nW6pVNs=;
        b=uhO63Qp9b/cAQFEkz51NYK39j6URkI5ij1K8TbFDNcz1s0xz4ZMTRXeg17noOasqh6
         qU4SqWtczj8CjBduTMONTx0OQQMrrI4mVp5GunbrN6NDdf7SYf3ZMFCGucQMy2B1uvjJ
         6Zufe0yUweqPs3goEFz6ixTKt30gbAOKFb2y7vFH7Sge1Vqpmxr4TlR9wIvc8PL3a3ea
         QREvViMw2xdz1AEu6B1ZO2GOyrzBwtZujsZQ9Zr4iIhQNoTHSOl+FmNZqdhvGF4tLpVw
         GGRROXCfLbvSJ8st5VHd7T4JcA6RPKSN3raY3pklOL1d1t8SzpGz2mxG5TAzUpPkgV22
         CtRw==
X-Forwarded-Encrypted: i=1; AJvYcCVqRf+vEX9gy6TlaB2teDslLMJqWrhiIICnZ1HxXTS61GOwQulzr1wMr2GofrTGjN3XyYbTaIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0ouDM7Usj3s8R1NnZosE+8osZyl+EjZOcXeo+9ffi7Kvr8UM
	NOkQtSahNmLaMEkWejJlrPyukZaNoM/LL9nDdmhkufqUD91Dv7seY/Nm
X-Gm-Gg: ATEYQzwDk9wGX4+jysdD79dh5gb8a43DVP1pSj4YdyKvfvLqtXz2Almhg4vEJWOGd8u
	gbpFar6nJv33ILHojLUpHcuuNZ5ALkSIUOEE8DlnPe4uOE+I8y4U2UuKNTPhd2C2i6rWp7bmvrb
	Oml4501PWVKE1BJ2t6YrjLuQo8HQEBtgE+wHRG47+A0li55QFkiQVwO+d5xXi2X/n26gyLfV5Sw
	Ed2FC9fboNeEgDj6v7DmovQCwWe9PEXKtw99+8dtXVfSrWQ2S5o5xyVcc6ykcxRan3sa6bcwSE0
	gk3vWNayt/dcrqhWYTWtMeTNefaSqlHli+yxVvRMnLcfK8Nq/6A2BaY1ESQzr9WUAYyEeBL6Zzq
	15i7fXpd6f/aoeRpX0JswOWSgyLvUVNcT+RMk4+/zlmUN+vJikPGzprcuBGUwHUfSxvI2Fb9kP4
	4MiaaqZAyS1L4NVdteNc41DSO2WVuv6fzswMAiLg==
X-Received: by 2002:a17:903:32c9:b0:2ad:d5ea:4c89 with SMTP id d9443c01a7336-2ae823a296emr93888925ad.22.1773027085592;
        Sun, 08 Mar 2026 20:31:25 -0700 (PDT)
Received: from zjh-os.zhaoxin.com ([2404:7ac0:6c91:c65e:191e:9b9a:a3e:cb03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm123370615ad.92.2026.03.08.20.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 20:31:25 -0700 (PDT)
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
	Hugh Dickins <hughd@google.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Jonas Zhou <jonaszhou@zhaoxin.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com,
	Jianhui Zhou <jianhuizzzzz@gmail.com>
Subject: [PATCH v3] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Mon,  9 Mar 2026 11:30:53 +0800
Message-ID: <20260309033053.220012-1-jianhuizzzzz@gmail.com>
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
X-Rspamd-Queue-Id: CD56923388B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,google.com,zhaoxin.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-223481-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizzzzz@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,appspotmail.com:email]
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

Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
Reported-by: syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f525fd79634858f478e7
Cc: stable@vger.kernel.org
Signed-off-by: Jianhui Zhou <jianhuizzzzz@gmail.com>
---
v3:
- Fix Fixes tag to a08c7193e4f1 (Hugh Dickins)

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


