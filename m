Return-Path: <stable+bounces-217250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFMFJcODlWlrSAIAu9opvQ
	(envelope-from <stable+bounces-217250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 10:17:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C65C154A8A
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 10:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E74DE3007C8B
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542D33B6D0;
	Wed, 18 Feb 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJzLebHv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639933B6EC
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406191; cv=none; b=AAQXkkyV17bx1HpVXj9pgo6aePMeTmrkORjNqudR3MwJ1XPpPaXk2Vlfvqsu51TNiCzwPdwsP7BlCLGN4qz36e/7tGSOOTjAMaG34zuY7+IQvCWc4cI0+2D1p9l/EZgduMl3dwRKTgdzRIljIPYOXLD5uXSMbbfdGlD1uCeFYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406191; c=relaxed/simple;
	bh=ppf9OvYdBJc2dErMbeYp649Jg27CTKyvZL34q7/d1x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOxP79tAmrw8QazqBYmENxM35Qp80DFuCDmld6TdDoYQhl9V9120W72LWowLJi9E19aTrr6jXQSjcrbujzs949jBh9IU7HNr5ufzQaZLYeUDDLUfyA/bm6uUbSIktC5+c8YRRWj5REfHuuDC6RA38ays07XfYYneLeRIrw6MgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJzLebHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C11C19425;
	Wed, 18 Feb 2026 09:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771406191;
	bh=ppf9OvYdBJc2dErMbeYp649Jg27CTKyvZL34q7/d1x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJzLebHvw46Bwf+3ndXp1UQobNZ8HBCK+xk7JuTqBoFdQiF38q+b/cAP/YYQv4pgy
	 ICmtHt6f+n1JxdKleWo+hsiDruv+iEJrKFq8b3SjhXdMRhM1gOZwB2y89ijqJfBbzw
	 xRmBrEuLA5zO7IhUj/UrShkrcX3yZ0PCJNh8nOkUPwm4VLl4bVGoEPNmA8jKZ+G1Xk
	 NDgafYsgI/7HCYz8+62oILimCf1NiHUzDd9pX1pajG9+jjItBiDLiKsLupc5X1hU3e
	 BKGpeDHgxrxzZkN9AuH6BFMlZJc0ad9r9Cdl+xGOPmzvrBMKbLFOZjsWTZUS9Yw6pZ
	 92+mEjHGhdbow==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	Jane Chu <jane.chu@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Jann Horn <jannh@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH 6.1.y 1/4] mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count
Date: Wed, 18 Feb 2026 10:16:04 +0100
Message-ID: <20260218091608.25726-2-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218091608.25726-1-david@kernel.org>
References: <2026012605-uncorrupt-yanking-4155@gregkh>
 <20260218091608.25726-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217250-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,huawei.com:email,oracle.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 1C65C154A8A
X-Rspamd-Action: no action

From: Jane Chu <jane.chu@oracle.com>

commit 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared
count") introduced ->pt_share_count dedicated to hugetlb PMD share count
tracking, but omitted fixing copy_hugetlb_page_range(), leaving the
function relying on page_count() for tracking that no longer works.

When lazy page table copy for hugetlb is disabled, that is, revert commit
bcd51a3c679d ("hugetlb: lazy page table copies in fork()") fork()'ing with
hugetlb PMD sharing quickly lockup -

[  239.446559] watchdog: BUG: soft lockup - CPU#75 stuck for 27s!
[  239.446611] RIP: 0010:native_queued_spin_lock_slowpath+0x7e/0x2e0
[  239.446631] Call Trace:
[  239.446633]  <TASK>
[  239.446636]  _raw_spin_lock+0x3f/0x60
[  239.446639]  copy_hugetlb_page_range+0x258/0xb50
[  239.446645]  copy_page_range+0x22b/0x2c0
[  239.446651]  dup_mmap+0x3e2/0x770
[  239.446654]  dup_mm.constprop.0+0x5e/0x230
[  239.446657]  copy_process+0xd17/0x1760
[  239.446660]  kernel_clone+0xc0/0x3e0
[  239.446661]  __do_sys_clone+0x65/0xa0
[  239.446664]  do_syscall_64+0x82/0x930
[  239.446668]  ? count_memcg_events+0xd2/0x190
[  239.446671]  ? syscall_trace_enter+0x14e/0x1f0
[  239.446676]  ? syscall_exit_work+0x118/0x150
[  239.446677]  ? arch_exit_to_user_mode_prepare.constprop.0+0x9/0xb0
[  239.446681]  ? clear_bhb_loop+0x30/0x80
[  239.446684]  ? clear_bhb_loop+0x30/0x80
[  239.446686]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

There are two options to resolve the potential latent issue:
  1. warn against PMD sharing in copy_hugetlb_page_range(),
  2. fix it.
This patch opts for the second option.
While at it, simplify the comment, the details are not actually relevant
anymore.

Link: https://lkml.kernel.org/r/20250916004520.1604530-1-jane.chu@oracle.com
Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 14967a9c7d247841b0312c48dcf8cd29e55a4cc8)
[ David: We don't have ptdesc and the wrappers, so work directly on the
  page->pt_share_count. CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING is still
  called CONFIG_ARCH_WANT_HUGE_PMD_SHARE. ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e7bac08071de..b07b332beabb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5084,18 +5084,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			break;
 		}
 
-		/*
-		 * If the pagetables are shared don't copy or take references.
-		 *
-		 * dst_pte == src_pte is the common case of src/dest sharing.
-		 * However, src could have 'unshared' and dst shares with
-		 * another vma. So page_count of ptep page is checked instead
-		 * to reliably determine whether pte is shared.
-		 */
-		if (page_count(virt_to_page(dst_pte)) > 1) {
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+		/* If the pagetables are shared, there is nothing to do */
+		if (atomic_read(&virt_to_page(dst_pte)->pt_share_count)) {
 			addr |= last_addr_mask;
 			continue;
 		}
+#endif
 
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
-- 
2.43.0


