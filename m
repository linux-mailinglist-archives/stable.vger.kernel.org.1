Return-Path: <stable+bounces-239981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGLqIqZz5mnKwgEAu9opvQ
	(envelope-from <stable+bounces-239981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:42:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92915433004
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A22983008CAB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4603AD503;
	Mon, 20 Apr 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS52HPA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D339B97E
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710170; cv=none; b=L7+jj1FXR1xJxjWbZmzWY26jxMwGvZhIau2hyTFIW9nS9QEVksyK84C2davRHTJQ7PAqvYwD3k6MIEGGGcHzf2kVztu+YWnzkvb+p79TV7GiP/DhPK8Lm+xKlPg5HHI9TQaa5JZWf70iSBK582IyMjTYzKCU6QxCUJdjiS7crRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710170; c=relaxed/simple;
	bh=FgfV8idmq+/5DrvqQhKWSRVDGsL7QFqJkivyD0SbjTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UufEHs1Ayisww4IyH/H+ySDu3P7lsd1uJJDC8/V9G32tyfhg4Zk7YCxDzAz7KqcvsXxQKp/yRidMAeLC8sRX6crlTjqXwwhUwajAo6bWfrV5yoCQgo1lsOYWY62xRFYBFnHa2ycgd2lcB8Ty8gT0nmdH0suETIG3kGjCzk6xO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS52HPA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142C8C19425;
	Mon, 20 Apr 2026 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776710169;
	bh=FgfV8idmq+/5DrvqQhKWSRVDGsL7QFqJkivyD0SbjTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IS52HPA8kG2KmXu8bLPwZ/sYtBG5r6OITFklMvlkryaglnahCdfsnvEHF49D+CgDD
	 XIeQQqtU/6CU1Dj1MUMm9vofJnjKSNtnte1hyS/jwz5LWTF94S6zJ6Sas8fsyA5E9M
	 TL6cRM1n/kIfsjNxGy7A7yzgDLWsUNwWUd1q1VY4N+vr/H6zUP554540E6Hi5uDY9o
	 mskJk1VwZpu0Vsyj6liLqnVA07cGOZiLz4r9haUZSDTEX6vn8JXPSw9QyLXxhzC7vz
	 bOAnKzOh+Xv9Sm5JorwHa9LBjmXmwIGjAxE3FP8wM99/2t6Cq7sdwOpwZoTHj9dCvM
	 oYtM0Zu5aHNlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianhui Zhou <jianhuizzzzz@gmail.com>,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com,
	SeongJae Park <sj@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Jane Chu <jane.chu@oracle.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	JonasZhou <JonasZhou@zhaoxin.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Mon, 20 Apr 2026 14:36:06 -0400
Message-ID: <20260420183606.1528081-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042007-casually-unaligned-fc88@gregkh>
References: <2026042007-casually-unaligned-fc88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,kernel.org,oracle.com,redhat.com,google.com,zhaoxin.com,linux.dev,suse.de,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-239981-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,oracle.com:email,linux-foundation.org:email,zhaoxin.com:email]
X-Rspamd-Queue-Id: 92915433004
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jianhui Zhou <jianhuizzzzz@gmail.com>

[ Upstream commit 0217c7fb4de4a40cee667eb21901f3204effe5ac ]

In mfill_atomic_hugetlb(), linear_page_index() is used to calculate the
page index for hugetlb_fault_mutex_hash().  However, linear_page_index()
returns the index in PAGE_SIZE units, while hugetlb_fault_mutex_hash()
expects the index in huge page units.  This mismatch means that different
addresses within the same huge page can produce different hash values,
leading to the use of different mutexes for the same huge page.  This can
cause races between faulting threads, which can corrupt the reservation
map and trigger the BUG_ON in resv_map_release().

Fix this by introducing hugetlb_linear_page_index(), which returns the
page index in huge page granularity, and using it in place of
linear_page_index().

Link: https://lkml.kernel.org/r/20260310110526.335749-1-jianhuizzzzz@gmail.com
Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
Signed-off-by: Jianhui Zhou <jianhuizzzzz@gmail.com>
Reported-by: syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f525fd79634858f478e7
Acked-by: SeongJae Park <sj@kernel.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: JonasZhou <JonasZhou@zhaoxin.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ placed new `hugetlb_linear_page_index()` before `hstate_is_gigantic()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h | 17 +++++++++++++++++
 mm/userfaultfd.c        |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 81b69287ab3b0..32c9bc8c750c5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -783,6 +783,23 @@ static inline unsigned huge_page_shift(struct hstate *h)
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
 static inline bool hstate_is_gigantic(struct hstate *h)
 {
 	return huge_page_order(h) > MAX_PAGE_ORDER;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 904095f69a6e3..9951b4f42c65a 100644
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
2.53.0


