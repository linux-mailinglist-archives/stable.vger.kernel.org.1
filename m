Return-Path: <stable+bounces-217287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sICwLUC5lWm7UQIAu9opvQ
	(envelope-from <stable+bounces-217287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:06:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577E156811
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361973017267
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944D6309DB1;
	Wed, 18 Feb 2026 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W67mlTCK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB72FDC3C
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419965; cv=none; b=qgYUOXt8JemF9WDs91Eh3yo/+Fa1WUKGu3EalXAfMCFWAmENq1rOpP+aoiZeayUmpDNqAZLVHg3X7+en7rUE+45EUl4u2KBW0j9NxUdiWj8IFs1fUu2guv0x31xgGPVN9lidufcLGmZ+cY0RqJjJWU52YajSbkh0vwWxHR44eT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419965; c=relaxed/simple;
	bh=6hsTAe3F6SFDAEMSoXMlTVM/m77RYjqo0PE8OHxHQF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzpbAbx8fM6edbBn86kbH7eQpS6lfXEKicgWXckfZjzH0zUHPZ82bCNdr/gmCuu17hzl1pLkhPL0TF1u3N3ocZWryD9g0bta3lrdLh6C1POJ+jVdlrSJnl6ihUxNncH3rUUwzjvlrm74yWknji2hOjkahzkQFbwzf5xRFcPX1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W67mlTCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81365C19421;
	Wed, 18 Feb 2026 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771419965;
	bh=6hsTAe3F6SFDAEMSoXMlTVM/m77RYjqo0PE8OHxHQF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W67mlTCKp72Zw4n9T5Y138as/HTEXsStwujszIVALFiBNltq9AwOHYT6/DcHNLQjc
	 jeWoLrMgBBn+Y5PrP5CA2OHhb7Ff9nGjlQR9EtfrTacIJpQKbAn7Wax9h6t7taifxa
	 8on73z29A63mz8hvQQCkQVHGe6Ng32rZT7kaIb8Qe9sp6Erh7DmMsGJc1IYNZAZMvZ
	 HuQuWT/hS60Q6fHg9dbFnAJpL1/xX236ed4Q+/h/i3eKp/IZDW2LK61LCXyfEf5Q+R
	 tJ9dLzHYB5Xxc/7iV+bi6Fi5XDYMkoNdn93MiZ81dYjd+f8BDqQaq/awbvIa/2Fvx4
	 QPQAdiw++AR/Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jane Chu <jane.chu@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jann Horn <jannh@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lance Yang <lance.yang@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	James Houghton <jthoughton@google.com>
Subject: [PATCH 5.10.y 1/7] mm/hugetlb: fix skipping of unsharing of pmd page tables
Date: Wed, 18 Feb 2026 14:05:46 +0100
Message-ID: <20260218130552.55727-2-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218130552.55727-1-david@kernel.org>
References: <2026012610-absolve-ducktail-3c64@gregkh>
 <20260218130552.55727-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217287-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1577E156811
X-Rspamd-Action: no action

In the 5.10 backport of commit b30c14cd6102 ("hugetlb: unshare some PMDs
when splitting VMAs") we seemed to have missed that huge_pmd_unshare()
still adjusts the address itself.

For this reason, commit 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all
pmds for hugetlbfs when register wp") explicitly handled this case by
passing a temporary variable instead.

Fix it in 5.10 by doing the same thing.

Fixes: f1082f5f3d02 ("hugetlb: unshare some PMDs when splitting VMAs")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8efe35ea0baa..99a71943c1f6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5787,11 +5787,14 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
 	}
 	for (address = start; address < end; address += PUD_SIZE) {
+		unsigned long tmp = address;
+
 		ptep = huge_pte_offset(mm, address, sz);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
-		huge_pmd_unshare(mm, vma, &address, ptep);
+		/* We don't want 'address' to be changed */
+		huge_pmd_unshare(mm, vma, &tmp, ptep);
 		spin_unlock(ptl);
 	}
 	flush_hugetlb_tlb_range(vma, start, end);
-- 
2.43.0


