Return-Path: <stable+bounces-223863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPYgKfr6r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:05:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D7D249F29
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F105F3030126
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25F381B07;
	Tue, 10 Mar 2026 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3U0XS5Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A8383C64
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140703; cv=none; b=F8VITdugAw6oGp4fqV5eup55ScluXcnqJhJ8SNqjV5sjcFMmREs05+ir0l1zkbUUDc8uv28ztTc9PO3COB8ftDmq94xQ4SjmIEnGDexZmYzLxTIXA1yA4Yfhm+YO/e71jFC/HGafGkdspnVM3dsQbM2IBTHRPHn/5s22gw3PMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140703; c=relaxed/simple;
	bh=y/Y49EAr01paPWu39qxKvb9Xx3oXrJtEm6wtVh7OKWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZqzTKOYl1N1RZuwyMh+6/+c1ELO1TCAVH8YuWb6XIpYo5Bfphrszlu350CRp0iEEEFQZDOrXUfe8DW+nbppKoBVDqJwaFvbCyLvcKnIYwWdkF8nVr44YSvfsR5LtJFpm3gRjynet4sj7ATM0450Nlvu4tu/PAQ3z4rdUTBuwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3U0XS5Z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae4e538abdso89446655ad.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773140701; x=1773745501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGNmukUV6ZynmQPnufsr7pSOWgOJq6CQN8CVvI47374=;
        b=Q3U0XS5ZpxJUk8sMw14B8ohs8ber8RLzyDEdXMsmHMs9Q1jHZ4ocDFsxnUaUwKQ1YB
         WqBVU9sWYR9Yy44OfjP6NxRin3xjgpfBbp9y+/0Lpw/ROIZ/4qhZF3khl0vPnz5CNj6c
         NSx5JQe0iAn1AMZ+50mRhoDQzsv00khZuMKdQnJiBZPFDnSypDyzb3bM7ofEzYyQYFCk
         HTjGrJa7z+hHj6Y/iWiRdCvk+C1jsGcfyHr3gWSHTt6ofJFmqhpkziFhtVfZPWTmG04P
         hhmvdWMZz50wkzp9y1KT+po/HIuRhnEbwfS3go46Hs3QvhyS0fSpvFskf1DYtQbhSmJ9
         nong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140701; x=1773745501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GGNmukUV6ZynmQPnufsr7pSOWgOJq6CQN8CVvI47374=;
        b=VN7Cbj5nbEssHd29DMT18q8lXyRzTdK9OlnqR1UwLBH8SVq1wv7tf3RwWL4vkoHTNy
         eSM6xrJP9cAa9WkEescVbeBTY+8OCkaZmAdaJTP5XsTPCUJzQZWlC+r+JhmBLkpsnOEA
         JpMoQOMZkjSDrq2vOAqy7tjzWi4sJnAdZY9E1UpKImzZlxN9OXwPb63ERc2FZYBl6sXj
         JA8Z7V3T/eNFIpC/SMiOabtfOnpkOgdIHOzF/oHUn0An9clnZVuZ/KtU6hHxnTWOfZt0
         0XAFmQevONeZYj/aq0RFzvre0DAWFZAg68eOeAbQMFkFuxdlIyr+/XVaVIuS98H1ihFo
         PLmw==
X-Forwarded-Encrypted: i=1; AJvYcCVw840pVT2HnzSBEdRXvP81YU4xxGqcueFfA/6X3iX1xHQ2FBct8oHrXlIqZpOvidAhsZogEa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIW3Y56Dl2DALd614fW6ihRq+og85TkpLK6ekP5SvtVZaJrPk
	EE1XkNJk6qk8jIlcIfGnXE1onJ4C/b4Zo2JuJG53KoJRzxuz9N92q6Rf
X-Gm-Gg: ATEYQzw6r+N9PqX22q21o1rxR0UUAwnnMpwpNCvEiry1iJ4l0HA2HfmtgemgRqbksTP
	PRyccaBpNYtQMWkOieOx8RR+w9WL6WMG0NMLDUR77c9Yhg9iLvBEcbYt4geHYCBzWZtbHkchiGr
	TK55WRkPyije7aah8PQ5GHeCqq3QsObGSl3PUyjh+I8AumgMT4vsLCNN8RyA3aTTg6RVxNw2TnS
	ratfQM4igv7kxsVpOt7xE4/VsX5by4XSbtDBYV7Zuk4xuu9ZS4uq6CHJCaJaKRjwjzx+Du4gTUL
	/KUdhxIlPZqYktNLVx1nJ49Q+Wj4I85YYBl+cMrpxGpWOwi7rxkywOVBAOUjt8JsNc4K8CTFemy
	9hdys20/QKbIcyiM6OtFbcCONkHXA80ahhoy9T0NmeLelG0MLCNyc6JQwAZEDNU/9AgAeOJuqSS
	+StGaFGFt4dfLCwnHByR5ycOEohq+3H5PGXI5FKIM=
X-Received: by 2002:a17:903:2283:b0:2ae:5223:59ac with SMTP id d9443c01a7336-2ae823849famr139615335ad.13.1773140701141;
        Tue, 10 Mar 2026 04:05:01 -0700 (PDT)
Received: from zjh-os.zhaoxin.com ([2404:7ac0:6c5d:6b3c:b482:76f9:3eac:e82d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e5c167sm141829815ad.1.2026.03.10.04.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:05:00 -0700 (PDT)
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
Subject: [PATCH v4] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Tue, 10 Mar 2026 19:05:26 +0800
Message-ID: <20260310110526.335749-1-jianhuizzzzz@gmail.com>
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
X-Rspamd-Queue-Id: 09D7D249F29
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
	TAGGED_FROM(0.00)[bounces-223863-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizzzzz@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

In mfill_atomic_hugetlb(), linear_page_index() is used to calculate the
page index for hugetlb_fault_mutex_hash(). However, linear_page_index()
returns the index in PAGE_SIZE units, while hugetlb_fault_mutex_hash()
expects the index in huge page units. This mismatch means that different
addresses within the same huge page can produce different hash values,
leading to the use of different mutexes for the same huge page. This can
cause races between faulting threads, which can corrupt the reservation
map and trigger the BUG_ON in resv_map_release().

Fix this by introducing hugetlb_linear_page_index(), which returns the
page index in huge page granularity, and using it in place of
linear_page_index().

Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
Reported-by: syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f525fd79634858f478e7
Cc: stable@vger.kernel.org
Signed-off-by: Jianhui Zhou <jianhuizzzzz@gmail.com>
---
v4:
- Introduce hugetlb_linear_page_index() instead of exposing
  vma_hugecache_offset(); call hstate_vma() internally to simplify
  the API (David Hildenbrand)

v3:
- Fix Fixes tag to a08c7193e4f1 (Hugh Dickins)

v2:
- Remove unnecessary !CONFIG_HUGETLB_PAGE stub for vma_hugecache_offset()
  (Peter Xu, SeongJae Park)

 include/linux/hugetlb.h | 17 +++++++++++++++++
 mm/userfaultfd.c        |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65910437be1c..67d4f0924646 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -796,6 +796,23 @@ static inline unsigned huge_page_shift(struct hstate *h)
 	return h->order + PAGE_SHIFT;
 }
 
+/**
+ * hugetlb_linear_page_index() - linear_page_index() but in hugetlb
+ *				 page size granularity.
+ * @vma: the hugetlb VMA
+ * @address: the virtual address within the VMA
+ *
+ * Return: the page offset within the mapping in huge page units.
+ */
+static inline pgoff_t hugetlb_linear_page_index(struct vm_area_struct *vma,
+		unsigned long address)
+{
+	struct hstate *h = hstate_vma(vma);
+
+	return ((address - vma->vm_start) >> huge_page_shift(h)) +
+		(vma->vm_pgoff >> huge_page_order(h));
+}
+
 static inline bool order_is_gigantic(unsigned int order)
 {
 	return order > MAX_PAGE_ORDER;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 927086bb4a3c..5590989e18c7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -573,7 +573,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		 * in the case of shared pmds.  fault mutex prevents
 		 * races with other faulting threads.
 		 */
-		idx = linear_page_index(dst_vma, dst_addr);
+		idx = hugetlb_linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
-- 
2.43.0


