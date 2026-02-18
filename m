Return-Path: <stable+bounces-217292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD2WDVW5lWm7UQIAu9opvQ
	(envelope-from <stable+bounces-217292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:06:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F3D156835
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92F9830143D1
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C9309DB1;
	Wed, 18 Feb 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxh1vQW6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61D2FDC3C
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419986; cv=none; b=LYSJtER+vBsNg6mwGYFH9aTNA9e0WtNc2HkG7UJ9YksFTfNswP32NKvlHtEThDcckVhXgZ6fPLcVWukBMlpDfJ8a5DlY8vunfLY+bSlJj/mGkDxTZgGFjnKRRGfSkm3wS+fkDMmX4MfGioenATsQor4/R5xMaxtVFvcatEl/Vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419986; c=relaxed/simple;
	bh=j/VkrB+wzOf5ArcAY/u2FQnEjfTsdBcW4IzAHEUpdWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnnEcemWosBVdmvyXQpWbaDZR6VAgWT3k54P9zAfo8p7cN8134CLNDIT4WrrFHLRjCul08jS9rdsTQO2NWL16vty6TXV2K7GnST69Zucz5L+vezS4RTrTq1hH/V1n9PFq7JOmqI8ETQyXAzI5vlVg2/VjFtjIUt/0qHq5xW3+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxh1vQW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCF2C19421;
	Wed, 18 Feb 2026 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771419986;
	bh=j/VkrB+wzOf5ArcAY/u2FQnEjfTsdBcW4IzAHEUpdWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gxh1vQW6jw7hAyMUdM1nAHNZdn19vjeiRB3RlWQoowiFpi5QbM8UZILUUMlgllM9z
	 5pfRQijsu+9gFVTcM4FINYYfiyC67haX/1iajXL2vqZcBxrQyc6tVLni0WVQWjEmaQ
	 ZiCQTnO4D+9vhK9f8prmkSkWGudS0YYlxvllLRoJk19zLt9arfXN48pXGV1Pyxyn9c
	 qI2ykgriYxKUKN5+68OJpE4JCtDjcDGworBoOmB/cU7rh9QMgcH2gkKeuHTQF4u5cr
	 nWoWYNPYMQjEL/U5v/Z7+NKMcK7L4vEhpyeEa+Iu8/1oHgqOvtl0bQW8bBUu8/Vmxl
	 ytBToFGivkpmw==
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
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Uschakow, Stanislav" <suschako@amazon.de>
Subject: [PATCH 5.10.y 6/7] mm/rmap: fix two comments related to huge_pmd_unshare()
Date: Wed, 18 Feb 2026 14:05:51 +0100
Message-ID: <20260218130552.55727-7-david@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217292-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linux.dev:email,suse.de:email,oracle.com:email,amazon.de:email,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6F3D156835
X-Rspamd-Action: no action

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

PMD page table unsharing no longer touches the refcount of a PMD page
table.  Also, it is not about dropping the refcount of a "PMD page" but
the "PMD page table".

Let's just simplify by saying that the PMD page table was unmapped,
consequently also unmapping the folio that was mapped into this page.

This code should be deduplicated in the future.

Link: https://lkml.kernel.org/r/20251223214037.580860-4-david@kernel.org
Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: "Uschakow, Stanislav" <suschako@amazon.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit a8682d500f691b6dfaa16ae1502d990aeb86e8be)
[ David: We don't have 40549ba8f8e0 ("hugetlb: use new vma_lock
  for pmd sharing synchronization") and a98a2f0c8ce1 ("mm/rmap: split
  migration into its own so changes in mm/rmap.c looks quite different. ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/rmap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index e6f840be1890..315d7ceb573a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1490,13 +1490,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 							      range.end);
 
 				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
+				 * The PMD table was unmapped,
+				 * consequently unmapping the folio.
 				 */
 				page_vma_mapped_walk_done(&pvmw);
 				break;
-- 
2.43.0


